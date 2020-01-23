CREATE OR REPLACE FUNCTION getMaxLength2 (
    laTable in VARCHAR2, 
    LaColonne in VARCHAR2, 
    LeDelimiter in VARCHAR2,
    LeDelimiter2 in VARCHAR2,
    maxLength out NUMBER,
    maxLength2 out NUMBER)
RETURN NUMBER
AS
table_cursor SYS_REFCURSOR;
myQuery VARCHAR2(100);
nbrDelimiteur NUMBER;
nbrDelimiteur2 NUMBER;
myColonne VARCHAR2(2000);

BEGIN
myQuery := 'SELECT '||LaColonne||' FROM '||laTable;
--DBMS_OUTPUT.put_line ('----ERREUR----'||LaColonne||'--'||laTable);
  open table_cursor for myQuery;
  -- on boucle sur chaque ligne du tableau pour récupérer la longueur max d'une chaine delimiter par LeDelimiter
     maxLength :=0;
     maxLength2 :=0;
     loop
      fetch table_cursor into myColonne;
      EXIT when table_cursor%NOTFOUND;
      --DBMS_OUTPUT.put_line ('----ERREUR----LOOP');
        SELECT REGEXP_COUNT(myColonne, LeDelimiter) INTO nbrDelimiteur FROM dual;
        IF nbrDelimiteur > maxLength THEN
          maxLength:= nbrDelimiteur;
        END IF;

        IF LeDelimiter2 = ' ' THEN
            myColonne := REGEXP_REPLACE(myColonne,''||LeDelimiter2||LeDelimiter||'',''||LeDelimiter||'');
            myColonne := REGEXP_REPLACE(myColonne,''||LeDelimiter||LeDelimiter2||'',''||LeDelimiter||'');
            myColonne := REGEXP_REPLACE(myColonne,''||LeDelimiter2||LeDelimiter2||'',''||LeDelimiter2||'');
        END IF;
        SELECT REGEXP_COUNT(myColonne, LeDelimiter2) INTO nbrDelimiteur2 FROM dual;
        IF nbrDelimiteur2 > maxLength2 THEN
          maxLength2:= nbrDelimiteur2;
        END IF;

     end loop;
 close table_cursor;
 RETURN (maxLength + maxLength2);
END;
/

CREATE OR REPLACE FUNCTION createInsertValues2 (
    mystring_old in VARCHAR2, 
    delimiter in VARCHAR2,
    delimiter2 in VARCHAR2, 
    maxValues in NUMBER)
RETURN VARCHAR2
IS
myInsertValues VARCHAR2(500);
value VARCHAR2(500);
firstIteration BOOLEAN;
mystring VARCHAR2(500);
BEGIN

-- cas particulier : si on a ;; ou le transforme en ;-;
IF delimiter2 = ' ' THEN
    mystring := REGEXP_REPLACE(mystring_old,''||delimiter||delimiter||'',''||delimiter||'-'||delimiter||'');
    mystring := REGEXP_REPLACE(mystring,''||delimiter2||delimiter||'',''||delimiter||'');
    mystring := REGEXP_REPLACE(mystring,''||delimiter||delimiter2||'',''||delimiter||'');
    mystring := REGEXP_REPLACE(mystring,''||delimiter2||delimiter2||'',''||delimiter2||'');
ELSE
    mystring := REGEXP_REPLACE(mystring_old,''||delimiter||delimiter||'',''||delimiter||'-'||delimiter||'');
    mystring := REGEXP_REPLACE(mystring,''||delimiter2||delimiter||'',''||delimiter2||'-'||delimiter||'');
    mystring := REGEXP_REPLACE(mystring,''||delimiter||delimiter2||'',''||delimiter||'-'||delimiter2||'');
    mystring := REGEXP_REPLACE(mystring,''||delimiter2||delimiter2||'',''||delimiter2||'-'||delimiter2||'');

END IF;

--print_debug(mystring_n);
-- trim() : supprime les espaces avant et après
myInsertValues := 'VALUES (';
firstIteration :=TRUE; -- on ajoute la virgule après la 1er itération ( après avoir récupérer la 1er colonnes)
FOR i IN
 (SELECT trim(regexp_substr(mystring, '[^'||delimiter||delimiter2||']+', 1, LEVEL)) mot
 FROM dual
 CONNECT BY LEVEL <= maxValues+1)
 -- on peut remplacer nbrDelimiteur par regexp_count(MotsCles, delimiter)
 LOOP
    IF i.mot is null THEN
      value:= 'null';
    ELSIF i.mot = '-' OR UPPER(i.mot) = 'NULL' THEN
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
 --print_debug(myInsertValues);

 -- insertion les données
  RETURN (myInsertValues);
END;
/

CREATE OR REPLACE FUNCTION CSV2TAB2(
    csvTable in VARCHAR2,
    delimiter in VARCHAR2,  
    delimiter2 in VARCHAR2, 
    newTable in VARCHAR2)
RETURN NUMBER
IS
table_cursor SYS_REFCURSOR;
originalCol VARCHAR2(1000);
myQuery VARCHAR2(500);
myInsertValues VARCHAR2(500);
myInsertQuery VARCHAR2(500);


nbrDelimiteur NUMBER;
nbrDelimiteur1 NUMBER;
nbrDelimiteur2 NUMBER;
firstIteration BOOLEAN;

nbrLigne NUMBER;


BEGIN
  print_debug (' +---------------------------------------------------------------------+ ');
  print_debug (' [ TRANSFORME CSV TO A TABLE ] ');

  -- je determine le nombre de colonne
  nbrDelimiteur := getMaxLength2(csvTable,'col',delimiter,delimiter2,nbrDelimiteur1,nbrDelimiteur2);
  --nbrDelimiteur := getMaxLength(csvTable,'col',delimiter);
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

       -- je decoupe chaque ligne avec un delimiteur de mot et je construis la commande insert
       myInsertValues := createInsertValues2 (originalCol,delimiter,delimiter2,nbrDelimiteur);

       --myInsertValues := createInsertValues (originalCol, delimiter,nbrDelimiteur );
       myInsertQuery := 'INSERT INTO '|| newTable || ' '||myInsertValues;
       --DBMS_OUTPUT.put_line(myInsertQuery);
       EXECUTE IMMEDIATE myInsertQuery;
       nbrLigne := nbrLigne + 1;

      end loop;
  close table_cursor;

RETURN (nbrLigne);
END;
/

COMMIT;