# pages/top_stats.py
import streamlit as st
import requests
import pandas as pd
from typing import Dict, List, Optional

st.set_page_config(page_title="Top Player Stats", layout="wide")

hide_streamlit_style = """
<style>
ul[data-testid="stSidebarNavItems"]{display:none !important;}
div[data-testid="stSidebarHeader"]{display:none !important;}
#MainMenu{visibility:hidden;}
footer{visibility:hidden;}
section[data-testid="stSidebar"]{width:0 !important;min-width:0 !important;padding:0 !important;}
</style>
"""
st.markdown(hide_streamlit_style, unsafe_allow_html=True)


def nav_to(page_name: str):
    st.switch_page(page_name)


col1, col2 = st.columns([1.4, 8])

with col1:
    st.markdown("## 🏏 Cricbuzz")
    if st.button("🏠 Home"):
        nav_to("pages/home.py")
    if st.button("📡 Live Matches"):
        nav_to("pages/live_matches.py")
    if st.button("📊 Top Stats"):
        nav_to("pages/top_stats.py")
    if st.button("🧾 SQL Analytics"):
        nav_to("pages/sql_queries.py")
    if st.button("✏️ CRUD"):
        nav_to("pages/crud_operations.py")
    st.markdown("---")
    st.caption("Quick links")
    st.markdown("- [Project docs](#)")

