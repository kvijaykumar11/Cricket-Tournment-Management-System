SELECT pt.team_id, t.team_name, pt.points
FROM PointsTable pt
JOIN Teams t ON pt.team_id = t.team_id
WHERE pt.tournament_id = 1
  AND pt.points = (
    SELECT MAX(points) FROM PointsTable WHERE tournament_id = 1
  );
