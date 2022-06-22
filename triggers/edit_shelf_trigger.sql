DELIMITER //

DROP TRIGGER IF EXISTS edit_shelf;

CREATE TRIGGER edit_shelf
AFTER UPDATE ON shelves
FOR EACH ROW
BEGIN
    DECLARE v_alley_id_old INT(11);
    DECLARE v_alley_id_new INT(11);
    DECLARE v_hall_id_old INT(11);
    DECLARE v_hall_id_new INT(11);
    IF NOT (OLD.storage_rack_id = NEW.storage_rack_id) THEN
        SELECT alley_id
            INTO v_alley_id_old
            FROM storage_racks
            WHERE storage_rack_id=OLD.storage_rack_id;
        SELECT alley_id
            INTO v_alley_id_new
            FROM storage_racks
            WHERE storage_rack_id=NEW.storage_rack_id;
        SELECT hall_id
            INTO v_hall_id_old
            FROM alleys
            WHERE alley_id=v_alley_id_old;
        SELECT hall_id
            INTO v_hall_id_new
            FROM alleys
            WHERE alley_id=v_alley_id_new;
        UPDATE storage_racks
            SET total_capacity=total_capacity-OLD.total_capacity,
                free_capacity=free_capacity-OLD.free_capacity
            WHERE storage_rack_id=OLD.storage_rack_id;
        UPDATE storage_racks
            SET total_capacity=total_capacity+NEW.total_capacity,
                free_capacity=free_capacity+NEW.free_capacity
            WHERE storage_rack_id=NEW.storage_rack_id;
        UPDATE alleys
            SET total_capacity=total_capacity-OLD.total_capacity,
                free_capacity=free_capacity-OLD.free_capacity
            WHERE alley_id=v_alley_id_old;
        UPDATE alleys
            SET total_capacity=total_capacity+NEW.total_capacity,
                free_capacity=free_capacity+NEW.free_capacity
            WHERE alley_id=v_alley_id_new;
        UPDATE halls
            SET total_capacity=total_capacity-OLD.total_capacity,
                free_capacity=free_capacity-OLD.free_capacity
            WHERE hall_id=v_hall_id_old;
        UPDATE halls
            SET total_capacity=total_capacity+NEW.total_capacity,
                free_capacity=free_capacity+NEW.free_capacity
            WHERE hall_id=v_hall_id_new;
    END IF;
END//

DELIMITER ;