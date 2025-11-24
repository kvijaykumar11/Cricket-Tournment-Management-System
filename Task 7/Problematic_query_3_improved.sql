explain analyze
SELECT v.venue_id, v.venue_name, v.city, v.country,
       AVG(sc.total_runs) AS avg_innings_score,
       COUNT(*) AS innings_count
FROM Matches m
JOIN Venues v ON m.venue_id = v.venue_id
JOIN Scorecard sc ON sc.match_id = m.match_id
WHERE m.match_date >= '2024-01-01' AND m.match_date < '2025-01-01'
GROUP BY v.venue_id, v.venue_name, v.city, v.country
HAVING COUNT(*) > 10
ORDER BY avg_innings_score DESC
LIMIT 20;
