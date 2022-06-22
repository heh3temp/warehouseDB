DELIMITER //

DROP FUNCTION IF EXISTS if_employee_exists;

CREATE FUNCTION if_employee_exists (
    p_employee_id INT(11)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE employee_exists BOOLEAN;
    DECLARE v_employee_id INT(11);
    SET employee_exists = False;
    SELECT count(*)
        INTO v_employee_id
        FROM employees
        GROUP BY employee_id
        HAVING employee_id=p_employee_id;
    IF v_employee_id != 0 THEN
        SET employee_exists = True;
    END IF;
    RETURN employee_exists;
END//

DELIMITER ;