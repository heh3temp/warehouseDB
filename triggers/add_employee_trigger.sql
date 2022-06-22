DELIMITER //

DROP TRIGGER IF EXISTS add_employee;

CREATE TRIGGER add_employee
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO positions_history
        VALUES(NULL, NEW.employee_id,
               NEW.position_id, CURDATE(), NULL);
END//

DELIMITER ;