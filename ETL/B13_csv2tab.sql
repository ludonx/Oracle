

------------------------------------------------+
------------- dropTable                      |
------------------------------------------------+
-- permet de supprimer une table sans générer d'erreur si elle n'existe pas
CREATE OR REPLACE PROCEDURE dropTable (LaTable in VARCHAR2) AS
  BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE '||LaTable;
  EXCEPTION
      WHEN OTHERS THEN NULL;
  END;
  /
-- ===================================================
-- From a CSV file TO a TABLE with columns
-- ===================================================
-- MFB

EXEC dropTable('CSVfile');
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
EXEC dropTable('REGULAREXPRES');
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
EXEC dropTable('DICOPAYSVILLE');
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
------------- DATAREPORT by colonnes            |
------------------------------------------------+

--CREATE TABLE DR_CSVFile_Col
exec dropTable('DATAREPORTBYCOL');
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
SEMANTICSUBCATEGORY VARCHAR2(100)
);


COLUMN CVSName FORMAT A15
COLUMN OLDVALUES FORMAT A15
COLUMN SYNTACTICTYPE FORMAT A15
COLUMN COLUMNWIDHT FORMAT 999
COLUMN NUMBEROFWORDS FORMAT 999
COLUMN OBSERVATION FORMAT A15
COLUMN NEWVALUES FORMAT A15
COLUMN SEMANTICCATEGORY FORMAT A15
COLUMN SEMANTICSUBCATEGORY FORMAT A15




------------------------------------------------+
------------- DATAREPORT   For the table        |
------------------------------------------------+
-- contient le Profilage des données pour chaque colonne
DROP TABLE DATAREPORT;
CREATE TABLE DATAREPORT
(
    CSVName VARCHAR2(100),
    OLDName VARCHAR2(100);
    NEWName VARCHAR2(100);
    nbrRows NUMBER;
    nbrNullValues NUMBER;
    nbrNotNullValues NUMBER;
    minLenght NUMBER;
    maxLength NUMBER;
    nbrWords NUMBER;
    nbrValuesVarcharType NUMBER;
    nbrValuesNumberType NUMBER;
    nbrValuesDateType NUMBER;
    nbrValuesBooleanType NUMBER;
    nbrValuesNullType NUMBER;
    nbrOfDifferenteValues NUMBER;
    theDominantSyntacticType VARCHAR2(100);
    NumberOfSyntacticAnomalies NUMBER;
    NumberOfSyntacticNormalValues NUMBER;
    theDominantSemanticType VARCHAR2(100);
    NumberOfSemanticAnomalies NUMBER;
    NumberOfSemanticNormalValues NUMBER;

	CONSTRAINT PK_DATAREPORT				PRIMARY KEY(CSVName,OLDName)
);

