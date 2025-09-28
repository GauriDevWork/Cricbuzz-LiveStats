# utils/create_schema_fixed.py
import os
import sys
import re
from sqlalchemy import create_engine, text
from sqlalchemy.engine.url import make_url, URL

# config
DEFAULT_DB_URL = "mysql+pymysql://root:@127.0.0.1:3306/cricketdb"
DATABASE_URL = os.environ.get("DATABASE_URL", DEFAULT_DB_URL)
SEED = os.environ.get("SEED", "0") == "1"
SQL_FILE = os.path.join(os.path.dirname(__file__), "..", "sql", "create_schema_mysql.sql")

def ensure_database_exists(full_url: str):
    url = make_url(full_url)
    db_name = url.database
    if not db_name:
        raise ValueError("DATABASE_URL must include a database name")
    server_url = URL.create(
        drivername=url.drivername,
        username=url.username,
        password=url.password,
        host=url.host or "127.0.0.1",
        port=url.port or 3306,
        database=None,
        query=url.query
    )
    engine_server = create_engine(server_url, future=True)
    create_db_sql = f"CREATE DATABASE IF NOT EXISTS `{db_name}` CHARACTER SET = 'utf8mb4' COLLATE = 'utf8mb4_general_ci';"
    with engine_server.begin() as conn:
        conn.exec_driver_sql(create_db_sql)
    engine_server.dispose()
    print(f"Database `{db_name}` ensured.")

