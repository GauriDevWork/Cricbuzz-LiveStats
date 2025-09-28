# pages/live_matches.py
import streamlit as st
import requests
import json
import pandas as pd
import os
import time
import random
from datetime import datetime, timezone

# Try zoneinfo for correct IST display (optional)
try:
    from zoneinfo import ZoneInfo
    KOLKATA_TZ = ZoneInfo("Asia/Kolkata")
except Exception:
    KOLKATA_TZ = None

st.set_page_config(page_title="Cricbuzz Live Matches - Inline Details", layout="wide")

# Hide default sidebar/nav
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

def show_code_block(code: str, language: str = ""):
    st.code(code, language=language)



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
    st.markdown("- [Project docs](https://docs.google.com/document/d/1tV9bz0rtE41Ia9CvM_Z5ISGmojxZ_wDm/edit?usp=sharing&ouid=117739931704852783987&rtpof=true&sd=true)")

with col2:
    # -----------------------
    # API config (env friendly)
    # -----------------------
    API_HOST = "cricbuzz-cricket.p.rapidapi.com"
    API_KEY = "61e0315fa8msh334f66010769b4ep1c6915jsn6ba00378fac4"
    BASE = f"https://{API_HOST}"
    HEADERS = {"x-rapidapi-host": API_HOST, "x-rapidapi-key": API_KEY}

    # Rate-limit / retry settings
    MAX_RETRIES = 5
    BACKOFF_BASE = 1.0  # seconds
    MAX_BACKOFF_SLEEP = 5.0  # don't sleep too long in UI
    JITTER = 0.3

    # -----------------------
    # Networking with rate-limit handling
    # -----------------------
    def safe_get_url(url, params=None, timeout=10, max_retries=MAX_RETRIES):
        """
        GET with retries, exponential backoff + jitter.
        - Respects Retry-After header if present (but avoids excessively long sleeps in UI).
        - Returns parsed JSON or dict with '_error' on failure.
        """
        headers = HEADERS.copy()
        last_err = None

        for attempt in range(1, max_retries + 1):
            try:
                r = requests.get(url, headers=headers, params=params or {}, timeout=timeout)
            except Exception as e:
                last_err = f"Request exception: {e}"
                # apply small backoff before retrying
                sleep = min(MAX_BACKOFF_SLEEP, BACKOFF_BASE * (2 ** (attempt - 1)) + random.uniform(0, JITTER))
                time.sleep(sleep)
                continue

            if r.status_code == 200:
                try:
                    return r.json()
                except Exception as e:
                    return {"_error": f"JSON parse error: {e}", "_status": r.status_code, "_body_preview": r.text[:1000]}
            elif r.status_code == 429:
                # Too many requests: Respect Retry-After header if present
                retry_after = r.headers.get("Retry-After")
                msg = f"HTTP 429 Too Many Requests (attempt {attempt}/{max_retries})"
                if retry_after:
                    try:
                        ra = int(float(retry_after))
                    except Exception:
                        try:
                            # sometimes Retry-After is a HTTP-date; skip parsing to keep things simple
                            ra = None
                        except Exception:
                            ra = None
                    if ra is not None:
                        # if server asks for small wait (<= MAX_BACKOFF_SLEEP) do it, otherwise abort early
                        if ra <= MAX_BACKOFF_SLEEP:
                            time.sleep(ra + random.uniform(0, JITTER))
                            continue
                        else:
                            return {"_error": msg + f" — server asked Retry-After={ra}s (too long for UI).", "_status": 429}
                # Exponential backoff if no/large Retry-After
                sleep = min(MAX_BACKOFF_SLEEP, BACKOFF_BASE * (2 ** (attempt - 1)) + random.uniform(0, JITTER))
                time.sleep(sleep)
                last_err = msg
                continue
            elif 500 <= r.status_code < 600:
                # Server error - retry
                last_err = f"Server error HTTP {r.status_code}"
                sleep = min(MAX_BACKOFF_SLEEP, BACKOFF_BASE * (2 ** (attempt - 1)) + random.uniform(0, JITTER))
                time.sleep(sleep)
                continue
            else:
                # client error (4xx other than 429) or unknown
                return {"_error": f"HTTP {r.status_code} - {r.text[:500]}", "_status": r.status_code}

        # exhausted retries
        return {"_error": last_err or "Unknown network error after retries."}

    # -----------------------
    # Cached fetchers
    # -----------------------
    @st.cache_data(ttl=15)  # cache live feed for 15 seconds to reduce calls
    def fetch_live():
        return safe_get_url(f"{BASE}/matches/v1/live")

    # Cache each match scorecard separately for a short time to avoid repeated fetches.
    @st.cache_data(ttl=10)  # cached per match id for 10 seconds
    def fetch_scorecard_v2(match_id):
        if not match_id:
            return {"_error": "No match id provided"}
        return safe_get_url(f"{BASE}/mcenter/v1/{match_id}/hscard")

    # -----------------------
    # Small helpers & formatters
    # -----------------------
    def format_venue(v):
        if isinstance(v, dict):
            ground = v.get("ground") or v.get("groundName") or v.get("name") or ""
            city = v.get("city") or v.get("town") or v.get("location") or ""
            parts = [p for p in (ground, city) if p]
            return ", ".join(parts) if parts else json.dumps(v, ensure_ascii=False)
        return str(v) if v is not None else ""

    def rr_from_overs(runs, overs_str):
        try:
            if runs is None or overs_str is None:
                return None
            s = str(overs_str)
            if "." in s:
                w, b = s.split(".")
                overs_float = int(w) + int(b) / 6.0
            else:
                overs_float = float(s)
            if overs_float <= 0:
                return None
            return round(float(runs) / overs_float, 2)
        except Exception:
            return None

    def batsmen_df(batsmen):
        rows = []
        for b in batsmen or []:
            rows.append({
                "Name": b.get("name") or b.get("nickname") or "",
                "R": int(b.get("runs") or 0),
                "B": int(b.get("balls") or 0),
                "4s": int(b.get("fours") or 0),
                "6s": int(b.get("sixes") or 0),
                "SR": float(b.get("strkrate") or 0) if (b.get("strkrate") not in (None, "")) else 0,
                "Dismissal": b.get("outdec") or ""
            })
        df = pd.DataFrame(rows)
        if not df.empty:
            df = df[["Name", "R", "B", "4s", "6s", "SR", "Dismissal"]]
        return df

    def bowlers_df(bowlers):
        rows = []
        for b in bowlers or []:
            rows.append({
                "Name": b.get("name") or b.get("nickname") or "",
                "O": b.get("overs") or "0",
                "M": int(b.get("maidens") or 0),
                "R": int(b.get("runs") or 0),
                "W": int(b.get("wickets") or 0),
                "Econ": float(b.get("economy") or 0)
            })
        df = pd.DataFrame(rows)
        if not df.empty:
            df = df[["Name", "O", "M", "R", "W", "Econ"]]
        return df

    # -----------------------
    # Scorecard rendering with "Yet to bat" and error handling
    # -----------------------
    def render_scorecard(scorecard):
        if not scorecard or (isinstance(scorecard, dict) and scorecard.get("_error")):
            # If we have an error payload, show message and offer any JSON blob for download if present
            if isinstance(scorecard, dict) and scorecard.get("_error"):
                st.warning(f"Could not fetch scorecard: {scorecard.get('_error')}")
                # If we have some cached JSON in message, offer it (optional)
            st.info("Scorecard not available.")
            return

        # find innings list (flexible handling)
        innings_list = []
        if isinstance(scorecard, dict):
            if "scorecard" in scorecard and isinstance(scorecard["scorecard"], list):
                innings_list = scorecard["scorecard"]
            elif "innings" in scorecard and isinstance(scorecard["innings"], list):
                innings_list = scorecard["innings"]
            elif any(k in scorecard for k in ("scorecard", "innings")):
                # fallback: try direct extraction
                for k in ("scorecard", "innings"):
                    v = scorecard.get(k)
                    if isinstance(v, list):
                        innings_list = v
                        break
            else:
                # maybe the API returned the innings directly as the top-level dict with inning objects under keys
                # try simplistic approach: look for keys that look like innings objects (contain 'batsman' etc.)
                possible = []
                for v in scorecard.values():
                    if isinstance(v, dict) and ("batsman" in v or "bowler" in v):
                        possible.append(v)
                if possible:
                    innings_list = possible

        if not innings_list:
            st.info("No innings found.")
            return

        for i, inn in enumerate(innings_list, start=1):
            team = inn.get("batteamname") or inn.get("batteamsname") or inn.get("teamname") or f"Innings {i}"
            runs = inn.get("score") or 0
            wkts = inn.get("wickets") or 0
            overs = inn.get("overs") or "0"
            st.subheader(f"Innings {i}: {team} — {runs}/{wkts} ({overs} overs)")

            # Extras
            extras = inn.get("extras") or {}
            if extras:
                st.write(f"Extras: {extras.get('total', sum([extras.get(k,0) for k in ['byes','legbyes','wides','noballs']]))} "
                        f"(b {extras.get('byes',0)}, lb {extras.get('legbyes',0)}, w {extras.get('wides',0)}, nb {extras.get('noballs',0)})")

            rr = rr_from_overs(runs, overs)
            if rr is not None:
                st.write(f"Run Rate: {rr}")

            # Batsmen split
            bats = inn.get("batsman") or inn.get("batsmen") or []
            batted = []
            yet_to_bat = []
            for b in bats:
                try:
                    balls = int(b.get("balls") or 0)
                except Exception:
                    balls = 0
                outdec = (b.get("outdec") or "").strip()
                if balls > 0 or outdec != "":
                    batted.append(b)
                else:
                    yet_to_bat.append(b)

            if batted:
                st.markdown("**Batsmen (played / currently batting / out)**")
                st.dataframe(batsmen_df(batted), use_container_width=True, hide_index=True)
            else:
                st.info("No batsmen have batted yet in this innings.")

            if yet_to_bat:
                names = [y.get("name") or y.get("nickname") or "" for y in yet_to_bat]
                st.markdown("**Yet to bat:** " + ", ".join([f"**{n}**" for n in names if n]))


            # Bowlers
            bowlers = inn.get("bowler") or inn.get("bowlers") or []
            if bowlers:
                st.markdown("**Bowlers**")
                st.dataframe(bowlers_df(bowlers), use_container_width=True, hide_index=True)
            else:
                st.info("No bowlers data available for this innings.")

            # Fall of wickets
            fow_wrapper = inn.get("fow") or {}
            fow_list = fow_wrapper.get("fow") if isinstance(fow_wrapper, dict) and "fow" in fow_wrapper else fow_wrapper if isinstance(fow_wrapper, list) else []
            if fow_list:
                st.markdown("**Fall of Wickets**")
                fow_rows = []
                for fw in fow_list:
                    fow_rows.append({
                        "Batsman": fw.get("batsmanname") or fw.get("batsman") or "",
                        "Score": fw.get("runs") or fw.get("score") or "",
                        "Over": fw.get("overnbr") or fw.get("over") or ""
                    })
                st.dataframe(pd.DataFrame(fow_rows), use_container_width=True, hide_index=True)

            #st.markdown("====")

    # -----------------------
    # Main UI
    # -----------------------
    st.title("🏏 Live Matches")

    # 1) fetch live feed (cached briefly)
    live_data = fetch_live()
    if isinstance(live_data, dict) and live_data.get("_error"):
        st.error(f"Could not fetch live feed: {live_data.get('_error')}")
        # if 429, offer guidance:
        if live_data.get("_status") == 429:
            st.warning("API responded with HTTP 429. Reduce request frequency or upgrade your RapidAPI plan.")
        st.stop()

    # 2) find match wrappers (flexible search)
    def find_match_wrappers(obj):
        found = []
        if isinstance(obj, dict):
            if "matchInfo" in obj and isinstance(obj["matchInfo"], dict):
                found.append(obj)
            else:
                for v in obj.values():
                    found.extend(find_match_wrappers(v))
        elif isinstance(obj, list):
            for item in obj:
                found.extend(find_match_wrappers(item))
        return found

    match_wrappers = find_match_wrappers(live_data)
    if not match_wrappers:
        st.info("No matches found in feed.")
        st.stop()

    # session state: keep a small cache of last fetched scorecards so we can offer them on errors
    if "scorecard_cache" not in st.session_state:
        st.session_state.scorecard_cache = {}

    for idx, mwrap in enumerate(match_wrappers):
        mi = mwrap.get("matchInfo", {}) or {}
        t1 = mi.get("team1", {}) or {}
        t2 = mi.get("team2", {}) or {}
        t1_name = t1.get("teamSName") or t1.get("teamName") or ""
        t2_name = t2.get("teamSName") or t2.get("teamName") or ""
        desc = mi.get("matchDesc") or ""
        status = mi.get("status") or ""
        with st.expander(f"{t1_name} vs {t2_name} — {desc}"):
            st.write(status)
            #st.write(mi)
            venue = mi.get("venueInfo") or {}
            ground = venue.get("ground") or "Unknown ground"
            city = venue.get("city") or ""

            st.write(
                f"Venue: {ground}"
                + (f", {city}" if city else "")
                )


            match_id = mi.get("matchId") or mi.get("match_id") or mi.get("id")
            if not match_id:
                st.info("No match id available.")
                continue

            # fetch scorecard (cached). If cached previously in session_state, we can show when 429 happens.
            scorecard = fetch_scorecard_v2(match_id)

            if isinstance(scorecard, dict) and scorecard.get("_error"):
                st.warning(f"Scorecard fetch error: {scorecard.get('_error')}")
                # if we have previously cached JSON in session_state, offer it
                cached_sc = st.session_state.scorecard_cache.get(str(match_id))
                if cached_sc:
                    st.info("Showing last cached scoreboard copy (may be slightly stale).")
                    render_scorecard(cached_sc)
                    st.download_button(label="Download cached JSON", data=json.dumps(cached_sc, indent=2, ensure_ascii=False),
                                    file_name=f"match_{match_id}_cached.json", mime="application/json")
                else:
                    st.info("No cached scoreboard available for this match.")
                # Give a short tip to the user
                if scorecard.get("_status") == 429:
                    st.error("API rate limit reached (HTTP 429). Reduce refresh frequency, increase cache TTL, or upgrade your API plan.")
                continue

            # success: render and update session cache
            render_scorecard(scorecard)
            st.session_state.scorecard_cache[str(match_id)] = scorecard
            exit; 
