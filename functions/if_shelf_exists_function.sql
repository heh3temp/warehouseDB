DELIMITER //

DROP FUNCTION IF EXISTS if_shelf_exists;

CREATE FUNCTION if_shelf_exists (
    p_shelf_id INT(11)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE shelf_exists BOOLEAN;
    DECLARE v_shelf_id INT(11);
    SET shelf_exists = False;
    SELECT count(*)
        INTO v_shelf_id
        FROM shelves
        GROUP BY shelf_id
        HAVING shelf_id=p_shelf_id;
    IF v_shelf_id != 0 THEN
        SET shelf_exists = True;
    END IF;
    RETURN shelf_exists;
END//

DELIMITER ;