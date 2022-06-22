SET foreign_key_checks = 0;
DELETE FROM alleys;
DELETE FROM categories;
DELETE FROM contractors;
DELETE FROM employees;
DELETE FROM halls;
DELETE FROM items;
DELETE FROM positions;
DELETE FROM positions_history;
DELETE FROM shelves;
DELETE FROM storage_racks;
DELETE FROM transactions_history;
DELETE FROM transaction_descriptions;
SET foreign_key_checks = 1;

ALTER TABLE alleys AUTO_INCREMENT = 1;
ALTER TABLE categories AUTO_INCREMENT = 1;
ALTER TABLE contractors AUTO_INCREMENT = 1;
ALTER TABLE employees AUTO_INCREMENT = 1;
ALTER TABLE halls AUTO_INCREMENT = 1;
ALTER TABLE items AUTO_INCREMENT = 1;
ALTER TABLE positions AUTO_INCREMENT = 1;
ALTER TABLE positions_history AUTO_INCREMENT = 1;
ALTER TABLE shelves AUTO_INCREMENT = 1;
ALTER TABLE storage_racks AUTO_INCREMENT = 1;
ALTER TABLE transactions_history AUTO_INCREMENT = 1;
ALTER TABLE transaction_descriptions AUTO_INCREMENT = 1;

CALL add_category('artykuly budowlane');
CALL add_category('artykuly toaletowe');
CALL add_category('chemia');
CALL add_category('artykuly spozywcze');
CALL add_category('towary luksusowe');
CALL add_category('RTV');
CALL add_category('AGD');
CALL add_category('meble');
CALL add_category('odziez');

CALL add_position('kierownik', 3000, 5000);
CALL add_position('magazynier', 2000, 2500);
CALL add_position('pracownik biurowy', 3000, 4000);
CALL add_position('handlowiec', 3000, 4500);

CALL add_employee('Waclaw', 'Polak', 'kierownik', 4200);                    -- ID 1
CALL add_employee('Sebastian', 'Zalewski', 'kierownik', 5000);              -- ID 2
CALL add_employee('Piotr', 'Kowalski', 'magazynier', 2300);                 -- ID 3
CALL add_employee('Magdalena', 'Baranowska', 'kierownik', 5000);            -- ID 4
CALL add_employee('Alina', 'Maciejewska', 'handlowiec', 4300);              -- ID 5
CALL add_employee('Dariusz', 'Marciniak', 'magazynier', 2500);              -- ID 6
CALL add_employee('Krystian', 'Jaworski', 'magazynier', 2500);              -- ID 7
CALL add_employee('Dariusz', 'Michalak', 'pracownik biurowy', 3800);        -- ID 8
CALL add_employee('Arleta', 'Krupa', 'magazynier', 2000);                   -- ID 9
CALL add_employee('Ewelina', 'Andrzejewska', 'pracownik biurowy', 4000);    -- ID 10
CALL add_employee('Kazimierz', 'Makowski', 'pracownik biurowy', 3600);      -- ID 11

CALL add_hall('Pierwsza', 1, 5, 10, 5, 20);     -- 5 alleys (1-5)
                                                -- 50 storage racks (1-50)
                                                -- 250 shelves (1-250)
CALL add_hall('Druga', 4, 6, 8, 5, 15);         -- 6 alleys (6-11)
                                                -- 48 storage racks (51-98)
                                                -- 240 shelves (251-490)
CALL add_hall('Trzecia', 2, 3, 5, 2, 25);       -- 3 alleys (12-14)
                                                -- 15 storage racks (99-113)
                                                -- 30 shelves (491-520)
CALL add_hall('Czwarta', 4, 10, 5, 3, 9);       -- 10 alleys (15-24)
                                                -- 50 storage racks (114-163)
                                                -- 150 shelves (521-670)
CALL add_hall('Piata', 1, 4, 8, 6, 20);         -- 4 alleys (25-28)
                                                -- 32 storage racks (164-195)
                                                -- 192 shelves (671-862)

