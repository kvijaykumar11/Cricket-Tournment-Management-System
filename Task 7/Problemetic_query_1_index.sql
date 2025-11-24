--creating indexes fot the Teams and macthces for optimal search operations that speed up the table lookup
CREATE INDEX idx_matches_team1 ON Matches(team1_id);
CREATE INDEX idx_matches_team2 ON Matches(team2_id);
CREATE INDEX idx_matches_team1_team2 ON Matches(team1_id, team2_id);
CREATE INDEX idx_teams_ranking ON Teams(team_id, ranking);

-- materialized helper table / normalization
-- Instead of OR, maintain MatchTeams(match_id, team_id, opponent_team_id)
CREATE TABLE IF NOT EXISTS MatchTeams (
  match_id INT NOT NULL,
  team_id INT NOT NULL,
  opponent_team_id INT NOT NULL,
  tournament_id INT,
  PRIMARY KEY (match_id, team_id)
);
INSERT INTO MatchTeams(match_id, team_id, opponent_team_id, tournament_id)
SELECT m.match_id, m.team1_id, m.team2_id, m.tournament_id FROM Matches m;
INSERT INTO MatchTeams(match_id, team_id, opponent_team_id, tournament_id)
SELECT m.match_id, m.team2_id, m.team1_id, m.tournament_id FROM Matches m;
CREATE INDEX idx_matchteams_team_tour ON MatchTeams(team_id, tournament_id);
CREATE INDEX idx_matchteams_opponent ON MatchTeams(opponent_team_id);
ANALYZE MatchTeams;
