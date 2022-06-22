DELIMITER //

DROP TRIGGER IF EXISTS remove_position;
CREATE TRIGGER remove_position
BEFORE DELETE ON positions
FOR EACH ROW
BEGIN
    UPDATE employees
        SET position_id=NULL
        WHERE position_id=OLD.position_id;
END//

DELIMITER ;

        