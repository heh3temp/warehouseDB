DELIMITER //

DROP FUNCTION IF EXISTS if_position_id_exists;

CREATE FUNCTION if_position_id_exists (
    p_position_id VARCHAR(45)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE position_exists BOOLEAN;
    DECLARE v_position_id INT(11);
    SET position_exists = False;
    SELECT count(*)
        INTO v_position_id
        FROM positions
        GROUP BY position_id
        HAVING position_id=p_position_id;
    IF v_position_id != 0 THEN
        SET position_exists = True;
    END IF;
    RETURN position_exists;
END//

DELIMITER ;