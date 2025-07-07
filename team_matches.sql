

DROP TABLE IF EXISTS organizations;
CREATE TABLE organizations (
  orgz_id int NOT NULL AUTO_INCREMENT COMMENT 'PK: PK_ORGZ_ID',
  orgz_name varchar(255) NOT NULL COMMENT 'ORGANIZATION NAME',
  orgz_created datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ORGANIZATION CREATED DATE',
  orgz_status tinyint NOT NULL DEFAULT '1' COMMENT '0-Inactive,1- Active,2- Deleted',
  PRIMARY KEY (orgz_id)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='TABLE TO STORE THE ORGANIZATIONS';
INSERT INTO organizations VALUES (1,'Organization1','2025-07-07 10:31:22',1),(2,'Organization2','2025-07-07 10:31:22',1);

DROP TABLE IF EXISTS team_matches;
CREATE TABLE team_matches (
  match_id int NOT NULL AUTO_INCREMENT COMMENT 'PK: PK_MATCH_ID',
  match_orgz_id int NOT NULL COMMENT 'FK: FK_MATCH_ORGZ_ID REFER ORGANIZATIONS(ORGZ_ID)',
  match_team1_id int NOT NULL COMMENT 'FK: FK_MATCH_TEAM1_ID REFER TEAMS(TEAM_ID)',
  match_team2_id int NOT NULL COMMENT 'FK: FK_MATCH_TEAM2_ID REFER TEAMS(TEAM_ID)',
  match_team1_score int NOT NULL COMMENT 'TEAM1 SCORE',
  match_team2_score int NOT NULL COMMENT 'TEAM2 SCORE',
  match_played_date datetime NOT NULL COMMENT 'MATCH PLAYED DATE',
  match_played_ground varchar(255) NOT NULL COMMENT 'MATCH PLAYED GROUND NAME',
  match_game_status varchar(255) NOT NULL COMMENT 'GAME FINAL STATUS',
  PRIMARY KEY (match_id),
  KEY FK_MATCH_TEAM1_ID (match_team1_id),
  KEY FK_MATCH_TEAM2_ID (match_team2_id),
  KEY FK_MATCH_ORGZ_ID (match_orgz_id),
  CONSTRAINT FK_MATCH_ORGZ_ID FOREIGN KEY (match_orgz_id) REFERENCES organizations (orgz_id),
  CONSTRAINT FK_MATCH_TEAM1_ID FOREIGN KEY (match_team1_id) REFERENCES teams (team_id),
  CONSTRAINT FK_MATCH_TEAM2_ID FOREIGN KEY (match_team2_id) REFERENCES teams (team_id)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='TABLE TO STORE THE TEAM MATCHES';
INSERT INTO team_matches VALUES (1,1,1,2,40,60,'2025-07-10 00:00:00','Hills Stay - Athelitic Ground','Team2 Won'),(2,1,2,1,60,30,'2025-07-11 00:00:00','Athelitic - Hills Stay Ground','Team1 Won'),(3,1,1,2,70,80,'2025-07-12 00:00:00','Hills Stay - Athelitic Ground','Team2 Won'),(4,1,2,3,70,80,'2025-07-13 00:00:00','Athelitic - Complete Game Ground','Team2 Won'),(5,1,2,3,70,80,'2025-07-14 00:00:00','Athelitic - Complete Game Ground','Team2 Won'),(6,2,1,2,70,80,'2025-07-14 00:00:00','Hills Stay - Athelitic Ground','Team2 Won'),(7,2,2,3,70,80,'2025-07-15 00:00:00','Athelitic - Complete Game Ground','Team2 Won'),(8,2,2,3,70,80,'2025-07-16 00:00:00','Athelitic - Complete Game Ground','Team2 Won');


DROP TABLE IF EXISTS teams;
CREATE TABLE teams (
  team_id int NOT NULL AUTO_INCREMENT COMMENT 'PK: PK_TEAM_ID',
  team_name varchar(255) NOT NULL COMMENT 'TEAM NAME',
  team_created datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'TEAM CREATED DATE',
  team_modified datetime DEFAULT NULL COMMENT 'TEAM MODIFIED DATE',
  team_status tinyint NOT NULL DEFAULT '1' COMMENT '0-InActive,1-Active,2-Deleted',
  PRIMARY KEY (team_id)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='TABLE TO STORE TEAM DETAILS';
INSERT INTO teams VALUES (1,'Hills Stay','2025-07-05 11:23:34',NULL,1),(2,'Athelitic','2025-07-05 11:23:34',NULL,1),(3,'Complete Game','2025-07-05 11:23:34',NULL,1);

CREATE OR REPLACE VIEW viw_org_team_matches AS
SELECT
    m.match_id,
    m.match_orgz_id,
    o.orgz_name AS organization_name,
    t.team_id AS your_team_id,
    t.team_name AS your_team_name,
    opp.team_id AS opponent_team_id,
    opp.team_name AS opponent_team_name,
    CASE
        WHEN m.match_team1_id = t.team_id THEN m.match_team1_score
        ELSE m.match_team2_score
    END AS your_team_score,
    CASE
        WHEN m.match_team1_id = t.team_id THEN m.match_team2_score
        ELSE m.match_team1_score
    END AS opponent_team_score,
    m.match_played_date
FROM
    team_matches m
	JOIN organizations o ON m.match_orgz_id = o.orgz_id AND o.orgz_status =1
	JOIN teams t ON t.team_id IN (m.match_team1_id, m.match_team2_id) AND t.team_status =1
	JOIN teams opp ON (opp.team_id != t.team_id AND opp.team_id IN (m.match_team1_id, m.match_team2_id)) AND opp.team_status =1;