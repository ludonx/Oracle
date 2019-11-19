--CreateSortedBlocks(F,N,M,B,K);
-- ALGO MFB
@elim.sql -- pour la fonction AddColumnKey
-- permet de supprimer une table sans générer d'erreur si elle n'existe pas
CREATE OR REPLACE PROCEDURE dropTable (LaTable in VARCHAR2) AS
  BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE '||LaTable;
  EXCEPTION
      WHEN OTHERS THEN NULL;
  END;
  /
CREATE OR REPLACE FUNCTION CreateSortedBlocks
(
  laTable in VARCHAR2,
  nbrData in NUMBER,
  memorySize in NUMBER,
  nbrBlocks in NUMBER,
  keyAtributes in VARCHAR2
  -- must be separate by comma ','


) RETURN VARCHAR2
IS

table_cursor SYS_REFCURSOR;

blocksNames VARCHAR2(200);
currentBlock VARCHAR2(200);
newtable VARCHAR2(200);
myQuery VARCHAR2(200);
myQueryBlock VARCHAR2(200);
insertBlockQuery VARCHAR2(200);

primaryKeyName VARCHAR2(200);
keyColName VARCHAR2(200);
delim VARCHAR2(200);
seuil NUMBER;
blockId NUMBER;

keyColNameBlocs VARCHAR2(200);
nbrElemInsert VARCHAR2(200);
BEGIN
newtable := 'v'||laTable;
-- je cres une vue avec uniquement les attributs de  keyAtributes
dropTable(newtable);
EXECUTE IMMEDIATE 'CREATE TABLE '|| newtable || ' AS SELECT '|| keyAtributes||' FROM '||laTable;

-- je concatener les colonnes de ma vue pour crees une
primaryKeyName := ' ';
keyColName := 'BlockingKey';
delim := ' ';
seuil := 40;
AddColumnKey(newtable, primaryKeyName, keyColName, delim,seuil);

-- la colonnes qui m'interesse maintenant est la colonnes 'BlockingKey'
-- je trie ma vue en fonction de ma colonnes 'BlockingKey'
-- puis je parcours cette table et je cree les blocks
-- le nombre max d'element par blocs = memorySize
myQuery := 'SELECT '|| keyColName|| ' FROM '|| newtable ||' ORDER BY ' || keyColName ;
nbrElemInsert := 0;
blockId := 1;

-- pour le 1er block
currentBlock := 'b'||blockId|| '_' || laTable;
myQueryBlock := 'CREATE  TABLE '|| currentBlock || ' (' || keyColName ||  '  VARCHAR2(1000) )' ;
DBMS_OUTPUT.put_line (myQueryBlock);

dropTable(currentBlock);
EXECUTE IMMEDIATE myQueryBlock;

-- liste de toutes les blocks
blocksNames :=currentBlock;

open table_cursor for myQuery;
  loop
    fetch table_cursor into keyColNameBlocs ;
    EXIT when table_cursor%NOTFOUND;
    IF nbrElemInsert = memorySize THEN
    blockId := blockId +1;
    -- le blocks est plein ou c'est les premier block
    currentBlock := 'b'||blockId|| '_' || laTable;
    myQueryBlock := 'CREATE  TABLE '|| currentBlock || ' (' || keyColName ||  '  VARCHAR2(1000) )' ;
    DBMS_OUTPUT.put_line (myQueryBlock);

    dropTable(currentBlock);
    EXECUTE IMMEDIATE myQueryBlock;
    -- liste de toutes les blocks
    blocksNames := blocksNames || '  --  ' || currentBlock;

    nbrElemInsert := 0;
    ELSE
    -- c'est le meme blocks
    -- on ajoute les données
    insertBlockQuery := 'INSERT INTO ' || currentBlock || ' VALUES (''' || keyColNameBlocs|| ''')';
    DBMS_OUTPUT.put_line(insertBlockQuery);
    EXECUTE IMMEDIATE  insertBlockQuery;
    nbrElemInsert := nbrElemInsert+1;
    END IF;


  end loop;
close table_cursor;

RETURN (blocksNames);
--- en cas d'erreur : si la colonne keyColName existe deja par exemple
--EXCEPTION
--      WHEN OTHERS THEN NULL;
END;
/
