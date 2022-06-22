DELIMITER //

DROP FUNCTION IF EXISTS count_items_in_category;

CREATE FUNCTION count_items_in_category(category_name VARCHAR(45))
RETURNS INT(11)
BEGIN
    DECLARE num_items INT(11);

    SELECT COUNT(*) INTO num_items
    FROM items AS i JOIN categories AS c ON (c.category_id = i.category_id)
    WHERE c.name = category_name;

    RETURN num_items;

END //

DELIMITER;