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

