# pages/sql_queries.py
"""
Stable final CRUD UI for players & player_stats.
- Non-blocking flash messages using session_state + expiry (no time.sleep).
- Forms reset when closed.
- Edit & Delete buttons grouped (single-line).
- No st.experimental_rerun() calls.
- Uses SQLAlchemy Core with reflected metadata.
"""

import streamlit as st
import pandas as pd
import os
import time
from datetime import datetime
from sqlalchemy import create_engine, MetaData, inspect, text
from sqlalchemy.exc import SQLAlchemyError

st.set_page_config(page_title="Players & Match Stats — CRUD (Final Stable)", layout="wide")

# --- CSS: keep actions compact & inline ---
st.markdown(
    """
    <style>
    ul[data-testid="stSidebarNavItems"]{display:none !important;}
    div[data-testid="stSidebarHeader"]{display:none !important;}
    #MainMenu{visibility:hidden;}
    footer{visibility:hidden;}
    section[data-testid="stSidebar"]{width:0 !important;min-width:0 !important;padding:0 !important;}
    .action-btn {padding:6px 8px; border-radius:6px; margin-right:6px;}
    </style>
    """,
    unsafe_allow_html=True,
)

# ----------------- Helpers -----------------
def human_label(colname: str) -> str:
    return colname.replace("_", " ").strip().title()

def set_flash(text: str, ftype: str = "success", ttl: int = 3):
    """Set a flash message in session_state with an expiry timestamp (non-blocking)."""
    st.session_state["__flash"] = {"text": text, "type": ftype, "expires_at": time.time() + ttl}

def clear_flash_if_expired():
    f = st.session_state.get("__flash")
    if not f:
        return
    if time.time() > f.get("expires_at", 0):
        st.session_state["__flash"] = None

def show_flash():
    f = st.session_state.get("__flash")
    if not f:
        return
    t = f.get("text", "")
    typ = f.get("type", "info")
    if typ == "success":
        st.success(t)
    elif typ == "error":
        st.error(t)
    else:
        st.info(t)

def clear_form_keys(prefix: str, names: list):
    """Delete keys created by a form so inputs reset next time."""
    for n in names:
        key = f"{prefix}{n}"
        if key in st.session_state:
            del st.session_state[key]

# ----------------- DB config -----------------
DB_HOST = os.getenv("DB_HOST", "127.0.0.1")
DB_PORT = int(os.getenv("DB_PORT", 3306))
DB_USER = os.getenv("DB_USER", "root")
DB_PASS = os.getenv("DB_PASS", "")
DB_NAME = os.getenv("DB_NAME", "cricketdb")

@st.cache_resource
def get_engine():
    url = f"mysql+pymysql://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}?charset=utf8mb4"
    return create_engine(url, pool_pre_ping=True)

try:
    engine = get_engine()
except Exception as e:
    st.error("Failed to create DB engine. Ensure pymysql is installed and credentials are correct.")
    st.exception(e)
    st.stop()

# quick connection test
try:
    with engine.connect() as conn:
        conn.execute(text("SELECT 1"))
except Exception as e:
    st.error("DB connection test failed. Check that MySQL is accessible.")
    st.exception(e)
    st.stop()

inspector = inspect(engine)
metadata = MetaData()

# Create minimal tables if missing (development convenience)
existing = inspector.get_table_names()
with engine.begin() as conn:
    if "players" not in existing:
        conn.execute(text("CREATE TABLE players (id INT PRIMARY KEY AUTO_INCREMENT, player_id VARCHAR(64), name VARCHAR(255))"))
    if "player_stats" not in existing:
        conn.execute(text("CREATE TABLE player_stats (id INT PRIMARY KEY AUTO_INCREMENT, player_id VARCHAR(64), format VARCHAR(20))"))

metadata.reflect(bind=engine, only=["players", "player_stats"])
players_table = metadata.tables.get("players")
player_stats_table = metadata.tables.get("player_stats")

if players_table is None or player_stats_table is None:
    st.error("Could not reflect 'players' and/or 'player_stats' tables.")
    st.stop()

