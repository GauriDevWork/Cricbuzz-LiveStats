# test_mysql_conn.py
import os
from sqlalchemy import create_engine, text

# Adjust if root has a password; typical local XAMPP root might have an empty password.
HOST = os.environ.get("DB_HOST", "127.0.0.1")
PORT = os.environ.get("DB_PORT", "3306")
USER = os.environ.get("DB_USER", "root")
PASSWORD = os.environ.get("DB_PASS", "")   # set to your root password if set
DB = os.environ.get("DB_NAME", "cricketdb")         # leave blank to connect without specifying DB

# build SQLAlchemy URL
if DB:
    DATABASE_URL = f"mysql+pymysql://{USER}:{PASSWORD}@{HOST}:{PORT}/{DB}"
else:
    DATABASE_URL = f"mysql+pymysql://{USER}:{PASSWORD}@{HOST}:{PORT}/"

print("Connecting with:", DATABASE_URL.replace(PASSWORD, "****"))

engine = create_engine(DATABASE_URL, future=True)

with engine.connect() as conn:
    # If no DB specified, list databases
    if not DB:
        res = conn.execute(text("SHOW DATABASES;"))
        print("Databases:")
        for row in res:
            print(" -", row[0])
    else:
        # quick sanity query
        res = conn.execute(text("SELECT VERSION();"))
        print("MySQL version:", res.scalar())
