BEGIN;
UPDATE Sponsors
SET amount = amount * 1.10
WHERE sponsor_id = 1;
COMMIT;
