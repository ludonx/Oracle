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


CREATE OR REPLACE PROCEDURE alterAddCol(
    laTable IN VARCHAR2,
    newColonne IN VARCHAR2,
    newType IN VARCHAR2 )
AS
myQuery VARCHAR2(500);

BEGIN
    myQuery := 'ALTER TABLE '|| laTable ||' ADD '||newColonne||' '|| newType ;
    EXECUTE IMMEDIATE myQuery ;
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE alterDropCol(
    laTable IN VARCHAR2,
    newColonne IN VARCHAR2)
AS
myQuery VARCHAR2(500);

BEGIN
    myQuery := 'ALTER TABLE '|| laTable ||' DROP COLUMN '||newColonne ;
    EXECUTE IMMEDIATE myQuery ;
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/
--------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE print_debug(string IN VARCHAR2)
AS

BEGIN
    DBMS_OUTPUT.put_line(string);
END;
/

--------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertIntoETLtable(
    ETLtable IN VARCHAR2,
    CSVName IN VARCHAR2,
    laTable IN VARCHAR2,
    laColonne IN VARCHAR2,
    dataReportTable IN VARCHAR2,
    dataReportColonne IN VARCHAR2)
AS
myQueryInsertETL VARCHAR2(500);
myQueryCheck VARCHAR2(500);

nbr NUMBER;

BEGIN
    nbr := 0;
    myQueryCheck := 'SELECT COUNT(*) FROM '||ETLtable||' WHERE CSVName = '''||CSVName 
                    ||''' AND laTable = '''|| laTable 
                    ||''' AND laColonne = '''||laColonne 
                    ||''' AND dataReportTable = '''||dataReportTable 
                    ||''' AND dataReportColonne = '''||dataReportColonne ||''' ';
    
    --print_debug(myQueryCheck);
    EXECUTE IMMEDIATE myQueryCheck INTO nbr;
    IF (nbr = 0)THEN 
        myQueryInsertETL := 'INSERT INTO '||ETLtable||' VALUES('''||CSVName ||''', '''|| laTable ||''', '''||laColonne ||''','''||dataReportTable ||''','''||dataReportColonne ||''' )';
        EXECUTE IMMEDIATE myQueryInsertETL;
    END IF;
    

END;
/
--------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION isCity(data IN VARCHAR2)

RETURN BOOLEAN
AS
nbr NUMBER;
trouver BOOLEAN;

BEGIN
    nbr := 0;
    trouver := false;
    SELECT COUNT(*) INTO nbr FROM DICOPAYSVILLE
    WHERE VILLE = UPPER(data) OR VILLE = data
    OR VILLE_EN = UPPER(data) OR VILLE_EN = data;
    IF nbr > 0 THEN
      trouver := true;
    END IF;
    
    RETURN ( trouver );
END;
/
--------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION isCountry(data IN VARCHAR2)

RETURN BOOLEAN
AS
nbr NUMBER;
trouver BOOLEAN;

BEGIN
    nbr := 0;
    trouver := false;
    SELECT COUNT(*) INTO nbr FROM DICOPAYSVILLE
    WHERE PAYS = UPPER(data) OR PAYS = data
    OR PAYS_EN = UPPER(data) OR PAYS_EN = data;
    IF nbr > 0 THEN
      trouver := true;
    END IF;
    
    RETURN ( trouver );
END;
/
--------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION isContinent(data IN VARCHAR2)

RETURN BOOLEAN
AS
nbr NUMBER;
trouver BOOLEAN;

BEGIN
    nbr := 0;
    trouver := false;
    SELECT COUNT(*) INTO nbr FROM DICOPAYSVILLE
    WHERE CONTINENT = UPPER(data) OR CONTINENT = data
    OR CONTINENT_EN = UPPER(data) OR CONTINENT_EN = data;
    IF nbr > 0 THEN
      trouver := true;
    END IF;
    
    RETURN ( trouver );
END;
/
