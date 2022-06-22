DELIMITER //

DROP PROCEDURE IF EXISTS remove_employee;

CREATE PROCEDURE remove_employee (
    IN p_employee_id INT(11)
)
BEGIN
    IF (SELECT if_employee_exists(p_employee_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Employee not found. (remove_employee_procedure)';
    ELSE
        UPDATE halls
            SET manager_id=NULL
            WHERE manager_id=p_employee_id;
        UPDATE alleys
            SET warehouseman_id=NULL
            WHERE warehouseman_id=p_employee_id;
        UPDATE employees
            SET position_id=NULL, salary=NULL, is_fired=1
            WHERE employee_id=p_employee_id;
    END IF;
END//

DELIMITER ;