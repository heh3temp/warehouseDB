DELIMITER //

DROP TRIGGER IF EXISTS remove_employee;
CREATE TRIGGER remove_employee
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF NEW.is_fired = 1 THEN
        UPDATE positions_history
            SET date_end=CURDATE()
            WHERE employee_id=NEW.employee_id
            AND ISNULL(date_end);
    END IF;
END//

DELIMITER ;