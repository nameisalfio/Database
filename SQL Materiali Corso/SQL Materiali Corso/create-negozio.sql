DROP DATABASE IF EXISTS `negozio`;
CREATE DATABASE IF NOT EXISTS `negozio`;
USE `negozio`;

CREATE TABLE IF NOT EXISTS `clienti` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `data_nascita` date DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `indirizzo` varchar(50) NOT NULL,
  `citta` varchar(50) NOT NULL,
  `provincia` char(2) NOT NULL,
  `punti` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_cliente`) 
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `clienti` (`id_cliente`, `nome`, `cognome`, `data_nascita`, `telefono`, `indirizzo`, `citta`, `provincia`, `punti`) VALUES
	(1, 'Battista', 'Maccari', '1989-03-13', '340-986-5581', 'Via Mercalli 1', 'Mantova', 'MN', 19646),
	(2, 'Innocenzo', 'Bruschetta', '1989-03-28', '335-448-9622', 'Via Roma 99', 'Bitonto', 'BA', 18320),
	(3, 'Frederico', 'Bormizzi', '1988-01-23', '331-158-9999', 'Viale Fiorito 18', 'Chiusi', 'SI', 20340),
	(4, 'Amelia', 'Rosario', '1977-03-29', '358-569-9874', 'Strada Statale 99, km 55', 'Ferrara', 'FE', 17830),
	(5, 'Clementino', 'Bettecchi', '1976-10-22', NULL, 'Via Viali Viola, 55', 'Sassari', 'SS', 21048),
	(6, 'Elena', 'Tosi', '1994-08-19', '349-558-9641', 'Via Fasulla, 123', 'Trento', 'TN', 20446),
	(7, 'Ilenia', 'Dorsy', '1967-08-15', '331-198-5555', 'Viale Mercato, 1000', 'Borgia', 'CZ', 19045),
	(8, 'Thor', 'Norreno', '1996-07-01', '340-695-5334', 'Via Martiri 589', 'Bassano del Grappa', 'VI', 17578),
	(9, 'Romualdo', 'Russo', '1995-05-08', '340-234-6335', 'Viale Volta 1001', 'Potenza', 'PZ', 18859),
	(10, 'Levante', 'Mattei', '1972-09-27', '340-990-0938', 'Vico Quarto 50', 'Pompiod', 'AO', 18169);


CREATE TABLE IF NOT EXISTS `corrieri` (
  `id_corriere` smallint NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`id_corriere`) 
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `corrieri` (`id_corriere`, `nome`) VALUES
	(1, 'Bartolini'),
	(2, 'SDA'),
	(3, 'Poste Italiane'),
	(4, 'UPS'),
	(5, 'GLS');

CREATE TABLE IF NOT EXISTS `prodotti` (
  `id_prodotto` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `quantita_disponibile` int NOT NULL,
  `prezzo` decimal(4,2) NOT NULL,
  PRIMARY KEY (`id_prodotto`) 
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `prodotti` (`id_prodotto`, `nome`, `quantita_disponibile`, `prezzo`) VALUES
	(1, 'Yogurt Greco Bianco', 80, 1.94),
	(2, 'Tonno - Naturale, Pinna Gialla', 59, 5.38),
	(3, 'Pomodoro - Grappolo, Maturo', 48, 4.08),
	(4, 'Maiale - Salsiccia, Secca', 100, 5.26),
	(5, 'Salsa - Messicana', 104, 2.36),
	(6, 'Quaderno Righe', 24, 3.12),
	(7, 'Ceci In Scatola', 108, 4.02),
	(8, 'Gocciole - Biscotti', 36, 1.47),
	(9, 'Patate', 77, 2.99),
	(10, 'Matita - Gomma', 16, 1.82);


CREATE TABLE IF NOT EXISTS `stati_ordine` (
  `id_stato_ordine` tinyint NOT NULL,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`id_stato_ordine`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `stati_ordine` (`id_stato_ordine`, `nome`) VALUES
	(1, 'Processato'),
	(2, 'Spedito'),
	(3, 'Consegnato');

CREATE TABLE IF NOT EXISTS `ordini` (
  `id_ordine` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `data_ordine` date NOT NULL,
  `stato` tinyint NOT NULL DEFAULT '1',
  `commenti` varchar(2000) DEFAULT NULL,
  `data_consegna` date DEFAULT NULL,
  `id_corriere` smallint DEFAULT NULL,
  PRIMARY KEY (`id_ordine`) ,
  KEY `fk_orders_customers_idx` (`id_cliente`) ,
  KEY `fk_orders_shippers_idx` (`id_corriere`) ,
  KEY `fk_orders_order_statuses_idx` (`stato`) ,
  CONSTRAINT `fk_orders_customers` FOREIGN KEY (`id_cliente`) REFERENCES `clienti` (`id_cliente`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_order_statuses` FOREIGN KEY (`stato`) REFERENCES `stati_ordine` (`id_stato_ordine`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_shippers` FOREIGN KEY (`id_corriere`) REFERENCES `corrieri` (`id_corriere`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `ordini` (`id_ordine`, `id_cliente`, `data_ordine`, `stato`, `commenti`, `data_consegna`, `id_corriere`) VALUES
	(1, 6, '2019-02-19', 1, NULL, NULL, NULL),
	(2, 7, '2018-08-22', 2, NULL, '2018-08-23', 4),
	(3, 8, '2017-12-21', 1, NULL, NULL, NULL),
	(4, 2, '2017-02-11', 1, NULL, NULL, NULL),
	(5, 5, '2017-09-14', 2, '', '2017-09-15', 3),
	(6, 10, '2018-12-08', 1, 'Lorem ipsum', NULL, NULL),
	(7, 2, '2018-10-12', 2, NULL, '2018-10-13', 4),
	(8, 5, '2018-06-28', 1, 'Excepteur sint occaecat cupidatat non proident', NULL, NULL),
	(9, 10, '2017-07-25', 2, 'Ut enim ad minim veniam', '2017-07-26', 1),
	(10, 6, '2018-05-12', 2, NULL, '2018-05-13', 2);
	
CREATE TABLE IF NOT EXISTS `dettagli_ordine` (
  `id_ordine` int NOT NULL AUTO_INCREMENT,
  `id_prodotto` int NOT NULL,
  `quantita` int NOT NULL,
  `prezzo` decimal(4,2) NOT NULL,
  PRIMARY KEY (`id_ordine`,`id_prodotto`) ,
  KEY `fk_order_items_products_idx` (`id_prodotto`) ,
  CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`id_ordine`) REFERENCES `ordini` (`id_ordine`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id_prodotto`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `dettagli_ordine` (`id_ordine`, `id_prodotto`, `quantita`, `prezzo`) VALUES
	(1, 4, 9, 4.47),
	(2, 1, 7, 9.83),
	(2, 4, 9, 2.39),
	(2, 6, 7, 3.67),
	(3, 3, 15, 9.85),
	(4, 3, 12, 7.72),
	(4, 10, 12, 7.13),
	(5, 2, 8, 10.62),
	(6, 1, 9, 9.38),
	(6, 2, 9, 4.01),
	(6, 3, 9, 8.19),
	(6, 5, 6, 4.18),
	(7, 3, 12, 9.90),
	(8, 5, 7, 7.67),
	(8, 8, 7, 9.32),
	(9, 6, 10, 8.01),
	(10, 1, 15, 6.74),
	(10, 9, 14, 5.01);
    
DROP TABLE IF EXISTS `dettaglio_ordine_note`;
CREATE TABLE IF NOT EXISTS `dettaglio_ordine_note` (
  `id_nota` int NOT NULL AUTO_INCREMENT,
  `id_ordine` int DEFAULT NULL,
  `id_prodotto` int DEFAULT NULL,
  `nota` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_nota`),
  KEY `FK_dettaglio_ordine_note_ordini` (`id_ordine`),
  KEY `FK_dettaglio_ordine_note_prodotti` (`id_prodotto`),
  CONSTRAINT `FK_dettaglio_ordine_note_ordini` FOREIGN KEY (`id_ordine`) REFERENCES `ordini` (`id_ordine`) ON UPDATE CASCADE,
  CONSTRAINT `FK_dettaglio_ordine_note_prodotti` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id_prodotto`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `dettaglio_ordine_note` (`id_nota`, `id_ordine`, `id_prodotto`, `nota`) VALUES
	(1, 2, 1, 'Prima nota'),
	(2, 2, 1, 'Seconda nota');