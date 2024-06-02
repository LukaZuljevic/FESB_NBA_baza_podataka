/*Kronološki pregled odigranih utakmica*/
SELECT *
FROM utakmica
ORDER BY datum ASC;

/*Popis svih igrača koji su igrali za određenu momčad tijekom sezone*/
SELECT i.Ime, i.Prezime, m.Ime_Momcad
FROM igrac i
JOIN momcad m ON i.id_momcad = m.id
WHERE m.Ime_Momcad = 'ImeMomcadi'
ORDER BY m.Ime_Momcad;

/*Popis igrača koji su igrali na pojedinoj utakmici*/
SELECT uis.id_utakmica, i.ime, i.prezime
FROM utakmicaigracistatistika uis
JOIN igrac i ON uis.oib_igrac = i.oib
WHERE uis.id_utakmica = 'idUtakmice'
ORDER BY uis.id_utakmica;

/*Izvještaj o rezultatima svih utakmica koja je određena momčad odigrala u pojedinoj fazi natjecanja*/
SELECT m.ime_momcad, um.domaci_gosti, um.broj_koseva, u.rang, u.datum
FROM utakmicamomcad um
JOIN momcad m ON um.id_momcad = m.id
JOIN utakmica u ON um.id_utakmica = u.id
WHERE m.ime_momcad = 'ImeMomcadi' AND u.rang = 'Rang'
ORDER BY u.datum;

/*Izvještaj o ulascima i izlascima igrača na pojedinoj utakmici.*/
SELECT uis.id_utakmica, i.ime, i.prezime, s.tip
FROM utakmicaigracistatistika uis
JOIN igrac i ON uis.oib_igrac = i.oib
JOIN statistika s ON uis.id_statistika = s.id
WHERE (s.tip = 'Ulaz' OR s.tip = 'Izlaz')
	   AND uis.id_utakmica = idUtakmica;


/*Izvještaj o prekršajima suđenim na pojedinoj utakmici*/
SELECT uis.id_utakmica, s.cetvrtina, s.vrijeme_semafor, s.tip
FROM utakmicaigracistatistika uis
JOIN utakmica u ON uis.id_utakmica = u.id
JOIN statistika s ON uis.id_statistika = s.id
WHERE s.tip = 'Prekrsaj' AND uis.id_utakmica = 'idUtakmice';

/*Statistiku učinka određenog igrača na pojedinoj utakmici, gdje učinak uključuje podatke o ukupnom broju postignutih koševa, broju koševa za 1 bod, broju koševa za 2 boda, broju "trica",
postotnoj uspješnosti za svaku navedenu stavku, broju osvojenih lopti, broju skokova te broju prekršaja.*/
SELECT i.ime, i.prezime, COUNT(CASE WHEN s.tip = 'Ulaz' THEN 1 END) AS Ulasci,
						 COUNT(CASE WHEN s.tip = 'Izlaz' THEN 1 END) AS Izlasci,
						 COUNT(CASE WHEN s.tip = 'Slobodno bacanje' THEN 1 END) AS slobodno_bacanje,
						 COUNT(CASE WHEN s.tip = 'Šut za 2' THEN 1 END) AS dva_poena,
						 COUNT(CASE WHEN s.tip = 'Šut za 3' THEN 1 END) AS trica,
						 COUNT(CASE WHEN s.tip = 'Osvojeni skok' THEN 1 END) AS osvojeni_skokovi,
						 COUNT(CASE WHEN s.tip = 'Osvojena lopta' THEN 1 END) AS osvojene_lopte,
						 COUNT(CASE WHEN s.tip = 'Prekrsaj' THEN 1 END) AS prekrsaji
FROM utakmicaigracistatistika uis
JOIN igrac i ON uis.oib_igrac = i.oib
JOIN statistika s ON uis.id_statistika = s.id
WHERE i.ime = 'Ime' AND i.prezime = 'Prezime'
GROUP BY i.ime, i.prezime;

/*Prosječnu statistiku učinka određenog igrača u cijeloj sezoni te ukupno vrijeme koje je proveo u igri.*/
WITH ulasci_izlasci AS(
	SELECT
		uis.oib_igrac,
		uis.id_utakmica,
		s.vrijeme_semafor,
		s.tip,
		LAG(s.vrijeme_semafor) OVER (PARTITION BY uis.oib_igrac, uis.id_utakmica ORDER BY s.vrijeme_semafor) AS prethodno_vrijeme,
		LAG(s.tip) OVER (PARTITION  BY uis.oib_igrac, uis.id_utakmica ORDER BY s.vrijeme_semafor) AS prethodna_akcija,
		LEAD(s.tip) OVER(PARTITION BY uis.oib_igrac, uis.id_utakmica ORDER BY s.vrijeme_semafor) AS sljedeca_akcija
	FROM 
		utakmicaigracistatistika uis
	JOIN 
		statistika s ON uis.id_statistika = s.id
	WHERE
		tip IN ('Ulaz', 'Izlaz')
),
vrijeme_na_terenu AS (
	SELECT
		oib_igrac,
		id_utakmica,
		CASE
			WHEN tip = 'Izlaz' AND prethodna_akcija = 'Ulaz' THEN EXTRACT(EPOCH FROM(vrijeme_semafor - prethodno_vrijeme))
			WHEN tip = 'Izlaz' AND prethodna_akcija IS NULL THEN EXTRACT(EPOCH FROM (vrijeme_semafor - '00:00:00'::interval))
			WHEN tip = 'Ulaz' AND sljedeca_akcija IS NULL THEN 2880 - EXTRACT(EPOCH FROM vrijeme_semafor)
			ELSE 0
		END AS provedeno_vrijeme
	FROM
		ulasci_izlasci
	
)
SELECT
	i.ime, i.prezime,
	ROUND(SUM(vnt.provedeno_vrijeme)/60) AS ukupno_minute
FROM 
	vrijeme_na_terenu vnt
JOIN
	igrac i ON vnt.oib_igrac = i.oib
GROUP BY i.ime, i.prezime;



/*Pregled rezultata svih odigranih utakmica*/
SELECT doma_momcad.ime_momcad AS Domaci, 
		gosti_momcad.ime_momcad AS Gosti,
		domacin.broj_koseva AS Domaci_kosevi,
		gosti.broj_koseva AS Gosti_kosevi
FROM utakmicamomcad domacin
JOIN utakmicamomcad gosti ON domacin.id_utakmica = gosti.id_utakmica
JOIN momcad doma_momcad ON domacin.id_momcad = doma_momcad.id
JOIN momcad gosti_momcad ON gosti.id_momcad = gosti_momcad.id
WHERE
	domacin.domaci_gosti = 'Domaci' AND gosti.domaci_gosti = 'Gosti';


/*Pogled sudaca i utakmicama koji su sudili*/
SELECT sudac, id AS match_id, rang, datum
FROM utakmica
SELECT 
    u.sudac, 
    u.id AS match_id, 
    u.rang, 
    u.datum,
    doma_momcad.ime_momcad AS domaci_tim, 
    gosti_momcad.ime_momcad AS gosti_tim
FROM 
    utakmica u
 JOIN 
    utakmicamomcad domacin ON u.id = domacin.id_utakmica AND domacin.domaci_gosti = 'Domaci'
 JOIN 
    utakmicamomcad gosti ON u.id = gosti.id_utakmica AND gosti.domaci_gosti = 'Gosti'
 JOIN 
    momcad doma_momcad ON domacin.id_momcad = doma_momcad.id
 JOIN 
    momcad gosti_momcad ON gosti.id_momcad = gosti_momcad.id;