def read_sql_file(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()

def split_create_statements(sql_text):
    """
    Extract top-level CREATE TABLE / USE / other statements.
    This function isolates CREATE TABLE ... ; blocks and returns them in order.
    """
    # Normalize line endings
    s = sql_text
    # Remove leading / trailing whitespace
    s = s.strip()
    # We'll capture statements by splitting on semicolons, but keep block statements intact
    parts = []
    cur = []
    in_s = False
    quote_char = None
    esc = False
    for ch in s:
        if esc:
            cur.append(ch)
            esc = False
            continue
        if ch == "\\":
            cur.append(ch)
            esc = True
            continue
        if ch in ("'", '"'):
            cur.append(ch)
            if not in_s:
                in_s = True
                quote_char = ch
            elif quote_char == ch:
                in_s = False
                quote_char = None
            continue
        if ch == ";" and not in_s:
            stmt = "".join(cur).strip()
            if stmt:
                parts.append(stmt)
            cur = []
            continue
        cur.append(ch)
    tail = "".join(cur).strip()
    if tail:
        parts.append(tail)
    # remove empty and pure comment statements
    stmts = [p.strip() for p in parts if p.strip() and not p.strip().startswith("--")]
    return stmts

def execute_statements_in_db(engine, statements):
    with engine.begin() as conn:
        for idx, stmt in enumerate(statements, 1):
            try:
                conn.exec_driver_sql(stmt)
                print(f"[ok] stmt #{idx}")
            except Exception as e:
                # For CREATE INDEX / duplicate errors you can choose to ignore specific codes,
                # but here we print and re-raise so you can see exact SQL errors if any CREATE failed.
                print(f"[ERROR] stmt #{idx} failed: {e}")
                print("Failed statement (first 300 chars):")
                print(stmt[:300])
                raise

def seed_demo(engine):
    with engine.begin() as conn:
        print("Seeding demo data...")
        conn.exec_driver_sql("""
        INSERT INTO teams (name, country) VALUES ('India','India')
        ON DUPLICATE KEY UPDATE country=VALUES(country);
        """)
        conn.exec_driver_sql("""
        INSERT INTO teams (name, country) VALUES ('Australia','Australia')
        ON DUPLICATE KEY UPDATE country=VALUES(country);
        """)
        conn.exec_driver_sql("""
        INSERT INTO players (full_name, country, playing_role, batting_style, team_id, external_id)
        VALUES ('Virat Kohli','India','Batsman','Right-hand',
          (SELECT id FROM teams WHERE name='India' LIMIT 1),
          'api_player_virat_1')
        ON DUPLICATE KEY UPDATE country=VALUES(country);
        """)
        conn.exec_driver_sql("""
        INSERT INTO venues (name, city, country, capacity, external_id)
        VALUES ('Eden Gardens','Kolkata','India',66000,'api_venue_eden_1')
        ON DUPLICATE KEY UPDATE city=VALUES(city), country=VALUES(country), capacity=VALUES(capacity);
        """)
        conn.exec_driver_sql("""
        INSERT INTO matches (description, match_date, match_type, team1_id, team2_id, venue_id, completed, winner_team_id, victory_margin_runs, victory_type, external_id)
        VALUES (
          'India vs Australia ODI','2024-09-01 10:00:00','ODI',
          (SELECT id FROM teams WHERE name='India' LIMIT 1),
          (SELECT id FROM teams WHERE name='Australia' LIMIT 1),
          (SELECT id FROM venues WHERE name='Eden Gardens' LIMIT 1),
          TRUE, (SELECT id FROM teams WHERE name='India' LIMIT 1), 45, 'runs', 'api_match_ind_v_aus_1'
        )
        ON DUPLICATE KEY UPDATE description=VALUES(description);
        """)
        conn.exec_driver_sql("""
        INSERT INTO player_match_stats (match_id, player_id, team_id, runs, balls_faced, strike_rate, batting_position, innings_number, not_out, external_id)
        VALUES (
          (SELECT id FROM matches WHERE external_id='api_match_ind_v_aus_1' LIMIT 1),
          (SELECT id FROM players WHERE external_id='api_player_virat_1' LIMIT 1),
          (SELECT id FROM teams WHERE name='India' LIMIT 1),
          85, 95, 89.47, 3, 1, FALSE, 'api_pms_1'
        )
        ON DUPLICATE KEY UPDATE runs=VALUES(runs), balls_faced=VALUES(balls_faced);
        """)
        print("Demo data inserted.")

def main():
    print("DATABASE_URL:", DATABASE_URL)
    if not os.path.isfile(SQL_FILE):
        print("SQL file not found:", SQL_FILE)
        sys.exit(1)

    ensure_database_exists(DATABASE_URL)
    engine = create_engine(DATABASE_URL, future=True)

    sql_text = read_sql_file(SQL_FILE)
    statements = split_create_statements(sql_text)
    # We will execute USE db first (if present), then execute CREATE TABLE statements
    # Filter statements: execute all statements, but if a statement starts with CREATE or USE or ALTER run it.
    exec_list = []
    for s in statements:
        s_low = s.strip().lower()
        if s_low.startswith("use ") or s_low.startswith("create ") or s_low.startswith("alter ") or s_low.startswith("insert "):
            exec_list.append(s + ";")  # add semicolon back for clarity

    try:
        execute_statements_in_db(engine, exec_list)
    except Exception as e:
        print("Error while executing statements:", e)
        engine.dispose()
        sys.exit(1)

    # Create indexes separately (if not present)
    index_statements = [
        "CREATE INDEX idx_matches_date ON matches(match_date);",
        "CREATE INDEX idx_matches_type ON matches(match_type);",
        "CREATE INDEX idx_player_stats_player ON player_match_stats(player_id);",
        "CREATE INDEX idx_player_stats_match ON player_match_stats(match_id);",
        "CREATE INDEX idx_bowling_bowler ON bowling_stats(bowler_id);",
        "CREATE INDEX idx_venues_city ON venues(city);"
    ]
    # Execute indexes but ignore specific "table doesn't exist" or duplicate index errors
    with engine.begin() as conn:
        for idx_sql in index_statements:
            try:
                conn.exec_driver_sql(idx_sql)
                print(f"[ok] index created: {idx_sql}")
            except Exception as e:
                print(f"[warn] index creation skipped/failed: {e}")

    if SEED:
        seed_demo(engine)

    engine.dispose()
    print("Done.")

if __name__ == "__main__":
    main()
