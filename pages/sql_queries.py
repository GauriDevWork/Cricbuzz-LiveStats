# pages/sql_queries.py
import streamlit as st
import pandas as pd
import sqlalchemy
import traceback
import re
from sqlalchemy import text

st.set_page_config(page_title="SQL Analytics Page", layout="wide")

# --- UI chrome ---
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
    st.markdown("- [Project docs](https://docs.google.com/document/d/1tV9bz0rtE41Ia9CvM_Z5ISGmojxZ_wDm/edit?usp=sharing&ouid=117739931704852783987&rtpof=true&sd=true)")

with col2:
    st.title("Cricket SQL Analytics (25 Queries)")

    # ---------- DB CREDENTIALS ----------
    DB_HOST = "127.0.0.1"
    DB_PORT = 3306
    DB_USER = "root"
    DB_PASS = ""
    DB_NAME = "cricketdb"
    # -----------------------------------

    @st.cache_resource
    def get_engine():
        url = f"mysql+pymysql://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}?charset=utf8mb4"
        engine = sqlalchemy.create_engine(url, pool_pre_ping=True)
        return engine

    engine = get_engine()

    try:
        with engine.connect() as conn:
            conn.execute(text("SELECT 1"))
        st.success("Connected to database.")
    except Exception as e:
        st.error("DB connection failed.")
        st.exception(e)
        st.stop()

    # ---------- Prewritten Queries ----------
    queries = {
        # Beginner
        "Q1 Players from India": """
            SELECT player_id, name, full_name, playing_role, batting_style, bowling_style
            FROM players
            WHERE country = 'India'
            ORDER BY name;
        """,
        "Q2 Recent matches (last 7 days)": """
            SELECT match_id, match_desc, team1_name, team2_name, venue_name, venue_city, match_start
            FROM matches
            WHERE match_start >= DATE_SUB(UTC_TIMESTAMP(), INTERVAL 7 DAY)
            ORDER BY match_start DESC;
        """,
        "Q3 Top 10 ODI run scorers": """
            SELECT p.name, ps.runs AS total_runs, ps.batting_avg, ps.centuries
            FROM player_stats ps
            JOIN players p ON p.player_id = ps.player_id
            WHERE ps.format = 'ODI'
            ORDER BY ps.runs DESC
            LIMIT 10;
        """,
        "Q4 Venues with capacity > 30000": """
            SELECT name AS venue_name, city, country, capacity
            FROM venues
            WHERE capacity > 30000
            ORDER BY capacity DESC;
        """,
        "Q5 Team wins": """
            SELECT winner AS team_name, COUNT(*) AS wins
            FROM matches
            WHERE winner IS NOT NULL
            GROUP BY winner
            ORDER BY wins DESC;
        """,
        "Q6 Player count by role": """
            SELECT playing_role, COUNT(*) AS player_count
            FROM players
            GROUP BY playing_role
            ORDER BY player_count DESC;
        """,
        "Q7 Highest individual score per format": """
            SELECT format, MAX(highest) AS highest_score
            FROM player_stats
            GROUP BY format;
        """,
        "Q8 Series started in 2024": """
            SELECT name, host_country, match_type, start_date, planned_matches
            FROM series
            WHERE YEAR(start_date) = 2024;
        """,

        # Intermediate
        "Q9 All-rounders >1000 runs & >50 wickets": """
            SELECT p.name, SUM(ps.runs) AS total_runs, SUM(ps.wickets) AS total_wickets
            FROM player_stats ps
            JOIN players p ON p.player_id = ps.player_id
            GROUP BY p.player_id, p.name
            HAVING total_runs > 1000 AND total_wickets > 50;
        """,
        "Q10 Last 20 completed matches": """
            SELECT match_desc, team1_name, team2_name, winner, victory_margin, victory_type, venue_name, match_start
            FROM matches
            WHERE status = 'completed'
            ORDER BY match_start DESC
            LIMIT 20;
        """,
        "Q11 Player performance across formats": """
            SELECT p.name,
                MAX(CASE WHEN ps.format='Test' THEN ps.runs END) AS test_runs,
                MAX(CASE WHEN ps.format='ODI' THEN ps.runs END) AS odi_runs,
                MAX(CASE WHEN ps.format='T20I' THEN ps.runs END) AS t20_runs,
                ROUND(AVG(ps.batting_avg),2) AS overall_avg
            FROM players p
            JOIN player_stats ps ON p.player_id = ps.player_id
            GROUP BY p.player_id, p.name
            HAVING COUNT(DISTINCT ps.format) >= 2;
        """,
        "Q12 Home vs Away wins": """
            SELECT t.name AS team_name,
                   CASE WHEN v.country = t.country THEN 'Home' ELSE 'Away' END AS where_played,
                   COUNT(*) AS wins
            FROM matches m
            JOIN teams t ON t.name = m.winner
            JOIN venues v ON v.venue_id = m.venue_id
            GROUP BY t.name, where_played;
        """,
        "Q13 Partnerships >=100 runs": """
            SELECT match_id, innings_number, batsman1_name, batsman2_name, partnership_runs
            FROM partnerships
            WHERE partnership_runs >= 100
            ORDER BY partnership_runs DESC;
        """,
        "Q14 Bowling performance at venues": """
            SELECT br.player_name, m.venue_name,
                   COUNT(DISTINCT br.match_id) AS matches_played,
                   SUM(br.wickets) AS total_wickets,
                   ROUND(AVG(br.economy),2) AS avg_economy
            FROM bowling_records br
            JOIN matches m ON m.match_id = br.match_id
            GROUP BY br.player_id, br.player_name, m.venue_name
            HAVING matches_played >= 3;
        """,
        "Q15 Close matches performance": """
            SELECT p.name, COUNT(DISTINCT m.match_id) AS close_matches
            FROM matches m
            JOIN players p ON 1=1
            WHERE (m.victory_type='runs' AND CAST(m.victory_margin AS UNSIGNED) < 50)
               OR (m.victory_type='wickets' AND CAST(m.victory_margin AS UNSIGNED) < 5)
            GROUP BY p.player_id, p.name;
        """,
        "Q16 Batting yearly since 2020": """
            SELECT p.name, YEAR(m.match_start) AS yr,
                   ROUND(AVG(ps.runs),2) AS avg_runs,
                   ROUND(AVG(ps.strike_rate),2) AS avg_sr
            FROM player_stats ps
            JOIN players p ON p.player_id = ps.player_id
            JOIN matches m ON 1=1
            WHERE m.match_start >= '2020-01-01'
            GROUP BY p.name, YEAR(m.match_start);
        """,

        # Advanced
        "Q17 Toss advantage": """
            SELECT toss_decision,
                   SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END) AS wins_when_won_toss,
                   COUNT(*) AS total_matches,
                   ROUND(100*SUM(CASE WHEN toss_winner = winner THEN 1 ELSE 0 END)/COUNT(*),2) AS pct
            FROM matches
            GROUP BY toss_decision;
        """,
        "Q18 Economical bowlers ODI/T20": """
            SELECT br.player_name,
                   SUM(br.runs_conceded)/NULLIF(SUM(br.overs),0) AS economy,
                   SUM(br.wickets) AS total_wickets,
                   COUNT(DISTINCT br.match_id) AS matches
            FROM bowling_records br
            JOIN matches m ON m.match_id = br.match_id
            WHERE m.format IN ('ODI','T20I')
            GROUP BY br.player_id, br.player_name
            HAVING matches >= 10
            ORDER BY economy ASC;
        """,
        "Q19 Consistent batsmen (since 2022)": """
            SELECT p.name, AVG(ps.runs) AS avg_runs, STDDEV_POP(ps.runs) AS sd_runs
            FROM player_stats ps
            JOIN players p ON p.player_id = ps.player_id
            WHERE ps.created_at >= '2022-01-01'
            GROUP BY p.player_id, p.name
            HAVING COUNT(*) >= 10
            ORDER BY sd_runs ASC;
        """,
        "Q20 Matches per format + batting avg": """
            SELECT p.name,
                SUM(CASE WHEN ps.format='Test' THEN ps.matches ELSE 0 END) AS test_matches,
                SUM(CASE WHEN ps.format='ODI' THEN ps.matches ELSE 0 END) AS odi_matches,
                SUM(CASE WHEN ps.format='T20I' THEN ps.matches ELSE 0 END) AS t20_matches,
                ROUND(AVG(ps.batting_avg),2) AS overall_avg,
                SUM(ps.matches) AS total_matches
            FROM players p
            JOIN player_stats ps ON ps.player_id = p.player_id
            GROUP BY p.player_id, p.name
            HAVING total_matches >= 20;
        """,
        "Q21 Performance ranking": """
            SELECT p.name,
                (SUM(ps.runs)*0.01 + AVG(ps.batting_avg)*0.5 + AVG(ps.strike_rate)*0.3
                + SUM(ps.wickets)*2 + (50-AVG(ps.bowling_avg))*0.5 + (6-AVG(ps.economy))*2) AS perf_score
            FROM players p
            JOIN player_stats ps ON p.player_id = ps.player_id
            GROUP BY p.player_id, p.name
            ORDER BY perf_score DESC;
        """,
        "Q22 Head-to-head analysis": """
            SELECT LEAST(team1_name, team2_name) AS team_a,
                   GREATEST(team1_name, team2_name) AS team_b,
                   COUNT(*) AS total_matches,
                   SUM(CASE WHEN winner=team1_name THEN 1 ELSE 0 END) AS wins_team1,
                   SUM(CASE WHEN winner=team2_name THEN 1 ELSE 0 END) AS wins_team2
            FROM matches
            WHERE match_start >= DATE_SUB(NOW(), INTERVAL 3 YEAR)
            GROUP BY team_a, team_b
            HAVING COUNT(*) >= 5;
        """,
        "Q23 Recent player form (template)": """
            -- Needs per-innings data. Placeholder.
            SELECT player_id, name
            FROM players
            LIMIT 50;
        """,
        "Q24 Successful partnerships": """
            SELECT batsman1_name, batsman2_name,
                   COUNT(*) AS total_partnerships,
                   AVG(partnership_runs) AS avg_runs,
                   MAX(partnership_runs) AS highest
            FROM partnerships
            GROUP BY batsman1_id, batsman2_id
            HAVING COUNT(*) >= 5
            ORDER BY avg_runs DESC;
        """,
        "Q25 Player performance evolution (template)": """
            -- Requires batting_innings table. Placeholder.
            SELECT * FROM batting_innings LIMIT 50;
        """,
    }

    queries["Custom SQL (paste below)"] = "-- paste SQL below --"

    choice = st.selectbox("Select a query:", list(queries.keys()))
    sql = queries[choice]

    st.markdown("**SQL to be executed (editable):**")
    edit_sql = st.text_area("SQL", value=sql.strip(), height=220)

    def drop_header_row_if_needed(df: pd.DataFrame) -> pd.DataFrame:
        if df.empty: return df
        try:
            first = df.iloc[0].astype(str)
            cols = df.columns.astype(str)
            matches = sum(1 for c, v in zip(cols, first) if c.lower() == v.lower())
            if matches >= max(2, int(len(cols)/2)):
                df = df.iloc[1:].reset_index(drop=True)
        except Exception:
            return df
        return df

    def pretty_column_name(col: str) -> str:
        if not col: return col
        specials = {
            "player_id":"Player ID","match_id":"Match ID","match_desc":"Match Description",
            "batting_style":"Batting Style","bowling_style":"Bowling Style",
            "venue_name":"Venue","venue_city":"Venue City","total_runs":"Total Runs",
            "batting_avg":"Batting Avg","centuries":"Centuries"
        }
        if col in specials: return specials[col]
        s = col.replace("_"," ").title()
        return s.replace("Id","ID")

    def remove_pk_and_index_and_prettify(df: pd.DataFrame) -> pd.DataFrame:
        df = df.drop(columns=[c for c in ["pk","id"] if c in df.columns], errors="ignore")
        df = df.reset_index(drop=True)
        return df.rename(columns={c:pretty_column_name(c) for c in df.columns})

    if st.button("Execute Query"):
        try:
            df = pd.read_sql_query(text(edit_sql), con=engine)
            df = drop_header_row_if_needed(df)
            df = remove_pk_and_index_and_prettify(df)

            if df.empty:
                st.info("No rows returned.")
                st.dataframe(df)
            else:
                st.success(f"{len(df)} rows returned.")
                st.dataframe(df.style.hide(axis="index"))
                csv = df.to_csv(index=False).encode("utf-8")
                st.download_button("Download CSV", csv, file_name="query_results.csv", mime="text/csv")
        except Exception as e:
            st.error("Query failed.")
            st.code(edit_sql, language="sql")
            st.exception(e)
            st.text_area("Traceback", traceback.format_exc(), height=300)
