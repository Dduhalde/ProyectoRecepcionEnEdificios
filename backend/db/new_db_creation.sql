-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema roentgenium_new_eer
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema roentgenium_new_eer
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `roentgenium_new_eer` DEFAULT CHARACTER SET utf8 ;
USE `roentgenium_new_eer` ;

-- -----------------------------------------------------
-- Table `roentgenium_new_eer`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roentgenium_new_eer`.`person` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(31) NOT NULL,
  `last_name` VARCHAR(31) NOT NULL,
  `run` INT NOT NULL,
  `run_vd` TINYINT(1) NOT NULL,
  `birth_date` DATE NULL,
  `contact_phone_number` VARCHAR(15) NULL,
  `contact_email` VARCHAR(127) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `run_UNIQUE` (`run` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roentgenium_new_eer`.`tower`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roentgenium_new_eer`.`tower` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `located_at` VARCHAR(127) NOT NULL,
  `name_identifier` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roentgenium_new_eer`.`apartment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roentgenium_new_eer`.`apartment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tower_id` INT NOT NULL,
  `number_identifier` SMALLINT NOT NULL,
  `floor` TINYINT NOT NULL,
  PRIMARY KEY (`id`, `tower_id`),
  INDEX `fk_apartment_tower_idx` (`tower_id` ASC) VISIBLE,
  CONSTRAINT `fk_apartment_tower`
    FOREIGN KEY (`tower_id`)
    REFERENCES `roentgenium_new_eer`.`tower` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roentgenium_new_eer`.`inhabitant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roentgenium_new_eer`.`inhabitant` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `apartment_id` INT NOT NULL,
  `person_id` INT NOT NULL,
  PRIMARY KEY (`id`, `apartment_id`, `person_id`),
  INDEX `fk_inhabitant_apartment1_idx` (`apartment_id` ASC) VISIBLE,
  INDEX `fk_inhabitant_person1_idx` (`person_id` ASC) VISIBLE,
  CONSTRAINT `fk_inhabitant_apartment1`
    FOREIGN KEY (`apartment_id`)
    REFERENCES `roentgenium_new_eer`.`apartment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inhabitant_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `roentgenium_new_eer`.`person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roentgenium_new_eer`.`visitor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roentgenium_new_eer`.`visitor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `person_id` INT NOT NULL,
  PRIMARY KEY (`id`, `person_id`),
  INDEX `fk_visitor_person1_idx` (`person_id` ASC) VISIBLE,
  CONSTRAINT `fk_visitor_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `roentgenium_new_eer`.`person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roentgenium_new_eer`.`mail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roentgenium_new_eer`.`mail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `apartment_id` INT NOT NULL,
  `arrival_time` DATETIME NOT NULL,
  `mail_type` TINYINT NOT NULL,
  `is_notified` TINYINT(1) NOT NULL,
  `is_claimed` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`, `apartment_id`),
  INDEX `fk_mail_apartment1_idx` (`apartment_id` ASC) VISIBLE,
  CONSTRAINT `fk_mail_apartment1`
    FOREIGN KEY (`apartment_id`)
    REFERENCES `roentgenium_new_eer`.`apartment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roentgenium_new_eer`.`visitor_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roentgenium_new_eer`.`visitor_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `visitor_id` INT NOT NULL,
  `apartment_id` INT NOT NULL,
  `visit_date` DATETIME NOT NULL,
  `visit_type` TINYINT NOT NULL,
  PRIMARY KEY (`id`, `visitor_id`, `apartment_id`),
  INDEX `fk_visitor_log_visitor1_idx` (`visitor_id` ASC) VISIBLE,
  INDEX `fk_visitor_log_apartment1_idx` (`apartment_id` ASC) VISIBLE,
  CONSTRAINT `fk_visitor_log_visitor1`
    FOREIGN KEY (`visitor_id`)
    REFERENCES `roentgenium_new_eer`.`visitor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_visitor_log_apartment1`
    FOREIGN KEY (`apartment_id`)
    REFERENCES `roentgenium_new_eer`.`apartment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roentgenium_new_eer`.`vehicle_visitors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roentgenium_new_eer`.`vehicle_visitors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `visitor_id` INT NOT NULL,
  `license_plate` VARCHAR(8) NOT NULL,
  `parking_spot` TINYINT NULL,
  `parking_date` DATETIME NULL,
  PRIMARY KEY (`id`, `visitor_id`),
  INDEX `fk_vehicles_visitors_visitor1_idx` (`visitor_id` ASC) VISIBLE,
  CONSTRAINT `fk_vehicles_visitors_visitor1`
    FOREIGN KEY (`visitor_id`)
    REFERENCES `roentgenium_new_eer`.`visitor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roentgenium_new_eer`.`login_sys`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roentgenium_new_eer`.`login_sys` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `person_id` INT NOT NULL,
  `username` VARCHAR(127) NOT NULL,
  `password_hashed` CHAR(64) NOT NULL,
  `password_salt` CHAR(32) NOT NULL,
  `user_role` TINYINT NOT NULL,
  `last_access` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `person_id`),
  INDEX `fk_login_sys_person1_idx` (`person_id` ASC) VISIBLE,
  CONSTRAINT `fk_login_sys_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `roentgenium_new_eer`.`person` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roentgenium_new_eer`.`frequent_visitor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roentgenium_new_eer`.`frequent_visitor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `visitor_id` INT NOT NULL,
  `apartment_id` INT NOT NULL,
  PRIMARY KEY (`id`, `visitor_id`, `apartment_id`),
  INDEX `fk_table1_visitor1_idx` (`visitor_id` ASC) VISIBLE,
  INDEX `fk_table1_apartment1_idx` (`apartment_id` ASC) VISIBLE,
  CONSTRAINT `fk_table1_visitor1`
    FOREIGN KEY (`visitor_id`)
    REFERENCES `roentgenium_new_eer`.`visitor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_apartment1`
    FOREIGN KEY (`apartment_id`)
    REFERENCES `roentgenium_new_eer`.`apartment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `roentgenium_new_eer` ;

-- -----------------------------------------------------
-- Placeholder table for view `roentgenium_new_eer`.`visitors_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roentgenium_new_eer`.`visitors_information` (`visitor_id` INT, `full_name` INT, `run` INT, `birth_date` INT, `apartment_visited` INT, `is_frequent_visitor` INT, `visit_motive` INT, `visit_date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `roentgenium_new_eer`.`unclaimed_correspondence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roentgenium_new_eer`.`unclaimed_correspondence` (`id` INT, `recipient` INT, `mail_type` INT, `arrival_time` INT, `is_notified` INT, `is_claimed` INT);

