DELIMITER //

DROP FUNCTION IF EXISTS if_contractor_exists;

CREATE FUNCTION if_contractor_exists (
    p_contractor_id INT(11)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE contractor_exists BOOLEAN;
    DECLARE v_contractor_id INT(11);
    SET contractor_exists = False;
    SELECT count(*)
        INTO v_contractor_id
        FROM contractors
        GROUP BY contractor_id
        HAVING contractor_id=p_contractor_id;
    IF v_contractor_id != 0 THEN
        SET contractor_exists = True;
    END IF;
    RETURN contractor_exists;
END//

DELIMITER ;