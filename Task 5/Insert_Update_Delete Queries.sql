SELECT setval('teams_team_id_seq', COALESCE((SELECT MAX(team_id) FROM Teams), 0));
SELECT setval('venues_venue_id_seq', COALESCE((SELECT MAX(venue_id) FROM Venues), 0));
SELECT setval('umpires_umpire_id_seq', COALESCE((SELECT MAX(umpire_id) FROM Umpires), 0));
SELECT setval('tournament_tournament_id_seq', COALESCE((SELECT MAX(tournament_id) FROM Tournament), 0));
SELECT setval('sponsors_sponsor_id_seq', COALESCE((SELECT MAX(sponsor_id) FROM Sponsors), 0));
SELECT setval('players_player_id_seq', COALESCE((SELECT MAX(player_id) FROM Players), 0));
SELECT setval('matches_match_id_seq', COALESCE((SELECT MAX(match_id) FROM Matches), 0));
SELECT setval('scorecard_scorecard_id_seq', COALESCE((SELECT MAX(scorecard_id) FROM Scorecard), 0));

-- Insert Commands
INSERT INTO Teams (team_name, country, coach_name, ranking) VALUES ('Brisbane Aussi Strikers', 'Australia', 'Mark Wilson', 53);
SELECT * FROM Teams WHERE Ranking=53;

INSERT INTO Matches (tournament_id, team1_id, team2_id, venue_id, match_date, match_type) VALUES (3, 2, 3, 1, '2025-02-12', 'League Match');
SELECT * FROM Matches WHERE match_date='2025-02-12';

-- Update Commands
UPDATE Players SET team_id = 4 WHERE player_name = 'Donald Walker' AND dob = '1998-05-27';
SELECT * FROM Players WHERE player_name = 'Donald Walker' AND dob = '1998-05-27';	

UPDATE Matches SET winner_team_id = 2, man_of_the_match_id = 15 WHERE match_id = 10;
SELECT * FROM Matches WHERE match_id = 10; 

-- Delete Commands
DELETE FROM Sponsors WHERE sponsor_id = 7;
SELECT * FROM Sponsors WHERE sponsor_id = 7;

DELETE FROM Venues WHERE venue_id = 3;
SELECT * FROM Venues WHERE venue_id = 3;















