DELIMITER  //

DROP PROCEDURE IF EXISTS add_position;

CREATE PROCEDURE add_position (
	IN name VARCHAR(45),
    IN salary_min DECIMAL(15, 2),
    IN salary_max DECIMAL(15, 2)
)
BEGIN
	INSERT INTO positions
        VALUES (NULL, name, salary_min, salary_max);
END;

DELIMITER ;