COLUMN CSVName FORMAT A15
COLUMN OLDName FORMAT A15
COLUMN NEWName FORMAT A15
COLUMN nbrRows FORMAT 99
COLUMN nbrNullValues FORMAT 99
COLUMN nbrNotNullValues FORMAT 99
COLUMN minLenght FORMAT 99
COLUMN maxLength FORMAT 99
COLUMN nbrWords FORMAT 99
COLUMN nbrValuesVarcharType FORMAT 99
COLUMN nbrValuesNumberType FORMAT 99
COLUMN nbrValuesDateType FORMAT 99
COLUMN nbrValuesBooleanType FORMAT 99
COLUMN nbrValuesNullType FORMAT 99
COLUMN nbrOfDifferenteValues FORMAT 99
COLUMN theDominantSyntacticType FORMAT A15
COLUMN NumberOfSyntacticAnomalies FORMAT 99
COLUMN NumberOfSyntacticNormalValues FORMAT 99
COLUMN theDominantSemanticType FORMAT A15
COLUMN NumberOfSemanticAnomalies FORMAT 99
COLUMN NumberOfSemanticNormalValues FORMAT 99
/*------------------------------------------------+
------------- DATAREPORT   For the table        |
------------------------------------------------+
-- contient le Profilage des données pour chaque colonne
DROP TABLE DATAREPORT2;
CREATE TABLE DATAREPORT2
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

	CONSTRAINT PK_DATAREPORT2				PRIMARY KEY(CSVName,OLDName)
);

COLUMN CSVName FORMAT A15
COLUMN OLDName FORMAT A15
COLUMN NEWName FORMAT A15
COLUMN M000 FORMAT 99
COLUMN M100 FORMAT 99
COLUMN M101 FORMAT 99
COLUMN M102 FORMAT 99
COLUMN M103 FORMAT 99
COLUMN M104 FORMAT 99
COLUMN M005 FORMAT 99
COLUMN M106 FORMAT 99
COLUMN M107 FORMAT 99
COLUMN M108 FORMAT 99
COLUMN M109 FORMAT 99
COLUMN M110 FORMAT 99
COLUMN M111 FORMAT A15
COLUMN M112 FORMAT 99
COLUMN M113 FORMAT 99
COLUMN M114 FORMAT A15
COLUMN M115 FORMAT 99
COLUMN M116 FORMAT 99
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
INSERT INTO DEFINITION VALUES ('M105','Number of values of the STRING TYPE');
INSERT INTO DEFINITION VALUES ('M106','Number of values of the NUMBER TYPE');
INSERT INTO DEFINITION VALUES ('M107','Number of values of the DATE TYPE');
INSERT INTO DEFINITION VALUES ('M108','Number of values of the BOOLEAN TYPE');
INSERT INTO DEFINITION VALUES ('M109','Number of values of the NULL TYPE');
INSERT INTO DEFINITION VALUES ('M110','Number of DIFFERENT values');
INSERT INTO DEFINITION VALUES ('M111','The DOMINANT syntactic TYPE');
INSERT INTO DEFINITION VALUES ('M112','Number of syntactic ANOMALIES');
INSERT INTO DEFINITION VALUES ('M113','Number of syntactic Normal values');
INSERT INTO DEFINITION VALUES ('M114','The DOMINANT semantic TYPE');
INSERT INTO DEFINITION VALUES ('M115','Number of semantic ANOMALIES');
INSERT INTO DEFINITION VALUES ('M116','Number of semantic Normal values');

COLUMN ID FORMAT A15
COLUMN DESCRIPTION FORMAT A15
*/

COMMIT;

------------------------------------------------+
------------- getMaxLength                      |
------------------------------------------------+
-- permet de déterminer la ligne qui a le plus d'element dans un fichier csv
-- retourne le nombre de LeDelimiter de la ligne qui en a le plus
CREATE OR REPLACE FUNCTION getMaxLength (LaTable in VARCHAR2, LaColonne in VARCHAR2, LeDelimiter in VARCHAR2)
  RETURN NUMBER
  AS
  table_cursor SYS_REFCURSOR;
  myQuery VARCHAR2(100);
  maxLength NUMBER;
  nbr_delimiteur NUMBER;
  myColonne VARCHAR2(100);

  BEGIN
  myQuery := 'SELECT '||LaColonne||' FROM '||LaTable;
    open table_cursor for myQuery;
    -- on boucle sur chaque ligne du tableau pour récupérer la longueur max d'une chaine delimiter par LeDelimiter
       maxLength :=0;
       loop
        fetch table_cursor into myColonne;
        EXIT when table_cursor%NOTFOUND;
          SELECT REGEXP_COUNT(myColonne, LeDelimiter) INTO nbr_delimiteur FROM dual;
          IF nbr_delimiteur > maxLength THEN
            maxLength:= nbr_delimiteur;
          END IF;

       end loop;
   close table_cursor;
   RETURN (maxLength);
  END;
  /


------------------------------------------------+
------------- createTable                      |
------------------------------------------------+
-- permet de créer une table de NbrCol colonnes
CREATE OR REPLACE PROCEDURE createTable (LaTable in VARCHAR2, NbrCol in NUMBER)
  AS
  table_cursor SYS_REFCURSOR;
  myQueryCreateTable VARCHAR2(500);
  first_iteration BOOLEAN;
  BEGIN
    myQueryCreateTable := ' CREATE TABLE '||LaTable||' (';
    first_iteration := TRUE;
    FOR i IN 1..NbrCol
    LOOP
         IF first_iteration = TRUE THEN
           myQueryCreateTable := myQueryCreateTable || 'Col'||i||' VARCHAR2(200)';
           first_iteration :=FALSE;
         ELSE
           myQueryCreateTable := myQueryCreateTable || ', Col'||i||' VARCHAR2(200)';
         END IF;
    END LOOP;
    myQueryCreateTable := myQueryCreateTable||' )';
    DBMS_OUTPUT.put_line(myQueryCreateTable);
    dropTable(LaTable);
    EXECUTE IMMEDIATE myQueryCreateTable;
  END;
  /



