-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema NewsAndBlogSite
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema NewsAndBlogSite
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `NewsAndBlogSite` DEFAULT CHARACTER SET utf8 ;
USE `NewsAndBlogSite` ;

-- -----------------------------------------------------
-- Table `NewsAndBlogSite`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`authors` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`author_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NewsAndBlogSite`.`news_topics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`news_topics` (
  `news_topic_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `parent_news_topic_id` INT NULL,
  PRIMARY KEY (`news_topic_id`),
  INDEX `fk_news_topics_news_topics1_idx` (`parent_news_topic_id` ASC),
  CONSTRAINT `fk_news_topics_news_topics1`
    FOREIGN KEY (`parent_news_topic_id`)
    REFERENCES `NewsAndBlogSite`.`news_topics` (`news_topic_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NewsAndBlogSite`.`news`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`news` (
  `new_id` INT NOT NULL AUTO_INCREMENT,
  `header` VARCHAR(80) NOT NULL,
  `content` LONGTEXT NOT NULL,
  `author` INT NULL,
  `date` DATE NULL,
  `topic` INT NULL,
  PRIMARY KEY (`new_id`),
  INDEX `author_idx` (`author` ASC),
  INDEX `topic_idx` (`topic` ASC),
  CONSTRAINT `author_news`
    FOREIGN KEY (`author`)
    REFERENCES `NewsAndBlogSite`.`authors` (`author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `topic_news`
    FOREIGN KEY (`topic`)
    REFERENCES `NewsAndBlogSite`.`news_topics` (`news_topic_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NewsAndBlogSite`.`blog_topics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`blog_topics` (
  `blog_topic_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `parent_blog_topic_id` INT NULL,
  PRIMARY KEY (`blog_topic_id`),
  INDEX `fk_blog_topics_blog_topics1_idx` (`parent_blog_topic_id` ASC),
  CONSTRAINT `fk_blog_topics_blog_topics1`
    FOREIGN KEY (`parent_blog_topic_id`)
    REFERENCES `NewsAndBlogSite`.`blog_topics` (`blog_topic_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NewsAndBlogSite`.`blogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`blogs` (
  `blog_id` INT NOT NULL AUTO_INCREMENT,
  `header` VARCHAR(80) NOT NULL,
  `content` LONGTEXT NOT NULL,
  `author` INT NULL,
  `date` DATE NULL,
  `topic` INT NULL,
  PRIMARY KEY (`blog_id`),
  INDEX `author_idx` (`author` ASC),
  INDEX `topic_idx` (`topic` ASC),
  CONSTRAINT `author_blogs`
    FOREIGN KEY (`author`)
    REFERENCES `NewsAndBlogSite`.`authors` (`author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `topic_blogs`
    FOREIGN KEY (`topic`)
    REFERENCES `NewsAndBlogSite`.`blog_topics` (`blog_topic_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NewsAndBlogSite`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`tags` (
  `blog_tags_id` INT NOT NULL,
  `content` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`blog_tags_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NewsAndBlogSite`.`news_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`news_tags` (
  `news_tags_id` INT NOT NULL,
  `content` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`news_tags_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NewsAndBlogSite`.`news_has_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`news_has_tags` (
  `news_new_id` INT NOT NULL,
  `tags_blog_tags_id` INT NOT NULL,
  PRIMARY KEY (`news_new_id`, `tags_blog_tags_id`),
  INDEX `fk_news_has_tags1_tags1_idx` (`tags_blog_tags_id` ASC),
  INDEX `fk_news_has_tags1_news1_idx` (`news_new_id` ASC),
  CONSTRAINT `fk_news_has_tags1_news1`
    FOREIGN KEY (`news_new_id`)
    REFERENCES `NewsAndBlogSite`.`news` (`new_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_news_has_tags1_tags1`
    FOREIGN KEY (`tags_blog_tags_id`)
    REFERENCES `NewsAndBlogSite`.`tags` (`blog_tags_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NewsAndBlogSite`.`blogs_has_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`blogs_has_tags` (
  `blogs_blog_id` INT NOT NULL,
  `tags_blog_tags_id` INT NOT NULL,
  PRIMARY KEY (`blogs_blog_id`, `tags_blog_tags_id`),
  INDEX `fk_blogs_has_tags1_tags1_idx` (`tags_blog_tags_id` ASC),
  INDEX `fk_blogs_has_tags1_blogs1_idx` (`blogs_blog_id` ASC),
  CONSTRAINT `fk_blogs_has_tags1_blogs1`
    FOREIGN KEY (`blogs_blog_id`)
    REFERENCES `NewsAndBlogSite`.`blogs` (`blog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blogs_has_tags1_tags1`
    FOREIGN KEY (`tags_blog_tags_id`)
    REFERENCES `NewsAndBlogSite`.`tags` (`blog_tags_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NewsAndBlogSite`.`news_has_blogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`news_has_blogs` (
  `news_new_id` INT NOT NULL,
  `blogs_blog_id` INT NOT NULL,
  PRIMARY KEY (`news_new_id`, `blogs_blog_id`),
  INDEX `fk_news_has_blogs_blogs1_idx` (`blogs_blog_id` ASC),
  INDEX `fk_news_has_blogs_news1_idx` (`news_new_id` ASC),
  CONSTRAINT `fk_news_has_blogs_news1`
    FOREIGN KEY (`news_new_id`)
    REFERENCES `NewsAndBlogSite`.`news` (`new_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_news_has_blogs_blogs1`
    FOREIGN KEY (`blogs_blog_id`)
    REFERENCES `NewsAndBlogSite`.`blogs` (`blog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NewsAndBlogSite`.`news_has_news_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`news_has_news_tags` (
  `new_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  PRIMARY KEY (`new_id`, `tag_id`),
  INDEX `fk_news_has_news_tags_news_tags1_idx` (`tag_id` ASC),
  INDEX `fk_news_has_news_tags_news1_idx` (`new_id` ASC),
  CONSTRAINT `fk_news_has_news_tags_news1`
    FOREIGN KEY (`new_id`)
    REFERENCES `NewsAndBlogSite`.`news` (`new_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_news_has_news_tags_news_tags1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `NewsAndBlogSite`.`news_tags` (`news_tags_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NewsAndBlogSite`.`news_has_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`news_has_tags` (
  `news_new_id` INT NOT NULL,
  `tags_blog_tags_id` INT NOT NULL,
  PRIMARY KEY (`news_new_id`, `tags_blog_tags_id`),
  INDEX `fk_news_has_tags1_tags1_idx` (`tags_blog_tags_id` ASC),
  INDEX `fk_news_has_tags1_news1_idx` (`news_new_id` ASC),
  CONSTRAINT `fk_news_has_tags1_news1`
    FOREIGN KEY (`news_new_id`)
    REFERENCES `NewsAndBlogSite`.`news` (`new_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_news_has_tags1_tags1`
    FOREIGN KEY (`tags_blog_tags_id`)
    REFERENCES `NewsAndBlogSite`.`tags` (`blog_tags_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `NewsAndBlogSite`.`blogs_has_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`blogs_has_tags` (
  `blogs_blog_id` INT NOT NULL,
  `tags_blog_tags_id` INT NOT NULL,
  PRIMARY KEY (`blogs_blog_id`, `tags_blog_tags_id`),
  INDEX `fk_blogs_has_tags1_tags1_idx` (`tags_blog_tags_id` ASC),
  INDEX `fk_blogs_has_tags1_blogs1_idx` (`blogs_blog_id` ASC),
  CONSTRAINT `fk_blogs_has_tags1_blogs1`
    FOREIGN KEY (`blogs_blog_id`)
    REFERENCES `NewsAndBlogSite`.`blogs` (`blog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blogs_has_tags1_tags1`
    FOREIGN KEY (`tags_blog_tags_id`)
    REFERENCES `NewsAndBlogSite`.`tags` (`blog_tags_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `NewsAndBlogSite` ;

-- -----------------------------------------------------
-- Placeholder table for view `NewsAndBlogSite`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NewsAndBlogSite`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `NewsAndBlogSite`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `NewsAndBlogSite`.`view1`;
USE `NewsAndBlogSite`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
