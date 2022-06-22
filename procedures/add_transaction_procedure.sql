DELIMITER //

DROP PROCEDURE IF EXISTS add_transaction;

CREATE PROCEDURE add_transaction (
    IN p_contractor_id INT(11),
    OUT r_transaction_id INT(11)
)
BEGIN
    IF (SELECT if_contractor_exists(p_contractor_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Contractor not found. (add_transaction_procedure)';
    ELSE
        INSERT INTO transactions_history
            VALUES(NULL, p_contractor_id, 0, CURDATE());
        SELECT transaction_id
            INTO r_transaction_id
            FROM transactions_history
            ORDER BY transaction_id DESC
            LIMIT 1;
    END IF;
END//

DELIMITER ;