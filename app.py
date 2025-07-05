from flask import Flask, jsonify
from db_connection import get_connection

app = Flask(__name__)

@app.route('/team/<int:team_id>/matches', methods=['GET'])
def get_team_matches(team_id):
    query = """
        SELECT 
            m.match_id MatchID,
            (SELECT team_name FROM teams WHERE team_id = %s) AS TeamName,
            CASE 
                WHEN m.match_team1_id =%s THEN t2.team_name
                ELSE t1.team_name
            END AS Opponent_TeamName,
            m.match_team1_score AS Team1_Score,
            m.match_team2_score AS Team2_Score,
            m.match_played_ground AS Match_Played_Ground,
            m.match_game_status AS Game_Status
        FROM
            team_matches m
            INNER JOIN teams t1 ON t1.team_id = m.match_team1_id AND t1.team_status=1
            INNER JOIN teams t2 ON t2.team_id = m.match_team2_id AND t2.team_status=1
        WHERE %s IN(t1.team_id,t2.team_id)
        ORDER BY m.match_id;
        """
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(query,(team_id,team_id,team_id))
        results = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(results)
    except Exception as exception:
        return jsonify({'error': str(exception)}),500
    
if __name__ == '__main__':
    app.run(debug=True)
