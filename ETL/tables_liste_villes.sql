------------------------------------------------+
------------- DICOPAYSVILLE                     |
------------------------------------------------+
-- contient une liste non exhaustive de pays et de ville
EXEC dropTable('DICOPAYSVILLE');
CREATE TABLE DICOPAYSVILLE
(
	CONTINENT VARCHAR2(20),
	PAYS VARCHAR2(20),
	VILLE VARCHAR2(20),
	CONTINENT_EN VARCHAR2(20),
	PAYS_EN VARCHAR2(20),
	VILLE_EN VARCHAR2(20),
	CONSTRAINT PK_DICOPAYSVILLE				PRIMARY KEY(CONTINENT,PAYS,VILLE),
	CONSTRAINT CK_DICOPAYSVILLE_PAYS	CHECK(PAYS = UPPER(PAYS)),
	CONSTRAINT CK_DICOPAYSVILLE_VILLE	CHECK(VILLE = UPPER(VILLE))
);

-- EUROPE 	------------------------------------ EUROPE 	------------------------------------ EUROPE
INSERT INTO DICOPAYSVILLE VALUES ('EUROPE','FRANCE','PARIS',				'EUROPE','FRANCE','PARIS');
INSERT INTO DICOPAYSVILLE VALUES ('EUROPE','ANGLETERRE','LONDRES',	'EUROPE','ENGLAN','LONDON');
INSERT INTO DICOPAYSVILLE VALUES ('EUROPE','ROYAUME-UNI','LONDRES',	'EUROPE','UNITED-KINGDOM','LONDON');
INSERT INTO DICOPAYSVILLE VALUES ('EUROPE','ESPAGNE','MADRID',			'EUROPE','SPAIN','MADRID');
INSERT INTO DICOPAYSVILLE VALUES ('EUROPE','ITALIE','ROME',					'EUROPE','ITALY','ROME');

-- AFRIQUE 	------------------------------------ AFRIQUE 	------------------------------------ AFRIQUE

INSERT INTO DICOPAYSVILLE VALUES ('AFRIQUE','TUNISIE','TUNIS',			'AFRICA','TUNISIA','TUNIS');

-- AMERIQUE ------------------------------------ AMERIQUE 	------------------------------------ AMERIQUE
INSERT INTO DICOPAYSVILLE VALUES ('AMERIQUE','CANADA','TORONTO',			'AMERIQUE','CANADA','TORONTO');

-- ASIE 	------------------------------------ ASIE 		------------------------------------ ASIE
INSERT INTO DICOPAYSVILLE VALUES ('ASIE','CHINE','PEKIN',			'ASIA','China','PEKIN');


-- INDE 	------------------------------------ INDE 		------------------------------------ INDE
