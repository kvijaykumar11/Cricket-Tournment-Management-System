EXPLAIN ANALYZE

-- A: top venues by average innings total in 2024
SELECT v.venue_id, v.venue_name, v.city, v.country,
       AVG(sc.total_runs) AS avg_innings_score,
       COUNT(*) AS innings_count
FROM Scorecard sc
JOIN Matches m ON sc.match_id = m.match_id
JOIN Venues v   ON m.venue_id = v.venue_id
WHERE m.match_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY v.venue_id, v.venue_name, v.city, v.country
HAVING COUNT(*) > 10
ORDER BY avg_innings_score DESC
LIMIT 20;

-- Scorecard table is very larger and performing join to the Matches and venues upon group by that requires scanning many rows and a large aggregation
--If m.match_date and m.venue_id lack selective indexes, PostgreSql does a seq scan over Macthes and then a hash join to scorecard