CALL add_item('cement', 10, 'artykuly budowlane', 1, 30);
CALL add_item('cement', 10, 'artykuly budowlane', 2, 30);
CALL add_item('cement', 10, 'artykuly budowlane', 3, 30);
CALL add_item('cement', 10, 'artykuly budowlane', 4, 30);
CALL add_item('cement', 10, 'artykuly budowlane', 5, 30);
CALL add_item('cegly', 25, 'artykuly budowlane', 500, 200);
CALL add_item('cegly', 25, 'artykuly budowlane', 501, 200);
CALL add_item('cegly', 25, 'artykuly budowlane', 502, 200);
CALL add_item('cegly', 25, 'artykuly budowlane', 503, 200);
CALL add_item('cegly', 25, 'artykuly budowlane', 504, 200);
CALL add_item('papier toaletowy', 5, 'artykuly toaletowe', 700, 20);
CALL add_item('papier toaletowy', 5, 'artykuly toaletowe', 701, 20);
CALL add_item('papier toaletowy', 5, 'artykuly toaletowe', 702, 20);
CALL add_item('papier toaletowy', 5, 'artykuly toaletowe', 703, 20);
CALL add_item('papier toaletowy', 5, 'artykuly toaletowe', 704, 20);
CALL add_item('ludwik', 5, 'chemia', 300, 10);
CALL add_item('ludwik', 5, 'chemia', 301, 10);
CALL add_item('ludwik', 5, 'chemia', 302, 10);
CALL add_item('ludwik', 5, 'chemia', 303, 10);
CALL add_item('ludwik', 5, 'chemia', 304, 10);
CALL add_item('ludwik', 5, 'chemia', 305, 10);
CALL add_item('cukier', 1, 'artykuly spozywcze', 530, 5);
CALL add_item('cukier', 1, 'artykuly spozywcze', 531, 5);
CALL add_item('cukier', 1, 'artykuly spozywcze', 532, 5);
CALL add_item('cukier', 1, 'artykuly spozywcze', 533, 5);
CALL add_item('cukier', 1, 'artykuly spozywcze', 534, 5);
CALL add_item('coca-cola', 5, 'towary luksusowe', 620, 15);
CALL add_item('coca-cola', 5, 'towary luksusowe', 621, 15);
CALL add_item('coca-cola', 5, 'towary luksusowe', 622, 15);
CALL add_item('coca-cola', 5, 'towary luksusowe', 623, 15);
CALL add_item('coca-cola', 5, 'towary luksusowe', 624, 15);
CALL add_item('telewizor MANTA', 25, 'RTV', 510, 2000);
CALL add_item('telewizor MANTA', 25, 'RTV', 511, 2000);
CALL add_item('telewizor MANTA', 25, 'RTV', 512, 2000);
CALL add_item('telewizor MANTA', 25, 'RTV', 513, 2000);
CALL add_item('telewizor MANTA', 25, 'RTV', 514, 2000);
CALL add_item('pralka Frania', 25, 'AGD', 515, 500);
CALL add_item('pralka Frania', 25, 'AGD', 516, 500);
CALL add_item('pralka Frania', 25, 'AGD', 517, 500);
CALL add_item('pralka Frania', 25, 'AGD', 518, 500);
CALL add_item('pralka Frania', 25, 'AGD', 519, 500);
CALL add_item('pralka Frania', 25, 'AGD', 520, 500);
CALL add_item('IKEA KRUKENOFF', 20, 'meble', 800, 1);
CALL add_item('IKEA KRUKENOFF', 20, 'meble', 801, 1);
CALL add_item('IKEA KRUKENOFF', 20, 'meble', 802, 1);
CALL add_item('IKEA KRUKENOFF', 20, 'meble', 803, 1);
CALL add_item('IKEA KRUKENOFF', 20, 'meble', 804, 1);
CALL add_item('kurtka', 5, 'odziez', 450, 200);
CALL add_item('kurtka', 5, 'odziez', 451, 200);
CALL add_item('kurtka', 5, 'odziez', 452, 200);
CALL add_item('kurtka', 5, 'odziez', 453, 200);
CALL add_item('kurtka', 5, 'odziez', 454, 200);

CALL add_contractor('Jan', 'Kowalski', 'Polska', 'Warszawa', 'Sarmacka 120', 'jan.kowalski@gmail.com', '123456789', 'jkowalski', '1234');
CALL add_contractor('Piotr', 'Nowak', 'Polska', 'Warszawa', 'Nowa 134', 'piotr.nowak@gmail.com', '123456789', 'pnowak', '1234');
CALL add_contractor('Adam', 'Kaczmarczyk', 'Polska', 'Sopot', 'Dluga 15', 'adam.kaczmarczyk@gmail.com', '123456789', 'akaczmarczyk', '1234');
CALL add_contractor('Juliusz', 'Czarnecki', 'Polska', 'Zakopane', 'Piekna 12', 'juliusz.czarnecki@gmail.com', '123456789', 'jczarnecki', '1234');
CALL add_contractor('Cecylia', 'Pietrzak', 'Polska', 'Zakopane', 'Mickiewicza 128', 'cecylia.pietrzak@gmail.com', '123456789', 'cpietrzak', '1234');
CALL add_contractor('Maria', 'Michalak', 'Polska', 'Poznan', 'Zlota 120', 'maria.michalak@gmail.com', '123456789', 'mmichalak', '1234');
CALL add_contractor('Krystyna', 'Wojciechowska', 'Polska', 'Warszawa', 'Senna 12', 'krystyna.wojciechowska@gmail.com', '123456789', 'kwojciechowska', '1234');
CALL add_contractor('Balbina', 'Kucharska', 'Polska', 'Lublin', 'Krotka 99', 'balbina.kucharska@gmail.com', '123456789', 'bkucharska', '1234');
