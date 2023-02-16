DROP DATABASE IF EXISTS `azienda`;
CREATE DATABASE IF NOT EXISTS `azienda`;
USE `azienda`;


CREATE TABLE IF NOT EXISTS `uffici` (
  `id_ufficio` int NOT NULL,
  `indirizzo` varchar(50) NOT NULL,
  `citta` varchar(50) NOT NULL,
  `provincia` varchar(50) NOT NULL,
  PRIMARY KEY (`id_ufficio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `uffici` (`id_ufficio`, `indirizzo`, `citta`, `provincia`) VALUES
	(1, 'via Roma 11', 'Cagliari', 'CA'),
	(2, 'piazza Navona 5', 'Roma', 'RO'),
	(3, 'via Firenze 23', 'Bari', 'BA'),
	(4, 'piazza del Carmine 6', 'Cagliari', 'CA'),
	(5, 'piazza Maggiore 1', 'Bologna', 'BO'),
	(6, 'via Cesare 27', 'Siena', 'SI'),
	(7, 'via Borsellino 100', 'Palermo', 'PA'),
	(8, 'via Battisti 12', 'Roma', 'RO'),
	(9, 'via Scalfaro 7', 'Catanzaro', 'CZ'),
	(10, 'via Vevey 5', 'Aosta', 'AO');
	
CREATE TABLE IF NOT EXISTS `impiegati` (
  `id_impiegato` int NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `mansione` varchar(50) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `salario` int NOT NULL,
  `id_responsabile` int DEFAULT NULL,
  `id_ufficio` int NOT NULL,
  PRIMARY KEY (`id_impiegato`),
  KEY `fk_employees_offices_idx` (`id_ufficio`),
  KEY `fk_employees_employees_idx` (`id_responsabile`),
  CONSTRAINT `fk_employees_managers` FOREIGN KEY (`id_responsabile`) REFERENCES `impiegati` (`id_impiegato`),
  CONSTRAINT `fk_employees_offices` FOREIGN KEY (`id_ufficio`) REFERENCES `uffici` (`id_ufficio`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `impiegati` (`id_impiegato`, `cognome`, `mansione`, `nome`, `salario`, `id_responsabile`, `id_ufficio`) VALUES
	(37270, 'Magagna', 'Anestesista', 'Jolanda', 36996, NULL, 10),
	(33391, 'Norcini', 'Infermiere', 'Dario', 35871, 37270, 1),
	(37851, 'Mattarella', 'Professore universitario', 'Sara', 71926, 37270, 1),
	(40448, 'Crialesi', 'Nomade digitale', 'Mirko', 67860, 37270, 1),
	(56274, 'Alfonsi', 'Responsabile amministrativo', 'Karim', 83150, 37270, 1),
	(63196, 'Scuteri', 'Stagista', 'Alberto', 5179, 37270, 2),
	(67009, 'de Rossi', 'Dirigente sanitario', 'Norberto', 87257, 37270, 2),
	(67370, 'Rossi', 'Dirigente amministrativo', 'Elody', 69767, 37270, 2),
	(68249, 'Verdi', 'Programmatore junior', 'Nicola', 25832, 37270, 2),
	(72540, 'Iannone', 'Amministratore delegato', 'Guglielmo', 90690, 37270, 3),
	(72913, 'Conte', 'Sistemista', 'Cassandra', 69401, 37270, 3),
	(75900, 'Giuva', 'Farmacista', 'Vincenzo', 27578, 37270, 3),
	(76196, 'Jacazio', 'Calciatore Serie B', 'Mariella', 92241, 37270, 3),
	(80529, 'Aronne', 'Archeologo', 'Lidia', 50182, 37270, 4),
	(80679, 'Sordi', 'Medico', 'Milena', 40987, 37270, 4),
	(84791, 'Tarabelli', 'Geologo', 'Alessandro', 66760, 37270, 4),
	(95213, 'Cherubini', 'Operaio specializzato', 'Claudio', 59119, 37270, 4),
	(96513, 'Bianchi', 'Commesso', 'Thomas', 20354, 37270, 5),
	(98374, 'Dalai', 'Impiegato', 'Ester', 43187, 37270, 5),
	(115357, 'Fumagalli', 'Responsabile vendite', 'Ivano', 65710, 37270, 5);


	
DROP DATABASE IF EXISTS `fatturazione`;
CREATE DATABASE IF NOT EXISTS `fatturazione`;
USE `fatturazione`;

CREATE TABLE IF NOT EXISTS `clienti` (
  `id_cliente` int NOT NULL,
  `nome` varchar(50)  NOT NULL,
  `indirizzo` varchar(50)  NOT NULL,
  `citta` varchar(50)  NOT NULL,
  `provincia` char(2)  NOT NULL,
  `telefono` varchar(50)  DEFAULT NULL,
  PRIMARY KEY (`id_cliente`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `clienti` (`id_cliente`, `nome`, `indirizzo`, `citta`, `provincia`, `telefono`) VALUES
	(1, 'Vinobello', 'via Giglio 3', 'Velletri', 'RO', '340-986-5581'),
	(2, 'Motorworld', 'corso Buenos Aires 5', 'Milano', 'MI', '335-448-9622'),
	(3, 'YogaAcademy', 'via Vittorio Emanuele 5', 'Torino', 'TO', '331-158-9999'),
	(4, 'Krm', 'via Dante 20', 'Firenze', 'FI', '358-569-9874'),
	(5, 'Tutto1euro', 'via Cagliari 6', 'Potenza', 'PZ', '349-558-9641');


CREATE TABLE IF NOT EXISTS `fatture` (
  `id_fattura` int NOT NULL,
  `numero` varchar(50)  NOT NULL,
  `id_cliente` int NOT NULL,
  `totale_fattura` decimal(9,2) NOT NULL,
  `totale_pagamento` decimal(9,2) NOT NULL DEFAULT '0.00',
  `data_fattura` date NOT NULL,
  `data_scadenza` date NOT NULL,
  `data_pagamento` date DEFAULT NULL,
  PRIMARY KEY (`id_fattura`) ,
  KEY `FK_client_id` (`id_cliente`) ,
  CONSTRAINT `FK_client_id` FOREIGN KEY (`id_cliente`) REFERENCES `clienti` (`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `fatture` (`id_fattura`, `numero`, `id_cliente`, `totale_fattura`, `totale_pagamento`, `data_fattura`, `data_scadenza`, `data_pagamento`) VALUES
	(1, 'web-10000', 2, 138.79, 0.00, '2019-03-19', '2019-04-08', NULL),
	(2, 'web-10001', 5, 212.32, 45.18, '2019-06-21', '2019-07-11', '2019-02-22'),
	(3, 'web-10002', 5, 184.99, 0.00, '2019-08-10', '2019-08-30', NULL),
	(4, 'web-10003', 3, 189.21, 0.00, '2019-03-18', '2019-04-07', NULL),
	(5, 'web-10004', 5, 206.36, 0.00, '2019-07-28', '2019-08-17', NULL),
	(6, 'web-10005', 1, 194.78, 111.55, '2019-02-08', '2019-02-28', '2019-01-13'),
	(7, 'web-10006', 3, 170.87, 0.00, '2019-09-14', '2019-10-04', NULL),
	(8, 'store-00001', 1, 226.12, 0.00, '2019-05-30', '2019-06-19', NULL),
	(9, 'web-10008', 5, 209.17, 0.00, '2019-07-19', '2019-08-08', NULL),
	(10, 'web-10009', 1, 196.50, 0.00, '2019-07-10', '2019-07-30', NULL),
	(11, 'web-10010', 3, 163.15, 37.03, '2019-01-17', '2019-02-06', '2019-01-21'),
	(13, 'web-10011', 5, 172.01, 124.44, '2019-07-05', '2019-07-25', '2019-02-05'),
	(15, 'web-10012', 3, 204.29, 117.31, '2019-12-05', '2019-12-25', '2019-01-25'),
	(16, 'store-00002', 1, 199.02, 0.00, '2019-04-09', '2019-04-29', NULL),
	(17, 'web-10014', 3, 163.38, 105.10, '2019-08-09', '2019-08-29', '2019-01-25'),
	(18, 'web-10015', 5, 217.17, 79.77, '2019-06-02', '2019-06-22', '2019-01-18'),
	(19, 'web-10016', 1, 171.47, 0.00, '2019-12-03', '2019-12-23', NULL);


CREATE TABLE IF NOT EXISTS `metodi_pagamento` (
  `id_metodo_pagamento` tinyint NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(50)  NOT NULL,
  PRIMARY KEY (`id_metodo_pagamento`) 
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `metodi_pagamento` (`id_metodo_pagamento`, `descrizione`) VALUES
	(1, 'Carta di Credito'),
	(2, 'Contanti'),
	(3, 'PayPal'),
	(4, 'Bonifico');


CREATE TABLE IF NOT EXISTS `pagamenti` (
  `id_pagamento` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_fattura` int NOT NULL,
  `data` date NOT NULL,
  `importo` decimal(9,2) NOT NULL,
  `metodo_pagamento` tinyint NOT NULL,
  PRIMARY KEY (`id_pagamento`) ,
  KEY `fk_client_id_idx` (`id_cliente`) ,
  KEY `fk_invoice_id_idx` (`id_fattura`) ,
  KEY `fk_payment_payment_method_idx` (`metodo_pagamento`) ,
  CONSTRAINT `fk_payment_client` FOREIGN KEY (`id_cliente`) REFERENCES `clienti` (`id_cliente`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_invoice` FOREIGN KEY (`id_fattura`) REFERENCES `fatture` (`id_fattura`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_payment_method` FOREIGN KEY (`metodo_pagamento`) REFERENCES `metodi_pagamento` (`id_metodo_pagamento`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO `pagamenti` (`id_pagamento`, `id_cliente`, `id_fattura`, `data`, `importo`, `metodo_pagamento`) VALUES
	(1, 5, 2, '2019-02-22', 45.18, 1),
	(2, 1, 6, '2019-01-13', 111.55, 1),
	(3, 3, 11, '2019-01-21', 37.03, 1),
	(4, 5, 13, '2019-02-05', 124.44, 1),
	(5, 3, 15, '2019-01-25', 117.31, 1),
	(6, 3, 17, '2019-01-25', 105.10, 1),
	(7, 5, 18, '2019-01-18', 69.77, 1),
	(8, 5, 18, '2019-01-18', 10.00, 2);


DROP DATABASE IF EXISTS `magazzino`;
CREATE DATABASE IF NOT EXISTS `magazzino`;
USE `magazzino`;

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