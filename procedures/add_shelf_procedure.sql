DELIMITER //

DROP PROCEDURE IF EXISTS add_shelf;

CREATE PROCEDURE add_shelf (
    IN p_storage_rack_id INT(11),
    IN p_capacity INT(11)
)
BEGIN 
    DECLARE v_alley_id INT(11);
    DECLARE v_hall_id INT(11);
    IF (SELECT if_storage_rack_exists(p_storage_rack_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Storage rack not found. (add_shelf_procedure)';
    ELSE
        SELECT alley_id
            INTO v_alley_id
            FROM storage_racks
            WHERE storage_rack_id=p_storage_rack_id;
        SELECT hall_id
            INTO v_hall_id
            FROM alleys
            WHERE alley_id=v_alley_id;
        
        INSERT INTO shelves
            VALUES(NULL, p_capacity, p_capacity, p_storage_rack_id);
        
        UPDATE storage_racks
            SET total_capacity=total_capacity+p_capacity,
                free_capacity=free_capacity+p_capacity
            WHERE storage_rack_id=p_storage_rack_id;
        UPDATE alleys
            SET total_capacity=total_capacity+p_capacity,
                free_capacity=free_capacity+p_capacity
            WHERE alley_id=v_alley_id;
        UPDATE halls
            SET total_capacity=total_capacity+p_capacity,
                free_capacity=free_capacity+p_capacity
            WHERE hall_id=v_hall_id;
    END IF;
END//

DELIMITER ;