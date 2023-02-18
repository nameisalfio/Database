-- MySQL Workbench Synchronization
-- Generated: 2023-02-18 16:25
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: alfio

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER SCHEMA `mydb`  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci ;

CREATE TABLE IF NOT EXISTS `mydb`.`Classifica` (
  `id` INT(11) NOT NULL,
  `categoria` VARCHAR(15) NULL DEFAULT NULL,
  `punti` INT(11) NOT NULL,
  `id_gara` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_gara`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Gara` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Team` (
  `id` INT(11) NOT NULL,
  `nome_team` VARCHAR(15) NOT NULL,
  `nazione` VARCHAR(15) NULL DEFAULT NULL,
  `id_coach` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_coach`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Coach` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Coach` (
  `id` INT(11) NOT NULL,
  `nome` VARCHAR(15) NULL DEFAULT NULL,
  `cognome` VARCHAR(15) NULL DEFAULT NULL,
  `contatto` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Atleta` (
  `id` INT(11) NOT NULL,
  `nome` VARCHAR(15) NULL DEFAULT NULL,
  `congome` VARCHAR(15) NULL DEFAULT NULL,
  `sesso` VARCHAR(10) NULL DEFAULT NULL,
  `nazione` VARCHAR(15) NULL DEFAULT NULL,
  `id_team` INT(11) NOT NULL,
  `data_nascita` DATE NULL DEFAULT NULL,
  `tipo_sport` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_team`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Team` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Performance` (
  `id` INT(11) NOT NULL,
  `id_gara` INT(11) NULL DEFAULT NULL,
  `progressivo` INT(11) NULL DEFAULT NULL,
  `id_atleta` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_atleta`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Atleta` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_gara`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Gara` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Giudice` (
  `id` INT(11) NOT NULL,
  `progressivo` INT(11) NULL DEFAULT NULL,
  `contatto` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Gara` (
  `id` INT(11) NOT NULL,
  `num_partecipanti` BIGINT(20) NULL DEFAULT NULL,
  `nome_gara` VARCHAR(10) NULL DEFAULT NULL,
  `categoria` VARCHAR(15) NULL DEFAULT NULL,
  `id_classifica` INT(11) NULL DEFAULT NULL,
  `id_giudice` INT(11) NULL DEFAULT NULL,
  `id_location` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_classifica`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Classifica` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_giudice`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Giudice` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_location`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Location` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Location` (
  `id` INT(11) NOT NULL,
  `settore` VARCHAR(15) NULL DEFAULT NULL,
  `team_di_casa` VARCHAR(15) NULL DEFAULT NULL,
  `città` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Biglietto` (
  `codice` INT(11) NOT NULL,
  `biglietti_venduti` MEDIUMINT(9) NULL DEFAULT NULL,
  `data_emissione` DATE NULL DEFAULT NULL,
  `settore` VARCHAR(15) NULL DEFAULT NULL,
  `costo` INT(11) NULL DEFAULT NULL,
  `id_location` INT(11) NULL DEFAULT NULL,
  `id_spettatore` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`codice`),
  CONSTRAINT `id_location`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Location` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_spettatore`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Spettatore` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Spettatore` (
  `id` INT(11) NOT NULL,
  `nome` VARCHAR(15) NULL DEFAULT NULL,
  `cognome` VARCHAR(15) NULL DEFAULT NULL,
  `contatto` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Collocazione` (
  `id_classifica` INT(11) NOT NULL,
  `id_team` INT(11) NOT NULL,
  `posizione` INT(11) NOT NULL,
  PRIMARY KEY (`id_classifica`, `id_team`),
  CONSTRAINT `id_team`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Team` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_classifica`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Classifica` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Vautazione` (
  `id_performance` INT(11) NOT NULL,
  `id_giudice` INT(11) NOT NULL,
  `punteggio_attribuito` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_performance`, `id_giudice`),
  CONSTRAINT `id_performance`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Performance` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_giudice`
    FOREIGN KEY ()
    REFERENCES `mydb`.`Giudice` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
