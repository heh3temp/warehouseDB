DROP PROCEDURE IF EXISTS add_contractor;

DELIMITER //

CREATE PROCEDURE add_contractor(
	IN name VARCHAR(45),
    IN surname VARCHAR(45),
    IN country VARCHAR(45),
	IN city VARCHAR(45),
    IN street VARCHAR(45),
    IN email VARCHAR(45),
	IN phone_number VARCHAR(45),
    IN login VARCHAR(45),
	IN password VARCHAR(45)
)
BEGIN
    DECLARE date_added DATE;
    
    SET date_added = CURDATE();
    
	INSERT INTO contractors
        VALUES (NULL, name, surname, country, city, street,
			    email, phone_number, date_added, login, password, 1, NULL);
    
END //

DELIMITER ;