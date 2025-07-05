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

### 📌 1. `teams` Table

```sql
CREATE TABLE teams (
    team_id INTEGER NOT NULL AUTO_INCREMENT COMMENT 'PK: PK_TEAM_ID',
    team_name VARCHAR(255) NOT NULL COMMENT 'TEAM NAME',
    team_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() COMMENT 'TEAM CREATED DATE',
    team_modified DATETIME NULL COMMENT 'TEAM MODIFIED DATE',
    team_status TINYINT NOT NULL DEFAULT 1 COMMENT '0-InActive,1-Active,2-Deleted',
    CONSTRAINT PK_TEAM_ID PRIMARY KEY (team_id)
) ENGINE=InnoDB COMMENT='TABLE TO STORE TEAM DETAILS';

📌 2. team_matches Table
CREATE TABLE team_matches (
    match_id INTEGER NOT NULL AUTO_INCREMENT COMMENT 'PK: PK_MATCH_ID',
    match_team1_id INTEGER NOT NULL COMMENT 'FK: MATCH_TEAM1_ID → TEAMS(team_id)',
    match_team2_id INTEGER NOT NULL COMMENT 'FK: MATCH_TEAM2_ID → TEAMS(team_id)',
    match_team1_score INTEGER NOT NULL COMMENT 'TEAM1 SCORE',
    match_team2_score INTEGER NOT NULL COMMENT 'TEAM2 SCORE',
    match_played_ground VARCHAR(255) NOT NULL COMMENT 'MATCH PLAYED GROUND',
    match_game_status VARCHAR(255) NOT NULL COMMENT 'GAME FINAL STATUS',
    CONSTRAINT PK_MATCH_ID PRIMARY KEY (match_id),
    CONSTRAINT FK_MATCH_TEAM1_ID FOREIGN KEY (match_team1_id) REFERENCES teams(team_id),
    CONSTRAINT FK_MATCH_TEAM2_ID FOREIGN KEY (match_team2_id) REFERENCES teams(team_id)
) ENGINE=InnoDB COMMENT='TABLE TO STORE MATCH DETAILS';

🔁 Sample Data
INSERT INTO teams (team_id, team_name) VALUES
(1, 'Hills Stay'),
(2, 'Athelitic'),
(3, 'Complete Game');

UPDATE teams SET team_status = 1 WHERE team_id IN (1, 2, 3);

INSERT INTO team_matches (match_id, match_team1_id, match_team2_id, match_team1_score, match_team2_score, match_played_ground, match_game_status) VALUES
(1, 1, 2, 40, 60, 'Hills Stay - Athelitic Ground','Team2 Won'),
(2, 2, 1, 60, 30, 'Athelitic - Hills Stay Ground','Team1 Won'),
(3, 1, 2, 70, 80, 'Hills Stay - Athelitic Ground', 'Team2 Won'),
(4, 2, 3, 70, 80, 'Athelitic - Complete Game Ground','Team2 Won'),
(5, 2, 3, 70, 80, 'Athelitic - Complete Game Ground','Team2 Won');

