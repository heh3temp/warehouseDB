DELIMITER //

DROP TRIGGER IF EXISTS add_item;

CREATE TRIGGER add_item
AFTER INSERT ON items
FOR EACH ROW
BEGIN
    DECLARE v_shelf_id INT(11);
    DECLARE v_storage_rack_id INT(11);
    DECLARE v_alley_id INT(11);
    DECLARE v_hall_id INT(11);
    SET v_shelf_id = NEW.shelf_id;
    SELECT storage_rack_id
        INTO v_storage_rack_id
        FROM shelves
        WHERE shelf_id=NEW.shelf_id;
    SELECT alley_id
        INTO v_alley_id
        FROM storage_racks
        WHERE storage_rack_id=v_storage_rack_id;
    SELECT hall_id
        INTO v_hall_id
        FROM alleys
        WHERE alley_id=v_alley_id;
    UPDATE shelves
        SET free_capacity=free_capacity-NEW.consumed_capacity
        WHERE shelf_id=v_shelf_id;
    UPDATE storage_racks
        SET free_capacity=free_capacity-NEW.consumed_capacity
        WHERE storage_rack_id=v_storage_rack_id;
    UPDATE alleys
        SET free_capacity=free_capacity-NEW.consumed_capacity
        WHERE alley_id=v_alley_id;
    UPDATE halls
        SET free_capacity=free_capacity-NEW.consumed_capacity
        WHERE hall_id=v_hall_id;
END//

DELIMITER ;