DELIMITER //

DROP PROCEDURE IF EXISTS sell_item;

CREATE PROCEDURE sell_item (
    IN p_transaction_id INT(11),
    IN p_item_id INT(11)
)
BEGIN
    DECLARE v_item_cost INT(11);
    IF (SELECT if_transaction_exists(p_transaction_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Transaction not found. (sell_item_procedure)';
    ELSE
        IF (SELECT if_item_exists(p_item_id)) = 0 THEN
            SIGNAL SQLSTATE '02000'
                SET MESSAGE_TEXT = 'Item not found. (sell_item_procedure)';
        ELSE
            CALL remove_item(p_item_id);
            SELECT cost
                INTO v_item_cost
                FROM items
                WHERE item_id=p_item_id;
            UPDATE transactions_history
                SET value=value+v_item_cost
                WHERE transaction_id=p_transaction_id;
            INSERT INTO transaction_descriptions
                VALUES(NULL, p_transaction_id,
                    p_item_id, v_item_cost);
        END IF;
    END IF;
END//

DELIMITER ;