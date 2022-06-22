DELIMITER //

DROP PROCEDURE IF EXISTS change_alley_warehouseman;

CREATE PROCEDURE change_alley_warehouseman (
    IN p_alley_id INT(11),
    IN p_new_warehouseman_id VARCHAR(45)
)
BEGIN
    IF (SELECT if_alley_exists(p_alley_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Alley not found. (change_alley_warehouseman_procedure)';
    ELSE
        IF (SELECT if_employee_exists(p_new_warehouseman_id)) = 0 THEN
            SIGNAL SQLSTATE '02000'
                SET MESSAGE_TEXT = 'Employee not found. (change_alley_warehouseman_procedure)';
        ELSE
            UPDATE alleys
                SET warehouseman_id=p_new_warehouseman_id
                WHERE alley_id=p_alley_id;
        END IF;
    END IF;
END//

DELIMITER ;
