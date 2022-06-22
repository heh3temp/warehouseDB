DELIMITER //

DROP PROCEDURE IF EXISTS remove_shelf;

CREATE PROCEDURE remove_shelf (
    IN p_shelf_id INT(11)
)
BEGIN
    DECLARE v_capacity_to_remove INT(11);
    DECLARE v_storage_rack_id INT(11);
    DECLARE v_alley_id INT(11);
    DECLARE v_hall_id INT(11);
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_item_id INT(11);
    DECLARE cur1 CURSOR FOR
        SELECT item_id
        FROM items
        WHERE shelf_id=p_shelf_id;
    DECLARE CONTINUE HANDLER FOR
        NOT FOUND
        SET done = TRUE;
    IF (SELECT if_shelf_exists(p_shelf_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Shelf not found. (remove_shelf_procedure)';
    ELSE
        OPEN cur1;
        item_remove_loop: LOOP
            FETCH cur1
                INTO v_item_id;
            IF done THEN
                LEAVE item_remove_loop;
            END IF;
            CALL remove_item(v_item_id);
        END LOOP;
        CLOSE cur1;

        SELECT total_capacity
            INTO v_capacity_to_remove
            FROM shelves
            WHERE shelf_id=p_shelf_id;
        SELECT storage_rack_id
            INTO v_storage_rack_id
            FROM shelves
            WHERE shelf_id=p_shelf_id;
        SELECT alley_id
            INTO v_alley_id
            FROM storage_racks
            WHERE storage_rack_id=v_storage_rack_id;
        SELECT hall_id
            INTO v_hall_id
            FROM alleys
            WHERE alley_id=v_alley_id;
        
        UPDATE storage_racks
            SET total_capacity=total_capacity-v_capacity_to_remove
            WHERE storage_rack_id=v_storage_rack_id;
        UPDATE storage_racks
            SET free_capacity=free_capacity-v_capacity_to_remove
            WHERE storage_rack_id=v_storage_rack_id;
        
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

        DELETE FROM shelves
            WHERE shelf_id=p_shelf_id;
    END IF;
END//

DELIMITER ;