DROP DATABASE IF EXISTS `database`;
CREATE DATABASE IF NOT EXISTS `database`;
USE `database`;

CREATE TABLE IF NOT EXISTS `database`.`Location` (
  `id` INT NOT NULL,
  `settore` VARCHAR(15) NULL DEFAULT NULL,
  `team_di_casa` VARCHAR(15) NULL DEFAULT NULL,
  `città` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `database`.`Giudice` (
  `id` INT NOT NULL,
  `progressivo` INT NULL DEFAULT NULL,
  `contatto` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `database`.`Gara` (
  `id` INT NOT NULL,
  `num_partecipanti` BIGINT NULL DEFAULT NULL,
  `nome_gara` VARCHAR(10) NULL DEFAULT NULL,
  `categoria` VARCHAR(15) NULL DEFAULT NULL,
  /*`id_classifica` INT NULL DEFAULT NULL,*/
  `id_giudice` INT NULL DEFAULT NULL,
  `id_location` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  /*CONSTRAINT `id_classifica`
    FOREIGN KEY (`id_classifica`)
    REFERENCES `database`.`Classifica` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,*/
  CONSTRAINT `id_giudice`
    FOREIGN KEY (`id_giudice`)
    REFERENCES `database`.`Giudice` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_location`
    FOREIGN KEY (`id_location`)
    REFERENCES `database`.`Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `database`.`Classifica` (
  `id` INT NOT NULL,
  `categoria` VARCHAR(15) NULL DEFAULT NULL,
  `punti` INT NOT NULL,
  `id_gara` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_gara`
    FOREIGN KEY (`id_gara`)
    REFERENCES `database`.`Gara` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `database`.`Coach` (
  `id` INT NOT NULL,
  `nome` VARCHAR(15) NULL DEFAULT NULL,
  `cognome` VARCHAR(15) NULL DEFAULT NULL,
  `contatto` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `database`.`Team` (
  `id` INT NOT NULL,
  `nome_team` VARCHAR(15) NOT NULL,
  `nazione` VARCHAR(15) NULL DEFAULT NULL,
  `id_coach` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_coach`
    FOREIGN KEY (`id_coach`)
    REFERENCES `database`.`Coach` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `database`.`Atleta` (
  `id` INT NOT NULL,
  `nome` VARCHAR(15) NULL DEFAULT NULL,
  `congome` VARCHAR(15) NULL DEFAULT NULL,
  `sesso` VARCHAR(10) NULL DEFAULT NULL,
  `nazione` VARCHAR(15) NULL DEFAULT NULL,
  `id_team` INT NOT NULL,
  `data_nascita` DATE NULL DEFAULT NULL,
  `tipo_sport` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_team`
    FOREIGN KEY (`id_team`)
    REFERENCES `database`.`Team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `database`.`Performance` (
  `id` INT NOT NULL,
  `gara` INT NULL DEFAULT NULL,
  `progressivo` INT NULL DEFAULT NULL,
  `id_atleta` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_atleta`
    FOREIGN KEY (`id_atleta`)
    REFERENCES `database`.`Atleta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `gara`
    FOREIGN KEY (`gara`)
    REFERENCES `database`.`Gara` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `database`.`Gara` (
  `id` INT NOT NULL,
  `num_partecipanti` BIGINT NULL DEFAULT NULL,
  `nome_gara` VARCHAR(10) NULL DEFAULT NULL,
  `categoria` VARCHAR(15) NULL DEFAULT NULL,
  `id_classifica` INT NULL DEFAULT NULL,
  `id_giudice` INT NULL DEFAULT NULL,
  `id_location` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id_classifica`
    FOREIGN KEY (`id_classifica`)
    REFERENCES `database`.`Classifica` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_giudice`
    FOREIGN KEY (`id_giudice`)
    REFERENCES `database`.`Giudice` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_location`
    FOREIGN KEY (`id_location`)
    REFERENCES `database`.`Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `database`.`Spettatore` (
  `id` INT NOT NULL,
  `nome` VARCHAR(15) NULL DEFAULT NULL,
  `cognome` VARCHAR(15) NULL DEFAULT NULL,
  `contatto` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `database`.`Biglietto` (
  `codice` INT NOT NULL,
  `biglietti_venduti` MEDIUMINT NULL DEFAULT NULL,
  `data_emissione` DATE NULL DEFAULT NULL,
  `settore` VARCHAR(15) NULL DEFAULT NULL,
  `costo` INT NULL DEFAULT NULL,
  `location` INT NULL DEFAULT NULL,
  `id_spettatore` INT NULL DEFAULT NULL,
  PRIMARY KEY (`codice`),
  CONSTRAINT `location`
    FOREIGN KEY (`location`)
    REFERENCES `database`.`Location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_spettatore`
    FOREIGN KEY (`id_spettatore`)
    REFERENCES `database`.`Spettatore` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `database`.`Collocazione` (
  `classifica` INT NOT NULL,
  `team` INT NOT NULL,
  `posizione` INT NOT NULL,
  PRIMARY KEY (`classifica`, `team`),
  CONSTRAINT `team`
    FOREIGN KEY (`team`)
    REFERENCES `database`.`Team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `classifica`
    FOREIGN KEY (`classifica`)
    REFERENCES `database`.`Classifica` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

CREATE TABLE IF NOT EXISTS `database`.`Vautazione` (
  `id_performance` INT NOT NULL,
  `giudice` INT NOT NULL,
  `punteggio_attribuito` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_performance`, `giudice`),
  CONSTRAINT `id_performance`
    FOREIGN KEY (`id_performance`)
    REFERENCES `database`.`Performance` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `giudice`
    FOREIGN KEY (`giudice`)
    REFERENCES `database`.`Giudice` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;