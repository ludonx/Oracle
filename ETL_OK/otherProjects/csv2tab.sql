-- ===================================================
-- From a CSV file TO a TABLE with columns
-- ===================================================
-- MFB

DROP TABLE CSVfile;
CREATE TABLE CSVfile (Col VARCHAR2(1000));

INSERT INTO CSVfile VALUES ('Adam;Paris;M;19;19-06-2001;38°C');
INSERT INTO CSVfile VALUES ('Eve;Paris;F;23;16-10-1996;37°C');
INSERT INTO CSVfile VALUES ('Gabriel;Paris;m;18;17-09-2002;36,5°C');
INSERT INTO CSVfile VALUES ('Mariam;Paris;F;41;13-08-1978;38Celcius');
INSERT INTO CSVfile VALUES ('Nadia;Londres;f;55;10-10-1965;95°F');
INSERT INTO CSVfile VALUES ('In�s;Madrid;F;50;22-11-1969;99,5°F');
INSERT INTO CSVfile VALUES ('Inconnu;77;12-12-2012');
INSERT INTO CSVfile VALUES ('Abnomly;Rome;1;88;02-10-2019;38°C');
INSERT INTO CSVfile VALUES ('Anomalies;Tunis;f;99;25-30-2020;x');
INSERT INTO CSVfile VALUES ('Adam;Paris;M;19;19-06-2001;38°C');
INSERT INTO CSVfile VALUES ('Eve;Paris;F;23;16-10-1996;37°C');




SET TIMING ON;
SET LINES 1000
SET PAGES 1000
COLUMN CATEGORY     FORMAT A10
COLUMN TYPE         FORMAT A10
COLUMN REGULAREXPR	FORMAT A30

------------------------------------------------+
------------- REGULAREXPRES                     |
------------------------------------------------+
-- contient les expresion REGULIERE des différentes categorie de variables

DROP TABLE REGULAREXPRES;
CREATE TABLE REGULAREXPRES
(
CATEGORY	VARCHAR2(50),
TYPE		VARCHAR2(50),
REGULAREXPR	VARCHAR2(200),
CONSTRAINT PK_REGULAREXPRES				PRIMARY KEY(CATEGORY),
CONSTRAINT CK_REGULAREXPRES_CATEGORY	CHECK(CATEGORY = UPPER(CATEGORY))
);
INSERT INTO REGULAREXPRES VALUES ('TEMPERATUREC','NUMBER', '^[0-9]+(,)?[0-9]*(°C|CELCIUS|�C)$');
INSERT INTO REGULAREXPRES VALUES ('TEMPERATUREF','NUMBER', '^[0-9]+(,)?[0-9]*(°F|FAHRENHEIT|�F)$');
INSERT INTO REGULAREXPRES VALUES ('DATE','DATE', '([0-2][0-9]|3[0-1])-(0[0-9]|1[0-2])-[0-9]{4}');
INSERT INTO REGULAREXPRES VALUES ('FIRSTNAME', 'VARCHAR2(50)', '^[[:alpha:] ]+$' );
INSERT INTO REGULAREXPRES VALUES ('CITY','VARCHAR2(50)','^[[:alpha:] ]+$' );
INSERT INTO REGULAREXPRES VALUES ('AGE','NUMBER','^[[:digit:]]+$' );
INSERT INTO REGULAREXPRES VALUES ('GENDER','VARCHAR2(2)','^(M|F)$' );

------------------------------------------------+
------------- DICOPAYSVILLE                     |
------------------------------------------------+
-- contient une liste non exhaustive de pays et de ville
DROP TABLE DICOPAYSVILLE;
CREATE TABLE DICOPAYSVILLE
(
	PAYS VARCHAR2(20),
	VILLE VARCHAR2(20),
	CONSTRAINT PK_DICOPAYSVILLE				PRIMARY KEY(PAYS,VILLE),
	CONSTRAINT CK_DICOPAYSVILLE_PAYS	CHECK(PAYS = UPPER(PAYS)),
	CONSTRAINT CK_DICOPAYSVILLE_VILLE	CHECK(VILLE = UPPER(VILLE))
);

INSERT INTO DICOPAYSVILLE VALUES ('FRANCE','PARIS');
INSERT INTO DICOPAYSVILLE VALUES ('ANGLETERRE','LONDRES');
INSERT INTO DICOPAYSVILLE VALUES ('ESPAGNE','MADRID');
INSERT INTO DICOPAYSVILLE VALUES ('ITALIE','ROME');
INSERT INTO DICOPAYSVILLE VALUES ('TUNISIE','TUNIS');


------------------------------------------------+
------------- DATAPROFILING                     |
------------------------------------------------+
-- contient le Profilage des données pour chaque colonne
DROP TABLE DATAPROFILING;
CREATE TABLE DATAPROFILING
(
	OLDName VARCHAR2(20),
	NEWName VARCHAR2(20),
	M000 NUMBER,
	M100 NUMBER,
	M101 NUMBER,
	M102 NUMBER,
	M103 NUMBER,
	M104 NUMBER,
	M005 NUMBER,
	M106 NUMBER,
	M107 NUMBER,
	M108 NUMBER,
	M109 NUMBER,
	M110 NUMBER,
	M111 VARCHAR2(20),
	M112 NUMBER,
	M113 NUMBER,
	M114 VARCHAR2(20),
	M115 NUMBER,
	M116 NUMBER,

	CONSTRAINT PK_DATAPROFILING				PRIMARY KEY(OLDName)
);

------------------------------------------------+
------------- DEFINITION                        |
------------------------------------------------+
-- contient les definition des variable de Profilage
DROP TABLE DEFINITION;
CREATE TABLE DEFINITION
(
	ID VARCHAR2(20),
	DESCRIPTION VARCHAR2(200),
	CONSTRAINT PK_DEFINITION			PRIMARY KEY(ID)
);
INSERT INTO DEFINITION VALUES ('M000','Number of rows');
INSERT INTO DEFINITION VALUES ('M100','Number of NULL values');
INSERT INTO DEFINITION VALUES ('M101','Number of NOT NULL values');
INSERT INTO DEFINITION VALUES ('M102','min length (characters)');
INSERT INTO DEFINITION VALUES ('M103','MAX LENGTH (characters)');
INSERT INTO DEFINITION VALUES ('M104','Number of worlds');


COMMIT;
