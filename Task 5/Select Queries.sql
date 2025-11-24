SELECT 
    (SELECT COUNT(*) FROM Venues) +
    (SELECT COUNT(*) FROM Umpires) +
    (SELECT COUNT(*) FROM UmpireExperience) +
    (SELECT COUNT(*) FROM Tournament) +
    (SELECT COUNT(*) FROM Teams) +
    (SELECT COUNT(*) FROM Sponsors) +
    (SELECT COUNT(*) FROM Players) +
    (SELECT COUNT(*) FROM Matches) +
    (SELECT COUNT(*) FROM Scorecard) +
    (SELECT COUNT(*) FROM PointsTable) +
    (SELECT COUNT(*) FROM PlayerStats) +
    (SELECT COUNT(*) FROM Match_Umpires) 
AS total_rows;



SELECT role, COUNT(*) AS player_count FROM Players GROUP BY role ORDER BY player_count DESC;

SELECT p.team_id, t.team_name, COUNT(*) AS players_count FROM Players p JOIN Teams t 
ON p.team_id = t.team_id GROUP BY p.team_id, t.team_name HAVING COUNT(*) > 10 
ORDER BY players_count DESC LIMIT 10;

SELECT sc.scorecard_id, sc.match_id, sc.batting_team_id, sc.innings_no, sc.total_runs
FROM Scorecard sc
ORDER BY sc.total_runs DESC
LIMIT 10;


SELECT m.match_id, m.tournament_id, t.tournament_name, m.match_date, v.venue_name, 
v.city, m.team1_id, m.team2_id
FROM Matches m JOIN Tournament t ON m.tournament_id = t.tournament_id
JOIN Venues v ON m.venue_id = v.venue_id ORDER BY m.match_date LIMIT 50;


SELECT p.player_id, p.player_name, p.team_id, t.team_name, COUNT(sc.scorecard_id) AS appearances
FROM Players p
LEFT JOIN Scorecard sc ON sc.batting_team_id = p.team_id
LEFT JOIN Teams t ON p.team_id = t.team_id
GROUP BY p.player_id, p.player_name, p.team_id, t.team_name
ORDER BY appearances DESC
LIMIT 20;

SELECT pt.tournament_id,pt.team_id,t.team_name,MAX(pt.points) AS highest_points
FROM PointsTable pt JOIN Teams t ON pt.team_id = t.team_id 
GROUP BY pt.tournament_id, pt.team_id, t.team_name ORDER BY highest_points DESC LIMIT 50;

SELECT team_id, team_name, country FROM Teams ORDER BY team_name DESC LIMIT 20;
