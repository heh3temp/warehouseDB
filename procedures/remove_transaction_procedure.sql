DELIMITER //

DROP PROCEDURE IF EXISTS remove_transaction;

CREATE PROCEDURE remove_transaction (
    IN p_transaction_id INT(11)
)
BEGIN
    IF (SELECT if_transaction_exists(p_transaction_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Transaction not found. (remove_transaction_procedure)';
    ELSE
        DELETE FROM transaction_descriptions
            WHERE transaction_id=p_transaction_id;
        DELETE FROM transactions_history
            WHERE transaction_id=p_transaction_id;
    END IF;
END//

DELIMITER ;