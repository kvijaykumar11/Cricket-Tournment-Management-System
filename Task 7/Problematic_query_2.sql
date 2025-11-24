Explain analyze
SELECT u.umpire_id, u.umpire_name,
       (SELECT AVG(ue.experience_years)
        FROM UmpireExperience ue
        WHERE ue.umpire_id = u.umpire_id) AS avg_experience,
       (SELECT COUNT(*) 
        FROM Match_Umpires mu
        JOIN Matches mm ON mu.match_id = mm.match_id
        WHERE mu.umpire_id = u.umpire_id
          AND mm.match_date BETWEEN '2024-01-01' AND '2024-12-31') AS matches_officiated
FROM Umpires u
WHERE (SELECT COUNT(*) 
       FROM Match_Umpires mu2
       WHERE mu2.umpire_id = u.umpire_id) > 5
ORDER BY matches_officiated DESC;

-- this query has has corealted subqueries that runs once per umpire so that toal cost will be total number of umpires cost of subquery
-- this makes more cost and complicated query, as match_umpire and Matches data are so large.