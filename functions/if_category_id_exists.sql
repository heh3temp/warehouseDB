DELIMITER //

DROP FUNCTION IF EXISTS if_category_id_exists;

CREATE FUNCTION if_category_id_exists (
    p_category_id INT(11)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE category_exists BOOLEAN;
    DECLARE v_category_id INT(11);
    SET category_exists = False;
    SELECT count(*)
        INTO v_category_id
        FROM categories
        GROUP BY category_id
        HAVING category_id=p_category_id;
    IF v_category_id != 0 THEN
        SET category_exists = True;
    END IF;
    RETURN category_exists;
END//

DELIMITER ;