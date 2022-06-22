DELIMITER //

DROP PROCEDURE IF EXISTS add_hall;

CREATE PROCEDURE add_hall (
    IN p_name VARCHAR(45),
    IN p_manager_id INT(11),
    IN p_alleys INT(11),
    IN p_storage_racks INT(11),
    IN p_shelves INT(11),
    IN p_shelf_size DECIMAL(10, 0)
)
BEGIN
    DECLARE v_storage_rack_size INT(11);
    DECLARE v_alley_size INT(11);
    DECLARE v_hall_size INT(11);
    DECLARE v_hall_id INT(11);
    DECLARE v_alley_id INT(11);
    DECLARE v_storage_rack_id INT(11);
    DECLARE v_alleys_iterator INT(11);
    DECLARE v_storage_racks_iterator INT(11);
    DECLARE v_shelves_iterator INT(11);
    SET v_storage_rack_size = p_shelf_size * p_shelves;
    SET v_alley_size = v_storage_rack_size * p_storage_racks;
    SET v_hall_size = v_alley_size * p_alleys;
    INSERT INTO halls
        VALUES(NULL, v_hall_size, p_name, p_manager_id, v_hall_size);
    SELECT hall_id
        INTO v_hall_id
        FROM halls
        ORDER BY hall_id DESC
        LIMIT 1;
    SET v_alleys_iterator = p_alleys;
    WHILE v_alleys_iterator > 0 DO
        INSERT INTO alleys
            VALUES(NULL, NULL, v_hall_id, v_alley_size, v_alley_size);
        SELECT alley_id
            INTO v_alley_id
            FROM alleys
            ORDER BY alley_id DESC
            LIMIT 1;
        SET v_storage_racks_iterator = p_storage_racks;
        WHILE v_storage_racks_iterator > 0 DO
            INSERT INTO storage_racks
                VALUES(NULL, v_storage_rack_size, v_storage_rack_size, v_alley_id);
            SELECT storage_rack_id
                INTO v_storage_rack_id
                FROM storage_racks
                ORDER BY storage_rack_id DESC
                LIMIT 1;
            SET v_shelves_iterator = p_shelves;
            WHILE v_shelves_iterator > 0 DO
                INSERT INTO shelves
                    VALUES(NULL, p_shelf_size, p_shelf_size, v_storage_rack_id);
                SET v_shelves_iterator = v_shelves_iterator - 1;
            END WHILE;
            SET v_storage_racks_iterator = v_storage_racks_iterator - 1;
        END WHILE;
        SET v_alleys_iterator = v_alleys_iterator - 1;
    END WHILE;
END//

DELIMITER ;