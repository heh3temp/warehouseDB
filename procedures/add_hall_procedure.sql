DELIMITER //

DROP PROCEDURE IF EXISTS add_hall;

CREATE PROCEDURE add_hall (
    IN p_name VARCHAR(45),
    IN p_manager_id INT(11),
    IN p_alleys_num INT(11),
    IN p_storage_racks_num INT(11),
    IN p_shelves_num INT(11),
    IN p_shelf_capacity INT(11)
)
BEGIN
    DECLARE v_alleys_iterator INT(11);
    DECLARE v_hall_id INT(11);
    IF (SELECT if_employee_exists(p_manager_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Employee not found. (add_hall_procedure)';
    ELSE
        INSERT INTO halls
            VALUES(NULL, 0, p_name, p_manager_id, 0);
        SELECT hall_id
            INTO v_hall_id
            FROM halls
            ORDER BY hall_id DESC
            LIMIT 1;

        SET v_alleys_iterator = p_alleys_num;
        WHILE v_alleys_iterator > 0 DO
            CALL add_alley(v_hall_id, NULL, p_storage_racks_num,
                           p_shelves_num, p_shelf_capacity);
            SET v_alleys_iterator = v_alleys_iterator - 1;
        END WHILE;
    END IF;
END//

DELIMITER ;