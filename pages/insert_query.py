#!/usr/bin/env python3
"""
ingest_matches.py

Fetches matches (live/upcoming/recent) from RapidAPI Cricbuzz endpoints and upserts
rows into the 'series', 'venues' and 'matches' tables of your local `cricketdb`.

Usage:
    pip install requests sqlalchemy pymysql python-dateutil
    export RAPIDAPI_KEY="your_key_here"   # optional, falls back to embedded key
    python ingest_matches.py
"""

import os
import json
import time
import logging
from datetime import datetime
from dateutil import parser as dtparser  # pip install python-dateutil
import requests
import sqlalchemy
from sqlalchemy import text

# ---------- CONFIG ----------
RAPIDAPI_KEY = "72d9f8fec5mshfc0f2f47123393ep150dedjsn98f5405906fe"
RAPIDAPI_HOST = "cricbuzz-cricket.p.rapidapi.com"
BASE = "https://cricbuzz-cricket.p.rapidapi.com"
HEADERS = {"x-rapidapi-key": RAPIDAPI_KEY, "x-rapidapi-host": RAPIDAPI_HOST}

DB_HOST = "127.0.0.1"
DB_PORT = "3306"
DB_USER = "root"
DB_PASS = ""
DB_NAME = "cricketdb"

# logging
logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")

# ---------- helpers ----------
def get(url_path, params=None, retries=2):
    url = BASE + url_path
    for attempt in range(retries+1):
        try:
            logging.info(f"GET {url} params={params}")
            r = requests.get(url, headers=HEADERS, params=params, timeout=20)
            r.raise_for_status()
            return r.json()
        except Exception as e:
            logging.warning(f"GET failed ({e}), attempt {attempt+1}/{retries+1}")
            time.sleep(0.8)
    raise RuntimeError(f"Failed to GET {url}")

