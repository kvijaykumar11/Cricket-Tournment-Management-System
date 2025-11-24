DROP TABLE IF EXISTS ScorecardFailures CASCADE;

CREATE TABLE ScorecardFailures (
    failure_id SERIAL PRIMARY KEY,
    failed_at TIMESTAMP DEFAULT NOW(),
    operation TEXT,
    match_id INT,
    batting_team_id INT,
    innings_no INT,
    error_message TEXT
);

CREATE OR REPLACE FUNCTION check_scorecard_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.total_runs < 0 OR NEW.wickets < 0 OR NEW.wickets > 10 OR NEW.innings_no < 1
       OR (NEW.overs * 10)::INT % 10 > 5 OR NEW.overs < 0 THEN

        INSERT INTO ScorecardFailures(operation, match_id, batting_team_id, innings_no, error_message)
        VALUES (
            TG_OP || ' Scorecard', 
            NEW.match_id,
            NEW.batting_team_id,
            NEW.innings_no,
            'Invalid values in Scorecard'
        );

        RETURN NULL;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Creation of Trigger
DROP TRIGGER IF EXISTS trg_check_scorecard ON Scorecard;
CREATE TRIGGER trg_check_scorecard
BEFORE INSERT OR UPDATE ON Scorecard
FOR EACH ROW
EXECUTE FUNCTION check_scorecard_trigger();

-- Valid Transaction Query
INSERT INTO Scorecard(match_id, batting_team_id, innings_no, total_runs, wickets, overs)
VALUES (1, 10, 1, 250, 7, 50.0);

-- Invalid Transaction Query
INSERT INTO Scorecard(match_id, batting_team_id, innings_no, total_runs, wickets, overs)
VALUES (2, 10, 1, 200, 12, 50.3); 

-- Query to check logs
SELECT * FROM ScorecardFailures
