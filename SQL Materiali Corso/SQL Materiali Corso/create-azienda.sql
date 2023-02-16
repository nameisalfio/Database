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


	
