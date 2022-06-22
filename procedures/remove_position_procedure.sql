DELIMITER //

DROP PROCEDURE IF EXISTS remove_position;

CREATE PROCEDURE remove_position (
    IN p_position_id INT(11)
)
BEGIN
    IF (SELECT if_position_id_exists(p_position_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Position not found. (remove_position_procedure)';
    ELSE
        DELETE FROM positions
            WHERE position_id=p_position_id;
    END IF;
END//

DELIMITER ;