def safe_parse_dt(val):
    if not val:
        return None
    if isinstance(val, (int, float)):
        # maybe epoch ms?
        try:
            return datetime.utcfromtimestamp(int(val)//1000 if int(val) > 1e10 else int(val))
        except Exception:
            return None
    try:
        return dtparser.parse(val)
    except Exception:
        return None

def normalize_match_obj(m):
    """Extract common fields robustly from potentially variable JSON shapes."""
    # prefer commonly used keys
    match_id = m.get("matchId") or m.get("id") or m.get("mid") or m.get("idStr") or m.get("match_id")
    match_desc = m.get("matchDesc") or m.get("matchDescText") or m.get("header") or m.get("title") or m.get("matchDesc")
    # teams
    team1_name = m.get("team1Name") or m.get("teamA") or (m.get("team1") or {}).get("name") or None
    team2_name = m.get("team2Name") or m.get("teamB") or (m.get("team2") or {}).get("name") or None
    team1_id = (m.get("team1") or {}).get("id") if isinstance(m.get("team1"), dict) else None
    team2_id = (m.get("team2") or {}).get("id") if isinstance(m.get("team2"), dict) else None
    # venue
    venue = m.get("venue") or m.get("ground") or {}
    venue_id = venue.get("id") or venue.get("venueId") or m.get("venueId")
    venue_name = venue.get("name") or venue.get("venue") or m.get("venue_name")
    venue_city = venue.get("city") or m.get("venueCity")
    # series
    series_id = m.get("seriesId") or m.get("series_id") or (m.get("series") or {}).get("id") or m.get("seriesIdStr")
    series_name = m.get("seriesName") or (m.get("series") or {}).get("name")
    # meta
    match_start = None
    for k in ("start", "startTime", "matchStart", "date", "begin_at", "match_date"):
        if m.get(k):
            match_start = m.get(k)
            break
    match_start = safe_parse_dt(match_start)
    status = m.get("status") or m.get("state") or m.get("statusText")
    toss_winner = m.get("tossWinner")
    toss_decision = m.get("tossDecision")
    winner = m.get("winner") or m.get("result") or None
    victory_margin = m.get("resultMargin") or m.get("victory_margin") or None
    victory_type = None
    if victory_margin:
        s = str(victory_margin).lower()
        victory_type = "wickets" if "wkt" in s or "wicket" in s else "runs" if any(c.isdigit() for c in s) else None
    fmt = m.get("matchType") or m.get("format") or m.get("type")
    return {
        "match_id": match_id,
        "match_desc": match_desc,
        "team1_id": team1_id,
        "team1_name": team1_name,
        "team2_id": team2_id,
        "team2_name": team2_name,
        "venue_id": str(venue_id) if venue_id is not None else None,
        "venue_name": venue_name,
        "venue_city": venue_city,
        "match_start": match_start,
        "status": status,
        "toss_winner": toss_winner,
        "toss_decision": toss_decision,
        "winner": winner,
        "victory_margin": victory_margin,
        "victory_type": victory_type,
        "format": fmt,
        "series_id": str(series_id) if series_id is not None else None,
        "series_name": series_name,
        "raw_json": json.dumps(m, ensure_ascii=False)
    }

# ---------- DB helpers ----------
def get_engine():
    url = f"mysql+pymysql://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}?charset=utf8mb4"
    engine = sqlalchemy.create_engine(url, pool_pre_ping=True)
    return engine

def upsert_series(conn, series_id, series_name):
    if not series_id:
        return
    q = text("""
    INSERT INTO series (series_id, name, raw_json)
    VALUES (:series_id, :name, :raw_json)
    ON DUPLICATE KEY UPDATE name = VALUES(name), raw_json = VALUES(raw_json)
    """)
    conn.execute(q, {"series_id": str(series_id), "name": series_name or None, "raw_json": json.dumps({"series_id":series_id,"name":series_name}, ensure_ascii=False)})

def upsert_venue(conn, venue_id, venue_name, venue_city):
    if not (venue_id or venue_name):
        return
    # use venue_id if present, otherwise create a pseudo id from name
    vid = str(venue_id) if venue_id else f"v__{venue_name[:80]}" 
    q = text("""
    INSERT INTO venues (venue_id, name, city, raw_json)
    VALUES (:venue_id, :name, :city, :raw_json)
    ON DUPLICATE KEY UPDATE name = VALUES(name), city = VALUES(city), raw_json = VALUES(raw_json)
    """)
    raw = json.dumps({"venue_id": venue_id, "name": venue_name, "city": venue_city}, ensure_ascii=False)
    conn.execute(q, {"venue_id": vid, "name": venue_name, "city": venue_city, "raw_json": raw})
    return vid

def upsert_match(conn, m):
    # insert into matches, ON DUPLICATE KEY UPDATE
    q = text("""
    INSERT INTO matches 
      (match_id, match_desc, team1_id, team1_name, team2_id, team2_name, venue_id, venue_name, venue_city, match_start, status, toss_winner, toss_decision, winner, victory_margin, victory_type, format, raw_json, series_id)
    VALUES
      (:match_id, :match_desc, :team1_id, :team1_name, :team2_id, :team2_name, :venue_id, :venue_name, :venue_city, :match_start, :status, :toss_winner, :toss_decision, :winner, :victory_margin, :victory_type, :format, :raw_json, :series_id)
    ON DUPLICATE KEY UPDATE
      match_desc = VALUES(match_desc),
      team1_id = VALUES(team1_id), team1_name = VALUES(team1_name),
      team2_id = VALUES(team2_id), team2_name = VALUES(team2_name),
      venue_id = VALUES(venue_id), venue_name = VALUES(venue_name), venue_city = VALUES(venue_city),
      match_start = VALUES(match_start), status = VALUES(status),
      toss_winner = VALUES(toss_winner), toss_decision = VALUES(toss_decision),
      winner = VALUES(winner), victory_margin = VALUES(victory_margin), victory_type = VALUES(victory_type),
      format = VALUES(format), raw_json = VALUES(raw_json), series_id = VALUES(series_id)
    """)
    params = {
        "match_id": str(m["match_id"]) if m["match_id"] is not None else None,
        "match_desc": m["match_desc"],
        "team1_id": m["team1_id"],
        "team1_name": m["team1_name"],
        "team2_id": m["team2_id"],
        "team2_name": m["team2_name"],
        "venue_id": m["venue_id"],
        "venue_name": m["venue_name"],
        "venue_city": m["venue_city"],
        "match_start": m["match_start"].strftime("%Y-%m-%d %H:%M:%S") if m["match_start"] else None,
        "status": m["status"],
        "toss_winner": m["toss_winner"],
        "toss_decision": m["toss_decision"],
        "winner": m["winner"],
        "victory_margin": m["victory_margin"],
        "victory_type": m["victory_type"],
        "format": m["format"],
        "raw_json": m["raw_json"],
        "series_id": m["series_id"]
    }
    conn.execute(q, params)

# ---------- main flow ----------
def main():
    engine = get_engine()
    with engine.connect() as conn:
        # verify connectivity
        conn.execute(text("SELECT 1"))

        endpoints = ["/matches/v1/live", "/matches/v1/upcoming", "/matches/v1/recent"]
        processed = 0
        for ep in endpoints:
            try:
                data = get(ep)
            except Exception as e:
                logging.warning(f"Skipping {ep}: {e}")
                continue

            # robustly collect candidate match dicts
            candidates = []
            def collect(o):
                if isinstance(o, dict):
                    # heuristics: dicts with matchId or team1/team2 fields
                    if any(k in o for k in ("matchId","mid","match_id","team1Name","teamA","team1")):
                        candidates.append(o)
                    else:
                        for v in o.values():
                            collect(v)
                elif isinstance(o, list):
                    for item in o:
                        collect(item)
            collect(data)

            # fallback: if top-level is list of matches
            if isinstance(data, list) and data and isinstance(data[0], dict):
                candidates.extend(data)

            # dedupe by matchId if possible
            seen = set()
            unique = []
            for c in candidates:
                mid = c.get("matchId") or c.get("id") or c.get("mid")
                if mid:
                    if mid in seen: 
                        continue
                    seen.add(mid)
                unique.append(c)

            logging.info(f"{ep} -> {len(unique)} candidate match objects")

            for raw_m in unique:
                nm = normalize_match_obj(raw_m)
                # ensure series exists first (prevents fk error)
                if nm.get("series_id"):
                    try:
                        upsert_series(conn, nm["series_id"], nm.get("series_name"))
                    except Exception as e:
                        logging.warning(f"Could not upsert series {nm.get('series_id')}: {e}")
                # ensure venue exists (and get canonical venue_id)
                if nm.get("venue_id") or nm.get("venue_name"):
                    try:
                        # upsert venue and get canonical id used in DB
                        canonical_vid = upsert_venue(conn, nm.get("venue_id"), nm.get("venue_name"), nm.get("venue_city"))
                        # if venue_id not present in nm, use canonical_vid
                        if not nm.get("venue_id"):
                            nm["venue_id"] = canonical_vid
                    except Exception as e:
                        logging.warning(f"Could not upsert venue: {e}")

                # finally insert match
                try:
                    upsert_match(conn, nm)
                    processed += 1
                except Exception as e:
                    logging.error(f"[ERROR] upsert_match failed for {nm.get('match_id')}: {e}")

                time.sleep(0.05)

        logging.info(f"Processed {processed} matches across endpoints.")

if __name__ == "__main__":
    main()
