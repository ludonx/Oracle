------------------------------------------------+
------------- DATAREPORT   For the table        |
------------------------------------------------+
-- contient le Profilage des données pour chaque colonne
DROP TABLE DATAREPORT;
CREATE TABLE DATAREPORT
(
  CSVName VARCHAR2(100),
	OLDName VARCHAR2(100),
	NEWName VARCHAR2(100),
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

	CONSTRAINT PK_DATAREPORT				PRIMARY KEY(CSVName,OLDName)
);

------------------------------------------------+
------------- DEFINITION  FOR DATAREPORT        |
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


------------------------------------------------+
------------- DATAREPORT by colonnes            |
------------------------------------------------+

--CREATE TABLE DR_CSVFile_Col
CREATE TABLE DATAREPORTBYCOL
(
CVSName VARCHAR2(100),
OLDVALUES VARCHAR2(100),
SYNTACTICTYPE VARCHAR2(100),
COLUMNWIDHT NUMBER,
NUMBEROFWORDS NUMBER,
OBSERVATION VARCHAR2(100),
NEWVALUES VARCHAR2(100),
SEMANTICCATEGORY VARCHAR2(100),
SEMANTICSUBCATEGORY VARCHAR2(100),
);




COMMIT;
