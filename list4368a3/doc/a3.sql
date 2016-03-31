-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ndt14b
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ndt14b` ;

-- -----------------------------------------------------
-- Schema ndt14b
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ndt14b` DEFAULT CHARACTER SET utf8 ;
USE `ndt14b` ;

-- -----------------------------------------------------
-- Table `ndt14b`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ndt14b`.`customer` ;

CREATE TABLE IF NOT EXISTS `ndt14b`.`customer` (
  `cus_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cus_fname` VARCHAR(15) NOT NULL,
  `cus_lname` VARCHAR(30) NOT NULL,
  `cus_street` VARCHAR(45) NOT NULL,
  `cus_city` VARCHAR(30) NOT NULL,
  `cus_state` CHAR(2) NOT NULL,
  `cus_zip` INT NOT NULL,
  `cus_phone` BIGINT NOT NULL,
  `cus_email` VARCHAR(100) NULL,
  `cus_url` VARCHAR(200) NULL,
  `cus_notes` VARCHAR(255) NULL,
  PRIMARY KEY (`cus_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ndt14b`.`store`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ndt14b`.`store` ;

CREATE TABLE IF NOT EXISTS `ndt14b`.`store` (
  `store_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `store_name` VARCHAR(45) NOT NULL,
  `store_street` VARCHAR(45) NOT NULL,
  `store_city` VARCHAR(30) NOT NULL,
  `store_state` CHAR(2) NOT NULL,
  `store_zip` INT NOT NULL,
  `store_phone` BIGINT NOT NULL,
  `store_email` VARCHAR(100) NULL,
  `store_url` VARCHAR(200) NULL,
  `store_ytd_sales` DECIMAL(8,2) NOT NULL,
  `store_notes` VARCHAR(45) NULL,
  PRIMARY KEY (`store_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ndt14b`.`pet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ndt14b`.`pet` ;

CREATE TABLE IF NOT EXISTS `ndt14b`.`pet` (
  `pet_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `store_id` INT UNSIGNED NOT NULL,
  `cus_id` INT UNSIGNED NULL,
  `pet_type` ENUM('cat', 'dog', 'fish', 'reptile', 'rabbit', 'bird') NOT NULL,
  `pet_sex` ENUM('m', 'f') NOT NULL,
  `pet_cost` DECIMAL(8,2) NOT NULL,
  `pet_price` DECIMAL(8,2) NOT NULL,
  `pet_color` VARCHAR(20) NOT NULL,
  `pet_sale_date` DATE NULL,
  `pet_is_vaccine` TINYINT(1) NOT NULL,
  `pet_is_neutered` TINYINT(1) NOT NULL,
  `pet_note` VARCHAR(255) NULL,
  PRIMARY KEY (`pet_id`, `store_id`),
  INDEX `fk_pet_customer_idx` (`cus_id` ASC),
  INDEX `fk_pet_store1_idx` (`store_id` ASC),
  CONSTRAINT `fk_pet_customer`
    FOREIGN KEY (`cus_id`)
    REFERENCES `ndt14b`.`customer` (`cus_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `ndt14b`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ndt14b`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ndt14b`.`member` ;

CREATE TABLE IF NOT EXISTS `ndt14b`.`member` (
  `mem_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `mem_fname` VARCHAR(15) NOT NULL,
  `mem_lname` VARCHAR(30) NOT NULL,
  `mem_street` VARCHAR(30) NOT NULL,
  `mem_city` VARCHAR(20) NOT NULL,
  `mem_state` CHAR(2) NOT NULL,
  `mem_zip` INT NOT NULL,
  `mem_phone` BIGINT UNSIGNED NOT NULL,
  `mem_email` VARCHAR(45) NULL,
  `mem_url` VARCHAR(45) NULL,
  `mem_notes` VARCHAR(255) NULL,
  PRIMARY KEY (`mem_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ndt14b`.`publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ndt14b`.`publisher` ;

CREATE TABLE IF NOT EXISTS `ndt14b`.`publisher` (
  `pub_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pub_fname` VARCHAR(15) NOT NULL,
  `pub_lname` VARCHAR(30) NOT NULL,
  `pub_street` VARCHAR(30) NOT NULL,
  `pub_city` VARCHAR(20) NOT NULL,
  `pub_state` CHAR(2) NOT NULL,
  `pub_zip` INT UNSIGNED NOT NULL,
  `pub_phone` BIGINT UNSIGNED NOT NULL,
  `pub_email` VARCHAR(45) NULL,
  `pub_url` VARCHAR(45) NULL,
  `pub_notes` VARCHAR(255) NULL,
  PRIMARY KEY (`pub_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ndt14b`.`book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ndt14b`.`book` ;

CREATE TABLE IF NOT EXISTS `ndt14b`.`book` (
  `bok_isbn` VARCHAR(13) NOT NULL,
  `pub_id` SMALLINT UNSIGNED NOT NULL,
  `bok_title` VARCHAR(100) NOT NULL,
  `bok_pub_date` DATE NOT NULL,
  `bok_num_pages` INT NOT NULL,
  `bok_cost` DECIMAL(5,2) NOT NULL,
  `bok_price` VARCHAR(45) NOT NULL,
  `bok_notes` VARCHAR(255) NULL,
  PRIMARY KEY (`bok_isbn`, `pub_id`),
  INDEX `fk_book_publisher1_idx` (`pub_id` ASC),
  CONSTRAINT `fk_book_publisher1`
    FOREIGN KEY (`pub_id`)
    REFERENCES `ndt14b`.`publisher` (`pub_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ndt14b`.`loaner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ndt14b`.`loaner` ;

CREATE TABLE IF NOT EXISTS `ndt14b`.`loaner` (
  `loan_id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `mem_id` SMALLINT UNSIGNED NOT NULL,
  `bok_isbn` VARCHAR(13) NOT NULL,
  `lon_loan_date` DATE NULL,
  `lon_due_date` DATE NULL,
  `long_return_date` DATE NULL,
  `lon_late_fee` DECIMAL(5,2) UNSIGNED NULL,
  `lon_notes` VARCHAR(255) NULL,
  PRIMARY KEY (`loan_id`, `mem_id`, `bok_isbn`),
  INDEX `fk_loaner_member1_idx` (`mem_id` ASC),
  INDEX `fk_loaner_book1_idx` (`bok_isbn` ASC),
  CONSTRAINT `fk_loaner_member1`
    FOREIGN KEY (`mem_id`)
    REFERENCES `ndt14b`.`member` (`mem_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_loaner_book1`
    FOREIGN KEY (`bok_isbn`)
    REFERENCES `ndt14b`.`book` (`bok_isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ndt14b`.`author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ndt14b`.`author` ;

CREATE TABLE IF NOT EXISTS `ndt14b`.`author` (
  `auth_id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `auth_fname` VARCHAR(30) NOT NULL,
  `auth_lname` VARCHAR(30) NOT NULL,
  `auth_street` VARCHAR(30) NOT NULL,
  `auth_city` VARCHAR(20) NOT NULL,
  `auth_state` CHAR(2) NOT NULL,
  `auth_zip` INT UNSIGNED NOT NULL,
  `auth_phone` VARCHAR(45) NOT NULL,
  `auth_email` VARCHAR(45) NULL,
  `auth_url` VARCHAR(45) NULL,
  `auth_notes` VARCHAR(255) NULL,
  PRIMARY KEY (`auth_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ndt14b`.`attribution`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ndt14b`.`attribution` ;

CREATE TABLE IF NOT EXISTS `ndt14b`.`attribution` (
  `attr_id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `bok_isbn` VARCHAR(13) NOT NULL,
  `auth_id` MEDIUMINT UNSIGNED NOT NULL,
  `attr_notes` VARCHAR(255) NULL,
  PRIMARY KEY (`attr_id`, `auth_id`),
  INDEX `fk_attribution_author1_idx` (`auth_id` ASC),
  INDEX `fk_attribution_book1_idx` (`bok_isbn` ASC),
  CONSTRAINT `fk_attribution_author1`
    FOREIGN KEY (`auth_id`)
    REFERENCES `ndt14b`.`author` (`auth_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_attribution_book1`
    FOREIGN KEY (`bok_isbn`)
    REFERENCES `ndt14b`.`book` (`bok_isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ndt14b`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ndt14b`.`category` ;

CREATE TABLE IF NOT EXISTS `ndt14b`.`category` (
  `cat_id` SMALLINT NOT NULL,
  `cat_type` VARCHAR(45) NOT NULL,
  `cat_notes` VARCHAR(45) NULL,
  PRIMARY KEY (`cat_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ndt14b`.`book_cat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ndt14b`.`book_cat` ;

CREATE TABLE IF NOT EXISTS `ndt14b`.`book_cat` (
  `bok_cat_id` INT NOT NULL,
  `bok_isbn` VARCHAR(13) NOT NULL,
  `cat_id` SMALLINT NOT NULL,
  PRIMARY KEY (`bok_cat_id`, `cat_id`),
  INDEX `fk_book_cat_category1_idx` (`cat_id` ASC),
  INDEX `fk_book_cat_book1_idx` (`bok_isbn` ASC),
  CONSTRAINT `fk_book_cat_category1`
    FOREIGN KEY (`cat_id`)
    REFERENCES `ndt14b`.`category` (`cat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_cat_book1`
    FOREIGN KEY (`bok_isbn`)
    REFERENCES `ndt14b`.`book` (`bok_isbn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ndt14b`.`customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `ndt14b`;
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (1, 'Sarah', 'Snow', 'P.O. Box 500, 8067 Odio. St.', 'Hartford', 'CT', 1562, 4884199716, 'ornare.lectus@feugiatnonlobortis.edu', NULL, 'semper et, lacinia');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (2, 'Kieran', 'Becker', '416-3987 Mauris Rd.', 'Annapolis', 'MD', 7316, 9873477812, 'aliquam@mus.net', NULL, 'luctus lobortis. Class aptent taciti sociosqu');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (3, 'Scarlett', 'Patrick', '9296 At Avenue', 'Bangor', 'ME', 8043, 8777881572, 'quis.urna.Nunc@sodalesnisimagna.net', NULL, 'aptent taciti sociosqu ad litora torquent per conubia nostra, per');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (4, 'Patrick', 'Rosario', '604-1810 A, Rd.', 'Harrisburg', 'PA', 6818, 1268285583, 'ultricies.adipiscing@felispurusac.net', NULL, 'enim nec tempus scelerisque, lorem ipsum');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (5, 'Jorden', 'Bullock', 'P.O. Box 855, 6202 Nulla. Avenue', 'Kearney', 'NE', 5394, 1397548515, 'eu.accumsan.sed@sitametornare.co.uk', NULL, 'blandit enim consequat');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (6, 'Jolene', 'Kim', '2743 Et, Rd.', 'Kailua', 'HI', 8504, 1814274335, 'purus.sapien@Phasellusfermentumconvallis.org', NULL, 'a tortor.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (7, 'Armand', 'Wolf', 'Ap #660-4053 Consequat, Rd.', 'Worcester', 'MA', 3458, 6479612396, 'orci.Ut@lectuspedeet.net', NULL, 'ullamcorper, velit in aliquet lobortis, nisi nibh lacinia orci,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (8, 'Emerson', 'Little', '1169 Sagittis Road', 'Springfield', 'MA', 7515, 5292329485, 'mollis.Integer@egestaslacinia.net', NULL, 'ipsum. Curabitur consequat, lectus sit amet');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (9, 'Emmanuel', 'Maldonado', 'P.O. Box 133, 628 Augue Ave', 'Carson City', 'NV', 8540, 2680716592, 'nunc@vestibulum.ca', NULL, 'lacus pede sagittis augue, eu tempor erat');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (10, 'Jesse', 'Steele', '343-5575 Nunc Rd.', 'Cambridge', 'MA', 5624, 4185868523, 'Donec@auctornon.net', NULL, 'nisl arcu iaculis');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (11, 'David', 'Frost', 'P.O. Box 738, 4169 Nisl St.', 'Salt Lake City', 'UT', 6025, 5620997308, 'sociosqu@Proin.net', NULL, 'ac, feugiat non, lobortis');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (12, 'Tucker', 'Hall', 'Ap #869-9661 Enim Rd.', 'Fort Smith', 'AR', 8957, 8753651403, 'eu.erat.semper@Proinultrices.org', NULL, 'sem ut cursus luctus,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (13, 'Hedwig', 'Parsons', 'P.O. Box 825, 6896 Sem, Avenue', 'Kansas City', 'MO', 8953, 1102539413, 'semper@fringillaornareplacerat.edu', NULL, 'Curabitur vel lectus. Cum sociis natoque penatibus');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (14, 'Wynter', 'Franklin', 'P.O. Box 536, 8522 Aenean Street', 'Springfield', 'MA', 2017, 9659703088, 'nibh@elementum.co.uk', NULL, 'metus. In nec orci. Donec nibh. Quisque nonummy ipsum non');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (15, 'Kenyon', 'Moss', '462 Vitae Rd.', 'Phoenix', 'AZ', 3998, 4536618555, 'cubilia.Curae.Donec@metusInlorem.co.uk', NULL, 'semper erat, in');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (16, 'Kareem', 'Ingram', '926 Consectetuer Street', 'Newark', 'DE', 2606, 6886481796, 'at.nisi@sit.com', NULL, 'eu nulla at sem molestie sodales.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (17, 'Seth', 'Riley', '5218 Phasellus Ave', 'Bear', 'DE', 4186, 3013567283, 'pede.Suspendisse.dui@lacinia.edu', NULL, 'aliquet vel, vulputate eu,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (18, 'Rebecca', 'Obrien', '649-4777 Phasellus Avenue', 'Grand Island', 'NE', 3282, 2782061543, 'adipiscing@nequeInornare.net', NULL, 'eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (19, 'Tanek', 'Pena', 'Ap #747-4746 Vitae Road', 'Annapolis', 'MD', 2887, 6430836949, 'vulputate.eu.odio@semelitpharetra.co.uk', NULL, 'quis');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (20, 'Bree', 'Valentine', 'P.O. Box 812, 9736 Consequat Road', 'Annapolis', 'MD', 4434, 4918170532, 'parturient@malesuadaid.ca', NULL, 'enim. Nunc ut erat. Sed nunc est, mollis non,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (21, 'Rana', 'Holt', '628-9288 Praesent Avenue', 'Lincoln', 'NE', 5226, 3405301375, 'ac.urna.Ut@nec.net', NULL, 'dolor sit amet, consectetuer adipiscing elit. Aliquam auctor,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (22, 'Halla', 'Lyons', '6739 Cras Ave', 'Portland', 'ME', 8796, 9899384393, 'lectus@nulla.edu', NULL, 'nec, eleifend non, dapibus rutrum, justo. Praesent');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (23, 'Dara', 'Cunningham', 'Ap #946-4891 Vitae Rd.', 'Lewiston', 'ME', 5843, 2933548990, 'montes.nascetur@nonummy.com', NULL, 'semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (24, 'Kermit', 'Morton', 'P.O. Box 508, 9861 Sem Rd.', 'Lexington', 'KY', 8224, 9150170049, 'eu.tellus@egestas.net', NULL, 'sem semper erat, in');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (25, 'Benedict', 'Casey', '179-8133 Eros Street', 'Colchester', 'VT', 1419, 0715486718, 'consequat@Cras.org', NULL, 'nibh. Phasellus nulla. Integer vulputate,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (26, 'Yardley', 'Cooley', 'P.O. Box 487, 8552 Proin Ave', 'Kailua', 'HI', 6137, 0697362897, 'nec@orcilobortis.edu', NULL, 'sollicitudin adipiscing ligula. Aenean gravida nunc sed pede. Cum');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (27, 'Holmes', 'Thomas', 'Ap #719-5825 Phasellus St.', 'Owensboro', 'KY', 7992, 4926683459, 'elit.pede.malesuada@interdumSedauctor.com', NULL, 'massa. Suspendisse eleifend. Cras sed leo.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (28, 'Ursula', 'Evans', 'Ap #340-1075 Et Rd.', 'Birmingham', 'AL', 7506, 1696383994, 'orci.adipiscing.non@adipiscinglacus.net', NULL, 'viverra. Donec tempus, lorem fringilla ornare placerat, orci');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (29, 'Carla', 'Ratliff', 'P.O. Box 403, 8977 Consectetuer Rd.', 'Worcester', 'MA', 6555, 4517567975, 'risus.a.ultricies@ipsumdolor.org', NULL, 'ligula tortor, dictum eu,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (30, 'Griffin', 'Knight', 'P.O. Box 543, 3567 Dui Avenue', 'Carson City', 'NV', 6204, 2172358366, 'et.rutrum.eu@lacus.co.uk', NULL, 'luctus sit amet, faucibus ut, nulla. Cras eu');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (31, 'Quynn', 'Holman', '110-2327 Id, Road', 'Philadelphia', 'PA', 8740, 3724340322, 'nonummy.ultricies@velitjusto.co.uk', NULL, 'Nam ac nulla. In tincidunt congue turpis. In');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (32, 'Hayfa', 'Nicholson', 'P.O. Box 961, 1603 Lectus, Avenue', 'Mesa', 'AZ', 2447, 1124230176, 'tincidunt.adipiscing@dignissimMaecenas.com', NULL, 'dis parturient montes, nascetur ridiculus mus. Donec dignissim magna');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (33, 'Ayanna', 'Rowland', 'Ap #945-6361 Donec St.', 'Lowell', 'MA', 1632, 2794982785, 'arcu.Vestibulum.ut@nectempusmauris.org', NULL, 'hendrerit. Donec porttitor tellus non magna. Nam ligula elit, pretium');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (34, 'Carson', 'Castro', '913-7847 Ornare Street', 'Aurora', 'CO', 2304, 8642116011, 'erat.Vivamus.nisi@Suspendisseseddolor.net', NULL, 'et pede. Nunc sed orci lobortis augue');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (35, 'Bianca', 'Castaneda', 'Ap #251-2099 Amet Rd.', 'Milwaukee', 'WI', 1950, 4597692179, 'enim@at.edu', NULL, 'posuere at, velit.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (36, 'Paloma', 'Salazar', '9637 Nisi. Ave', 'Olathe', 'KS', 5610, 5461157274, 'Integer.sem.elit@odio.co.uk', NULL, 'est. Mauris eu turpis. Nulla aliquet.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (37, 'Lynn', 'Hutchinson', '140-5059 Sit Avenue', 'Helena', 'MT', 1456, 1197893213, 'Cras@semNulla.co.uk', NULL, 'libero et tristique pellentesque, tellus sem mollis');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (38, 'Gloria', 'Cortez', '695-6997 Mus. Street', 'Hillsboro', 'OR', 4957, 5639009244, 'sed.pede.Cum@blanditviverra.net', NULL, 'eu odio tristique pharetra. Quisque');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (39, 'Wade', 'Duran', 'Ap #853-9906 Enim Road', 'Sacramento', 'CA', 6668, 1071580496, 'enim.condimentum@tellusAeneanegestas.ca', NULL, 'mauris a nunc. In at pede. Cras vulputate');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (40, 'Jamalia', 'Wagner', '471-9545 Habitant Rd.', 'Newark', 'DE', 6421, 8519929209, 'id.mollis.nec@diameu.org', NULL, 'ullamcorper, velit in aliquet lobortis, nisi nibh lacinia');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (41, 'Mona', 'Hayes', 'Ap #492-5975 Erat. Street', 'Memphis', 'TN', 7254, 7330469863, 'mi.tempor@idantedictum.ca', NULL, 'Nullam');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (42, 'Chanda', 'Mejia', 'Ap #217-6478 Dolor Street', 'Bridgeport', 'CT', 3069, 5929199488, 'turpis@montesnasceturridiculus.net', NULL, 'nunc risus varius orci, in consequat enim');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (43, 'Tana', 'Mccullough', 'Ap #772-3531 Lorem Street', 'San Francisco', 'CA', 5753, 2958115706, 'Nullam.nisl@tellusPhasellus.net', NULL, 'id');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (44, 'Heather', 'Decker', '8762 Amet Avenue', 'Huntsville', 'AL', 2925, 4006960792, 'Aliquam.nec@suscipit.org', NULL, 'dui lectus rutrum urna,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (45, 'Zephania', 'Schmidt', 'P.O. Box 167, 7203 Pellentesque Rd.', 'Portland', 'OR', 7636, 2593543044, 'et@semperauctor.ca', NULL, 'commodo hendrerit. Donec porttitor tellus non magna.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (46, 'Bradley', 'Ellis', 'Ap #198-9784 Sit St.', 'Jonesboro', 'AR', 5222, 6405218415, 'Integer.sem@Intincidunt.co.uk', NULL, 'Suspendisse sagittis.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (47, 'Palmer', 'Hubbard', '9733 Eros. Road', 'Bridgeport', 'CT', 4782, 8594179484, 'egestas.a.scelerisque@semconsequat.net', NULL, 'sed libero. Proin sed turpis');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (48, 'Germaine', 'Cooley', 'Ap #564-3083 Egestas. Road', 'Stamford', 'CT', 6599, 2241955110, 'elementum.at.egestas@massarutrummagna.ca', NULL, 'ac mattis semper, dui');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (49, 'Mercedes', 'Calhoun', 'P.O. Box 461, 1037 Phasellus Street', 'Detroit', 'MI', 2284, 2536715268, 'Proin@consectetueradipiscingelit.org', NULL, 'enim consequat purus. Maecenas libero est, congue a, aliquet');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (50, 'Christen', 'Lindsey', 'Ap #386-4436 Habitant Road', 'Essex', 'VT', 5947, 5726687798, 'mollis.non@lacinia.org', NULL, 'In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (51, 'Clinton', 'Foster', '1475 Libero. St.', 'Orlando', 'FL', 5859, 4776774193, 'mollis.nec@egestas.org', NULL, 'rutrum magna. Cras convallis convallis dolor. Quisque tincidunt');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (52, 'Russell', 'Mathis', '871-676 Leo Ave', 'Seattle', 'WA', 7946, 4744824101, 'diam.vel.arcu@ipsumnon.edu', NULL, 'eleifend. Cras sed');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (53, 'Violet', 'Orr', 'P.O. Box 276, 6388 Egestas St.', 'Clarksville', 'TN', 7149, 9024723814, 'sodales@libero.edu', NULL, 'aliquet lobortis, nisi nibh lacinia orci, consectetuer');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (54, 'Nicole', 'Castaneda', 'P.O. Box 238, 6396 At Road', 'Fort Worth', 'TX', 3446, 2256556036, 'Quisque@ultricessit.org', NULL, 'sit amet');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (55, 'Brynne', 'Baird', '556-4421 Vitae Av.', 'Savannah', 'GA', 6833, 6690982616, 'natoque.penatibus.et@bibendumullamcorper.co.uk', NULL, 'Ut semper');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (56, 'Nash', 'Madden', '823-4591 In Rd.', 'Green Bay', 'WI', 2193, 3665285253, 'senectus.et.netus@iaculislacuspede.edu', NULL, 'ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (57, 'Richard', 'Waller', '107-8319 Ut Avenue', 'Fort Wayne', 'IN', 2259, 9636321225, 'interdum.ligula@eliteratvitae.com', NULL, 'Nunc lectus');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (58, 'Forrest', 'Miranda', 'Ap #277-3172 Posuere St.', 'Meridian', 'ID', 8101, 2025141477, 'risus.Donec.egestas@velit.com', NULL, 'risus. Duis a mi fringilla mi lacinia mattis.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (59, 'Lucas', 'Gallagher', '971-4357 Curabitur Rd.', 'Racine', 'WI', 3628, 5917854989, 'in@sedfacilisisvitae.com', NULL, 'metus');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (60, 'Nerea', 'Howe', '771-8665 Ultrices. Av.', 'Gillette', 'WY', 5566, 1764532426, 'senectus.et.netus@Morbi.org', NULL, 'Nunc lectus pede,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (61, 'Lars', 'Ward', '4417 Sem, Rd.', 'Jacksonville', 'FL', 3504, 7741783845, 'tristique.pellentesque.tellus@diam.ca', NULL, 'lorem,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (62, 'Kathleen', 'Walker', '737-9065 Malesuada Av.', 'Virginia Beach', 'VA', 8237, 1656491760, 'vitae.dolor.Donec@parturient.net', NULL, 'ac turpis egestas. Fusce aliquet magna a neque. Nullam ut');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (63, 'Raven', 'Gonzalez', '8670 Cursus Ave', 'Grand Rapids', 'MI', 3306, 1873697661, 'sed@placeratCrasdictum.co.uk', NULL, 'gravida nunc sed pede. Cum sociis natoque penatibus et');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (64, 'Pamela', 'Gonzalez', 'Ap #545-9853 Nec, Ave', 'West Valley City', 'UT', 1470, 3841620203, 'Donec@maurisaliquameu.org', NULL, 'congue turpis. In');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (65, 'Joseph', 'Oneill', 'Ap #813-9592 Quam. Rd.', 'Waterbury', 'CT', 7806, 6114698645, 'enim@eros.co.uk', NULL, 'felis.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (66, 'Brody', 'Fuentes', '5884 Imperdiet Av.', 'Augusta', 'ME', 1007, 5319627156, 'cursus.et@odio.net', NULL, 'magna. Nam ligula elit, pretium');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (67, 'Harrison', 'Boyd', 'P.O. Box 511, 3074 Ut, Ave', 'Jackson', 'MS', 5611, 6226439309, 'odio.Nam.interdum@arcu.com', NULL, 'magna. Nam ligula elit, pretium et, rutrum non, hendrerit');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (68, 'Darryl', 'Page', 'P.O. Box 716, 8533 Commodo Avenue', 'Rock Springs', 'WY', 3011, 1876813501, 'faucibus.id.libero@orci.edu', NULL, 'orci. Phasellus dapibus quam quis diam.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (69, 'Aspen', 'Kirby', 'P.O. Box 784, 5573 Vestibulum Rd.', 'New Haven', 'CT', 5980, 2513214530, 'nulla.Integer.vulputate@Infaucibus.co.uk', NULL, 'tristique pellentesque,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (70, 'Sage', 'Holmes', '7022 In, St.', 'Dallas', 'TX', 5337, 7510093867, 'ultricies.sem.magna@sitametluctus.co.uk', NULL, 'semper rutrum. Fusce dolor quam, elementum at, egestas a, scelerisque');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (71, 'Ethan', 'Hobbs', '6315 Libero St.', 'Baltimore', 'MD', 5878, 5830268259, 'quam.vel@lectusquismassa.net', NULL, 'facilisis non, bibendum sed, est. Nunc');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (72, 'Allegra', 'Best', '5661 Aliquam St.', 'Cheyenne', 'WY', 8628, 5016669713, 'vulputate.lacus.Cras@Phasellus.net', NULL, 'dolor. Fusce mi lorem, vehicula et, rutrum eu, ultrices sit');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (73, 'Nora', 'Richmond', 'P.O. Box 189, 4739 Scelerisque, Rd.', 'Augusta', 'ME', 6292, 3237050085, 'ligula.Aenean.gravida@ut.net', NULL, 'semper pretium neque. Morbi quis urna. Nunc');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (74, 'Germane', 'Wallace', 'Ap #316-3698 Orci Rd.', 'Lafayette', 'LA', 4121, 6653403495, 'non@etnunc.ca', NULL, 'lectus quis massa. Mauris vestibulum, neque sed dictum eleifend,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (75, 'Aubrey', 'Talley', '694-626 Morbi Street', 'Eugene', 'OR', 5524, 4771875932, 'libero@Duis.com', NULL, 'vitae velit egestas lacinia. Sed congue, elit sed consequat auctor,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (76, 'Kitra', 'Zimmerman', '2431 Mauris Road', 'Tuscaloosa', 'AL', 1912, 1871254412, 'fermentum@Maecenasmifelis.org', NULL, 'arcu. Curabitur ut odio vel est tempor');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (77, 'Darrel', 'Roth', 'P.O. Box 761, 480 Metus Ave', 'Montpelier', 'VT', 1432, 5474312157, 'est.Mauris@Inatpede.com', NULL, 'Nunc ut erat. Sed nunc');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (78, 'Dieter', 'Ferrell', 'Ap #921-7775 Quis, St.', 'Hattiesburg', 'MS', 2538, 0981624838, 'ac.nulla@dui.com', NULL, 'enim consequat purus. Maecenas libero est, congue a, aliquet vel,');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (79, 'Cameran', 'Stephens', 'Ap #819-8275 Suspendisse Rd.', 'Broken Arrow', 'OK', 5558, 7389693111, 'ipsum.ac@elitdictum.ca', NULL, 'a purus. Duis elementum, dui');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (80, 'Scarlett', 'Lucas', 'P.O. Box 577, 8962 Id Road', 'Bridgeport', 'CT', 1911, 2211103613, 'neque@estMauriseu.co.uk', NULL, 'posuere cubilia Curae; Donec');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (81, 'Rachel', 'Contreras', 'P.O. Box 306, 6156 Nunc Avenue', 'Philadelphia', 'PA', 5329, 2802070166, 'libero@Morbinequetellus.ca', NULL, 'odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (82, 'Flynn', 'Sanford', 'P.O. Box 905, 5354 Odio Ave', 'Vancouver', 'WA', 1266, 2237664627, 'faucibus.orci@sagittis.co.uk', NULL, 'Duis');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (83, 'Jescie', 'Dunlap', 'Ap #139-2310 Rhoncus. Rd.', 'Bowling Green', 'KY', 5341, 1038132475, 'Fusce@sollicitudinorci.ca', NULL, 'ullamcorper eu, euismod ac, fermentum vel, mauris.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (84, 'Carol', 'Quinn', 'Ap #130-5863 Vel St.', 'San Francisco', 'CA', 7277, 3981523757, 'interdum.enim.non@ullamcorper.edu', NULL, 'eu eros. Nam consequat dolor vitae dolor. Donec');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (85, 'Cheyenne', 'Hutchinson', 'Ap #577-1227 Erat St.', 'Boise', 'ID', 7564, 2533475676, 'Morbi.neque@eratnonummy.org', NULL, 'aliquet, sem');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (86, 'Mufutau', 'Rivera', '4225 Maecenas Street', 'Salt Lake City', 'UT', 2865, 8917887034, 'dignissim@magna.com', NULL, 'velit. Cras lorem');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (87, 'Thane', 'Cameron', 'P.O. Box 390, 9856 Augue St.', 'Juneau', 'AK', 3134, 4484842515, 'Nam.ligula@Uttincidunt.ca', NULL, 'Maecenas ornare egestas ligula. Nullam feugiat placerat velit.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (88, 'Martena', 'Reid', '6711 Tristique St.', 'Lewiston', 'ME', 5955, 5135992703, 'sollicitudin@diamlorem.org', NULL, 'dictum placerat, augue. Sed molestie. Sed id');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (89, 'Kennan', 'Wiley', '1496 Mauris. St.', 'Bozeman', 'MT', 4370, 4358058804, 'ac@nec.ca', NULL, 'sed pede nec ante blandit viverra. Donec tempus, lorem');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (90, 'Orli', 'Robinson', 'Ap #135-2375 Erat, St.', 'Orlando', 'FL', 7221, 9580236166, 'ad@massa.com', NULL, 'Donec elementum, lorem ut aliquam');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (91, 'Riley', 'Heath', '3676 At, Ave', 'Los Angeles', 'CA', 5616, 7363292958, 'quam.elementum.at@gravida.org', NULL, 'orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam ornare, libero');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (92, 'Perry', 'Delacruz', 'P.O. Box 150, 682 Lobortis Street', 'Columbus', 'OH', 1064, 7545204573, 'luctus.ut.pellentesque@et.com', NULL, 'turpis nec mauris blandit mattis. Cras');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (93, 'Kristen', 'Rosario', '912-5141 Aliquam Avenue', 'Cedar Rapids', 'IA', 6451, 7861408161, 'imperdiet.ornare@Classaptenttaciti.net', NULL, 'torquent per conubia');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (94, 'Alfonso', 'Rios', '586-7396 Donec Street', 'Columbia', 'MD', 2423, 1550008942, 'id.nunc@loremeu.net', NULL, 'Sed et');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (95, 'Susan', 'Medina', '829-8982 Urna Avenue', 'Omaha', 'NE', 3178, 7158091125, 'luctus.vulputate@odioAliquam.ca', NULL, 'et, eros. Proin ultrices.');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (96, 'Fredericka', 'Fox', '328-4532 Mauris Av.', 'Wyoming', 'WY', 6519, 6914907743, 'diam.luctus@placerategetvenenatis.net', NULL, 'tempor');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (97, 'Kato', 'Pierce', 'P.O. Box 425, 4984 Tincidunt Rd.', 'Norfolk', 'VA', 2732, 8040223305, 'Integer.id@acmieleifend.net', NULL, 'ut eros');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (98, 'Sybil', 'Carson', '225-4396 Nulla Road', 'Louisville', 'KY', 1032, 9297561342, 'velit.in@vitaesodales.co.uk', NULL, 'tellus id nunc interdum');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (99, 'Dolan', 'Best', 'Ap #468-7035 Vitae Ave', 'Spokane', 'WA', 1576, 5013755752, 'sem@ligulatortor.net', NULL, 'aliquam eros turpis non enim. Mauris quis turpis');
INSERT INTO `ndt14b`.`customer` (`cus_id`, `cus_fname`, `cus_lname`, `cus_street`, `cus_city`, `cus_state`, `cus_zip`, `cus_phone`, `cus_email`, `cus_url`, `cus_notes`) VALUES (100, 'Katelyn', 'Holcomb', 'Ap #199-6430 Lacus. Avenue', 'Honolulu', 'HI', 2662, 7182572178, 'erat.nonummy.ultricies@aliquamarcuAliquam.ca', NULL, 'fames ac turpis egestas.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ndt14b`.`store`
-- -----------------------------------------------------
START TRANSACTION;
USE `ndt14b`;
INSERT INTO `ndt14b`.`store` (`store_id`, `store_name`, `store_street`, `store_city`, `store_state`, `store_zip`, `store_phone`, `store_email`, `store_url`, `store_ytd_sales`, `store_notes`) VALUES (1, 'petco', '1822 Colonial Drive', 'Coral Springs ', 'FL', 33071, 9548027893, 'petco.csprings@gmail.com', 'http://petco_csprings.com', 500050.50, NULL);
INSERT INTO `ndt14b`.`store` (`store_id`, `store_name`, `store_street`, `store_city`, `store_state`, `store_zip`, `store_phone`, `store_email`, `store_url`, `store_ytd_sales`, `store_notes`) VALUES (2, 'petco', '2780 Royal Azalea', 'Springfield', 'VA', 23456, 7032292222, 'petco.springfield@gmail.com', 'http://petco_springfield.com', 1000000.80, NULL);
INSERT INTO `ndt14b`.`store` (`store_id`, `store_name`, `store_street`, `store_city`, `store_state`, `store_zip`, `store_phone`, `store_email`, `store_url`, `store_ytd_sales`, `store_notes`) VALUES (3, 'petco', '2550 Peachleaf Place', 'Fairfax', 'VA', 64125, 7035559999, 'petco.peachleaf@gmail.com', 'http://petco_peachleaf.com', 880000.50, NULL);
INSERT INTO `ndt14b`.`store` (`store_id`, `store_name`, `store_street`, `store_city`, `store_state`, `store_zip`, `store_phone`, `store_email`, `store_url`, `store_ytd_sales`, `store_notes`) VALUES (4, 'dogs and cats', '600 Dixie Drive', 'Tallahassee', 'FL', 32304, 9548180579, 'dogsandcats@gmail.com', 'http://dogsandcats_dixiedr.com', 999000.99, NULL);
INSERT INTO `ndt14b`.`store` (`store_id`, `store_name`, `store_street`, `store_city`, `store_state`, `store_zip`, `store_phone`, `store_email`, `store_url`, `store_ytd_sales`, `store_notes`) VALUES (5, 'animals co', '1200 South Beach', 'Miami', 'FL', 10295, 3056789000, 'animalsco@gmail.com', 'http://animalco.com', 15005555.50, NULL);
INSERT INTO `ndt14b`.`store` (`store_id`, `store_name`, `store_street`, `store_city`, `store_state`, `store_zip`, `store_phone`, `store_email`, `store_url`, `store_ytd_sales`, `store_notes`) VALUES (6, 'animal life', '1111 Pensacola Street', 'Tallahassee', 'FL', 32305, 8032245678, 'animals@gmail.com', 'http://animalife.com', 1200000.50, NULL);
INSERT INTO `ndt14b`.`store` (`store_id`, `store_name`, `store_street`, `store_city`, `store_state`, `store_zip`, `store_phone`, `store_email`, `store_url`, `store_ytd_sales`, `store_notes`) VALUES (7, 'pet market', '1111 Coconut Creek', 'Broward', 'FL', 56702, 7545446777, 'petmarket@gmail.com', 'http://petmarket.com', 450000.55, NULL);
INSERT INTO `ndt14b`.`store` (`store_id`, `store_name`, `store_street`, `store_city`, `store_state`, `store_zip`, `store_phone`, `store_email`, `store_url`, `store_ytd_sales`, `store_notes`) VALUES (8, 'paws and dogs', '6000 Cowboy', 'Austin', 'TX', 89032, 3902149809, 'pawsanddogs@gmail.com', 'http://pawsanddogs.com', 1300.55, NULL);
INSERT INTO `ndt14b`.`store` (`store_id`, `store_name`, `store_street`, `store_city`, `store_state`, `store_zip`, `store_phone`, `store_email`, `store_url`, `store_ytd_sales`, `store_notes`) VALUES (9, 'cats and claws', '7000 Fire', 'Phoeniz', 'AZ', 34560, 4126470983, 'catsandclaws@gmail.com', 'http://catsandclaws.com', 899999.60, NULL);
INSERT INTO `ndt14b`.`store` (`store_id`, `store_name`, `store_street`, `store_city`, `store_state`, `store_zip`, `store_phone`, `store_email`, `store_url`, `store_ytd_sales`, `store_notes`) VALUES (10, 'sea life', '7000 Riverside', 'Archer', 'MA', 99870, 2496302834, 'sealife@gmail.com', 'http://sealife.com', 102783.99, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ndt14b`.`pet`
-- -----------------------------------------------------
START TRANSACTION;
USE `ndt14b`;
INSERT INTO `ndt14b`.`pet` (`pet_id`, `store_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_color`, `pet_sale_date`, `pet_is_vaccine`, `pet_is_neutered`, `pet_note`) VALUES (1, 1, 1, 'dog', 'm', 1000.50, 2001.00, 'brown', '2000-12-01', true, true, NULL);
INSERT INTO `ndt14b`.`pet` (`pet_id`, `store_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_color`, `pet_sale_date`, `pet_is_vaccine`, `pet_is_neutered`, `pet_note`) VALUES (2, 1, 2, 'cat', 'm', 200.50, 401.00, 'orange', '2000-12-05', true, true, NULL);
INSERT INTO `ndt14b`.`pet` (`pet_id`, `store_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_color`, `pet_sale_date`, `pet_is_vaccine`, `pet_is_neutered`, `pet_note`) VALUES (3, 2, 3, 'fish', 'm', 10.50, 21.00, 'orange', '2005-03-04', true, false, NULL);
INSERT INTO `ndt14b`.`pet` (`pet_id`, `store_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_color`, `pet_sale_date`, `pet_is_vaccine`, `pet_is_neutered`, `pet_note`) VALUES (4, 2, 4, 'reptile', 'm', 11.00, 22.00, 'green', '2006-04-04', false, false, NULL);
INSERT INTO `ndt14b`.`pet` (`pet_id`, `store_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_color`, `pet_sale_date`, `pet_is_vaccine`, `pet_is_neutered`, `pet_note`) VALUES (5, 3, 5, 'rabbit', 'f', 30.00, 60.00, 'white', '2008-09-09', false, false, NULL);
INSERT INTO `ndt14b`.`pet` (`pet_id`, `store_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_color`, `pet_sale_date`, `pet_is_vaccine`, `pet_is_neutered`, `pet_note`) VALUES (6, 3, NULL, 'dog', 'f', 500.50, 1005.00, 'black', NULL, true, true, NULL);
INSERT INTO `ndt14b`.`pet` (`pet_id`, `store_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_color`, `pet_sale_date`, `pet_is_vaccine`, `pet_is_neutered`, `pet_note`) VALUES (7, 4, NULL, 'dog', 'f', 1000.50, 2000.00, 'black', NULL, true, false, NULL);
INSERT INTO `ndt14b`.`pet` (`pet_id`, `store_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_color`, `pet_sale_date`, `pet_is_vaccine`, `pet_is_neutered`, `pet_note`) VALUES (8, 4, NULL, 'dog', 'f', 1200.50, 1400.50, 'black', NULL, true, false, NULL);
INSERT INTO `ndt14b`.`pet` (`pet_id`, `store_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_color`, `pet_sale_date`, `pet_is_vaccine`, `pet_is_neutered`, `pet_note`) VALUES (9, 5, NULL, 'cat', 'm', 100.99, 205.50, 'white', NULL, true, false, NULL);
INSERT INTO `ndt14b`.`pet` (`pet_id`, `store_id`, `cus_id`, `pet_type`, `pet_sex`, `pet_cost`, `pet_price`, `pet_color`, `pet_sale_date`, `pet_is_vaccine`, `pet_is_neutered`, `pet_note`) VALUES (10, 5, NULL, 'cat', 'm', 80.99, 150.00, 'gray', NULL, true, false, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ndt14b`.`member`
-- -----------------------------------------------------
START TRANSACTION;
USE `ndt14b`;
INSERT INTO `ndt14b`.`member` (`mem_id`, `mem_fname`, `mem_lname`, `mem_street`, `mem_city`, `mem_state`, `mem_zip`, `mem_phone`, `mem_email`, `mem_url`, `mem_notes`) VALUES (1, 'Galvin', 'Perry', '5381 Morbi Rd.', 'Richmond', 'MA', 83846, 9606054130, 'Cras@luct.ca', '', '');
INSERT INTO `ndt14b`.`member` (`mem_id`, `mem_fname`, `mem_lname`, `mem_street`, `mem_city`, `mem_state`, `mem_zip`, `mem_phone`, `mem_email`, `mem_url`, `mem_notes`) VALUES (2, 'Maia', 'Summers', '3207 Lectus Road', 'Springwater', 'UT', 28997, 8969059675, 'et.libero@Suspendissealiquetmolestie.edu', '', '');
INSERT INTO `ndt14b`.`member` (`mem_id`, `mem_fname`, `mem_lname`, `mem_street`, `mem_city`, `mem_state`, `mem_zip`, `mem_phone`, `mem_email`, `mem_url`, `mem_notes`) VALUES (3, 'Colin', 'Sykes', 'Ap #796-9099 Mollis Street', 'Tallahassee', 'FL', 84348, 1526098948, 'enim@quispedeSuspendisse.org', '', '');
INSERT INTO `ndt14b`.`member` (`mem_id`, `mem_fname`, `mem_lname`, `mem_street`, `mem_city`, `mem_state`, `mem_zip`, `mem_phone`, `mem_email`, `mem_url`, `mem_notes`) VALUES (4, 'Christopher', 'Reeves', '902-8323 A Rd.', 'Golf', 'NE', 67298, 3111702455, 'Duis@pulvinararcuet.net', '', '');
INSERT INTO `ndt14b`.`member` (`mem_id`, `mem_fname`, `mem_lname`, `mem_street`, `mem_city`, `mem_state`, `mem_zip`, `mem_phone`, `mem_email`, `mem_url`, `mem_notes`) VALUES (5, 'Ivy', 'Workman', 'P.O. Box 176, 3131 Tempor St.', 'Miami', 'FL', 47227, 5753249376, 'libero.est@Quisqueac.ca', '', '');
INSERT INTO `ndt14b`.`member` (`mem_id`, `mem_fname`, `mem_lname`, `mem_street`, `mem_city`, `mem_state`, `mem_zip`, `mem_phone`, `mem_email`, `mem_url`, `mem_notes`) VALUES (6, 'Gregory', 'Riley', '5295 Sociis Rd.', 'Oregon', 'OK', 61950, 6949806448, 'dapibus@hendreritDonecporttitor.ca', '', '');
INSERT INTO `ndt14b`.`member` (`mem_id`, `mem_fname`, `mem_lname`, `mem_street`, `mem_city`, `mem_state`, `mem_zip`, `mem_phone`, `mem_email`, `mem_url`, `mem_notes`) VALUES (7, 'Farrah', 'Blanchard', '6210 Mattis Avenue', 'Okeechobee', 'ME', 43179, 3744684774, 'velit.egestas@nequepellentesque.co.uk', '', '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ndt14b`.`publisher`
-- -----------------------------------------------------
START TRANSACTION;
USE `ndt14b`;
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (1, 'Ayanna', 'Browning', '5518 Lorem St.', 'Dallas', 'TX', 46118, 9686080365, 'Sed.eget.lacus@Utsemperpretium.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (2, 'Ralph', 'Glass', 'P.O. Box 598, 6279 Nascetur Road', 'Bellevue', 'WA', 54516, 4975528062, 'sit.amet@metus.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (3, 'Elton', 'Farmer', '4097 Enim Street', 'Bear', 'DE', 95536, 1224145433, 'Nunc@velquamdignissim.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (4, 'Vincent', 'Valentine', 'P.O. Box 993, 2547 Tristique Rd.', 'Glendale', 'AZ', 69863, 8725323897, 'lacus.Aliquam@consectetuermaurisid.edu', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (5, 'Sylvester', 'Randall', '870-8935 Ac Ave', 'Jackson', 'MS', 93609, 6209953182, 'magna@eget.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (6, 'Kai', 'Pearson', 'Ap #208-6200 Nunc Avenue', 'Lakewood', 'CO', 59547, 6232844708, 'primis.in.faucibus@tortorat.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (7, 'Lilah', 'West', '362-7450 Nec, Rd.', 'Idaho Falls', 'ID', 73757, 9736905416, 'lectus@pedeet.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (8, 'Darius', 'Chase', 'P.O. Box 317, 9607 Metus Rd.', 'Richmond', 'VA', 76417, 8478808950, 'laoreet@dapibus.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (9, 'Plato', 'Monroe', 'P.O. Box 327, 5582 Interdum. St.', 'Racine', 'WI', 80148, 9896051539, 'risus@nullaIntegervulputate.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (10, 'Colorado', 'Olsen', 'P.O. Box 206, 9387 Nec Avenue', 'Frankfort', 'KY', 17609, 6313851173, 'mus.Donec@sapien.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (11, 'Tallulah', 'Chapman', '8510 Lorem Avenue', 'Baton Rouge', 'LA', 27077, 6173453061, 'adipiscing.fringilla@fringillaeuismodenim.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (12, 'Ryder', 'Potter', '430-3152 Magna St.', 'Knoxville', 'TN', 79560, 6471387879, 'in.consequat@placeratorci.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (13, 'Kay', 'Kidd', 'P.O. Box 984, 7254 Lectus Ave', 'Denver', 'CO', 62259, 8723629080, 'Fusce.aliquet@Maecenaslibero.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (14, 'Gwendolyn', 'George', '8711 Faucibus Avenue', 'Bear', 'DE', 88947, 1205846990, 'est.vitae@felis.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (15, 'Audra', 'Walters', '7047 Sed Rd.', 'Eugene', 'OR', 82354, 3438891670, 'torquent.per@loremeu.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (16, 'Xyla', 'Brady', '425-1952 Magnis Rd.', 'San Antonio', 'TX', 76164, 5303502510, 'fringilla.ornare.placerat@Fusce.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (17, 'Roary', 'Sparks', 'P.O. Box 915, 5008 Imperdiet St.', 'Lexington', 'KY', 50767, 7588541770, 'Proin@massa.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (18, 'Fletcher', 'Duran', 'P.O. Box 726, 588 Porttitor Street', 'Rockville', 'MD', 19649, 5204486312, 'dolor.sit@antedictum.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (19, 'Knox', 'Robbins', '6468 Cursus Av.', 'Minneapolis', 'MN', 88269, 3435666600, 'Pellentesque.habitant.morbi@egetmetus.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (20, 'Ishmael', 'Scott', '1473 Eros. Ave', 'Fort Smith', 'AR', 69969, 8076823868, 'ac.tellus@interdumCurabiturdictum.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (21, 'Bianca', 'Chavez', 'P.O. Box 575, 8265 Curae; Rd.', 'Boston', 'MA', 69141, 4341119924, 'quis.accumsan.convallis@cursusnon.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (22, 'Brett', 'Jarvis', 'P.O. Box 715, 8748 Lacus. Street', 'Chattanooga', 'TN', 44281, 7869782375, 'vehicula.aliquet@orci.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (23, 'Juliet', 'Benson', 'P.O. Box 658, 1677 Nulla Ave', 'Mobile', 'AL', 98006, 1397318161, 'ac.risus.Morbi@egetnisidictum.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (24, 'Dolan', 'May', '492-4812 Sem Avenue', 'Grand Island', 'NE', 72046, 7941413002, 'tristique@Quisqueornaretortor.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (25, 'Deacon', 'William', '5615 Curabitur Rd.', 'Augusta', 'ME', 58531, 1504199949, 'magna.a@Mauris.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (26, 'Xenos', 'Fischer', 'P.O. Box 804, 9753 Duis Rd.', 'Green Bay', 'WI', 54229, 1903269602, 'amet.dapibus.id@nuncnulla.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (27, 'Hayes', 'Donovan', '8526 Mauris Road', 'Independence', 'MO', 32848, 3332143727, 'ac.mattis@Pellentesque.edu', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (28, 'Oleg', 'Klein', '644-9471 Iaculis Rd.', 'Saint Paul', 'MN', 46757, 6796752699, 'velit.eget.laoreet@augueeu.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (29, 'Aristotle', 'Small', '741-3297 Neque. Road', 'Hillsboro', 'OR', 71928, 9866863927, 'Mauris.molestie.pharetra@ipsumdolorsit.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (30, 'Katelyn', 'Buckner', 'Ap #394-6392 Sed Avenue', 'Erie', 'PA', 38896, 7412285941, 'vulputate.eu@mollislectuspede.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (31, 'Lawrence', 'Romero', '4068 Vitae Road', 'Houston', 'TX', 56130, 2303252684, 'placerat.Cras.dictum@ante.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (32, 'Winter', 'Ellis', 'Ap #145-5412 Enim. Street', 'Cambridge', 'MA', 67004, 1116936327, 'ornare.lectus.justo@turpis.edu', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (33, 'Alfonso', 'Holder', 'P.O. Box 634, 6675 Nisi. Road', 'Newark', 'DE', 93419, 5135038869, 'pharetra.nibh@lobortisultrices.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (34, 'Charde', 'Workman', 'P.O. Box 182, 9842 Semper Rd.', 'Tuscaloosa', 'AL', 72983, 3193524560, 'dui.Fusce.diam@convallis.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (35, 'Wanda', 'Sparks', 'Ap #498-9945 Non, Rd.', 'Kailua', 'HI', 20983, 6505417765, 'magnis.dis@elitCurabitur.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (36, 'Savannah', 'Powers', 'Ap #775-8879 Aliquam Av.', 'Green Bay', 'WI', 31915, 3227631489, 'aliquet.metus.urna@interdum.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (37, 'Autumn', 'Merrill', 'Ap #594-9511 Mauris Av.', 'Dallas', 'TX', 87372, 5507853945, 'sed.leo@necurnaet.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (38, 'Daquan', 'Farrell', 'Ap #205-3501 Aliquet Av.', 'West Jordan', 'UT', 28480, 5346892831, 'orci@lacinia.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (39, 'Eric', 'Fuller', '7120 A, Rd.', 'Knoxville', 'TN', 88469, 1343949064, 'sit@erat.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (40, 'Ima', 'Holland', '319-8093 In Av.', 'Helena', 'MT', 51239, 6219266492, 'massa.Integer@ligulaAenean.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (41, 'Xavier', 'Sawyer', '4191 Vulputate, Road', 'Colchester', 'VT', 56230, 7442073915, 'torquent.per@aliquet.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (42, 'Xaviera', 'Charles', '814-8142 Ut Rd.', 'Ketchikan', 'AK', 35900, 9451780381, 'rhoncus.id@magnatellusfaucibus.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (43, 'Cassidy', 'Terry', 'P.O. Box 625, 8329 Consectetuer Rd.', 'Frankfort', 'KY', 83325, 3493538101, 'Sed@erosnectellus.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (44, 'Jillian', 'Dale', 'Ap #339-3586 Ac St.', 'Carson City', 'NV', 96736, 4317374103, 'ultrices.sit.amet@egestasAliquamfringilla.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (45, 'Melanie', 'Stephens', 'Ap #797-4568 Nisi. Street', 'Grand Rapids', 'MI', 66900, 4845398746, 'condimentum@lectus.edu', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (46, 'Xavier', 'Tate', '7487 Rutrum. Road', 'North Las Vegas', 'NV', 25521, 7191630398, 'orci@ultriciesadipiscingenim.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (47, 'Chiquita', 'Oneil', '298-2088 Amet Street', 'Norman', 'OK', 17162, 8694093989, 'ligula.Nullam@quisaccumsan.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (48, 'Fredericka', 'Hughes', 'Ap #495-3299 Nulla Avenue', 'Lexington', 'KY', 85869, 1763444812, 'Duis@vehiculaet.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (49, 'Hamish', 'West', 'P.O. Box 164, 7830 Bibendum St.', 'Newport News', 'VA', 20008, 4192254109, 'pede.sagittis@Quisque.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (50, 'Boris', 'Sosa', 'P.O. Box 852, 3801 Enim, Av.', 'South Burlington', 'VT', 53949, 1336806599, 'Cras.sed.leo@semperdui.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (51, 'Illana', 'Rivers', 'Ap #982-8046 Mollis Street', 'Hattiesburg', 'MS', 21708, 4583836486, 'semper@Maurisnon.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (52, 'Lydia', 'Wallace', '533-461 Fusce Av.', 'Frederick', 'MD', 75818, 2927073569, 'sem@Nam.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (53, 'Nerea', 'Mcdonald', '4038 Adipiscing. Av.', 'Georgia', 'GA', 11701, 8447932104, 'Proin@laoreet.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (54, 'Hiram', 'Chan', 'Ap #490-6557 Donec St.', 'College', 'AK', 79175, 5283074288, 'ridiculus.mus.Proin@seddictumeleifend.edu', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (55, 'Elizabeth', 'Evans', 'Ap #149-3487 Porta Av.', 'Tulsa', 'OK', 57418, 9936323795, 'egestas.urna.justo@ipsumSuspendissenon.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (56, 'Jessamine', 'Christensen', 'Ap #766-9377 Ultrices Avenue', 'Jefferson City', 'MO', 17948, 4779474466, 'tempor.bibendum.Donec@gravidaPraesent.edu', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (57, 'Malachi', 'Frost', 'P.O. Box 769, 8787 Sed Ave', 'Hillsboro', 'OR', 26380, 9986493902, 'sem.consequat@sitamet.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (58, 'Oren', 'Vance', '366-2846 Ut, St.', 'Bozeman', 'MT', 59925, 4015659849, 'dictum@miDuisrisus.edu', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (59, 'Carson', 'Fuentes', 'P.O. Box 488, 3177 Eu St.', 'Erie', 'PA', 55947, 5387987192, 'lorem.luctus.ut@Fuscealiquetmagna.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (60, 'Camille', 'Robertson', '109-5478 Proin Av.', 'Chandler', 'AZ', 56080, 5091297550, 'pede@tellusAeneanegestas.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (61, 'Deacon', 'Harrell', 'Ap #500-4582 Orci, St.', 'Fort Wayne', 'IN', 31470, 5663557343, 'et.netus@gravidamauris.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (62, 'Avram', 'Santana', '237-7323 Parturient Rd.', 'Fayetteville', 'AR', 99055, 7231623264, 'parturient@eliterat.edu', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (63, 'Malcolm', 'Gay', 'Ap #728-6913 Elit, Av.', 'Allentown', 'PA', 88817, 1062119289, 'Praesent.eu.nulla@leo.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (64, 'Casey', 'Franco', '3355 Luctus St.', 'Fayetteville', 'AR', 30248, 6546310703, 'montes.nascetur@loremacrisus.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (65, 'Hayfa', 'Franks', 'P.O. Box 270, 7468 Sit Avenue', 'Sacramento', 'CA', 11699, 5473600561, 'Vestibulum@intempus.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (66, 'Tatyana', 'Dale', '596-9996 In Rd.', 'Anchorage', 'AK', 90537, 2487043869, 'sit.amet.consectetuer@Praesentluctus.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (67, 'Alice', 'Anderson', 'P.O. Box 552, 1079 Netus Avenue', 'Owensboro', 'KY', 61563, 4609661940, 'senectus.et@nonlorem.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (68, 'Yasir', 'Molina', '243-741 Egestas Road', 'Kansas City', 'MO', 55263, 7584778184, 'rutrum.urna.nec@quisurnaNunc.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (69, 'Reece', 'Chang', '948-9123 In St.', 'Baton Rouge', 'LA', 89258, 2023199253, 'congue.a@ultrices.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (70, 'Jarrod', 'Greer', '303-6683 Eget Street', 'Essex', 'VT', 51581, 9785789642, 'Mauris@dignissimMaecenas.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (71, 'Claire', 'Gonzalez', 'P.O. Box 746, 5069 Cubilia Ave', 'Annapolis', 'MD', 57692, 1342821806, 'nulla.Donec@dis.edu', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (72, 'Lysandra', 'Mcdonald', '571-1410 Quis Street', 'Vancouver', 'WA', 15640, 1471982085, 'lorem@eleifendnuncrisus.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (73, 'Yasir', 'Cote', '681-1946 Eu Street', 'Covington', 'KY', 67224, 6961036290, 'a@Donec.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (74, 'Madeson', 'West', 'P.O. Box 601, 2125 Quisque St.', 'Colorado Springs', 'CO', 57921, 7005202730, 'erat.vel@ipsumleoelementum.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (75, 'Samantha', 'Fischer', '876-3756 Ac St.', 'Provo', 'UT', 85235, 3581252550, 'purus.Duis.elementum@acnullaIn.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (76, 'Zeph', 'Stein', '9922 Pede Rd.', 'Salem', 'OR', 78446, 5868220888, 'dictum@nonlacinia.edu', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (77, 'Jordan', 'Rollins', '1748 Ipsum St.', 'West Valley City', 'UT', 93096, 5532924181, 'tempor@mi.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (78, 'Rhoda', 'Walls', 'Ap #625-7583 Tristique St.', 'Springdale', 'AR', 34440, 4668762474, 'nonummy.ac.feugiat@Fusce.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (79, 'Barrett', 'Dudley', '804-3928 Vulputate Road', 'Phoenix', 'AZ', 80925, 6794504226, 'nec.ante.Maecenas@utipsumac.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (80, 'Patience', 'Key', '597-3310 Cras Ave', 'Cedar Rapids', 'IA', 23492, 6763863186, 'Duis@pellentesque.edu', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (81, 'Demetria', 'Barrett', '859-5618 Ipsum. St.', 'Bellevue', 'WA', 54634, 3132997621, 'a.sollicitudin@velturpisAliquam.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (82, 'Bree', 'Prince', '685-2039 Diam Avenue', 'Pocatello', 'ID', 28769, 3413627764, 'dolor@eu.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (83, 'Rhonda', 'Webster', 'P.O. Box 620, 5763 Ac Rd.', 'Tuscaloosa', 'AL', 50348, 2821063807, 'pharetra.felis@insodaleselit.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (84, 'Ciara', 'Banks', '5228 Auctor. Ave', 'Boston', 'MA', 59296, 8385234112, 'molestie@Sed.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (85, 'Daquan', 'Hughes', '959-7525 Nulla Ave', 'Billings', 'MT', 54598, 4369570731, 'eros@atarcuVestibulum.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (86, 'Garrett', 'Battle', 'P.O. Box 811, 2529 Ac Av.', 'Cedar Rapids', 'IA', 68457, 9485066400, 'vel.pede.blandit@ornareelit.edu', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (87, 'Amery', 'Stone', '3689 Risus. Rd.', 'San Diego', 'CA', 36831, 8957176115, 'risus.Quisque.libero@orci.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (88, 'Dominic', 'Henderson', '512-4855 Magna. Av.', 'Memphis', 'TN', 92467, 5053412539, 'aliquam@justonec.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (89, 'Lyle', 'Howell', '328 Mauris Ave', 'Hilo', 'HI', 36563, 8574613489, 'sagittis@CuraePhasellusornare.org', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (90, 'Tanek', 'Cameron', 'Ap #528-6291 Vitae Road', 'Rockville', 'MD', 76619, 4441489066, 'auctor.velit.Aliquam@cubilia.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (91, 'Dane', 'Douglas', 'P.O. Box 553, 4855 Dolor. Street', 'Louisville', 'KY', 57067, 6076607910, 'Maecenas.mi.felis@Sedetlibero.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (92, 'Yoshi', 'English', '961-2724 Ipsum. St.', 'Lexington', 'KY', 25015, 7284422975, 'nisi.nibh.lacinia@faucibusorci.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (93, 'Carla', 'Gaines', '316-4205 Lorem Avenue', 'Aurora', 'CO', 12946, 2347340792, 'leo.Cras@pharetra.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (94, 'Ira', 'Harrington', '742-6764 Nunc Av.', 'Rochester', 'MN', 70503, 6162272280, 'auctor.non.feugiat@vitae.edu', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (95, 'Xena', 'Pugh', 'Ap #490-8481 Quisque Avenue', 'Independence', 'MO', 16419, 5382296734, 'sollicitudin@Praesent.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (96, 'Drake', 'Dotson', 'P.O. Box 774, 8874 Elit Rd.', 'Wichita', 'KS', 98131, 7507406278, 'mi.lacinia@Integeraliquam.com', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (97, 'Venus', 'Nichols', 'P.O. Box 696, 1045 Vulputate St.', 'Columbia', 'MD', 21997, 8084726626, 'Mauris@nullaInteger.ca', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (98, 'Jeremy', 'Haley', '399 A, Rd.', 'Cincinnati', 'OH', 93980, 6455823495, 'ultricies@aliquetdiamSed.net', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (99, 'Maile', 'Jefferson', 'P.O. Box 590, 5439 Odio Street', 'Naperville', 'IL', 93662, 6927922478, 'facilisis.magna@Sednuncest.co.uk', '', '');
INSERT INTO `ndt14b`.`publisher` (`pub_id`, `pub_fname`, `pub_lname`, `pub_street`, `pub_city`, `pub_state`, `pub_zip`, `pub_phone`, `pub_email`, `pub_url`, `pub_notes`) VALUES (100, 'Victoria', 'Bass', 'Ap #353-3545 Non, Rd.', 'Newport News', 'VA', 73653, 5725265290, 'volutpat@elitfermentumrisus.co.uk', '', '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ndt14b`.`book`
-- -----------------------------------------------------
START TRANSACTION;
USE `ndt14b`;
INSERT INTO `ndt14b`.`book` (`bok_isbn`, `pub_id`, `bok_title`, `bok_pub_date`, `bok_num_pages`, `bok_cost`, `bok_price`, `bok_notes`) VALUES ('9780439708180', 1, 'Harry Potter and the Sorcerrer\'s Stone', '1999-11-01', 250, 10.50, '30.50', NULL);
INSERT INTO `ndt14b`.`book` (`bok_isbn`, `pub_id`, `bok_title`, `bok_pub_date`, `bok_num_pages`, `bok_cost`, `bok_price`, `bok_notes`) VALUES ('9780439064873', 1, 'Harry Potter and the Chamber of Secrets', '2000-05-03', 340, 11.50, '30.50', NULL);
INSERT INTO `ndt14b`.`book` (`bok_isbn`, `pub_id`, `bok_title`, `bok_pub_date`, `bok_num_pages`, `bok_cost`, `bok_price`, `bok_notes`) VALUES ('9780439136365', 1, 'Harry Potter and the Prisoner of Azkaban', '2001-06-11', 448, 12.00, '30.50', NULL);
INSERT INTO `ndt14b`.`book` (`bok_isbn`, `pub_id`, `bok_title`, `bok_pub_date`, `bok_num_pages`, `bok_cost`, `bok_price`, `bok_notes`) VALUES ('9780439139601', 2, 'Harry Potter and the Goblet of Fire', '2003-08-01', 752, 15.00, '33.00', NULL);
INSERT INTO `ndt14b`.`book` (`bok_isbn`, `pub_id`, `bok_title`, `bok_pub_date`, `bok_num_pages`, `bok_cost`, `bok_price`, `bok_notes`) VALUES ('9780439358071', 2, 'Harry Potter and the Order of Phoenix', '2005-07-11', 896, 15.50, '33.00', NULL);
INSERT INTO `ndt14b`.`book` (`bok_isbn`, `pub_id`, `bok_title`, `bok_pub_date`, `bok_num_pages`, `bok_cost`, `bok_price`, `bok_notes`) VALUES ('9485347689392', 3, 'Quiet: the introvert', '2015-12-12', 150, 5, '12.00', NULL);
INSERT INTO `ndt14b`.`book` (`bok_isbn`, `pub_id`, `bok_title`, `bok_pub_date`, `bok_num_pages`, `bok_cost`, `bok_price`, `bok_notes`) VALUES ('9084023342426', 4, 'Health Body and Soul', '2014-02-14', 155, 11.33, '23.50', NULL);
INSERT INTO `ndt14b`.`book` (`bok_isbn`, `pub_id`, `bok_title`, `bok_pub_date`, `bok_num_pages`, `bok_cost`, `bok_price`, `bok_notes`) VALUES ('9375235029384', 5, 'The Cowboys', '1980-11-03', 168, 8.99, '18.99', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ndt14b`.`loaner`
-- -----------------------------------------------------
START TRANSACTION;
USE `ndt14b`;
INSERT INTO `ndt14b`.`loaner` (`loan_id`, `mem_id`, `bok_isbn`, `lon_loan_date`, `lon_due_date`, `long_return_date`, `lon_late_fee`, `lon_notes`) VALUES (1, 1, '9780439708180', '2014-04-04', '2014-05-04', '2014-05-03', 0.00, NULL);
INSERT INTO `ndt14b`.`loaner` (`loan_id`, `mem_id`, `bok_isbn`, `lon_loan_date`, `lon_due_date`, `long_return_date`, `lon_late_fee`, `lon_notes`) VALUES (2, 2, '9780439064873', '2015-01-01', '2015-02-02', '2015-01-31', 0.00, NULL);
INSERT INTO `ndt14b`.`loaner` (`loan_id`, `mem_id`, `bok_isbn`, `lon_loan_date`, `lon_due_date`, `long_return_date`, `lon_late_fee`, `lon_notes`) VALUES (3, 3, '9780439136365', '2016-01-01', '2016-02-02', '2016-02-04', 1.50, NULL);
INSERT INTO `ndt14b`.`loaner` (`loan_id`, `mem_id`, `bok_isbn`, `lon_loan_date`, `lon_due_date`, `long_return_date`, `lon_late_fee`, `lon_notes`) VALUES (4, 4, '9780439139601', '2014-08-11', '2014-09-10', '2014-10-10', 20.50, NULL);
INSERT INTO `ndt14b`.`loaner` (`loan_id`, `mem_id`, `bok_isbn`, `lon_loan_date`, `lon_due_date`, `long_return_date`, `lon_late_fee`, `lon_notes`) VALUES (5, 1, '9780439064873', '2014-04-04', '2014-05-04', '2014-05-03', 0.00, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ndt14b`.`author`
-- -----------------------------------------------------
START TRANSACTION;
USE `ndt14b`;
INSERT INTO `ndt14b`.`author` (`auth_id`, `auth_fname`, `auth_lname`, `auth_street`, `auth_city`, `auth_state`, `auth_zip`, `auth_phone`, `auth_email`, `auth_url`, `auth_notes`) VALUES (1, 'JK', 'Rowling', '123 Grindewald', 'London', 'England', 29053, '2907412423', 'jkrowling@gmail.cm', 'http://www.harrypotterrules.com', NULL);
INSERT INTO `ndt14b`.`author` (`auth_id`, `auth_fname`, `auth_lname`, `auth_street`, `auth_city`, `auth_state`, `auth_zip`, `auth_phone`, `auth_email`, `auth_url`, `auth_notes`) VALUES (2, 'Ryan', 'Rey', '3980 Boca ', 'Boca Raton', 'FL', 24804, '9284014801', 'ryan.rey@hotmail.com', 'http://www.ryanreyjournals.com', NULL);
INSERT INTO `ndt14b`.`author` (`auth_id`, `auth_fname`, `auth_lname`, `auth_street`, `auth_city`, `auth_state`, `auth_zip`, `auth_phone`, `auth_email`, `auth_url`, `auth_notes`) VALUES (3, 'Nhi', 'Tran', '1822 Colonial Drive', 'Coral Springs ', 'FL', 24801, '9548028937', NULL, NULL, NULL);
INSERT INTO `ndt14b`.`author` (`auth_id`, `auth_fname`, `auth_lname`, `auth_street`, `auth_city`, `auth_state`, `auth_zip`, `auth_phone`, `auth_email`, `auth_url`, `auth_notes`) VALUES (4, 'Carter ', 'Burkhart', '600 Dixie Drive', 'Tallahassee', 'FL', 32304, '9548018057', NULL, NULL, NULL);
INSERT INTO `ndt14b`.`author` (`auth_id`, `auth_fname`, `auth_lname`, `auth_street`, `auth_city`, `auth_state`, `auth_zip`, `auth_phone`, `auth_email`, `auth_url`, `auth_notes`) VALUES (5, 'Le', 'Long', '4890 Royal Azalea', 'Marymount ', 'MO', 25020, '8927301292', NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ndt14b`.`attribution`
-- -----------------------------------------------------
START TRANSACTION;
USE `ndt14b`;
INSERT INTO `ndt14b`.`attribution` (`attr_id`, `bok_isbn`, `auth_id`, `attr_notes`) VALUES (1, '9780439708180', 1, NULL);
INSERT INTO `ndt14b`.`attribution` (`attr_id`, `bok_isbn`, `auth_id`, `attr_notes`) VALUES (2, '9780439064873', 1, NULL);
INSERT INTO `ndt14b`.`attribution` (`attr_id`, `bok_isbn`, `auth_id`, `attr_notes`) VALUES (3, '9780439136365', 1, NULL);
INSERT INTO `ndt14b`.`attribution` (`attr_id`, `bok_isbn`, `auth_id`, `attr_notes`) VALUES (4, '9780439139601', 1, NULL);
INSERT INTO `ndt14b`.`attribution` (`attr_id`, `bok_isbn`, `auth_id`, `attr_notes`) VALUES (5, '9780439358071', 1, NULL);
INSERT INTO `ndt14b`.`attribution` (`attr_id`, `bok_isbn`, `auth_id`, `attr_notes`) VALUES (6, '9485347689392', 2, NULL);
INSERT INTO `ndt14b`.`attribution` (`attr_id`, `bok_isbn`, `auth_id`, `attr_notes`) VALUES (7, '9084023342426', 3, NULL);
INSERT INTO `ndt14b`.`attribution` (`attr_id`, `bok_isbn`, `auth_id`, `attr_notes`) VALUES (8, '9375235029384', 4, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ndt14b`.`category`
-- -----------------------------------------------------
START TRANSACTION;
USE `ndt14b`;
INSERT INTO `ndt14b`.`category` (`cat_id`, `cat_type`, `cat_notes`) VALUES (1, 'action', NULL);
INSERT INTO `ndt14b`.`category` (`cat_id`, `cat_type`, `cat_notes`) VALUES (2, 'children', NULL);
INSERT INTO `ndt14b`.`category` (`cat_id`, `cat_type`, `cat_notes`) VALUES (3, 'psychology', NULL);
INSERT INTO `ndt14b`.`category` (`cat_id`, `cat_type`, `cat_notes`) VALUES (4, 'health', NULL);
INSERT INTO `ndt14b`.`category` (`cat_id`, `cat_type`, `cat_notes`) VALUES (5, 'history', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ndt14b`.`book_cat`
-- -----------------------------------------------------
START TRANSACTION;
USE `ndt14b`;
INSERT INTO `ndt14b`.`book_cat` (`bok_cat_id`, `bok_isbn`, `cat_id`) VALUES (1, '9780439708180', 1);
INSERT INTO `ndt14b`.`book_cat` (`bok_cat_id`, `bok_isbn`, `cat_id`) VALUES (2, '9780439708180', 2);
INSERT INTO `ndt14b`.`book_cat` (`bok_cat_id`, `bok_isbn`, `cat_id`) VALUES (3, '9084023342426', 3);
INSERT INTO `ndt14b`.`book_cat` (`bok_cat_id`, `bok_isbn`, `cat_id`) VALUES (4, '9084023342426', 4);
INSERT INTO `ndt14b`.`book_cat` (`bok_cat_id`, `bok_isbn`, `cat_id`) VALUES (5, '9375235029384', 5);

COMMIT;
