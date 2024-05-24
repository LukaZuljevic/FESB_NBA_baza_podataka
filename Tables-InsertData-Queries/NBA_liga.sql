CREATE TABLE Liga(
	id		INTEGER DEFAULT 0 PRIMARY KEY,
	Predsjednik	CHAR(30),
	Trenutni_Prvak	CHAR(30),
	Sjediste	CHAR(30),
	Datum_Osnivanja	TIMESTAMP NOT NULL
);

CREATE TABLE Stadion(
	id		SERIAL PRIMARY KEY,
	Ime_Stadion	CHAR(30),
	Velicina	INTEGER NOT NULL,
	Grad		CHAR(30)	
);


CREATE TABLE Momcad(
	id		SERIAL PRIMARY KEY,
	Ime_Momcad	CHAR(30),
	Grad		CHAR(30),
	Vlasnik		CHAR(30),
	id_Stadion	INTEGER references Stadion(id),
	ID_Lige		INTEGER DEFAULT 0 references Liga(id)
);

CREATE TABLE Trener(
	oib		CHAR(11) PRIMARY KEY,
	Ime		CHAR(30),
	Prezime		CHAR(30),
	Godiste		INTEGER,
	Broj_Titula	INTEGER,
	id_Momcad	INTEGER references Momcad(id)	
);

CREATE TABLE Igrac(
	oib		CHAR(11) PRIMARY KEY,
	Ime		CHAR(30),
	Prezime		CHAR(30),
	Godiste		INTEGER,
	Visina		INTEGER,
	Tezina		INTEGER,
	Pozicija	INTEGER,
	Br_Dres		INTEGER,
	id_Momcad	INTEGER references Momcad(id)
);

CREATE TABLE Utakmica(
	id			SERIAL PRIMARY KEY,
	Rang		CHAR(20),
	Sudac		CHAR(30),
	Datum		TIMESTAMP NOT NULL 
);

CREATE TABLE Statistika(
    id SERIAL PRIMARY KEY,
    Cetvrtina char(2),
	Vrijeme_Semafor char(10),
	Tip		 CHAR(30)
);

CREATE TABLE UtakmicaMomcad(
    id_Utakmica INTEGER references Utakmica(id),
    id_Momcad INTEGER references Momcad(id),
    Domaci_Gosti char(10),
    Broj_koseva INTEGER,
    PRIMARY KEY(id_Utakmica, id_Momcad)
);

CREATE TABLE UtakmicaIgraciStatistika(
    id_Utakmica INTEGER references Utakmica(id),
    OIB_igrac char(11) references Igrac(oib),
    id_statistika INTEGER references Statistika(id),
    PRIMARY KEY	(id_Utakmica, OIB_Igrac, id_statistika)
);


