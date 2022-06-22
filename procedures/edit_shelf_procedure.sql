DELIMITER //

DROP PROCEDURE IF EXISTS edit_shelf;

CREATE PROCEDURE edit_shelf (
    IN p_shelf_id INT(11),
    IN p_storage_rack_id INT(11),
    IN p_shelf_new_total_capacity INT(11)
)
BEGIN
    DECLARE v_shelf_old_total_capacity INT(11);
    DECLARE v_shelf_free_capacity INT(11);
    DECLARE v_shelf_new_free_capacity INT(11);
    IF (SELECT if_shelf_exists(p_shelf_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Shelf not found. (edit_shelf_procedure)';
    ELSE
        IF (SELECT if_storage_rack_exists(p_storage_rack_id)) = 0 THEN
            SIGNAL SQLSTATE '02000'
                SET MESSAGE_TEXT = 'Storage rack not found. (edit_shelf_procedure)';
        ELSE
            SELECT free_capacity
                INTO v_shelf_free_capacity
                FROM shelves
                WHERE shelf_id=p_shelf_id;
            SELECT total_capacity
                INTO v_shelf_old_total_capacity
                FROM shelves
                WHERE shelf_id=p_shelf_id;
            SET v_shelf_new_free_capacity = v_shelf_free_capacity - (v_shelf_old_total_capacity - p_shelf_new_total_capacity);
            IF v_shelf_new_free_capacity < 0 THEN
                SIGNAL SQLSTATE '02000'
                    SET MESSAGE_TEXT = 'Not enough free space on shelf. Cannot change total capacity (edit_shelf_procedure)';
            ELSE
                UPDATE shelves
                    SET total_capacity=p_shelf_new_total_capacity,
                        free_capacity=v_shelf_new_free_capacity,
                        storage_rack_id=p_storage_rack_id
                    WHERE shelf_id=p_shelf_id;
            END IF;
        END IF;
    END IF;
END//

DELIMITER ;