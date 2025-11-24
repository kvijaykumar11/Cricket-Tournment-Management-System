explain analyze
SELECT t.team_id, t.team_name,
       AVG(op.ranking) AS avg_opponent_ranking,
       COUNT(mt.match_id) AS matches_played
FROM MatchTeams mt
JOIN Teams t ON mt.team_id = t.team_id
JOIN Teams op ON mt.opponent_team_id = op.team_id
WHERE mt.tournament_id = 1
GROUP BY t.team_id, t.team_name
HAVING COUNT(mt.match_id) > 0
ORDER BY avg_opponent_ranking ASC NULLS LAST
LIMIT 50;
