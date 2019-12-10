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
