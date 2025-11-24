SELECT m.match_id, m.tournament_id, t.tournament_name, m.match_date, v.venue_name, v.city, m.team1_id, m.team2_id
FROM Matches m
JOIN Tournament t ON m.tournament_id = t.tournament_id
JOIN Venues v ON m.venue_id = v.venue_id
ORDER BY m.match_date
LIMIT 20;
