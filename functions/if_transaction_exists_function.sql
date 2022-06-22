DELIMITER //

DROP FUNCTION IF EXISTS if_transaction_exists;

CREATE FUNCTION if_transaction_exists (
    p_transaction_id INT(11)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE transaction_exists BOOLEAN;
    DECLARE v_transaction_id INT(11);
    SET transaction_exists = False;
    SELECT count(*)
        INTO v_transaction_id
        FROM transactions_history
        GROUP BY transaction_id
        HAVING transaction_id=p_transaction_id;
    IF v_transaction_id != 0 THEN
        SET transaction_exists = True;
    END IF;
    RETURN transaction_exists;
END//

DELIMITER ;