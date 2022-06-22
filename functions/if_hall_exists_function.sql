DELIMITER //

DROP FUNCTION IF EXISTS if_hall_exists;

CREATE FUNCTION if_hall_exists (
    p_hall_id INT(11)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE hall_exists BOOLEAN;
    DECLARE v_hall_id INT(11);
    SET hall_exists = False;
    SELECT count(*)
        INTO v_hall_id
        FROM halls
        GROUP BY hall_id
        HAVING hall_id=p_hall_id;
    IF v_hall_id != 0 THEN
        SET hall_exists = True;
    END IF;
    RETURN hall_exists;
END//

DELIMITER ;