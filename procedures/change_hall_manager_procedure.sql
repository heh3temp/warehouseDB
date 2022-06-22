DELIMITER //

DROP PROCEDURE IF EXISTS change_hall_manager;

CREATE PROCEDURE change_hall_manager (
    IN p_hall_id INT(11),
    IN p_new_manager_id VARCHAR(45)
)
BEGIN
    IF (SELECT if_hall_exists(p_hall_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Hall not found. (change_hall_manager_procedure)';
    ELSE
        IF (SELECT if_employee_exists(p_new_manager_id)) = 0 THEN
            SIGNAL SQLSTATE '02000'
                SET MESSAGE_TEXT = 'Employee not found. (change_hall_manager_procedure)';
        ELSE
            UPDATE halls
                SET manager_id=p_new_manager_id
                WHERE hall_id=p_hall_id;
        END IF;
    END IF;
END//

DELIMITER ;