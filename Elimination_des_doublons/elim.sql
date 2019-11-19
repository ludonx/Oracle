set serveroutput on
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- permet d'ajouter une cles pour chaque ligne d'une table de données en prenant pour chaque colonne un nombre maximum de characters = seuil
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE AddColumnKey(laTable in VARCHAR2, primaryKeyName in VARCHAR2, keyColName in VARCHAR2, delim in VARCHAR2, seuil in NUMBER) AS
table_cursor SYS_REFCURSOR;
myQuery VARCHAR2(500);
selected_values VARCHAR2(500);
where_conditions VARCHAR2(500);
update_values VARCHAR2(500);
delimiteur VARCHAR2(500);

update_ok NUMBER;

keyValue VARCHAR2(2000);
nbrIteration NUMBER;
mycolname VARCHAR2(60);

BEGIN

--- cette requête permet de récupérer les colonnes qu'une table passer en paramètres
selected_values := ' COLUMN_NAME ';
where_conditions := ' where table_name = '''||upper(laTable)||''' AND DATA_TYPE = ''VARCHAR2''';
myQuery := 'SELECT '|| selected_values ||' FROM user_tab_columns'|| where_conditions;

--- je cree la requête qui permettra de concatener les colonnes de ma table
update_values := '';
delimiteur := delim;
nbrIteration := 0;
update_ok := 1;
open table_cursor for myQuery;
  loop
    fetch table_cursor into mycolname ;
    EXIT when table_cursor%NOTFOUND;
    --- on ne met pas la cles primaire dans la cles car elle sera forcement diferente
    --- en faissant ca on améliore la precision de la détection de doublons
    IF mycolname = primaryKeyName THEN
      delimiteur := delim;
    --_ si la keyColName existe deja, dans le cas d'execution multiple par exemple
    ELSIF UPPER(mycolname) = UPPER(keyColName) THEN
      update_ok := 0;
    ELSE
      --- je normalise la colonnes en respectant le seuil
      mycolname := 'SUBSTR(TRIM('||mycolname||'),0,'||seuil||')';
      IF nbrIteration = 0 THEN
      --- je prend la 1er valeur ( pour respecte le format à cause des virgule qu'il faudra ajouter)
        update_values := mycolname;
        nbrIteration := 1;
      ELSE
        --- je prend les autres valeurs
        update_values := update_values || '|| ''' || delimiteur|| '''|| ' || mycolname;
      END IF;
    END IF;
  end loop;
close table_cursor;


IF update_ok = 1 THEN
--- je rajoute une nouvelle colonnes à la table
EXECUTE IMMEDIATE 'ALTER TABLE  '||laTable||' ADD '||keyColName||' VARCHAR2(2000)';
END IF;

--- je met à jour la nouvelle colonnes keyColName avec la concatenation des autre colonne
--- je met la nouvelle colonne en majuscule
--DBMS_OUTPUT.put_line ('UPDATE '||laTable||' SET '||keyColName||' = ' || 'UPPER (  ('||update_values||'))');
--EXECUTE IMMEDIATE 'UPDATE '||laTable||' SET '||keyColName||' = ' || 'UPPER (  ('||update_values||'))';
EXECUTE IMMEDIATE 'UPDATE '||laTable||' SET '||keyColName||' = REGEXP_REPLACE (UPPER ( '||update_values||'), ''' || ' '|| ''',''' ||''|| ''')';
--update te set mykey = Regexp_replace (upper(nom||prenom||id), ' ','');


--- en cas d'erreur : si la colonne keyColName existe deja par exemple
--EXCEPTION
--      WHEN OTHERS THEN NULL;
END;
/


--------------------------------------------------------
--- une fois la cles cree, on vas eliminer les doublons
--------------------------------------------------------
CREATE OR REPLACE FUNCTION SupprimerDoublons(laTable in VARCHAR2, primaryKeyName in VARCHAR2, keyColName in VARCHAR2, delim in VARCHAR2, seuil in NUMBER,algoDeDetection in VARCHAR2 ,pctMin in NUMBER )
RETURN NUMBER
IS
table_cursor SYS_REFCURSOR;
myQuery VARCHAR2(500);
myQueryDelete VARCHAR2(2000);
selected_values VARCHAR2(500);
select_similar_data VARCHAR2(500);
where_conditions VARCHAR2(500);

keyColNameValue VARCHAR2(500);
primaryKeyNameValue VARCHAR2(500);

pctTrouver NUMBER;
nbrSupprime NUMBER;
nbrElementVisiter NUMBER;
BEGIN
--- cette requête permet de récupérer les colonnes clesdedetection et cles primaire ( pas forcement necessaire)  qu'une table passer en paramètres
selected_values := primaryKeyName ||',  '|| keyColName;
myQuery := 'SELECT '|| selected_values ||' FROM '||laTable;

--- pour chaque colonne récupérée, je lance la recherche
--- donc pour chaque colonne on auras une vue qui sera créeé
nbrSupprime :=0;
nbrElementVisiter := 1;
open table_cursor for myQuery;
  loop
    fetch table_cursor into primaryKeyNameValue, keyColNameValue ;
    EXIT when table_cursor%NOTFOUND;

    -- BETWEEN pctMin and 99 parce que 100 = la valeurs que l'on cherche
    -- mais si il y plusieur 100 il faudra simplement faire un select distinct
    -- si le pourcentage de similarité est supérieur a pctMin , on considere que c'est un doublons
    where_conditions := 'UTL_MATCH.' || algoDeDetection || '('||keyColName ||', ''' || keyColNameValue|| ''')  BETWEEN ' || pctMin || ' AND 99' ;
    select_similar_data := 'SELECT ' || primaryKeyName || ' FROM ' || laTable || ' WHERE ' || where_conditions;
    myQueryDelete := 'DELETE FROM '||laTable || ' WHERE '|| primaryKeyName || ' in ('||select_similar_data || ')';

    EXECUTE IMMEDIATE myQueryDelete;
    select count(*) into nbrSupprime from te;
    DBMS_OUTPUT.put_line(nbrSupprime);
    DBMS_OUTPUT.put_line (myQueryDelete);

    DBMS_OUTPUT.put_line ('----------------------------------------------------');
  end loop;
close table_cursor;
DBMS_OUTPUT.put_line ('--- > [Algo ] : '|| algoDeDetection || ' [nbr supprimer] : '|| nbrSupprime || ' / '|| nbrElementVisiter);
RETURN (nbrSupprime);
END;
/
