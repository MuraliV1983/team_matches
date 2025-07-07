# 🏏 Team Matches API — Flask + MySQL

A lightweight Flask + MySQL application to track matches played between two teams — including scores, ground details, and match status.

---

## 🚀 Features

- ✅ List all matches played by a given team
- 🧠 Smart opponent team identification
- ⚽ Match scores, ground, and game outcome
- 📦 RESTful API with JSON response
- 🔒 Clean DB structure with foreign key integrity

---

## 🛠️ Tech Stack

- **Backend**: Python, Flask
- **Database**: MySQL
- **Driver**: PyMySQL

---

## 📁 Project Structure

team_matches/
├── app.py # Main Flask app with API routes
├── db_config.py # MySQL DB connection setup
├── requirements.txt # Python dependencies
└── README.md # You are here!


---

## 🔌 API Endpoint

### ➤ Get Match Details by Team ID
GET /team/<team_id>/matches

GET /team/2/matches


#### 🔁 Sample Response
```json
[
  {
    "MatchID": 1,
    "TeamName": "Athelitic",
    "Opponent_TeamName": "Hills Stay",
    "Team1_Score": 40,
    "Team2_Score": 60,
    "Match_Played_Ground": "Hills Stay - Athelitic Ground",
    "Game_Status": "Team2 Won"
  }
]
🧪 How to Run Locally
Clone the repo

git clone https://github.com/MuraliV1983/team-matches.git
cd team-matches
Install Python packages

pip install -r requirements.txt
Set up MySQL database

Create DB and run the SQL script provided (in database.sql or inside your setup)

Ensure team statuses are set to 1 (active)

Run the Flask app
python app.py

🔐 Sample Tables (MySQL)
CREATE TABLE teams (...);
CREATE TABLE team_matches (...);
👉 Use your MySQL script to insert teams and matches


❤️ Connect
Built with care by Murali V
Follow the hashtag: #MuraliCodes to learn and grow together!

---

## 🗄️ Database Schema (MySQL)
The full database schema is available in:

```bash
team_matches.sql

This script includes:

teams table

organizations table

team_matches with latest fields:

match_orgz_id

match_played_date

match_status

viw_org_team_matches view for fast and user-oriented querying

Sample insert data for testing


✅ Add in 🚀 Features section:

- 🏢 Organization-based team match tracking
- 📆 Match play date support
- 📊 View-based data API for better performance

### ➤ Get Match Details by Team ID
`GET /team/<team_id>/matches`

Example:

---

✅ Replace or Extend 🔌 API Endpoint Section:
### ➤ Get Matches by Organization + Team  
Using a view (`viw_org_team_matches`) that simplifies team-vs-team match data with your/opponent details.

`GET /org/<orgz_id>/team/<team_id>/matches`

Example:
GET /org/1/team/1/matches
#### 🔁 Sample Response
```json
[
  {
    "match_id": 1,
    "match_orgz_id": 1,
    "organization_name": "Organization1",
    "your_team_id": 1,
    "your_team_name": "Hills Stay",
    "opponent_team_id": 2,
    "opponent_team_name": "Athelitic",
    "your_team_score": 40,
    "opponent_team_score": 60,
    "match_played_date": "2025-07-10T00:00:00",
    "match_played_ground": "Hills Stay - Athelitic Ground",
    "match_game_status": "Team2 Won"
  }
]
