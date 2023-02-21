
-- XQuery 1 
-- Selezionare il valore del campo "punti" per tutti i record nella tabella "Classifica" in cui la categoria è "Categoria2":

for $record in /database/table[@name="Classifica"]/record[categoria="Categoria2"]
return $record/punti


-- XQuery 2
-- Selezionare il nome di tutte le gare che hanno avuto almeno 15 partecipanti:

for $gara in /database/table[@name="Gara"]/record[num_partecipanti>=15]
return $gara/nome_gara


-- XQuery 3
-- Selezionare il nome della gara e il nome del team vincitore di ogni gara:

for $gara in /database/table[@name="Gara"]/record,
$classifica in /database/table[@name="Classifica"]/record[id_gara=$gara/id_classifica],
$collocazione in /database/table[@name="Collocazione"]/row[classifica=$classifica/id and posizione=1],
$team in /database/table[@name="Team"]/row[id=$collocazione/team]
return
    <result>
        <gara>{$gara/nome_gara/text()}</gara>
        <team>{$team/nome_team/text()}</team>
    </result>


-- XQuery 4
--  Selezionare la categoria con il maggior numero di punti totali:

let $classifica := /database/table[@name='Classifica']/record
let $categorie := distinct-values($classifica/categoria)
for $categoria in $categorie
let $punti_tot := sum($classifica[categoria=$categoria]/punti)
order by $punti_tot descending
return $categoria[1]


-- XQuery 5
-- Selezionare il nome e la nazione di tutte le squadre partecipanti alla gara con id 3:

for $g in /database/table[@name='Gara']/record[id=3]
return
  for $t in /database/table[@name='Team']/row
  where $t/id = $g/id_classifica
  return <team><nome>{$t/nome_team}</nome><nazione>{$t/nazione}</nazione></team>