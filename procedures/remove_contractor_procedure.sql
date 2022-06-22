DELIMITER //

DROP PROCEDURE IF EXISTS remove_contractor;

CREATE PROCEDURE remove_contractor (
    IN p_contractor_id INT(11)
)
BEGIN
    IF (SELECT if_contractor_exists(p_contractor_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Contractor not found. (emove_category_procedure)';
    ELSE
        UPDATE contractors
            SET is_active=0, date_removed=CURDATE()
            WHERE contractor_id=p_contractor_id;
    END IF;
END//

DELIMITER ;