-- -----------------------------------------------------
-- Placeholder table for view `roentgenium_new_eer`.`currently_parked_vehicles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roentgenium_new_eer`.`currently_parked_vehicles` (`visitor_id` INT, `full_name` INT, `license_plate` INT, `parked_at` INT, `parked_since` INT);

-- -----------------------------------------------------
-- procedure add_visitor
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE add_visitor(
    IN p_visitor_id INT,
    IN p_apartment_id INT,
    IN p_visit_type TINYINT
)
BEGIN
    DECLARE person_exists INT;

    -- Check if person already exists in visitor table
    SELECT COUNT(*) INTO person_exists
    FROM visitor
    WHERE person_id = p_visitor_id;

    -- If does not exist, INSERT
    IF person_exists = 0 THEN
        INSERT INTO visitor (person_id) VALUES (p_visitor_id);
    END IF;

    -- INSERT in the log
    INSERT INTO visitor_log (visitor_id, apartment_id, visit_date, visit_type)
    VALUES (p_visitor_id, p_apartment_id, NOW(), p_visit_type);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_inhabitant
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE add_inhabitant(IN p_id INT, IN apt_id INT)
BEGIN
	INSERT INTO inhabitant (person_id, apartment_id) VALUES (p_id, apt_id);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_mail
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE add_mail(IN m_type TINYINT, IN a_time DATETIME, IN apt_id INT, IN i_notified TINYINT)
BEGIN
	INSERT INTO mail (mail_type, arrival_time, apartment_id, is_notified, is_claimed) VALUES (m_type, a_time, apt_id, i_notified, 0);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_user_login
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE add_user_login(IN usrnm VARCHAR(127), IN psswrd CHAR(64), IN slt CHAR(32), IN u_role TINYINT)
BEGIN
	INSERT INTO login_sys (username, password_hashed, password_salt, user_role, last_access) VALUES (usrnm, psswrd, slt, u_role, NOW());
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_visitor_vehicle
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE add_visitor_vehicle(IN v_id INT, IN l_plate VARCHAR(8))
BEGIN
	INSERT INTO vehicle_visitors (visitor_id, license_plate) VALUES (v_id, l_plate);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure assign_parking_spot
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE assign_parking_spot(IN l_plate VARCHAR(8), IN p_spot SMALLINT)
BEGIN
	UPDATE vehicle_visitors SET parking_spot = p_spot, parking_date = NOW() WHERE (license_plate = l_plate AND (p_spot BETWEEN 1 AND 8) AND id > 0);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure free_parking_spot
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE free_parking_spot(IN l_plate VARCHAR(8))
BEGIN
	UPDATE vehicle_visitors SET parking_spot = NULL, parking_date = NULL WHERE license_plate = l_plate AND id > 0;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_vehicle
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE delete_vehicle(IN l_plate VARCHAR(8))
BEGIN
	DELETE FROM vehicles_visitors WHERE (license_plate = l_plate AND id > 0);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_mail_to_claimed
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE update_mail_to_claimed(IN m_id INT)
BEGIN
	UPDATE mail SET is_claimed = 1 WHERE id = m_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_frequent_visitor
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE add_frequent_visitor(IN v_id INT, IN apt_id INT)
BEGIN
	INSERT INTO frequent_visitor (visitor_id, apartment_id) VALUES (v_id, apt_id);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_tower
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE add_tower(IN tower_address VARCHAR(127), IN tower_name VARCHAR(45))
BEGIN
	INSERT INTO tower (located_at, name_identifier) VALUES (tower_address, tower_name);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_apartment
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE add_apartment(IN t_id INT, IN n_identifier SMALLINT, IN tower_floor_located_at TINYINT)
BEGIN
	INSERT INTO apartment (tower_id, number_identifier, floor) VALUES (t_id, n_identifier, tower_floor_located_at);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_visitor
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE delete_visitor(IN v_id INT)
BEGIN
	DECLARE p_id INT;
	DELETE FROM visitor_log WHERE visitor_id = v_id;
	DELETE FROM vehicle_visitors WHERE visitor_id = v_id;
    DELETE FROM frequent_visitor WHERE visitor_id = v_id;
    SELECT person_id INTO p_id FROM visitor WHERE id = v_id;
    DELETE FROM visitor WHERE id = v_id;
    DELETE FROM person WHERE id = p_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_person
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE PROCEDURE add_person(IN f_name VARCHAR(31), IN l_name VARCHAR(31), IN r_num INT, IN r_vd TINYINT(1), IN b_date DATE, IN phone_num VARCHAR(15), IN email VARCHAR(127))
BEGIN
	INSERT INTO person (first_name, last_name, run, run_vd, birth_date, contact_phone_number, contact_email) VALUES (f_name, l_name, r_num, r_vd, b_date, phone_num, email);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function obtain_person_id_by_run
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE FUNCTION obtain_person_id_by_run(run_search INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE person_id INT;
    
    SELECT id INTO person_id FROM person WHERE run = run_search;
    
    RETURN person_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function obtain_visitor_id_by_run
-- -----------------------------------------------------

DELIMITER $$
USE `roentgenium_new_eer`$$
CREATE FUNCTION obtain_visitor_id_by_run(run_search INT) RETURNS INT DETERMINISTIC
BEGIN
	DECLARE original_person_id INT;
    DECLARE visitor_id INT;
    
    SELECT id INTO original_person_id FROM person WHERE run = run_search;
    SELECT id INTO visitor_id FROM visitor WHERE person_id = original_person_id;
    
    RETURN visitor_id;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `roentgenium_new_eer`.`visitors_information`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roentgenium_new_eer`.`visitors_information`;
USE `roentgenium_new_eer`;
CREATE  OR REPLACE VIEW `visitors_information` AS
    SELECT 
        v.id AS visitor_id,
        CONCAT(p.first_name, ' ', p.last_name) AS full_name,
        CONCAT(p.run, '-', p.run_vd) AS run,
        p.birth_date,
        CONCAT(apt.number_identifier, '-', apt.tower_id) AS apartment_visited,
        IF(fv.id IS NOT NULL, 1, 0) AS is_frequent_visitor,
        vl.visit_type AS visit_motive,
        vl.visit_date
    FROM
        visitor v
	LEFT JOIN
		person p ON v.person_id = p.id
	LEFT JOIN
		visitor_log vl ON v.id = vl.visitor_id
	LEFT JOIN
		frequent_visitor fv ON v.id = fv.visitor_id
	LEFT JOIN
		apartment apt ON vl.apartment_id = apt.id
	ORDER BY vl.visit_date DESC;

-- -----------------------------------------------------
-- View `roentgenium_new_eer`.`unclaimed_correspondence`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roentgenium_new_eer`.`unclaimed_correspondence`;
USE `roentgenium_new_eer`;
CREATE  OR REPLACE VIEW `unclaimed_correspondence` AS
    SELECT 
		m.id,
        CONCAT(apt.number_identifier, '-', apt.tower_id) AS recipient,
        m.mail_type,
        m.arrival_time,
        m.is_notified,
        m.is_claimed
    FROM
        mail m
	LEFT JOIN
		apartment apt ON m.apartment_id = apt.id
    WHERE
        m.is_claimed = 0;

-- -----------------------------------------------------
-- View `roentgenium_new_eer`.`currently_parked_vehicles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roentgenium_new_eer`.`currently_parked_vehicles`;
USE `roentgenium_new_eer`;
CREATE  OR REPLACE VIEW `currently_parked_vehicles` AS
    SELECT 
        v.id AS visitor_id,
        CONCAT(p.first_name, ' ', p.last_name) AS full_name,
        vv.license_plate,
        vv.parking_spot AS parked_at,
        vv.parking_date AS parked_since
    FROM
        vehicle_visitors vv
	LEFT JOIN
		visitor v ON v.id = vv.visitor_id
	LEFT JOIN
		person p ON p.id = v.person_id
    WHERE
        vv.parking_spot IS NOT NULL;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;