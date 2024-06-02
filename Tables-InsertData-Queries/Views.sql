/*pogled koji daje uvid Nikolu Jokica*/
CREATE VIEW Nikola_Jokic AS
SELECT * 
FROM Igrac
WHERE Ime='Nikola' AND Prezime='Jokic'

/*pogled koji daje uvid u utakmice odigrane u 2024. godini u 5. mjesecu*/
CREATE VIEW Utakmice_2024 AS
SELECT *
FROM utakmica
WHERE EXTRACT(YEAR FROM datum) = 2024 AND EXTRACT(MONTH FROM datum) = 5;