# ----------------- Field whitelists -----------------
SHOWN_PLAYER_FIELDS = [
    "player_id", "name", "dob", "batting_style", "bowling_style",
    "batting_hand", "bowling_hand", "playing_role", "country"
]
SHOWN_STATS_FIELDS = [
    "player_id", "format", "matches", "innings", "runs", "balls_faced",
    "batting_avg", "highest_score", "fifties", "hundreds",
    "wickets", "bowling_avg", "overs", "economy"
]

actual_player_fields = [c for c in SHOWN_PLAYER_FIELDS if c in players_table.c.keys()]
actual_player_fields = [c for c in actual_player_fields if c.lower() not in ("image_id", "raw_json")]
actual_stats_fields = [c for c in SHOWN_STATS_FIELDS if c in player_stats_table.c.keys()]
actual_stats_fields = [c for c in actual_stats_fields if c.lower() not in ("image_id", "raw_json")]

player_cols = {c.name: c for c in players_table.columns}
stats_cols = {c.name: c for c in player_stats_table.columns}

# ----------------- Session-state flow flags -----------------
st.session_state.setdefault("__create", {"active": False, "area": None})
st.session_state.setdefault("__edit", {"active": False, "area": None, "id": None})
st.session_state.setdefault("__pending_delete", {"id": None, "area": None})
# flash stored as __flash by helper

# ----------------- Input builders -----------------
def build_widget(col, key_prefix="", prefill=None):
    name = col.name
    t = str(col.type).lower()
    key = f"{key_prefix}{name}"
    # hide unwanted fields
    if name.lower() in ("image_id", "raw_json"):
        return None
    label = human_label(name)
    if "int" in t:
        default = int(prefill) if prefill not in (None, "") else 0
        return st.number_input(label, value=default, step=1, key=key)
    if any(x in t for x in ("float", "double", "numeric", "decimal")):
        default = float(prefill) if prefill not in (None, "") else 0.0
        return st.number_input(label, value=default, format="%.2f", key=key)
    if "date" in t:
        if prefill:
            try:
                dt = pd.to_datetime(prefill).date()
            except Exception:
                dt = None
        else:
            dt = None
        return st.date_input(label, value=dt, key=key)
    if any(x in t for x in ("text", "longtext", "json")):
        return st.text_area(label, value=str(prefill or ""), key=key)
    return st.text_input(label, value=str(prefill or ""), key=key)

def build_payload_from_widgets(table, widget_vals):
    payload = {}
    for col in table.columns:
        name = col.name
        if name.lower() in ("image_id", "raw_json"):
            continue
        if col.primary_key and getattr(col, "autoincrement", False):
            continue
        v = widget_vals.get(name)
        if isinstance(v, str) and v.strip() == "":
            payload[name] = None
        else:
            payload[name] = v
    return payload

def fetch_page(table, cols, page=1, page_size=25):
    offset = (page - 1) * page_size
    if not cols:
        cols_sql = "*"
    else:
        cols_sql = ", ".join([f"`{c}`" for c in cols])
    with engine.connect() as conn:
        q = text(f"SELECT id, {cols_sql} FROM `{table.name}` ORDER BY id DESC LIMIT :lim OFFSET :off")
        df = pd.read_sql(q, conn, params={"lim": page_size, "off": offset})
    return df

# ----------------- Page layout -----------------
left, main = st.columns([1.4, 8])
with left:
    st.markdown("## 🏏 Cricbuzz")
    if st.button("🏠 Home"):
        try: st.switch_page("pages/home.py")
        except: pass
    if st.button("📡 Live Matches"):
        try: st.switch_page("pages/live_matches.py")
        except: pass
    if st.button("📊 Top Stats"):
        try: st.switch_page("pages/top_stats.py")
        except: pass
    if st.button("✏️ CRUD"):
        try: st.switch_page("pages/crud_operations.py")
        except: pass
    st.markdown("---")
    st.caption("Quick links")

