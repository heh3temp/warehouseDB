DELIMITER //

DROP TRIGGER IF EXISTS remove_category;
CREATE TRIGGER remove_category
BEFORE DELETE ON categories
FOR EACH ROW
BEGIN
    UPDATE items
        SET category_id=NULL
        WHERE category_id=OLD.category_id;
END//

DELIMITER ;

        