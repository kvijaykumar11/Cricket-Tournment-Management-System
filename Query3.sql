SELECT role, COUNT(*) AS player_count
FROM Players
GROUP BY role
ORDER BY player_count DESC;
