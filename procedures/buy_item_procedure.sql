DELIMITER //

DROP PROCEDURE IF EXISTS buy_item;

CREATE PROCEDURE buy_item (
    IN p_transaction_id INT(11),
    IN p_item_name VARCHAR(45),
    IN p_item_consumed_capacity INT(11),
    IN p_item_category_name VARCHAR(45),
    IN p_item_shelf_id INT(11),
    IN p_item_cost DECIMAL(15, 2)
)
BEGIN
    DECLARE v_item_id INT(11);
    CALL add_item(p_item_name, p_item_consumed_capacity,
                  p_item_category_name, p_item_shelf_id,
                  p_item_cost);
    SELECT item_id
        INTO v_item_id
        FROM items
        ORDER BY item_id DESC
        LIMIT 1;
    UPDATE transactions_history
        SET value=value-p_item_cost
        WHERE transaction_id=p_transaction_id;
    INSERT INTO transaction_descriptions
        VALUES(NULL, p_transaction_id, v_item_id, -p_item_cost);
END//

DELIMITER ;