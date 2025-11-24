SELECT p.team_id, t.team_name, COUNT(*) AS players_count
FROM Players p
JOIN Teams t ON p.team_id = t.team_id
GROUP BY p.team_id, t.team_name
HAVING COUNT(*) > 10
ORDER BY players_count DESC;
