DELIMITER //

DROP PROCEDURE IF EXISTS change_employee_position;
CREATE PROCEDURE change_employee_position (
    IN p_employee_id INT(11),
    IN p_new_position_name VARCHAR(45)
)
BEGIN
    DECLARE v_new_position_id INT(11);
    IF (SELECT if_employee_exists(p_employee_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Employee not found. (change_employee_position_procedure)';
    ELSE
        IF (SELECT if_position_name_exists(p_position_name)) = 0 THEN
            SIGNAL SQLSTATE '02000'
                SET MESSAGE_TEXT = 'Position not found. (change_employee_position_procedure)';
        ELSE
            SELECT position_id
                INTO v_new_position_id
                FROM positions
                WHERE name=p_new_position_name;
            UPDATE positions_history
                SET date_end=CURDATE()
                WHERE employee_id=p_employee_id
                    AND ISNULL(date_end);
            INSERT INTO positions_history
                VALUES(NULL, employee_id, v_new_position_id,
                    CURDATE(), NULL);
            UPDATE employees
                SET position_id=v_new_position_id
                WHERE employee_id=p_employee_id;
        END IF;
    END IF;
END//

DELIMITER ;