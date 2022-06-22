DELIMITER //

DROP FUNCTION IF EXISTS if_item_exists;

CREATE FUNCTION if_item_exists (
    p_item_id INT(11)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE item_exists BOOLEAN;
    DECLARE v_shelf_id INT(11);
    SET item_exists = False;
    SELECT shelf_id
        INTO v_shelf_id
        FROM items
        WHERE item_id=p_item_id;
    IF NOT ISNULL(v_shelf_id) THEN
        SET item_exists = True;
    END IF;
    RETURN item_exists;
END//

DELIMITER ;