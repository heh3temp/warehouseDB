DELIMITER //

DROP PROCEDURE IF EXISTS add_category;

CREATE PROCEDURE add_category (
	IN name VARCHAR(45)
)
BEGIN
	INSERT INTO categories
    	VALUES (NULL, name);
END;

DELIMITER ;