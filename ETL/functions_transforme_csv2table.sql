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
nbrDelimiteur NUMBER;
myColonne VARCHAR2(2000);

BEGIN
myQuery := 'SELECT '||LaColonne||' FROM '||laTable;
--DBMS_OUTPUT.put_line ('----ERREUR----'||LaColonne||'--'||laTable);
  open table_cursor for myQuery;
  -- on boucle sur chaque ligne du tableau pour récupérer la longueur max d'une chaine delimiter par LeDelimiter
     maxLength :=0;
     loop
      fetch table_cursor into myColonne;
      EXIT when table_cursor%NOTFOUND;
      --DBMS_OUTPUT.put_line ('----ERREUR----LOOP');
        SELECT REGEXP_COUNT(myColonne, LeDelimiter) INTO nbrDelimiteur FROM dual;
        IF nbrDelimiteur > maxLength THEN
          maxLength:= nbrDelimiteur;
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
firstIteration BOOLEAN;
BEGIN
  myQueryCreateTable := ' CREATE TABLE '||laTable||' (';
  firstIteration := TRUE;
  FOR i IN 1..NbrCol
  LOOP
       IF firstIteration = TRUE THEN
         myQueryCreateTable := myQueryCreateTable || 'Col'||i||' VARCHAR2(200)';
         firstIteration :=FALSE;
       ELSE
         myQueryCreateTable := myQueryCreateTable || ', Col'||i||' VARCHAR2(200)';
       END IF;
  END LOOP;
  myQueryCreateTable := myQueryCreateTable||' )';
  --DBMS_OUTPUT.put_line(myQueryCreateTable);
  dropTable(laTable);
  EXECUTE IMMEDIATE myQueryCreateTable;
END;
/

------------------------------------------------+
------------- createInsertValues                |
------------------------------------------------+
-- permet de générer la chaine de valeurs qui seront inséret dans une table à partir d'une chaine et d'un delimiteur
CREATE OR REPLACE FUNCTION createInsertValues (mystring in VARCHAR2, delimiter in VARCHAR2, maxValues in NUMBER)
RETURN VARCHAR2
IS
myInsertValues VARCHAR2(500);
value VARCHAR2(500);
firstIteration BOOLEAN;
BEGIN

-- trim() : supprime les espaces avant et après
myInsertValues := 'VALUES (';
firstIteration :=TRUE; -- on ajoute la virgule après la 1er itération ( après avoir récupérer la 1er colonnes)
FOR i IN
 (SELECT trim(regexp_substr(mystring, '[^'||delimiter||']+', 1, LEVEL)) mot
 FROM dual
 CONNECT BY LEVEL <= maxValues+1)
 -- on peut remplacer nbrDelimiteur par regexp_count(MotsCles, delimiter)
 LOOP
   IF i.mot is null THEN
     value:= 'null';

   ELSE
     value:=''''|| i.mot ||'''';
   END IF;

   IF firstIteration = TRUE THEN
     myInsertValues := myInsertValues || value;
     firstIteration :=FALSE;
   ELSE
       myInsertValues := myInsertValues ||', '||value;
   END IF;

 END LOOP;
 myInsertValues := myInsertValues || ' )';

 -- insertion les données
  RETURN (myInsertValues);
END;
/

------------------------------------------------+
------------- CSV2TAB                           |
------------------------------------------------+
-- permet de faire une conversion basic de la table csv à une colonne vers une table à plusieurs colonnes
-- csvTable : le nom de la table au format csv
-- newTable : le nom de la table au format sql
CREATE OR REPLACE FUNCTION CSV2TAB(csvTable in VARCHAR2,delimiter in VARCHAR2,  newTable in VARCHAR2)
RETURN NUMBER
IS
table_cursor SYS_REFCURSOR;
originalCol VARCHAR2(1000);
myQuery VARCHAR2(500);
myInsertValues VARCHAR2(500);
myInsertQuery VARCHAR2(500);


nbrDelimiteur NUMBER;
firstIteration BOOLEAN;

nbrLigne NUMBER;


BEGIN
  print_debug (' +---------------------------------------------------------------------+ ');
  print_debug (' [ TRANSFORME CSV TO A TABLE ] ');

  -- je determine le nombre de colonne
  nbrDelimiteur := getMaxLength(csvTable,'col',delimiter);
  -- je crée une table avec le nom csvTable et le nombre de colonnes = nbrDelimiteur
  dropTable(newTable);
  createTable(newTable,nbrDelimiteur+1);

  myQuery := 'SELECT * FROM '||csvTable;
  nbrLigne := 0;
   open table_cursor for myQuery;
   -- on boucle sur chaque ligne de la table csv et je récupére et je met les données dans des colonnes
      --first_line :=TRUE;
      loop
       fetch table_cursor into originalCol;
       EXIT when table_cursor%NOTFOUND;

       -- je decoupe chaque ligne avec un delimiteur de mot et je construit la commande insert
       myInsertValues := createInsertValues (originalCol, delimiter,nbrDelimiteur );
       myInsertQuery := 'INSERT INTO '|| newTable || ' '||myInsertValues;
       --DBMS_OUTPUT.put_line(myInsertQuery);
       EXECUTE IMMEDIATE myInsertQuery;
       nbrLigne := +1;

      end loop;
  close table_cursor;

RETURN (nbrLigne);
END;
/

COMMIT;
