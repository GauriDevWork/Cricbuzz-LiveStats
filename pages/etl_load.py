import os, json, time
import requests
import pymysql
from dotenv import load_dotenv

load_dotenv()
RKEY = os.getenv("RAPIDAPI_KEY")
RHOST = os.getenv("RAPIDAPI_HOST")

DB_CFG = {
    "host": "127.0.0.1",
    "user": "root",   # or your user
    "password": "",
    "db": "cricketdb",
    "charset": "utf8mb4",
    "cursorclass": pymysql.cursors.DictCursor
}

HEADERS = {
    "x-rapidapi-key": RKEY,
    "x-rapidapi-host": RHOST
}

def call_api(path, params=None):
    url = f"https://{RHOST}{path}"
    resp = requests.get(url, headers=HEADERS, params=params or {})
    resp.raise_for_status()
    return resp.json()

def upsert_player(conn, p):
    # p is a dict with keys: player_id, full_name, country, playing_role, batting_style, bowling_style, dob
    sql = """
    INSERT INTO players (player_id, full_name, country, playing_role, batting_style, bowling_style, dob)
    VALUES (%s,%s,%s,%s,%s,%s,%s)
    ON DUPLICATE KEY UPDATE
      full_name=VALUES(full_name),
      country=VALUES(country),
      playing_role=VALUES(playing_role),
      batting_style=VALUES(batting_style),
      bowling_style=VALUES(bowling_style),
      dob=VALUES(dob)
    """
    with conn.cursor() as cur:
        cur.execute(sql, (p['player_id'], p['full_name'], p.get('country'), p.get('playing_role'),
                          p.get('batting_style'), p.get('bowling_style'), p.get('dob')))

def upsert_team(conn, t):
    sql = "INSERT INTO teams (team_id,name,country) VALUES(%s,%s,%s) ON DUPLICATE KEY UPDATE name=VALUES(name), country=VALUES(country)"
    with conn.cursor() as cur:
        cur.execute(sql, (t['team_id'], t['name'], t.get('country')))

# You would implement similar upsert functions for venues, series, matches, player_match_stats, partnerships.

def main():
    conn = pymysql.connect(**DB_CFG)
    try:
        players_list = call_api("/teams/v1/2/players")  # <-- replace with real endpoint
        for p_raw in players_list.get('data', []):
            p = {
                'player_id': int(p_raw.get('id')),
                'full_name': p_raw.get('name'),
                'country': p_raw.get('country'),
                'playing_role': p_raw.get('role'),
                'batting_style': p_raw.get('battingStyle'),
                'bowling_style': p_raw.get('bowlingStyle'),
                'dob': p_raw.get('dob')
            }
            upsert_player(conn, p)
        conn.commit()

        # Repeat: fetch teams, matches, venues, series, and insert/upsert similarly.
        # For match scorecards you will likely need to call a scorecard endpoint for each match_id,
        # then write rows to matches and player_match_stats.

    finally:
        conn.close()

if __name__ == "__main__":
    main()
