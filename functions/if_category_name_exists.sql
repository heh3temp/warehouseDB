DELIMITER //

DROP FUNCTION IF EXISTS if_category_name_exists;

CREATE FUNCTION if_category_name_exists (
    p_category_name VARCHAR(45)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE category_exists BOOLEAN;
    DECLARE v_category_id INT(11);
    SET category_exists = False;
    SELECT count(*)
        INTO v_category_id
        FROM categories c
        GROUP BY c.category_id, c.name
        HAVING c.name = p_category_name;
    IF v_category_id != 0 THEN
        SET category_exists = True;
    END IF;
    RETURN category_exists;
END//

DELIMITER ;