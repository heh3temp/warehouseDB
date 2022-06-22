DROP VIEW IF EXISTS items_information;

CREATE VIEW items_information AS
    SELECT i.item_id `ID produktu`, i.name `Nazwa`, i.cost `Cena`, c.name `Nazwa kategorii`, s.shelf_id `ID półki`, sr.storage_rack_id `ID regału`, a.alley_id `ID alejki`, h.hall_id `ID hali`
    FROM items i
    JOIN categories c USING(category_id)
    JOIN shelves s USING(shelf_id)
    JOIN storage_racks sr USING(storage_rack_id)
    JOIN alleys a USING(alley_id)
    JOIN halls h USING(hall_id);