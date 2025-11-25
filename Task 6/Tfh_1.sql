DROP TABLE IF EXISTS TriggerFailures CASCADE;
CREATE TABLE TriggerFailures (
    failure_id SERIAL PRIMARY KEY,
    failed_at TIMESTAMP DEFAULT NOW(),
    operation TEXT,
    team_id INT,
    tournament_id INT,
    error_message TEXT
);

CREATE OR REPLACE FUNCTION check_points_trigger()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.points < 0 THEN

        INSERT INTO TriggerFailures(operation, team_id, tournament_id, error_message)
        VALUES ('INSERT/UPDATE PointsTable', NEW.team_id, NEW.tournament_id, 'Points cannot be negative');

        RAISE EXCEPTION 'Transaction aborted: Points cannot be negative for team_id %, tournament_id %', NEW.team_id, NEW.tournament_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER trg_check_points ON PointsTable CASCADE;
CREATE TRIGGER trg_check_points
BEFORE INSERT OR UPDATE ON PointsTable
FOR EACH ROW
EXECUTE FUNCTION check_points_trigger();

-- -- Valid Update
UPDATE PlayerStats
SET runs_scored = 60
WHERE player_id = 1 AND match_id = 39;

-- -- Invalid Update
UPDATE PlayerStats
SET runs_scored = -10
WHERE player_id = 1 AND match_id = 39;

-- -- -- Checking the failure log
SELECT * FROM TriggerFailures;










