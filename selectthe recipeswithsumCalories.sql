-- optional für FiSi und ITSE bzw. verpflichtend für FIAE und FIDP:

-- Auswahl aller Rezepte, die eine bestimmte Kalorienmenge nicht überschreiten 
SELECT rezepten.rezept_name,SUM(zutaten.kalorien * rezepteinhalt.menge) AS Kalorien
FROM zutaten
INNER JOIN rezepteinhalt ON zutaten.zutat_id = rezepteinhalt.zutat_id
INNER JOIN rezepten
ON rezepteinhalt.rezept_id =rezepten.rezept_id
GROUP BY rezepten.rezept_name 
HAVING SUM(zutaten.kalorien * rezepteinhalt.menge)<=100;

--Auswahl aller Rezepte, die weniger als fünf Zutaten enthalten
SELECT  rezepten.rezept_name, COUNT(rezepteinhalt.zutat_id) As ZutatenNum 
FROM rezepteinhalt
INNER JOIN rezepten
ON rezepteinhalt.rezept_id = rezepten.rezept_id
GROUP BY rezepten.rezept_name 
HAVING COUNT(rezepteinhalt.zutat_id)<3;

--Auswahl aller Rezepte, die weniger als fünf Zutaten enthalten und eine bestimmte Ernährungskategorie erfüllen
SELECT  rezepten.rezept_name, COUNT(rezepteinhalt.zutat_id) As ZutatenNum 
FROM rezepteinhalt
INNER JOIN rezepten
ON rezepteinhalt.rezept_id = rezepten.rezept_id

INNER JOIN vegetarisch
ON vegetarisch.rezept_id = rezepten.rezept_id  
GROUP BY rezepten.rezept_name
HAVING COUNT(rezepteinhalt.zutat_id)<3;

                        --neu start --
-- Auswahl aller rezepten die der Kunde at bestellt in bestimmten Datum 
SELECT rezepten.rezept_name,bestellung.bestellungs_datum
FROM rezepten
INNER JOIN bestellung
ON rezepten.rezept_id = bestellung.rezept_id
WHERE rezepten.rezept_id = ANY
   (SELECT bestellung.rezept_id
  	FROM bestellung
    WHERE kd_id = 1 
    AND bestellung.bestellungs_datum = '2022-06-24' );

-- rechnung preis
SELECT rezepten.rezept_name,sum(zutaten.netto_preis) AS rezeptPreis
FROM zutaten 
INNER JOIN rezepteinhalt
ON zutaten.zutat_id =rezepteinhalt.zutat_id
INNER JOIN rezepten
ON rezepten.rezept_id =rezepteinhalt.rezept_id
INNER JOIN bestellung
ON bestellung.rezept_id = rezepten.rezept_id