------------------------------------------------+
------------- getDataCategory                   |
------------------------------------------------+
-- return la catégorie d'une chaine de caractére en fonction de son expression regulier
CREATE OR REPLACE FUNCTION getDataCategory(data in VARCHAR2)
   RETURN VARCHAR2
   AS
   categoryData VARCHAR2(20) := 'INCONNU';
   first_val BOOLEAN := TRUE;
   nbr number;
   BEGIN
      FOR i IN (SELECT * FROM REGULAREXPRES)
      LOOP
        IF REGEXP_LIKE (UPPER(data),i.REGULAREXPR) THEN
          -- cas particulier , i.CATEGORY = CITY
          -- donc la data peux être une ville ou un nom
          IF (i.CATEGORY = 'CITY') THEN
            SELECT COUNT(*) INTO nbr FROM DICOPAYSVILLE WHERE VILLE = UPPER(data);
            IF nbr > 0 THEN
              categoryData := i.CATEGORY;
              EXIT;
            END IF;
          -- on peu rajouter plusieur ELSIF en fonction des cas particulier
          ELSE
            -- ci-bas les condition général,
            IF first_val = TRUE THEN
              categoryData := i.CATEGORY;
              first_val := FALSE;
            ELSE
              categoryData := categoryData ||'-'|| i.CATEGORY;
            END IF;
          END IF;

        END IF;
      END LOOP;
      RETURN(categoryData);
   END;
   /
------------------------------------------------+
------------- getDataType                       |
------------------------------------------------+
-- return le type d'une chaine de caractére en fonction de son expression regulier
CREATE OR REPLACE FUNCTION getDataType(data in VARCHAR2)
   RETURN VARCHAR2
   AS
   typeData VARCHAR2(20) := 'INCONNU';
   BEGIN
      FOR i IN (SELECT * FROM REGULAREXPRES)
      LOOP
        IF REGEXP_LIKE (UPPER(data),i.REGULAREXPR) THEN
          typeData := i.TYPE;
          EXIT;
        END IF;
      END LOOP;
      RETURN(typeData);
   END;
   /
------------------------------------------------+
------------- cleanData                         |
------------------------------------------------+
-- permet d'appliquer un première nettoyage des données en fonction de la catégorie
CREATE OR REPLACE FUNCTION cleanData(data in VARCHAR2, categorieData in VARCHAR2)
  RETURN VARCHAR2
  AS
  cleanData VARCHAR2(20);
  x NUMBER;
  BEGIN
     IF categorieData = 'FIRSTNAME' THEN
       cleanData:=LOWER(data);
       cleanData:=INITCAP(data);
     ELSIF categorieData = 'CITY' THEN
       cleanData:=UPPER(data);
     ELSIF categorieData = 'GENDER' THEN
       cleanData:=UPPER(data);
     ELSIF categorieData = 'TEMPERATUREC' THEN
       cleanData:=data;
       cleanData:=REGEXP_REPLACE(cleanData,'(°C|Celcius|�C)','');
     ELSIF categorieData = 'TEMPERATUREF' THEN
       cleanData:=data;
       cleanData:=REGEXP_REPLACE(cleanData,'(°F|FAHRENHEIT|�F)','');
       DBMS_OUTPUT.put_line('ici'||cleanData);
       x := (TO_NUMBER(cleanData) -32)*5/9;
       cleanData:=TO_CHAR(x);

     ELSE
       cleanData:=null;
     END IF;
     RETURN(cleanData);
  END;
  /