with col2:
    st.title("⭐ Top Player Stats")

    HEADERS = {
        "x-rapidapi-key": "72d9f8fec5mshfc0f2f47123393ep150dedjsn98f5405906fe",
        "x-rapidapi-host": "cricbuzz-cricket.p.rapidapi.com"
    }

    SEARCH_URL = "https://cricbuzz-cricket.p.rapidapi.com/stats/v1/player/search"
    PLAYER_URL = "https://cricbuzz-cricket.p.rapidapi.com/stats/v1/player/{player_id}"
    CAREER_URL = "https://cricbuzz-cricket.p.rapidapi.com/stats/v1/player/{player_id}/career"
    BATTING_STATS_URL = "https://cricbuzz-cricket.p.rapidapi.com/stats/v1/player/{player_id}/batting"
    BOWLING_STATS_URL = "https://cricbuzz-cricket.p.rapidapi.com/stats/v1/player/{player_id}/bowling"

    if "player_data" not in st.session_state:
        st.session_state.player_data = None
    if "last_query" not in st.session_state:
        st.session_state.last_query = ""

    def safe_get(url: str, params: Optional[Dict] = None) -> Optional[Dict]:
        try:
            resp = requests.get(url, headers=HEADERS, params=params, timeout=12)
            if resp.status_code == 204:
                return None
            resp.raise_for_status()
            return resp.json()
        except Exception as e:
            st.error(f"Request error: {e}")
            return None

    def search_player(name: str) -> List[Dict]:
        data = safe_get(SEARCH_URL, params={"plrN": name})
        if not data:
            return []
        return data.get("player", []) or []

    def get_player_details(player_id: str) -> Optional[Dict]:
        return safe_get(PLAYER_URL.format(player_id=player_id))

    def get_player_career(player_id: str) -> Optional[List[Dict]]:
        data = safe_get(CAREER_URL.format(player_id=player_id))
        if not data:
            return None
        if isinstance(data, dict) and "career" in data:
            return data.get("career") or []
        if isinstance(data, list):
            return data
        return data

    def get_player_batting(player_id: str) -> Optional[Dict]:
        return safe_get(BATTING_STATS_URL.format(player_id=player_id))

    def get_player_bowling(player_id: str) -> Optional[Dict]:
        return safe_get(BOWLING_STATS_URL.format(player_id=player_id))

    with st.form(key="player_search_form", clear_on_submit=False):
        player_query = st.text_input(
            "🔍 Search for a Player",
            placeholder="e.g., Virat Kohli, MS Dhoni",
            value=st.session_state.last_query,
        )
        submitted = st.form_submit_button("Search")

    if submitted:
        if not player_query.strip():
            st.warning("Please enter a player name.")
        else:
            st.session_state.last_query = player_query.strip()
            with st.spinner(f"Searching for {player_query}..."):
                results = search_player(player_query.strip())
                if not results:
                    st.info("No players found.")
                    st.session_state.player_data = None
                else:
                    if len(results) > 1:
                        option_labels = [
                            f"{r.get('name')} ({r.get('teamName','').strip()}) — id:{r.get('id')}"
                            for r in results
                        ]
                        choice = st.selectbox("Multiple players found — select one:", option_labels)
                        chosen = results[option_labels.index(choice)]
                    else:
                        chosen = results[0]

                    player_id = str(chosen.get("id"))
                    with st.spinner("Fetching player details and stats..."):
                        details = get_player_details(player_id)
                        career = get_player_career(player_id)
                        batting_stats = get_player_batting(player_id)
                        bowling_stats = get_player_bowling(player_id)
                        st.session_state.player_data = {
                            "basic": details or {},
                            "career": career,
                            "batting_stats": batting_stats,
                            "bowling_stats": bowling_stats,
                        }

    player_data = st.session_state.player_data

    if player_data:
        basic = player_data.get("basic", {}) or {}
        career = player_data.get("career")
        batting_stats = player_data.get("batting_stats")
        bowling_stats = player_data.get("bowling_stats")

        name = basic.get("name") or basic.get("fullName") or "Unknown"
        nickname = basic.get("nickName") or basic.get("shortName") or ""
        st.subheader(f"{name}" + (f" — {nickname}" if nickname else ""))

        col_left, col_right = st.columns([2, 1])

        with col_left:
            st.markdown("### Personal Details")
            st.write(f"**DOB:** {basic.get('DoB') or basic.get('dob','N/A')}")
            st.write(f"**Birthplace:** {basic.get('birthPlace','N/A')}")
            st.write(f"**Role:** {basic.get('role','N/A')}")
            st.write(f"**Batting Style:** {basic.get('bat') or basic.get('battingStyle','N/A')}")
            st.write(f"**Bowling Style:** {basic.get('bowl') or basic.get('bowlingStyle','N/A')}")

        with col_right:
            st.markdown("### Teams Played For")
            teams = basic.get("teamName") or basic.get("teams") or []
            if isinstance(teams, list):
                for t in teams:
                    st.write(f"- {t}")
            elif isinstance(teams, str) and teams.strip():
                st.write(teams)
            else:
                st.write("N/A")

        tab_career, tab_bat, tab_bowl = st.tabs(
            ["Career (summary)", "Batting Stats", "Bowling Stats"]
        )

        with tab_career:
            st.markdown("### Career Summary")

            if career:
                # If career is a dict, clean out unwanted keys
                if isinstance(career, dict):
                    # Keep only the part that actually contains rows
                    if "values" in career and isinstance(career["values"], list):
                        df_career = pd.DataFrame(career["values"])
                        rename_map = {
                            "name": "Format",
                            "debut": "Debut",
                            "lastPlayed": "Last Played",
                            "debutMatchID": "Debut Match ID",
                            "lastPlayedMatchId": "Last Match ID"
                        }
                        df_career = df_career.rename(columns=rename_map)
                        cols = df_career.columns.tolist()
                        if "Format" in cols:
                            cols = ["Format"] + [c for c in cols if c != "Format"]
                            df_career = df_career[cols]
                        st.dataframe(df_career, use_container_width=True, hide_index=True)
                    else:
                        st.info("No structured career rows found.")

                elif isinstance(career, list) and all(isinstance(item, dict) for item in career):
                    df_career = pd.DataFrame(career)
                    rename_map = {
                        "name": "Format",
                        "debut": "Debut",
                        "lastPlayed": "Last Played",
                        "debutMatchID": "Debut Match ID",
                        "lastPlayedMatchId": "Last Match ID"
                    }
                    df_career = df_career.rename(columns=rename_map)
                    if "Format" in df_career.columns:
                        cols = ["Format"] + [c for c in df_career.columns if c != "Format"]
                        df_career = df_career[cols]
                    st.dataframe(df_career, use_container_width=True, hide_index=True)

                else:
                    st.info("No career summary available.")
            else:
                st.info("No career summary available.")



        def _pivot_headers_values(payload: Dict, label_map: Dict[str, str], target_order: List[str], format_col_name: str = "Format"):
            """
            Pivot an API payload shaped like:
            { "headers": ["ROWHEADER","Test","ODI"...],
              "values": [ {"values":["Matches","123","302",...]}, ... ] }
            into a DataFrame with rows per format and columns per label_map (renamed).
            """
            if not (isinstance(payload, dict) and "headers" in payload and "values" in payload):
                return None
            headers = payload.get("headers", [])
            values = payload.get("values", [])

            if not headers or not isinstance(values, list):
                return None

            formats = headers[1:]  # e.g. ["Test","ODI","T20","IPL"]
            rows = [{format_col_name: f} for f in formats]

            # values is a list of dicts, each has "values": [label, val_for_format1, val_for_format2, ...]
            for val_entry in values:
                entry_vals = val_entry.get("values", [])
                if not isinstance(entry_vals, list) or len(entry_vals) < 2:
                    continue
                label_raw = entry_vals[0].strip()
                for i, fmt in enumerate(formats, start=1):
                    cell = entry_vals[i] if i < len(entry_vals) else None
                    rows[i - 1][label_raw] = cell

            df = pd.DataFrame(rows)

            # Rename columns according to label_map (only existing columns)
            rename_present = {k: v for k, v in label_map.items() if k in df.columns}
            if rename_present:
                df = df.rename(columns=rename_present)

            # Reorder columns: format column first, then the ones in target_order that exist
            ordered = [format_col_name] + [c for c in target_order if c in df.columns]
            # Append any other columns that exist but weren't in order list
            extras = [c for c in df.columns if c not in ordered]
            df = df[ordered + extras]

            # Convert numeric-like columns to numbers where possible
            for col in df.columns:
                if col == format_col_name:
                    continue
                # coerce after removing commas and stripping
                df[col] = df[col].astype(str).str.replace(",", "").str.strip().replace({"": None, "None": None})
                df[col] = pd.to_numeric(df[col], errors="coerce").fillna(df[col])

            return df

        with tab_bat:
            st.markdown("### Batting Career Summary")

            batting_label_map = {
                "Matches": "M",
                "Innings": "Inn",
                "Runs": "Runs",
                "Balls": "BF",
                "Highest": "HS",
                "Average": "Avg",
                "SR": "SR",
                "Not Out": "NO",
                "Fours": "4s",
                "Sixes": "6s",
                "50s": "50",
                "100s": "100",
                "200s": "200",
                "Ducks": "Ducks"
            }
            batting_order = ["M", "Inn", "Runs", "BF", "HS", "Avg", "SR", "NO", "4s", "6s", "50", "100", "200"]

            df_batting = None
            # prefer batting_stats endpoint payload; fallback to career aggregated list
            if batting_stats and isinstance(batting_stats, dict) and "headers" in batting_stats:
                df_batting = _pivot_headers_values(batting_stats, batting_label_map, batting_order)
            elif isinstance(batting_stats, dict):
                # maybe keyed by format
                rows = []
                for fmt, content in batting_stats.items():
                    if isinstance(content, dict):
                        r = content.copy()
                        r["Format"] = fmt
                        rows.append(r)
                if rows:
                    df_batting = pd.DataFrame(rows)
            elif isinstance(batting_stats, list) and all(isinstance(x, dict) for x in batting_stats):
                df_batting = pd.DataFrame(batting_stats)

            # fallback: if still None, try career list filtering for batting rows
            if df_batting is None and career and isinstance(career, list):
                batting_rows = [c for c in career if isinstance(c, dict) and (c.get("type") or "").lower() == "batting"]
                if batting_rows:
                    df_batting = pd.DataFrame(batting_rows).drop(columns=["type"], errors="ignore")

            if df_batting is not None and not df_batting.empty:
                # ensure rename for career fallback
                if "Format" not in df_batting.columns and "format" in df_batting.columns:
                    df_batting = df_batting.rename(columns={"format": "Format"})
                # reorder & hide index
                present_cols = [c for c in ["Format"] + batting_order if c in df_batting.columns]
                df_batting = df_batting[present_cols]
                st.dataframe(df_batting, use_container_width=True, hide_index=True)
            else:
                st.info("No batting stats available.")

        with tab_bowl:
            st.markdown("### Bowling Career Summary")

            bowling_label_map = {
                "Matches": "M",
                "Innings": "Inn",
                "Balls": "B",
                "Runs": "Runs",
                "Wkts": "Wkts",
                "Average": "Avg",
                "Econ": "Econ",
                "SR": "SR",
                "BBI": "BBI",
                "BBM": "BBM",
                "5w": "5w",
                "10w": "10w"
            }
            bowling_order = ["M", "Inn", "B", "Runs", "Wkts", "Avg", "Econ", "SR", "BBI", "BBM", "5w", "10w"]

            df_bowling = None
            if bowling_stats and isinstance(bowling_stats, dict) and "headers" in bowling_stats:
                df_bowling = _pivot_headers_values(bowling_stats, bowling_label_map, bowling_order)
            elif isinstance(bowling_stats, dict):
                rows = []
                for fmt, content in bowling_stats.items():
                    if isinstance(content, dict):
                        r = content.copy()
                        r["Format"] = fmt
                        rows.append(r)
                if rows:
                    df_bowling = pd.DataFrame(rows)
            elif isinstance(bowling_stats, list) and all(isinstance(x, dict) for x in bowling_stats):
                df_bowling = pd.DataFrame(bowling_stats)

            if df_bowling is None and career and isinstance(career, list):
                bowling_rows = [c for c in career if isinstance(c, dict) and (c.get("type") or "").lower() == "bowling"]
                if bowling_rows:
                    df_bowling = pd.DataFrame(bowling_rows).drop(columns=["type"], errors="ignore")

            if df_bowling is not None and not df_bowling.empty:
                if "Format" not in df_bowling.columns and "format" in df_bowling.columns:
                    df_bowling = df_bowling.rename(columns={"format": "Format"})
                present_cols = [c for c in ["Format"] + bowling_order if c in df_bowling.columns]
                df_bowling = df_bowling[present_cols]
                st.dataframe(df_bowling, use_container_width=True, hide_index=True)
            else:
                st.info("No bowling stats available.")

    else:
        st.info("Search for a player to view profile & stats.")
