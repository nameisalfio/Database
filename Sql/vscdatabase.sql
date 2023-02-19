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


CREATE TRIGGER `performance_insert_trigger` 
AFTER INSERT ON `performance` 
FOR EACH ROW 
BEGIN
    DECLARE punti INT;
    SELECT COUNT(*) INTO punti 
    FROM Performance 
    WHERE gara = NEW.gara AND progressivo <= NEW.progressivo AND id_atleta = NEW.id_atleta;
		UPDATE Classifica 
		SET punti = punti + punti 
		WHERE id = (SELECT id_classifica 
					FROM Gara 
					WHERE id = NEW.gara);
END



CREATE TRIGGER `atleta_delete_trigger` 
BEFORE DELETE ON `Atleta`
FOR EACH ROW
BEGIN
    DECLARE partecipazioni INT;
    SELECT COUNT(*) INTO partecipazioni FROM Performance WHERE id_atleta = OLD.id;
    IF partecipazioni > 0 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Impossibile eliminare l''atleta perché ha partecipato ad almeno una gara';
    END IF;
END



CREATE TRIGGER `team_insert_trigger` 
BEFORE DELETE ON `Team`
FOR EACH ROW
BEGIN
    -- incrementa il contatore di team iscritti alla gara corrente
    UPDATE gara_attuale
    SET num_team_iscritti = num_team_iscritti + 1;
END;


CREATE TRIGGER `coach_update_trigger` 
AFTER UPDATE ON Team
FOR EACH ROW
BEGIN
    -- controlla se il nuovo allenatore allena già un altro team
    DECLARE num_team_allenati INT;
    SELECT COUNT(*) INTO num_team_allenati 
    FROM Team 
    WHERE Coach.id = NEW.Coach.id;
    
    -- se il nuovo allenatore allena meno di due team, aggiorna la tabella degli allenatori
    IF num_team_allenati < 2 THEN
        UPDATE allenatori 
        SET num_team_allenati = num_team_allenati + 1 
        WHERE id = NEW.Coach.id;
    END IF;
END;



CREATE TRIGGER `update_classifica_trigger`
AFTER INSERT ON `Collocazione` FOR EACH ROW
BEGIN
    UPDATE Gara
    SET num_partecipanti = num_partecipanti + 1
    WHERE id = (SELECT id_gara FROM Gara WHERE id_classifica = NEW.classifica);
    
    UPDATE Classifica
    SET punti = (
        SELECT SUM(punti)
        FROM (
            SELECT COUNT(*) AS punti
            FROM Collocazione c
            JOIN Team t ON c.team = t.id
            JOIN Performance p ON t.id = p.id_team AND (SELECT id_gara FROM Gara WHERE id_classifica = c.classifica) = p.gara
            WHERE c.classifica = NEW.classifica AND p.progressivo = 1
            GROUP BY t.id
        ) AS punti_per_team
    )
    WHERE categoria = (SELECT categoria FROM Gara WHERE id_classifica = NEW.classifica)
    AND id_gara = (SELECT id_gara FROM Gara WHERE id_classifica = NEW.classifica);
    
    UPDATE Team
    SET id_coach = (SELECT id_coach FROM Team WHERE id = NEW.team)
    WHERE id = NEW.team;
END;

