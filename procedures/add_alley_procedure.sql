DELIMITER //

DROP PROCEDURE IF EXISTS add_alley;

CREATE PROCEDURE add_alley (
    IN p_hall_id INT(11),
    IN p_warehouseman_id INT(11),
    IN p_storage_racks_num INT(11),
    IN p_shelves_num INT(11),
    IN p_shelf_capacity INT(11)
)
BEGIN
    DECLARE v_alley_capacity INT(11);
    DECLARE v_storage_racks_iterator INT(11);
    DECLARE v_alley_id INT(11);
    IF (SELECT if_hall_exists(p_hall_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Hall not found. (add_alley_procedure)';
    ELSE
        IF (SELECT if_employee_exists(p_warehouseman_id)) = 0 THEN
            SIGNAL SQLSTATE '02000'
                SET MESSAGE_TEXT = 'Employee not found. (add_alley_procedure)';
        ELSE
            INSERT INTO alleys
                VALUES(NULL, p_warehouse_man_id, p_hall_id, 0, 0);
            SELECT alley_id
                INTO v_alley_id
                FROM alleys
                ORDER BY alley_id DESC
                LIMIT 1;

            SET v_storage_racks_iterator = p_storage_racks_num;
            WHILE v_storage_racks_iterator > 0 DO
                CALL add_storage_rack(v_alley_id, p_shelves_num, p_shelf_capacity);
                SET v_storage_racks_iterator = v_storage_racks_iterator - 1;
            END WHILE;
        END IF;
    END IF;
END//

DELIMITER ;