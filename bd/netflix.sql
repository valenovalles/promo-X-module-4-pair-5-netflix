-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema netflix
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema netflix
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `netflix` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`promos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`promos` (
  `idtable1` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `year` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtable1`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`alumans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alumans` (
  `idalumans` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `FkPromo` INT NOT NULL,
  PRIMARY KEY (`idalumans`),
  INDEX `fk_alumans_promos_idx` (`FkPromo` ASC) VISIBLE,
  CONSTRAINT `fk_alumans_promos`
    FOREIGN KEY (`FkPromo`)
    REFERENCES `mydb`.`promos` (`idtable1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`profes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`profes` (
  `idprofes` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprofes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`profes_has_promos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`profes_has_promos` (
  `fkProfes` INT NOT NULL,
  `fkPromos` INT NOT NULL,
  `IdPromoProfe` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_profes_has_promos_promos1_idx` (`fkPromos` ASC) VISIBLE,
  INDEX `fk_profes_has_promos_profes1_idx` (`fkProfes` ASC) VISIBLE,
  PRIMARY KEY (`IdPromoProfe`),
  CONSTRAINT `fk_profes_has_promos_profes1`
    FOREIGN KEY (`fkProfes`)
    REFERENCES `mydb`.`profes` (`idprofes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profes_has_promos_promos1`
    FOREIGN KEY (`fkPromos`)
    REFERENCES `mydb`.`promos` (`idtable1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `netflix` ;

-- -----------------------------------------------------
-- Table `netflix`.`actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`actors` (
  `idActor` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `birthday` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idActor`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`movie` (
  `idMovies` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `genre` VARCHAR(45) NOT NULL,
  `image` VARCHAR(1000) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `year` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`idMovies`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`user` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `user` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `plan_details` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE INDEX `user` (`user` ASC) VISIBLE,
  UNIQUE INDEX `email` (`email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`movie_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`movie_has_user` (
  `fkMovies` INT NOT NULL,
  `fkUser` INT NOT NULL,
  `idMovieUser` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_movie_has_user_user1_idx` (`fkUser` ASC) VISIBLE,
  INDEX `fk_movie_has_user_movie_idx` (`fkMovies` ASC) VISIBLE,
  PRIMARY KEY (`idMovieUser`),
  CONSTRAINT `fk_movie_has_user_movie`
    FOREIGN KEY (`fkMovies`)
    REFERENCES `netflix`.`movie` (`idMovies`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_user_user1`
    FOREIGN KEY (`fkUser`)
    REFERENCES `netflix`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `netflix`.`actors_has_movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `netflix`.`actors_has_movie` (
  `fkActors` INT NOT NULL,
  `fkMovie` INT NOT NULL,
  `idActorMovie` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_actors_has_movie_movie1_idx` (`fkMovie` ASC) VISIBLE,
  INDEX `fk_actors_has_movie_actors1_idx` (`fkActors` ASC) VISIBLE,
  PRIMARY KEY (`idActorMovie`),
  CONSTRAINT `fk_actors_has_movie_actors1`
    FOREIGN KEY (`fkActors`)
    REFERENCES `netflix`.`actors` (`idActor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_actors_has_movie_movie1`
    FOREIGN KEY (`fkMovie`)
    REFERENCES `netflix`.`movie` (`idMovies`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SELECT * FROM movie_has_user;
ALTER TABLE  movie_has_user ADD score INT;

SELECT * FROM actors_has_movie;


