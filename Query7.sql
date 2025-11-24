SELECT p.player_id, p.player_name, p.team_id, t.team_name, COUNT(sc.scorecard_id) AS appearances
FROM Players p
LEFT JOIN Scorecard sc ON sc.batting_team_id = p.team_id
LEFT JOIN Teams t ON p.team_id = t.team_id
GROUP BY p.player_id, p.player_name, p.team_id, t.team_name
ORDER BY appearances DESC
LIMIT 20;
