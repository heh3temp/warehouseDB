DELIMITER //

DROP PROCEDURE IF EXISTS edit_contractor;

CREATE PROCEDURE edit_contractor (
	IN p_contractor_id INT(11),
    IN p_name VARCHAR(45),
    IN p_surname VARCHAR(45),
    IN p_country VARCHAR(45),
	IN p_city VARCHAR(45),
    IN p_street VARCHAR(45),
    IN p_email VARCHAR(45),
	IN p_phone_number VARCHAR(45),
    IN p_login VARCHAR(45),
	IN p_password VARCHAR(45)
)
BEGIN
    IF (SELECT if_contractor_exists(p_contractor_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Contractor not found. (edit_contractor_procedure)';
    ELSE
        UPDATE contractors
            SET name=p_name, surname=p_surname,
                country=p_country, city=p_city,
                street=p_street, email=p_email,
                phone_number=p_phone_number,
                login=p_login, password=p_password
            WHERE contractor_id=p_contractor_id;
    END IF;
END//

DELIMITER ;