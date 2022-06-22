DELIMITER //

DROP PROCEDURE IF EXISTS remove_storage_rack;

CREATE PROCEDURE remove_storage_rack (
    IN p_storage_rack_id INT(11)
)
BEGIN
    DECLARE v_capacity_to_remove INT(11);
    DECLARE v_alley_id INT(11);
    DECLARE v_hall_id INT(11);
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_shelf_id INT(11);
    DECLARE cur1 CURSOR FOR
        SELECT shelf_id
        FROM shelves
        WHERE storage_rack_id=p_storage_rack_id;
    DECLARE CONTINUE HANDLER FOR
        NOT FOUND
        SET done = TRUE;

    IF (SELECT if_storage_rack_exists(p_storage_rack_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Storage rack not found. (remove_storage_rack_procedure)';
    ELSE
        OPEN cur1;
        shelf_remove_loop: LOOP
            FETCH cur1
                INTO v_shelf_id;
            IF done THEN
                LEAVE shelf_remove_loop;
            END IF;
            CALL remove_shelf(v_shelf_id);
        END LOOP;
        CLOSE cur1;
        
        SELECT total_capacity
            INTO v_capacity_to_remove
            FROM storage_racks
            WHERE storage_rack_id=p_storage_rack_id;
        SELECT alley_id
            INTO v_alley_id
            FROM storage_racks
            WHERE storage_rack_id=p_storage_rack_id;
        SELECT hall_id
            INTO v_hall_id
            FROM alleys
            WHERE alley_id=v_alley_id;
        
        UPDATE alleys
            SET total_capacity=total_capacity-v_capacity_to_remove
            WHERE alley_id=v_alley_id;
        UPDATE alleys
            SET free_capacity=free_capacity-v_capacity_to_remove
            WHERE alley_id=v_alley_id;
        
        UPDATE halls
            SET total_capacity=total_capacity-v_capacity_to_remove
            WHERE hall_id=v_hall_id;
        UPDATE halls
            SET free_capacity=free_capacity-v_capacity_to_remove
            WHERE hall_id=v_hall_id;

        DELETE FROM storage_racks
            WHERE storage_rack_id=p_storage_rack_id;
    END IF;
END//

DELIMITER ;