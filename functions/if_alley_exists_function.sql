DELIMITER //

DROP FUNCTION IF EXISTS if_alley_exists;

CREATE FUNCTION if_alley_exists (
    p_alley_id INT(11)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE alley_exists BOOLEAN;
    DECLARE v_alley_id INT(11);
    SET alley_exists = False;
    SELECT count(*)
        INTO v_alley_id
        FROM alleys
        GROUP BY alley_id
        HAVING alley_id=p_alley_id;
    IF v_alley_id != 0 THEN
        SET alley_exists = True;
    END IF;
    RETURN alley_exists;
END//

DELIMITER ;