------------------------------------------------+
------------- CSV2TAB                             |
------------------------------------------------+
-- permet de faire une conversion basic de la table csv à une colonne vers une table à plusieurs colonnes
-- csvTable : la table au format csv
-- Latable :
CREATE OR REPLACE PROCEDURE CSV2TAB(csvTable in VARCHAR2, Latable in VARCHAR2) AS
   table_cursor SYS_REFCURSOR;
   originalCol VARCHAR2(1000);
   myQuery VARCHAR2(500);
   myInsertValues VARCHAR2(500);
   myQueryCreateTable VARCHAR2(500);
   myQueryDropTable VARCHAR2(500);
   delimiter VARCHAR2(2);
   nbr_delimiteur NUMBER;
   first_iteration BOOLEAN;
   first_line BOOLEAN;
   value VARCHAR2(50);


   BEGIN

   delimiter:=';';
   -- je determine le nombre de colonne
   nbr_delimiteur := getMaxLength(csvTable,'col',delimiter);
   -- je crée une table avec le nom csvTable et le nombre de colonnes = nbr_delimiteur
   createTable(Latable,nbr_delimiteur+1);
   myQuery := 'SELECT * FROM '||csvTable;
     open table_cursor for myQuery;
     -- on boucle sur chaque ligne du tableau
        first_line :=TRUE;
        loop
         fetch table_cursor into originalCol;
         EXIT when table_cursor%NOTFOUND;

         -- on decoupe chaque ligne avec un delimiteur de mot et on construit la commande insert
         -- trim() : supprime les espaces avant et après
         myInsertValues :='INSERT INTO '|| Latable || ' VALUES (';
         first_iteration :=TRUE; -- on ajoute la virgul après la 1er colonne
         FOR i IN
          (SELECT trim(regexp_substr(originalCol, '[^'||delimiter||']+', 1, LEVEL)) mot
          FROM dual
          CONNECT BY LEVEL <= nbr_delimiteur+1)
          -- on peut remplacer nbr_delimiteur par regexp_count(MotsCles, delimiter)
          LOOP
          IF i.mot is null THEN
            value:= 'null';
          ELSE
            value:=''''|| i.mot ||'''';
          END IF;

          IF first_iteration = TRUE THEN
            myInsertValues := myInsertValues || value;
            first_iteration :=FALSE;
          ELSE
              myInsertValues := myInsertValues ||', '||value;
          END IF;

          END LOOP;
          myInsertValues := myInsertValues || ' )';
          -- insertion les données
          DBMS_OUTPUT.put_line(myInsertValues);
          EXECUTE IMMEDIATE myInsertValues;

        end loop;
    close table_cursor;

    END;
/
------------------------------------------------+
------------- iDQMS                             |
------------------------------------------------+



------------------------------------------------+
--- EXECUTION                                   |
------------------------------------------------+
set serveroutput on
declare
   result VARCHAR2(500);
   val VARCHAR2(50);
begin
   --CSV2TAB('CSVfile','mytable');
   DBMS_OUTPUT.put_line('Ma Fonction =============================== ');

   val:='10';
result := getDataType(val);
DBMS_OUTPUT.put_line('LE TYPE de '||val|| ' est : ' ||result);

val:='ludo';
result := getDataType(val);
DBMS_OUTPUT.put_line('LE TYPE de '||val|| ' est : ' ||result);

val:='25-30-2020';
result := getDataType(val);
DBMS_OUTPUT.put_line('LE TYPE de '||val|| ' est : ' ||result);

val:='25-11-2020';
result := getDataType(val);
DBMS_OUTPUT.put_line('LE TYPE de '||val|| ' est : ' ||result);

val:='5�C';
result := getDataType(val);
DBMS_OUTPUT.put_line('LE TYPE de '||val|| ' est : ' ||result);

val:='5�F';
result := getDataType(val);
DBMS_OUTPUT.put_line('LE TYPE de '||val|| ' est : ' ||result);

val:='5Celcius';
result := getDataType(val);
DBMS_OUTPUT.put_line('LE TYPE de '||val|| ' est : ' ||result);

val:='36,5�C';
result := getDataType(val);
DBMS_OUTPUT.put_line('LE TYPE de '||val|| ' est : ' ||result);

val:='36,5°C';
result := getDataType(val);
DBMS_OUTPUT.put_line('LE TYPE de '||val|| ' est : ' ||result);

val:='36,5�C';
result := cleanData(val,'TEMPERATUREC');
DBMS_OUTPUT.put_line('Le Clean de '||val|| ' est : ' ||result);

val:='36,5�F';
result := cleanData(val,'TEMPERATUREF');
DBMS_OUTPUT.put_line('Le Clean de '||val|| ' est : ' ||result);

val:='CSVfile';
result := getMaxLength(val,'col',';');
DBMS_OUTPUT.put_line('Le Max column number de '||val|| ' est : ' ||result);

val:='5Celcius';
result := getDataCategory(val);
DBMS_OUTPUT.put_line('La CATEGORY de '||val|| ' est : ' ||result);

val:='ludo';
result := getDataCategory(val);
DBMS_OUTPUT.put_line('La CATEGORY de '||val|| ' est : ' ||result);

val:='paris';
result := getDataCategory(val);
DBMS_OUTPUT.put_line('La CATEGORY de '||val|| ' est : ' ||result);
DBMS_OUTPUT.put_line('FIN');


end;
/
--SELECT * FROM mytable;
/*
@csv2tab
@B13_csv2tab
M2EID_13/M2EID_13
select getDataType('36,5�C') from dual;
*/
