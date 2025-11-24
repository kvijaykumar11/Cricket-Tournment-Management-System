-- B_improved: aggregate once, join results back
explain analyze
WITH umpire_match_counts AS (
  SELECT mu.umpire_id,
         COUNT(*) FILTER (WHERE mm.match_date BETWEEN '2024-01-01' AND '2024-12-31') AS matches_2024,
         COUNT(*) AS total_matches
  FROM Match_Umpires mu
  JOIN Matches mm ON mu.match_id = mm.match_id
  GROUP BY mu.umpire_id
),
umpire_experience AS (
  SELECT umpire_id, AVG(experience_years) AS avg_experience
  FROM UmpireExperience
  GROUP BY umpire_id
)
SELECT u.umpire_id, u.umpire_name,
       coalesce(ue.avg_experience,0) AS avg_experience,
       coalesce(um.matches_2024,0) AS matches_officiated,
       coalesce(um.total_matches,0) AS total_matches
FROM Umpires u
LEFT JOIN umpire_experience ue ON u.umpire_id = ue.umpire_id
LEFT JOIN umpire_match_counts um ON u.umpire_id = um.umpire_id
WHERE COALESCE(um.total_matches,0) > 5
ORDER BY matches_officiated DESC;
