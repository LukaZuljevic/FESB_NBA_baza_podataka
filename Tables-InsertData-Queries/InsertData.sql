INSERT INTO Liga
Values
('1', 'Adam Silver', 'Denver Nuggets', 'New York', '1946-06-06');

INSERT INTO Stadion(Ime_Stadion, Velicina, Grad)
Values
('Ball Arena', 18000, 'Denver'),
('Staples Center', 20000, 'Los Angeles'),
('333Ball Arena', 18000, 'Denver'),
('444Staples Center', 20000, 'Los Angeles'),
('Dallas Maverick Arena', 23000, 'Dallas');


INSERT INTO Momcad(Ime_Momcad, Grad, Vlasnik, id_Stadion, ID_Lige)
Values
('Denver Nuggets', 'Denver', 'Ante', 1, 1),
('Los Angeles Lakers', 'LA', 'Marko', 2, 1),
('Los Angeles Clippers', 'LA', 'Luka', 2, 1),
('Boston Celtics', 'Boston', 'Mate', 3, 1),
('Golden State Wariors', 'San Francisco', 'Mile', 4, 1),
('Dallas Mavericks', 'Dallas', 'Mark CUban', 5, 1);

INSERT INTO Igrac(oib, Ime, Prezime, Godiste, Visina, Tezina, Pozicija, Br_Dres, id_Momcad)
Values

('1234567891','Luka', 'Doncic', 1998, 210, 110, 3, 10, 5),
('1334567891','Nikola', 'Jokic', 1995, 215, 125, 1, 16, 1),
('12344567891','Jamal', 'Murray', 1992, 200, 112, 2, 17, 1),
('12345567891','Lebron', 'James', 1985, 208, 115, 4, 23, 2);

INSERT INTO Trener(oib, Ime, Prezime, Godiste, Broj_Titula, id_Momcad)
Values

('1234567892','Michael', 'Malone', 1971, 1, 1),
('1234567893','Joe', 'Mazzulla', 1988, 0, 3),
('1234567894','Darwin', 'Ham', 1973, 1, 2),
('1234567895','Jason', 'Kid', 1973, 1, 5);

INSERT INTO Utakmica(Rang, Sudac, Datum)
Values

('Cetvrtfinale', 'Jason Ant', '2024-5-24'),
('Istocna divizija', 'Mate Matic', '2024-3-20'),
('Zapadna divizija', 'Jason Ant', '2024-2-10'),
('Polufinale', 'Stipe Stipic', '2024-6-2'),
('Cetvrtfinale', 'Marko Markic', '2024-5-22');

INSERT INTO Statistika(Cetvrtina,Vrijeme_Semafor, Tip)
Values 

('1.', '10:08', 'Šut za 3'),
('2.', '00:03', 'Slobodno bacanje'),
('3.', '7:02', 'Ulaz u igru');



INSERT INTO UtakmicaMomcad(id_Utakmica, id_Momcad, Domaci_Gosti, Broj_koseva)
Values 

(1, 1, 'Domaci', 110),
(1, 5, 'Gosti', 99),
(2, 2, 'Domaci', 120),
(2, 3, 'Gosti', 132);
(3, 2, 'Domaci', 143),
(3, 5, 'Gosti', 123),
(4, 3, 'Domaci', 110),
(4, 4, 'Gosti', 89),
(5, 4, 'Domaci', 90),
(5, 1, 'Gosti', 99);


INSERT INTO UtakmicaIgraciStatistika(id_Utakmica, OIB_Igrac, id_statistika)
Values

(1, '1234567891', 1),
(1, '1234567891', 2),
(1, '1234567891', 3);