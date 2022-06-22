DELIMITER //

DROP FUNCTION IF EXISTS if_storage_rack_exists;

CREATE FUNCTION if_storage_rack_exists (
    p_storage_rack_id INT(11)
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE storage_rack_exists BOOLEAN;
    DECLARE v_storage_rack_id INT(11);
    SET storage_rack_exists = False;
    SELECT count(*)
        INTO v_storage_rack_id
        FROM storage_racks
        GROUP BY storage_rack_id
        HAVING storage_rack_id=p_storage_rack_id;
    IF v_storage_rack_id != 0 THEN
        SET storage_rack_exists = True;
    END IF;
    RETURN storage_rack_exists;
END//

DELIMITER ;