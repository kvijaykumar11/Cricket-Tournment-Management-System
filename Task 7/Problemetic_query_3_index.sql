CREATE INDEX idx_matchumpires_umpire_match ON Match_Umpires(umpire_id, match_id);
CREATE INDEX idx_matches_date ON Matches(match_date);
CREATE INDEX idx_umpireexp_umpire ON UmpireExperience(umpire_id);
