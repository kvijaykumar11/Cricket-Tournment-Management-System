explain analyze
SELECT t.team_id,
       t.team_name,
       (
         SELECT AVG(
           CASE
             WHEN m.team1_id = t.team_id THEN (SELECT ranking FROM Teams WHERE team_id = m.team2_id)
             WHEN m.team2_id = t.team_id THEN (SELECT ranking FROM Teams WHERE team_id = m.team1_id)
             ELSE NULL
           END
         )
         FROM Matches m
         WHERE (m.team1_id = t.team_id OR m.team2_id = t.team_id)
           AND m.tournament_id = 1
       ) AS avg_opponent_ranking,
       COUNT(*) AS matches_played
FROM Teams t
WHERE EXISTS (
  SELECT 1 FROM Matches m2
  WHERE (m2.team1_id = t.team_id OR m2.team2_id = t.team_id)
    AND m2.tournament_id = 1
)
GROUP BY t.team_id, t.team_name
ORDER BY avg_opponent_ranking ASC NULLS LAST
LIMIT 50;
--this is a problematic query as this has loops to iterate which takes more cost and time to run
--In this command we used correlated subqueries and OR conditions that forced repeated scans of the Matches table and scalar lookups of opponent rankings.