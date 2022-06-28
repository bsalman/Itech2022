SELECT kunden.vorname AS 'Vorname',
       kunden.name AS 'Name'
FROM kunden
WHERE kunden.kd_id IN (
    SELECT bestellung.kd_id
    FROM bestellung
    WHERE bestellung.geliefert = '0'
)