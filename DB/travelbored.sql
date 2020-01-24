-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema travelboreddb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `travelboreddb` ;

-- -----------------------------------------------------
-- Schema travelboreddb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `travelboreddb` DEFAULT CHARACTER SET utf8 ;
USE `travelboreddb` ;

-- -----------------------------------------------------
-- Table `location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `location` ;

CREATE TABLE IF NOT EXISTS `location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(100) NULL,
  `state` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `address` VARCHAR(200) NULL,
  `active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `active` TINYINT NULL DEFAULT 1,
  `role` VARCHAR(45) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(100) NOT NULL,
  `location_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  `user_img_url` VARCHAR(20000) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_user_location1_idx` (`location_id` ASC),
  CONSTRAINT `fk_user_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event` ;

CREATE TABLE IF NOT EXISTS `event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(50) NULL,
  `hook` VARCHAR(200) NULL,
  `description` TEXT NULL,
  `event_time` TIME NULL,
  `event_date` DATE NULL,
  `img_url` VARCHAR(10000) NULL,
  `event_url` VARCHAR(10000) NULL,
  `active` TINYINT NULL DEFAULT 1,
  `location_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_location1_idx` (`location_id` ASC),
  CONSTRAINT `fk_event_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event_detail` ;

CREATE TABLE IF NOT EXISTS `event_detail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `detail_name` VARCHAR(45) NULL,
  `detail_type` VARCHAR(45) NULL,
  `active` TINYINT NULL DEFAULT 1,
  `event_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_details_event1_idx` (`event_id` ASC),
  CONSTRAINT `fk_event_details_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event_comment` ;

CREATE TABLE IF NOT EXISTS `event_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NULL,
  `create_date` DATETIME NULL,
  `user_id` INT NOT NULL,
  `event_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_event_comment_event1_idx` (`event_id` ASC),
  CONSTRAINT `fk_event_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_comment_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group` ;

CREATE TABLE IF NOT EXISTS `group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NULL,
  `hook` VARCHAR(200) NULL,
  `user_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  `active` TINYINT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_group_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_group_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group_comment` ;

CREATE TABLE IF NOT EXISTS `group_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NULL,
  `create_date` DATETIME NULL,
  `group_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_group_comment_group1_idx` (`group_id` ASC),
  INDEX `fk_group_comment_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_group_comment_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_event` ;

CREATE TABLE IF NOT EXISTS `user_event` (
  `user_id` INT NOT NULL,
  `event_id` INT NOT NULL,
  `creator` TINYINT NULL DEFAULT 0,
  `active` TINYINT NULL DEFAULT 1,
  `create_date` DATETIME NULL,
  PRIMARY KEY (`user_id`, `event_id`),
  INDEX `fk_user_has_event_event1_idx` (`event_id` ASC),
  INDEX `fk_user_has_event_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_event_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_event_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_details` ;

CREATE TABLE IF NOT EXISTS `user_details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_detail_name` VARCHAR(45) NULL,
  `user_detail_description` VARCHAR(500) NULL,
  `user_detail_url` VARCHAR(20000) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_details_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_details_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_img`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event_img` ;

CREATE TABLE IF NOT EXISTS `event_img` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event_img_url` VARCHAR(20000) NULL,
  `event_img_name` VARCHAR(100) NULL,
  `event_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_img_event1_idx` (`event_id` ASC),
  CONSTRAINT `fk_event_img_event1`
    FOREIGN KEY (`event_id`)
    REFERENCES `event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS travelboreduser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'travelboreduser'@'localhost' IDENTIFIED BY 'travelboreduser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'travelboreduser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `location`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelboreddb`;
INSERT INTO `location` (`id`, `country`, `state`, `city`, `address`, `active`) VALUES (1, 'United States', 'Colorado', 'Denver', '123  denver test', 1);
INSERT INTO `location` (`id`, `country`, `state`, `city`, `address`, `active`) VALUES (2, 'United States', 'Colorado', 'Greenwood Village', '1234 greenwood test', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelboreddb`;
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `location_id`, `create_date`, `user_img_url`) VALUES (2, 'testuser', 'testuser', 1, 'user', 'Test', 'User', 'testuser@test.com', 1, '2020-01-24', 'https://skilldistillery.com/wp-content/uploads/2017/01/RobRPicSDWEB-250x250.jpg');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `location_id`, `create_date`, `user_img_url`) VALUES (1, 'admin', 'admin', 1, 'admin', 'admin first', 'admin last', 'admin@travelbored.com', 1, '2020-01-24', 'https://images.app.goo.gl/9GB2u5SozoJ1RX1A6');
INSERT INTO `user` (`id`, `username`, `password`, `active`, `role`, `first_name`, `last_name`, `email`, `location_id`, `create_date`, `user_img_url`) VALUES (3, 'moderator', 'moderator', 1, 'moderator', 'mod first', 'mod last', 'moderator@travelbored.com', 1, '2020-1-24', 'https://images.app.goo.gl/mwdtfRsxBKcT6rM76');

