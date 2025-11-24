CREATE INDEX idx_scorecard_matchid ON Scorecard(match_id);

CREATE INDEX idx_pointstable_tour_team ON PointsTable(tournament_id, team_id);

CREATE INDEX idx_players_teamid ON Players(team_id);

CREATE INDEX idx_matches_tournament ON Matches(tournament_id);
