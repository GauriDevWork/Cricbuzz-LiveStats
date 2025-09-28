import streamlit as st
from pathlib import Path
import textwrap

st.set_page_config(page_title="Cricbuzz LiveStats — Home", layout="wide")

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
    st.markdown("- [Project docs](#)")

with col2:
    st.title("🏏 Cricbuzz LiveStats Dashboard")
    st.markdown("""
    Welcome to **Cricbuzz LiveStats**, a Streamlit-based project that fetches, stores, and analyzes cricket data 
    using the Cricbuzz API.  

    ### 📌 About the Project
    This project connects to the **Cricbuzz RapidAPI** to fetch cricket data (live matches, player stats, team info) 
    and stores it in a local MySQL database. You can view live statistics, run SQL queries, and perform CRUD operations 
    directly from this app.

    ### 🛠 Tools & Technologies Used
    - **Python 3.10+**
    - **Streamlit** for the web UI  
    - **SQLAlchemy + PyMySQL** for database management  
    - **Requests** for API integration  
    - **Pandas** for data handling  
    - **phpMyAdmin** in Xampp for MySQL database management

    ### 📂 Navigation
    Use the sidebar to move between different pages:
    - **Home** → Overview of the project  
    - **Live Matches** → View ongoing cricket matches  
    - **Top Stats** → Analyze batting/bowling statistics  
    - **SQL Queries** → Run predefined and custom queries  
    - **CRUD Operations** → Insert, update, and delete records  
    - **ETL Load** → Load API data into the database  

    ### 📄 Documentation & Folder Structure
    You can view the detailed documentation and folder structure here:  
    👉 [Project Documentation](docs/README.md)

    """)