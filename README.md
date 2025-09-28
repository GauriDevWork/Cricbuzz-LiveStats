🏏 Cricbuzz LiveStats

📌 Overview
Cricbuzz LiveStats is a Streamlit-based dashboard + ETL pipeline that:
1. Fetches cricket data from the Cricbuzz API (via RapidAPI).
2. Stores structured data in a MySQL database.
3. Provides an interactive Streamlit dashboard to view live stats, run queries, and manage records.

📂 Folder Structure
Cricbuzz-LiveStats/
│── app.py                # Main entry point for Streamlit app
│── requirements.txt       # Python dependencies
│── test-env.py            # Test environment setup
│── .env                   # Environment variables (API keys, DB credentials)
│
├── data/                  # (Optional) Data dumps, backups
├── docs/                  # Documentation
│    └── README.md
├── notebooks/             # Jupyter notebooks for exploration
├── pages/                 # Streamlit multipage app
│    ├── home.py
│    ├── live_matches.py
│    ├── top_stats.py
│    ├── sql_queries.py
│    ├── crud_operations.py
│    ├── insert_query.py
│    └── etl_load.py
├── utils/                 # Utility scripts
│    ├── create_schema.py
│    └── test_mysql_conn.py
└── .streamlit/            # Streamlit configuration

🛠 Tools & Technologies
- Python 3.10+
- Streamlit → Web interface
- SQLAlchemy + PyMySQL → MySQL database connection
- Requests → API integration
- Pandas → Data transformation
- dotenv → Environment variable management
- phpMyAdmin (optional) → GUI for MySQL database management

⚙️ Setup Instructions

1. Clone the repo
   git clone <repo-url>
   cd Cricbuzz-LiveStats

2. Create virtual environment & install dependencies
   python -m venv .venv
   source .venv/bin/activate   # Linux/Mac
   .venv\Scripts\activate      # Windows
   pip install -r requirements.txt

3. Setup environment variables in `.env`
   RAPIDAPI_KEY=your_api_key_here
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=your_password
   DB_NAME=cricketdb

4. Initialize Database
   python utils/create_schema.py

5. Run the app
   streamlit run app.py

📊 Features
- Live Matches → View ongoing matches in real-time
- Top Stats → Analyze batting and bowling records
- SQL Queries → Run predefined and custom SQL queries
- CRUD Operations → Insert, update, and delete records in the DB
- ETL Load → Extract data from API and load into MySQL

🗄 Database Management
The project uses MySQL as the backend database, connected through SQLAlchemy + PyMySQL.

- Manage data directly from the Streamlit app (crud_operations.py, insert_query.py).
- Connect using the MySQL CLI or any database client.
- If installed, phpMyAdmin provides an additional GUI to explore and manage the database.

🚀 Future Enhancements
- Advanced analytics (e.g., strike rate, economy trends)
- Data visualizations with matplotlib or plotly
- Automated scheduled ETL jobs
