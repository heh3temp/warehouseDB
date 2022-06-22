DELIMITER //

DROP PROCEDURE IF EXISTS remove_alley;

CREATE PROCEDURE remove_alley (
    IN p_alley_id INT(11)
)
BEGIN
    DECLARE v_capacity_to_remove INT(11);
    DECLARE v_hall_id INT(11);
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_storage_rack_id INT(11);
    DECLARE cur1 CURSOR FOR
        SELECT storage_rack_id
            FROM storage_racks
            WHERE alley_id=p_alley_id;
    DECLARE CONTINUE HANDLER FOR
        NOT FOUND
        SET done = TRUE;
    IF (SELECT if_alley_exists(p_alley_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Alley not found. (remove_alley_procedure)';
    ELSE
        OPEN cur1;
        storage_rack_remove_loop: LOOP
            FETCH cur1
                INTO v_storage_rack_id;
            IF done THEN
                LEAVE storage_rack_remove_loop;
            END IF;
            CALL remove_storage_rack(v_storage_rack_id);
        END LOOP;
        CLOSE cur1;
        
        SELECT total_capacity
            INTO v_capacity_to_remove
            FROM alleys
            WHERE alley_id=p_alley_id;
        SELECT hall_id
            INTO v_hall_id
            FROM alleys
            WHERE alley_id=p_alley_id;
        
        UPDATE halls
            SET total_capacity=total_capacity-v_capacity_to_remove
            WHERE hall_id=v_hall_id;
        UPDATE halls
            SET free_capacity=free_capacity-v_capacity_to_remove
            WHERE hall_id=v_hall_id;

        DELETE FROM alleys
            WHERE alley_id=p_alley_id;
    END IF;
END//

DELIMITER ;