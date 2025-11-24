DROP TABLE IF EXISTS Match_Umpires CASCADE;
DROP TABLE IF EXISTS PlayerStats CASCADE;
DROP TABLE IF EXISTS PointsTable CASCADE;
DROP TABLE IF EXISTS Scorecard CASCADE;
DROP TABLE IF EXISTS Matches CASCADE;
DROP TABLE IF EXISTS Players CASCADE;
DROP TABLE IF EXISTS Sponsors CASCADE;
DROP TABLE IF EXISTS Teams CASCADE;
DROP TABLE IF EXISTS Tournament CASCADE;
DROP TABLE IF EXISTS UmpireExperience CASCADE;
DROP TABLE IF EXISTS Umpires CASCADE;
DROP TABLE IF EXISTS Venues CASCADE;


CREATE TABLE Venues (
    venue_id SERIAL PRIMARY KEY,
    venue_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    capacity INT NULL
);


CREATE TABLE Umpires (
    umpire_id SERIAL PRIMARY KEY,
    umpire_name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50) NOT NULL,
    experience_years INT NULL
);


CREATE TABLE UmpireExperience (
    umpire_id INT PRIMARY KEY,
    experience_years INT NOT NULL,
    FOREIGN KEY (umpire_id) REFERENCES Umpires(umpire_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Tournament (
    tournament_id SERIAL PRIMARY KEY,
    tournament_name VARCHAR(100) NOT NULL,
    format VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    host_country VARCHAR(50) NULL,
	CONSTRAINT unique_tournament UNIQUE (tournament_name, start_date, host_country)
);


CREATE TABLE Teams (
    team_id SERIAL PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    coach_name VARCHAR(100) NULL,
    ranking INT NULL,
	CONSTRAINT unique_team_name UNIQUE (team_name,country)
);


CREATE TABLE Sponsors (
    sponsor_id SERIAL PRIMARY KEY,
    sponsor_name VARCHAR(100) NOT NULL,
    amount DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    tournament_id INT NULL,
    FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT unique_sponsor_tournament UNIQUE (sponsor_name, tournament_id)
);


CREATE TABLE Players (
    player_id SERIAL PRIMARY KEY,
    player_name VARCHAR(100) NOT NULL,
    dob DATE NULL,
    role VARCHAR(50) NULL,
    bowling_style VARCHAR(50) NULL,
    batting_style VARCHAR(50) NULL,
    team_id INT NULL,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT unique_player UNIQUE (player_name, dob)
);


CREATE TABLE Matches (
    match_id SERIAL PRIMARY KEY,
    tournament_id INT NULL,
    team1_id INT NULL,
    team2_id INT NULL,
    venue_id INT NULL,
    match_date DATE NOT NULL,
    winner_team_id INT NULL,
    man_of_the_match_id INT NULL,
    match_type VARCHAR(50) NULL,
    FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (team1_id) REFERENCES Teams(team_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (team2_id) REFERENCES Teams(team_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (man_of_the_match_id) REFERENCES Players(player_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (winner_team_id) REFERENCES Teams(team_id) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT unique_match UNIQUE (tournament_id, team1_id, team2_id, match_date, venue_id),
    CONSTRAINT check_different_teams CHECK (team1_id != team2_id)
);


CREATE TABLE Scorecard (
    scorecard_id SERIAL PRIMARY KEY,
    match_id INT NULL,
    batting_team_id INT NULL,
    innings_no INT NOT NULL CHECK (innings_no >= 1),
    total_runs INT NULL DEFAULT 0 CHECK (total_runs >= 0),
    wickets INT NULL DEFAULT 0 CHECK (wickets >= 0 AND wickets <= 10),
    overs DECIMAL(4,1) NULL,
    FOREIGN KEY (batting_team_id) REFERENCES Teams(team_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT unique_scorecard UNIQUE (match_id, batting_team_id, innings_no)
);


CREATE TABLE PointsTable (
    tournament_id INT NOT NULL,
    team_id INT NOT NULL,
    matched_played INT NULL DEFAULT 0 CHECK (matched_played >= 0),
    wins INT NULL DEFAULT 0 CHECK (wins >= 0),
    losses INT NULL DEFAULT 0 CHECK (losses >= 0),
    ties INT NULL DEFAULT 0 CHECK (ties >= 0),
    points INT NULL DEFAULT 0 CHECK (points >= 0),
    net_run_rate DECIMAL(4,2) NULL DEFAULT 0.00,
    PRIMARY KEY (tournament_id, team_id),
    FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (team_id) REFERENCES Teams(team_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE PlayerStats (
    player_id INT NOT NULL,
    match_id INT NOT NULL,
    runs_scored INT NULL DEFAULT 0 CHECK (runs_scored >= 0),
    balls_faced INT NULL DEFAULT 0 CHECK (balls_faced >= 0),
    fours INT NULL DEFAULT 0 CHECK (fours >= 0),
    sixes INT NULL DEFAULT 0 CHECK (sixes >= 0),
    wickets_taken INT NULL DEFAULT 0 CHECK (wickets_taken >= 0),
    overs_bowled DECIMAL(4,1) NULL DEFAULT 0,
    catches INT NULL DEFAULT 0 CHECK (catches >= 0),
    PRIMARY KEY (player_id, match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Match_Umpires (
    match_id INT NOT NULL,
    umpire_id INT NOT NULL,
    role VARCHAR(50) NULL,
    PRIMARY KEY (match_id, umpire_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (umpire_id) REFERENCES Umpires(umpire_id) ON DELETE CASCADE ON UPDATE CASCADE
);