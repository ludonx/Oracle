set serveroutput on
SET TIMING ON;
SET LINES 1000
SET PAGES 1000
COLUMN BLOCKINGKEY    FORMAT A20
------------------------------------------------+
------------- getMaxLength                      |
------------------------------------------------+
-- permet de déterminer la ligne qui a le plus d'element dans un fichier csv
-- retourne le nombre de LeDelimiter de la ligne qui en a le plus
CREATE OR REPLACE FUNCTION getMaxLength (laTable in VARCHAR2, LaColonne in VARCHAR2, LeDelimiter in VARCHAR2)
RETURN NUMBER
AS
table_cursor SYS_REFCURSOR;
myQuery VARCHAR2(100);
maxLength NUMBER;
nbr_delimiteur NUMBER;
myColonne VARCHAR2(100);

BEGIN
myQuery := 'SELECT '||LaColonne||' FROM '||laTable;
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
CREATE OR REPLACE PROCEDURE createTable (laTable in VARCHAR2, NbrCol in NUMBER)
AS
table_cursor SYS_REFCURSOR;
myQueryCreateTable VARCHAR2(500);
first_iteration BOOLEAN;
BEGIN
  myQueryCreateTable := ' CREATE TABLE '||laTable||' (';
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
  dropTable(laTable);
  EXECUTE IMMEDIATE myQueryCreateTable;
END;
/

------------------------------------------------+
------------- CSV2TAB                           |
------------------------------------------------+
-- permet de faire une conversion basic de la table csv à une colonne vers une table à plusieurs colonnes
-- csvTable : le nom de la table au format csv
-- newTable : le nom de la table au format sql
CREATE OR REPLACE PROCEDURE CSV2TAB(csvTable in VARCHAR2,delimiter in VARCHAR2,  newTable in VARCHAR2) AS
table_cursor SYS_REFCURSOR;
originalCol VARCHAR2(1000);
myQuery VARCHAR2(500);
myInsertValues VARCHAR2(500);
myQueryCreateTable VARCHAR2(500);
myQueryDropTable VARCHAR2(500);

nbr_delimiteur NUMBER;
first_iteration BOOLEAN;
--first_line BOOLEAN;
value VARCHAR2(50);


BEGIN

  -- je determine le nombre de colonne
  nbr_delimiteur := getMaxLength(csvTable,'col',delimiter);
  -- je crée une table avec le nom csvTable et le nombre de colonnes = nbr_delimiteur
  createTable(newTable,nbr_delimiteur+1);

  myQuery := 'SELECT * FROM '||csvTable;
   open table_cursor for myQuery;
   -- on boucle sur chaque ligne de la table csv et je récupére et je met les données dans des colonnes
      --first_line :=TRUE;
      loop
       fetch table_cursor into originalCol;
       EXIT when table_cursor%NOTFOUND;

       -- je decoupe chaque ligne avec un delimiteur de mot et je construit la commande insert
       -- trim() : supprime les espaces avant et après
       myInsertValues :='INSERT INTO '|| newTable || ' VALUES (';
       first_iteration :=TRUE; -- on ajoute la virgule après la 1er itération ( après avoir récupérer la 1er colonnes)
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
        --EXECUTE IMMEDIATE myInsertValues;

      end loop;
  close table_cursor;

END;
/
