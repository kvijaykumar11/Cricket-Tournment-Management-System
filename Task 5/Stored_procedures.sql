-- Insert
CREATE OR REPLACE PROCEDURE insert_player(
    p_name VARCHAR,
    p_dob DATE,
    p_role VARCHAR,
    p_bowling VARCHAR,
    p_batting VARCHAR,
    p_team INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Players (player_name, dob, role, bowling_style, batting_style, team_id)
    VALUES (p_name, p_dob, p_role, p_bowling, p_batting, p_team);
END;
$$;


CREATE OR REPLACE PROCEDURE insert_sponsor(
    p_name VARCHAR,
    p_amount DECIMAL,
    p_tournament INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Sponsors (sponsor_name, amount, tournament_id)
    VALUES (p_name, p_amount, p_tournament);
END;
$$;

-- Update
CREATE OR REPLACE PROCEDURE update_tournament_dates(
    p_tournament_id INT,
    p_start DATE,
    p_end DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Tournament
    SET start_date = p_start,
        end_date = p_end
    WHERE tournament_id = p_tournament_id;
END;
$$;

-- Delete
CREATE OR REPLACE PROCEDURE delete_scorecard(
    p_scorecard_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Scorecard
    WHERE scorecard_id = p_scorecard_id;
END;
$$;

-- Select
CREATE OR REPLACE PROCEDURE get_sponsors_by_tournament(
    p_tournament_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Sponsors
    WHERE tournament_id = p_tournament_id;
END;
$$;

-- Queries to exe
CALL insert_player('KL Rahul', '1988-12-05', 'Batsman', 'Right-arm medium', 'Right-hand bat', 4);
SELECT * FROM Players WHERE player_name = 'KL Rahul';

CALL insert_sponsor('Pepsi', 500000, 2);
SELECT * FROM Sponsors WHERE sponsor_name='Pepsi'

CALL update_tournament_dates(3, '2025-01-10', '2025-02-05');

CALL delete_scorecard(10);








