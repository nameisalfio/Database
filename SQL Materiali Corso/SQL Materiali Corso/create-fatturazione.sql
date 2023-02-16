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

