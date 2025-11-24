SELECT sc.scorecard_id, sc.match_id, sc.batting_team_id, sc.innings_no, sc.total_runs
FROM Scorecard sc
ORDER BY sc.total_runs DESC
LIMIT 10;
