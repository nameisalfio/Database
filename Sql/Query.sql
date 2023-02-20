/*
-- Query 1
-- Trovare le location dove non si è mai tenuta una gara della categoria B

SELECT l.id, l.settore, l.team_di_casa, l.città
FROM Location 
WHERE NOT EXISTS (
					SELECT *
                    FROM Gara g
                    WHERE g.id_location = l.id
						AND	g.categoria = 'Categoria B'
				 );
*/

/*
-- Query 2
-- Selezionare il nome della gara, il nome del giudice e il nome della città della location 
-- in cui si è svolta per tutte le gare della categoria C che hanno avuto un giudice con progressivo 2 :

SELECT G.nome, J.contatto, L.città
FROM Gara G
	JOIN Giudice J ON G.id_giudice = J.id
    JOIN Location L ON G.id_location = L.id
WHERE G.categoria = 'Categoria C' 
	AND J.progressivo = 2;
*/

/*
-- Query 3
-- Restituire la città in cui si è svolta la gara con il maggior numero di partecipanti nella categoria "Categoria A" :

SELECT città
FROM Location
WHERE id = (
			SELECT id_location
            FROM Gara
            WHERE categoria = 'Categoria A' 
				AND num_partecipanti = (
										SELECT MAX(num_partecipanti)
                                        FROM Gara
                                        WHERE categoria = 'Categoria A'
                                        )
		   )
*/

/*
-- Query 4
-- Mostra i team di casa delle gare in cui ha partecipato un giudice che ha contato per una gara di categoria A :

SELECT DISTINCT team_di_casa
FROM Location
WHERE id IN (
			SELECT id_location
            FROM Gara
            WHERE id_giudice IN (
								 SELECT id_giudice
                                 FROM Gara
									JOIN Classifica ON Gara.id_classifica = Classifica.id
								WHERE Classifica.categoria = 'Categoria A'
                                )
			);

*/

/*
-- Query 5
-- Seleziona tutte le città che hanno ospitato gare di tutte le categorie esistenti :
    
SELECT L.città
FROM Location L
GROUP BY L.città
HAVING COUNT(DISTINCT(
					  SELECT G.categoria
                      FROM Gara G
                      WHERE G.id_location = L.id
					 )
			 ) = (
                     SELECT COUNT(DISTINCT G.categoria)
                     FROM Gara G
				 );
*/

/*
-- Query 6
-- Selezionare l'atleta che ha preso sempre la valutazione più alta per le proprie performance in tutte le proprie 
-- performance , indicandone anche il nome del team di cui fa parte e il nome del coach che lo allena  :

SELECT A.nome AS nome_atleta, T.nome_team AS nome_team, C.nome AS nome_coach
FROM Atleta A
    JOIN Performance P ON A.id = P.id_atleta
    JOIN Valutazione V ON P.id = V.id_performance
    JOIN (SELECT MAX(punteggio_attribuito) AS max_punteggio, id_performance 
          FROM Valutazione 
          GROUP BY id_performance) AS V2 ON V.punteggio_attribuito = V2.max_punteggio 
                                    AND V.id_performance = V2.id_performance
    JOIN Team T ON A.id_team = T.id
    JOIN Coach C ON T.id_coach = C.id
GROUP BY A.id
HAVING COUNT(*) = (SELECT COUNT(*) 
                   FROM Performance 
                   WHERE id_atleta = A.id);
*/