with main:
    st.title("Players & Match Stats — CRUD (Stable Final)")

    # show flash if present & not expired
    clear_flash_if_expired()
    show_flash()

    area = st.radio("Area", ["Players", "Match Stats"], index=0)
    page_size = 25
    page = st.number_input("Page", min_value=1, value=1, step=1)

    # Add New button
    a1, a2 = st.columns([1, 4])
    with a1:
        if st.button("➕ Add New", key="add_new_global"):
            st.session_state["__create"]["active"] = True
            st.session_state["__create"]["area"] = "players" if area == "Players" else "player_stats"
            # reset possible edit/delete states
            st.session_state["__edit"] = {"active": False, "area": None, "id": None}
            st.session_state["__pending_delete"] = {"id": None, "area": None}
            # clear form keys for a clean create
            if st.session_state["__create"]["area"] == "players":
                clear_form_keys("create_", actual_player_fields)
            else:
                clear_form_keys("create_", actual_stats_fields)
            # let Streamlit rerun naturally (button click causes rerun)

    # render listing with grouped Edit/Delete buttons
    def render_list_with_actions(table, shown_fields, cols_map, area_key):
        st.subheader(f"{human_label(area_key)} Listing (page {page})")
        if not shown_fields:
            st.info("No shown fields available in DB.")
            return
        df = fetch_page(table, shown_fields, page=page, page_size=page_size)
        if df.empty:
            st.info("No rows found on this page.")
            return
        # header
        header_cols = st.columns(len(shown_fields) + 1)
        for i, c in enumerate(shown_fields):
            header_cols[i].markdown(f"**{human_label(c)}**")
        header_cols[-1].markdown("**Actions**")
        # rows
        for _, row in df.iterrows():
            cols = st.columns(len(shown_fields) + 1)
            for i, c in enumerate(shown_fields):
                v = row.get(c)
                if pd.isna(v):
                    v = ""
                if isinstance(v, str) and len(v) > 120:
                    cols[i].write(v[:120] + "…")
                else:
                    cols[i].write(v)
            # grouped buttons (single line)
            row_id = int(row["id"])
            left_btn, right_btn = cols[-1].columns([1,1])
            # unique keys ensure no collision with other controls
            if left_btn.button("✏️ Edit", key=f"{area_key}_edit_{row_id}"):
                st.session_state["__edit"] = {"active": True, "area": area_key, "id": row_id}
                st.session_state["__create"] = {"active": False, "area": None}
                st.session_state["__pending_delete"] = {"id": None, "area": None}
                # clear previous edit keys so prefill is fresh
                if area_key == "players":
                    clear_form_keys("edit_", actual_player_fields)
                else:
                    clear_form_keys("edit_", actual_stats_fields)
            if right_btn.button("🗑️ Delete", key=f"{area_key}_delete_{row_id}"):
                st.session_state["__pending_delete"] = {"id": row_id, "area": area_key}
                st.session_state["__create"] = {"active": False, "area": None}
                st.session_state["__edit"] = {"active": False, "area": None, "id": None}

    # ---------- Create form ----------
    if st.session_state["__create"]["active"] and st.session_state["__create"]["area"] == ("players" if area == "Players" else "player_stats"):
        table = players_table if area == "Players" else player_stats_table
        cols_map = player_cols if area == "Players" else stats_cols
        shown = actual_player_fields if area == "Players" else actual_stats_fields

        st.subheader("Add New")
        with st.form("create_form"):
            widget_vals = {}
            for name in shown:
                col = cols_map[name]
                widget_vals[name] = build_widget(col, key_prefix="create_", prefill=None)
            submit = st.form_submit_button("Insert")
            cancel = st.form_submit_button("Cancel")
        if cancel:
            st.session_state["__create"] = {"active": False, "area": None}
            # clear create form keys
            clear_form_keys("create_", shown)
        if submit:
            payload = build_payload_from_widgets(table, widget_vals)
            try:
                with engine.begin() as conn:
                    conn.execute(table.insert().values(**payload))
                # hide + reset create form immediately
                st.session_state["__create"] = {"active": False, "area": None}
                clear_form_keys("create_", shown)
                set_flash("Record added successfully.", "success", ttl=3)
            except Exception as e:
                st.error("Insert failed.")
                st.exception(e)

    # ---------- Delete confirmation ----------
    pending = st.session_state.get("__pending_delete", {})
    if pending and pending.get("id") and pending.get("area") == ("players" if area == "Players" else "player_stats"):
        pid = pending["id"]
        st.warning(f"Confirm deletion of ID {pid} from {pending['area']}. This action is permanent.")
        c1, c2, _ = st.columns([1,1,4])
        if c1.button("Confirm Delete", key=f"confirm_delete_{pid}"):
            try:
                target = players_table if pending["area"] == "players" else player_stats_table
                with engine.begin() as conn:
                    conn.execute(target.delete().where(target.c.id == pid))
                # clear pending delete (hides confirmation immediately)
                st.session_state["__pending_delete"] = {"id": None, "area": None}
                set_flash(f"Deleted ID {pid}.", "success", ttl=3)
            except Exception as e:
                st.error("Delete failed.")
                st.exception(e)
                st.session_state["__pending_delete"] = {"id": None, "area": None}
        if c2.button("Cancel", key=f"cancel_delete_{pid}"):
            st.session_state["__pending_delete"] = {"id": None, "area": None}

    # ---------- Edit form ----------
    edit = st.session_state.get("__edit", {})
    if edit and edit.get("active") and edit.get("area") == ("players" if area == "Players" else "player_stats"):
        edit_id = edit.get("id")
        table = players_table if area == "Players" else player_stats_table
        cols_map = player_cols if area == "Players" else stats_cols
        shown = actual_player_fields if area == "Players" else actual_stats_fields

        rowdf = pd.read_sql(text(f"SELECT * FROM {table.name} WHERE id = :id"), engine, params={"id": edit_id})
        if rowdf.empty:
            st.error("Row not found (may have been deleted).")
            st.session_state["__edit"] = {"active": False, "area": None, "id": None}
        else:
            current = rowdf.to_dict(orient="records")[0]
            st.subheader(f"Edit ID {edit_id}")
            st.write("Current values (preview):")
            st.json({human_label(k): v for k, v in current.items() if k in (shown + ["id"])})
            with st.form("edit_form"):
                widget_vals = {}
                for name in shown:
                    col = cols_map[name]
                    widget_vals[name] = build_widget(col, key_prefix="edit_", prefill=current.get(name))
                submit = st.form_submit_button("Save")
                cancel = st.form_submit_button("Cancel")
            if cancel:
                st.session_state["__edit"] = {"active": False, "area": None, "id": None}
                clear_form_keys("edit_", shown)
            if submit:
                payload = build_payload_from_widgets(table, widget_vals)
                try:
                    with engine.begin() as conn:
                        conn.execute(table.update().where(table.c.id == edit_id).values(**payload))
                    # hide & clear edit form immediately
                    st.session_state["__edit"] = {"active": False, "area": None, "id": None}
                    clear_form_keys("edit_", shown)
                    set_flash("Record updated successfully.", "success", ttl=3)
                except Exception as e:
                    st.error("Update failed.")
                    st.exception(e)

    # ---------- Normal listing (show only when not blocking) ----------
    blocking = False
    if st.session_state["__create"]["active"] and st.session_state["__create"]["area"] == ("players" if area == "Players" else "player_stats"):
        blocking = True
    if st.session_state["__edit"]["active"] and st.session_state["__edit"]["area"] == ("players" if area == "Players" else "player_stats"):
        blocking = True
    if st.session_state["__pending_delete"]["id"] and st.session_state["__pending_delete"]["area"] == ("players" if area == "Players" else "player_stats"):
        blocking = True

    if not blocking:
        if area == "Players":
            render_list_with_actions(players_table, actual_player_fields, player_cols, "players")
        else:
            render_list_with_actions(player_stats_table, actual_stats_fields, stats_cols, "player_stats")

    st.markdown("---")
    st.caption("This UI edits the live DB. Hidden fields: image_id, raw_json. Backup your DB before mass edits.")
