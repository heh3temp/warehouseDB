DELIMITER //

DROP PROCEDURE IF EXISTS remove_item;

CREATE PROCEDURE remove_item (
    IN p_item_id INT(11)
)
BEGIN
    DECLARE v_capacity INT(11);
    DECLARE v_shelf_id INT(11);
    DECLARE v_storage_rack_id INT(11);
    DECLARE v_alley_id INT(11);
    DECLARE v_hall_id INT(11);
    IF (SELECT if_item_exists(p_item_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Item not found. (remove_item_procedure)';
    ELSE
        SELECT consumed_capacity
            INTO v_capacity
            FROM items
            WHERE item_id=p_item_id;
        SELECT shelf_id
            INTO v_shelf_id
            FROM items
            WHERE item_id=p_item_id;
        SELECT storage_rack_id
            INTO v_storage_rack_id
            FROM shelves
            WHERE shelf_id=v_shelf_id;
        SELECT alley_id
            INTO v_alley_id
            FROM storage_racks
            WHERE storage_rack_id=v_storage_rack_id;
        SELECT hall_id
            INTO v_hall_id
            FROM alleys
            WHERE alley_id=v_alley_id;
        UPDATE items
            SET shelf_id=NULL
            WHERE item_id=p_item_id;
        UPDATE shelves
            SET free_capacity=free_capacity+v_capacity
            WHERE shelf_id=v_shelf_id;
        UPDATE storage_racks
            SET free_capacity=free_capacity+v_capacity
            WHERE storage_rack_id=v_storage_rack_id;
        UPDATE alleys
            SET free_capacity=free_capacity+v_capacity
            WHERE alley_id=v_alley_id;
        UPDATE halls
            SET free_capacity=free_capacity+v_capacity
            WHERE hall_id=v_hall_id;
    END IF;
END//

DELIMITER ;