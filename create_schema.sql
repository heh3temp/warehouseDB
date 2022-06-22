SET foreign_key_checks = 0;

CREATE DATABASE IF NOT EXISTS `magazyn`;
USE `magazyn`;
DROP TABLE IF EXISTS `alleys`;
CREATE TABLE `alleys` (
  `alley_id` int(11) NOT NULL AUTO_INCREMENT,
  `warehouseman_id` int(11),
  `hall_id` int(11) NOT NULL,
  `total_capacity` int(11) NOT NULL,
  `free_capacity` int(11) NOT NULL,
  PRIMARY KEY (`alley_id`),
  KEY `fk_alleys_halls1_idx` (
    `hall_id`),
  KEY `fk_alleys_employees1_idx` (`warehouseman_id`),
  CONSTRAINT `fk_alleys_employees1`
    FOREIGN KEY (`warehouseman_id`)
    REFERENCES `employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alleys_halls1`
    FOREIGN KEY (`hall_id`)
    REFERENCES `halls` (`hall_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
);


DROP TABLE IF EXISTS `contractors`;
CREATE TABLE `contractors` (
  `contractor_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) DEFAULT NULL,
  `country` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `street` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  `date_added` date NOT NULL,
  `login` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `is_active` boolean NOT NULL DEFAULT 1,
  `date_removed` date DEFAULT NULL,
  PRIMARY KEY (`contractor_id`),
  UNIQUE KEY `login_UNIQUE` (`login`),
  UNIQUE KEY `email_UNIQUE` (`email`)
);


DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `position_id` int(11),
  `salary` decimal(15, 2),
  `is_fired` boolean DEFAULT 0,
  PRIMARY KEY (`employee_id`),
  KEY `fk_employees_positions1_idx` (`position_id`),
  CONSTRAINT `fk_employees_positions1`
    FOREIGN KEY (`position_id`)
    REFERENCES `positions` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


DROP TABLE IF EXISTS `halls`;
CREATE TABLE `halls` (
  `hall_id` int(11) NOT NULL AUTO_INCREMENT,
  `total_capacity` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `manager_id` int(11),
  `free_capacity` int(11) NOT NULL,
  PRIMARY KEY (`hall_id`),
  KEY `fk_halls_employees1_idx` (`manager_id`),
  CONSTRAINT `fk_halls_employees1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `consumed_capacity` int(11) NOT NULL,
  `category_id` int(11),
  `shelf_id` int(11),
  `cost` decimal(15,2) NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `fk_items_shelves1_idx` (`shelf_id`),
  KEY `fk_items_categories1_idx` (`category_id`),
  CONSTRAINT `fk_items_categories1`
    FOREIGN KEY (`category_id`)
    REFERENCES `categories` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_shelves1`
    FOREIGN KEY (`shelf_id`)
    REFERENCES `shelves` (`shelf_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


DROP TABLE IF EXISTS `positions`;
CREATE TABLE `positions` (
  `position_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `salary_min` decimal(10,0) NOT NULL,
  `salary_max` decimal(10,0) NOT NULL,
  PRIMARY KEY (`position_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
);


DROP TABLE IF EXISTS `positions_history`;
CREATE TABLE `positions_history` (
  `positions_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date DEFAULT NULL,
  PRIMARY KEY (`positions_history_id`),
  KEY `fk_positions_history_positions1_idx` (`position_id`),
  KEY `fk_positions_history_employees1` (`employee_id`),
  CONSTRAINT `fk_positions_history_employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_positions_history_positions1`
    FOREIGN KEY (`position_id`)
    REFERENCES `positions` (`position_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


DROP TABLE IF EXISTS `shelves`;
CREATE TABLE `shelves` (
  `shelf_id` int(11) NOT NULL AUTO_INCREMENT,
  `total_capacity` int(11) NOT NULL,
  `free_capacity` int(11) NOT NULL,
  `storage_rack_id` int(11) NOT NULL,
  PRIMARY KEY (`shelf_id`),
  KEY `fk_shelves_storage_racks1_idx` (`storage_rack_id`),
  CONSTRAINT `fk_shelves_storage_racks1`
    FOREIGN KEY (`storage_rack_id`)
    REFERENCES `storage_racks` (`storage_rack_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


DROP TABLE IF EXISTS `storage_racks`;
CREATE TABLE `storage_racks` (
  `storage_rack_id` int(11) NOT NULL AUTO_INCREMENT,
  `total_capacity` int(11) NOT NULL,
  `free_capacity` int(11) NOT NULL,
  `alley_id` int(11) NOT NULL,
  PRIMARY KEY (`storage_rack_id`),
  KEY `fk_storage_racks_alleys1_idx` (`alley_id`),
  CONSTRAINT `fk_storage_racks_alleys1`
    FOREIGN KEY (`alley_id`)
    REFERENCES `alleys` (`alley_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


DROP TABLE IF EXISTS `transactions_history`;
CREATE TABLE `transactions_history` (
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `contractor_id` int(11) NOT NULL,
  `value` decimal(15,2) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_transactions_history_contractors1_idx` (`contractor_id`),
  CONSTRAINT `fk_transactions_history_contractors1`
    FOREIGN KEY (`contractor_id`)
    REFERENCES `contractors` (`contractor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);


DROP TABLE IF EXISTS `transaction_descriptions`;
CREATE TABLE `transaction_descriptions` (
  `transactions_description_id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `value` decimal(15,2) NOT NULL,
  PRIMARY KEY (`transactions_description_id`),
  KEY `fk_transactions_description_transactions_history1_idx` (`transaction_id`),
  KEY `fk_transactions_description_items1_idx` (`item_id`),
  CONSTRAINT `fk_transactions_description_items1`
    FOREIGN KEY (`item_id`)
    REFERENCES `items` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_description_transactions_history1`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `transactions_history` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

SET foreign_key_checks = 1;