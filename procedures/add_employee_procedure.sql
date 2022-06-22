DELIMITER //

DROP PROCEDURE IF EXISTS add_employee;

CREATE PROCEDURE add_employee (
	IN p_name VARCHAR(45),
    IN p_surname VARCHAR(45),
    IN p_position_name VARCHAR(45),
    IN p_salary DECIMAL(15, 2)
)
BEGIN
	DECLARE v_position_id INT(11);
    DECLARE v_min_salary DECIMAL(10, 0);
    DECLARE v_max_salary DECIMAL(10, 0);
    IF (SELECT if_position_name_exists(p_position_name)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Position not found. (add_employee_procedure)';
    ELSE
        SELECT position_id
            INTO v_position_id
            FROM positions
            WHERE name=p_position_name;
        SELECT salary_min
            INTO v_min_salary
            FROM positions
            WHERE position_id=v_position_id;
        SELECT salary_max
            INTO v_max_salary
            FROM positions
            WHERE position_id=v_position_id;
        IF (p_salary >= v_min_salary AND p_salary <= v_max_salary) THEN
            INSERT INTO employees
                VALUES (NULL, p_name, p_surname, v_position_id, p_salary, 0);
        ELSE
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Salary not between min and max salary for given position. (add_employee_procedure)';
        END IF;
    END IF;
END //

DELIMITER ;