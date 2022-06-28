--=========================================================================
-------------------------Duty Tasks start---------------------------
--=========================================================================
--1) Auswahl aller Zutaten eines Rezeptes nach Rezeptname
SELECT zutaten.zutat_name
FROM (
    zutaten
    INNER JOIN rezepteinhalt
    ON zutaten.zutat_id = rezepteinhalt.zutat_id
)
INNER JOIN rezepten
ON rezepteinhalt.rezept_id = rezepten.rezept_id
WHERE rezepten.rezept_id = '4'

--2)Auswahl aller Rezepte einer bestimmten Ernährungskategorie
SELECT rezepten.rezept_name
FROM rezepten
WHERE rezepten.rezept_id IN (SELECT vegan.rezept_id FROM vegan);

SELECT rezepten.rezept_name
FROM rezepten
WHERE rezepten.rezept_id NOT IN (SELECT vegetarisch.rezept_id FROM vegetarisch);

--3)Auswahl aller Rezepte, die eine gewisse Zutat enthalten
SELECT zutaten.zutat_name, 
       rezepten.rezept_name
FROM (
    zutaten
    INNER JOIN rezepteinhalt
    ON zutaten.zutat_id = rezepteinhalt.zutat_id
)
INNER JOIN rezepten
ON rezepteinhalt.rezept_id = rezepten.rezept_id
WHERE zutaten.zutat_name = 'Bananen'

--4)Berechnung der durchschnittlichen Nährwerte aller Bestellungen eines Kunden
SELECT kunden.vorname AS 'Vorname',
       kunden.name AS 'Name',
       AVG(zutaten.kalorien)
FROM (
    kunden
    INNER JOIN bestellung
    ON kunden.kd_id = bestellung.kd_id
) INNER JOIN (
    rezepten 
    INNER JOIN (
        rezepteinhalt
        INNER JOIN zutaten
        ON rezepteinhalt.zutat_id = zutaten.zutat_id
    ) on rezepten.rezept_id = rezepteinhalt.rezept_id
)  on bestellung.rezept_id = rezepten.rezept_id

--5)Auswahl aller Zutaten, die bisher keinem Rezept zugeordnet sind
SELECT zutaten.zutat_name AS 'Zutat'
FROM zutaten
WHERE zutaten.zutat_id 
NOT IN (SELECT rezepteinhalt.zutat_id FROM rezepteinhalt);
--=========================================================================
-------------------------Duty Tasks end---------------------------
--=========================================================================

--=========================================================================
------------------------ Optionale Tasks Start------------------------------------
--=========================================================================

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
--=========================================================================
------------------------ Optional Tasks ende ------------------------------------
--=========================================================================

--=========================================================================
---------------------------- New Tasks Start------------------------------------
--=========================================================================
                       
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

-- rechnung preis not done
SELECT rezepten.rezept_name,sum(zutaten.netto_preis) AS rezeptPreis
FROM zutaten 
INNER JOIN rezepteinhalt
ON zutaten.zutat_id =rezepteinhalt.zutat_id
INNER JOIN rezepten
ON rezepten.rezept_id =rezepteinhalt.rezept_id
INNER JOIN bestellung
ON bestellung.rezept_id = rezepten.rezept_id
--=========================================================================
----------------------------- New Tasks ende ------------------------------------
--=========================================================================

