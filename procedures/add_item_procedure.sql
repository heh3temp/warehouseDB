DELIMITER //

DROP PROCEDURE IF EXISTS add_item; 

CREATE PROCEDURE add_item (
	IN p_name VARCHAR(45),
    IN p_consumed_capacity INT(11),
    IN p_category_name VARCHAR(45),
	IN p_shelf_id INT(11),
    IN p_cost DECIMAL(15, 2)
)
BEGIN
    DECLARE v_free_capacity INT(11);
	DECLARE v_category_id INT(11);
    IF (SELECT if_shelf_exists(p_shelf_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Shelf not found. (add_item_procedure)';
    ELSE
        IF (SELECT if_category_name_exists(p_category_name)) = 0 THEN
            SIGNAL SQLSTATE '02000'
                SET MESSAGE_TEXT = 'Category not found. (add_item_procedure)';
        ELSE
            SELECT free_capacity
                INTO v_free_capacity
                FROM shelves
                WHERE shelf_id=p_shelf_id;
            IF v_free_capacity < p_consumed_capacity THEN
                SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'There is not enough space on the shelf. (add_item_procedure)';
            ELSE
                SELECT category_id
                    INTO v_category_id
                    FROM categories
                    WHERE name=p_category_name;
                INSERT INTO items
                    VALUES(NULL, p_name, p_consumed_capacity,
                        v_category_id, p_shelf_id, p_cost);
            END IF;
        END IF;
    END IF;
END//

DELIMITER ;