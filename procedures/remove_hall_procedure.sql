DELIMITER //

DROP PROCEDURE IF EXISTS remove_hall;

CREATE PROCEDURE remove_hall (
    IN p_hall_id INT(11)
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_alley_id INT(11);
    DECLARE cur1 CURSOR FOR
        SELECT alley_id
            FROM alleys
            WHERE hall_id=p_hall_id;
    DECLARE CONTINUE HANDLER FOR
        NOT FOUND
        SET done = TRUE;
    IF (SELECT if_hall_exists(p_hall_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Hall not found. (remove_hall_procedure)';
    ELSE
        OPEN cur1;
        alley_remove_loop: LOOP
            FETCH cur1
                INTO v_alley_id;
            IF done THEN
                LEAVE alley_remove_loop;
            END IF;
            CALL remove_alley(v_alley_id);
        END LOOP;
        CLOSE cur1;

        DELETE FROM halls
            WHERE hall_id=p_hall_id;
    END IF;
END//

DELIMITER ;