COMMIT;


-- -----------------------------------------------------
-- Data for table `event`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelboreddb`;
INSERT INTO `event` (`id`, `title`, `hook`, `description`, `event_time`, `event_date`, `img_url`, `event_url`, `active`, `location_id`, `create_date`) VALUES (1, 'Skill Distillery', 'Skill Distillery is an intensive, 16-week Java bootcamp in Denver, Colorado. The course is arranged into three units – Java Programming, Server-side Java, and Front-end Development.', 'The curriculum focuses on the fundamentals of programming, Java (and its libraries), unit testing, Spring, Spring MVC, and using a source code repository. Students will also gain experience deploying web content to a web server and navigating the server file system from the command line. Skill Distillery graduates will be prepared to take the Oracle Certified Associate – Java Programmer exam and will be on track for a career as a web interface designer or a full stack application developer.', '08:30', '2020-01-25', 'https://images.app.goo.gl/AfH6qe6nLTRBhNZg8', 'https://images.app.goo.gl/TMzENCuQf9DNJBxPA', 1, 1, '2020-01-24');

COMMIT;


-- -----------------------------------------------------
-- Data for table `event_detail`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelboreddb`;
INSERT INTO `event_detail` (`id`, `detail_name`, `detail_type`, `active`, `event_id`) VALUES (1, 'dress code', 'black tie optional', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `event_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelboreddb`;
INSERT INTO `event_comment` (`id`, `content`, `create_date`, `user_id`, `event_id`) VALUES (1, 'Best coding school in the country!', '2020-01-24', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `group`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelboreddb`;
INSERT INTO `group` (`id`, `title`, `hook`, `user_id`, `create_date`, `active`) VALUES (1, 'SD Group', 'test hook', 1, '2020-01-24', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `group_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelboreddb`;
INSERT INTO `group_comment` (`id`, `content`, `create_date`, `group_id`, `user_id`) VALUES (1, 'content test', '2020-01-24', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_event`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelboreddb`;
INSERT INTO `user_event` (`user_id`, `event_id`, `creator`, `active`, `create_date`) VALUES (1, 1, NULL, 1, '2020-01-24');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_details`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelboreddb`;
INSERT INTO `user_details` (`id`, `user_detail_name`, `user_detail_description`, `user_detail_url`, `user_id`) VALUES (1, 'middle name', 'sd test middle', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `event_img`
-- -----------------------------------------------------
START TRANSACTION;
USE `travelboreddb`;
INSERT INTO `event_img` (`id`, `event_img_url`, `event_img_name`, `event_id`, `create_date`) VALUES (1, 'https://images.app.goo.gl/TMzENCuQf9DNJBxPA', 'skill distillery pic', 1, '2020-01-24');

COMMIT;

