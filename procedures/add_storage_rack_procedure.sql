DELIMITER //

DROP PROCEDURE IF EXISTS add_storage_rack;

CREATE PROCEDURE add_storage_rack (
    IN p_alley_id INT(11),
    IN p_shelves_num INT(11),
    IN p_shelf_capacity INT(11)
)
BEGIN
    DECLARE v_shelves_iterator INT(11);
    DECLARE v_storage_rack_id INT(11);
    IF (SELECT if_alley_exists(p_alley_id)) = 0 THEN
        SIGNAL SQLSTATE '02000'
            SET MESSAGE_TEXT = 'Alley not found. (add_storage_rack_procedure)';
    ELSE
        INSERT INTO storage_racks
            VALUES(NULL, 0, 0, p_alley_id);
        SELECT storage_rack_id
            INTO v_storage_rack_id
            FROM storage_racks
            ORDER BY storage_rack_id DESC
            LIMIT 1;

        SET v_shelves_iterator = p_shelves_num;
        WHILE v_shelves_iterator > 0 DO
            CALL add_shelf(v_storage_rack_id, p_shelf_capacity);
            SET v_shelves_iterator = v_shelves_iterator - 1;
        END WHILE;
    END IF;
END//

DELIMITER ;