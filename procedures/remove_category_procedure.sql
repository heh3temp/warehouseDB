DELIMITER //

DROP PROCEDURE IF EXISTS remove_category;

CREATE PROCEDURE remove_category (
    IN p_category_id INT(11)
)
BEGIN
    IF (SELECT if_category_id_exists(p_category_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Category not found. (remove_category_procedure)';
    ELSE
        DELETE FROM categories
            WHERE category_id=p_category_id;
    END IF;
END//

DELIMITER ;