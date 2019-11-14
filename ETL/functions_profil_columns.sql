------------------------------------------------+
------------- getDataType                       |
------------------------------------------------+
-- return le type d'une chaine de caractére en fonction de son expression regulier
CREATE OR REPLACE FUNCTION getDataType(data in VARCHAR2)
   RETURN VARCHAR2
   AS
   typeData VARCHAR2(20) := null;
   BEGIN
      FOR i IN (SELECT * FROM DDRE)
      LOOP
        IF REGEXP_LIKE (UPPER(data),i.REGULAREXPRESSION) THEN
          typeData := i.TYPE;
          EXIT;
        END IF;
      END LOOP;
      RETURN(typeData);
   END;
   /

------------------------------------------------+
------------- GenerateReportTable                    |
------------------------------------------------+
-- return le type d'une chaine de caractére en fonction de son expression regulier
CREATE OR REPLACE PROCEDURE GenerateReportTable(laTableReportByCol in VARCHAR2, colName in VARCHAR2, laTableReportTabale in VARCHAR2)
  AS
  --- la stucture de la table resultante sera la meme que DATAREPORT
  --- desc DATAREPORT --
  dataReportTable DATAREPORT%ROWTYPE;
  myInsertQuery VARCHAR2(500);
  myInsertValue VARCHAR2(500);

  BEGIN
   EXECUTE IMMEDIATE ' SELECT DISTINCT(CVSName) INTO ' || dataReportTable.CSVName || ' FROM ' || laTableReportByCol ;
   dataReportTable.OLDName := colName;
   --EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.NEWName || ' FROM ' || laTableReportByCol ;
   /*
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.nbrRows || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.nbrNullValues || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.nbrNotNullValues || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.minLenght || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.maxLength || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.nbrWords || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.nbrValuesVarcharType || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.nbrValuesNumberType || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.nbrValuesDateType || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.nbrValuesBooleanType || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.nbrValuesNullType || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.nbrOfDifferenteValues || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.theDominantSyntacticType || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.NumberOfSyntacticAnomalies || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.NumberOfSyntacticNormalValues || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.theDominantSemanticType || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.NumberOfSemanticAnomalies || ' FROM ' || laTableReportByCol ;
   EXECUTE IMMEDIATE ' SELECT INTO ' || dataReportTable.NumberOfSemanticNormalValues || ' FROM ' || laTableReportByCol ;
 */

  DBMS_OUTPUT.put_line ('dataReportTable.OLDName'||dataReportTable.OLDName);
  myInsertValue := ' VALUES ('|| ' '||')';

  myInsertQuery := ' INSERT INTO '||laTableReportTabale||' '||myInsertValue;
  DBMS_OUTPUT.put_line (myInsertQuery);
  --EXECUTE IMMEDIATE myInsertQuery;
  END;
  /

-------------------------------------------------------------------------------------
-- Génération de la Data Report DR_CSVFile_Col_
-- @param :
--      +input :
--          +le nom de la table qui contient des anomalies : laTable
--          +le nom de la colonnes : colName
--          +le nom de la table de rapport syntaxique et éventuellement sémantique : laTableRes
-----------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE GenerateReportByCol(CSVName in VARCHAR2, laTable in VARCHAR2,  colName in VARCHAR2, laTableRes in VARCHAR2) AS
table_cursor SYS_REFCURSOR;
myQuery VARCHAR2(500);
myInsertQuerySyntaxique VARCHAR2(500);
myInsertValueSyntaxique VARCHAR2(500);
selected_values VARCHAR2(500);
where_conditions VARCHAR2(500);

colDataType VARCHAR2(60);
colLength NUMBER;
colNbrMot NUMBER;
myColValues VARCHAR2(60);
myColValuesToInsert VARCHAR2(60);

dataReportTableName VARCHAR2(60);
--CSVName VARCHAR2(60); -- contiendra le nom du fichier csv : @ludo a modifier et mettre en parametre -- quoi que pas tres utilil ( voir prof)
--- la stucture de la table resultante sera la meme que DATAREPORTBYCOL
--- desc DATAREPORTBYCOL --
dataReport DATAREPORTBYCOL%ROWTYPE; -- à supprimer si pas utiliser
BEGIN
  -- je crée la table de profilage
  dropTable(laTableRes);
  EXECUTE IMMEDIATE ' CREATE TABLE '|| laTableRes || ' as SELECT * FROM DATAREPORTBYCOL';
  -- je m'assure que la table est bien vide
  EXECUTE IMMEDIATE ' DELETE  FROM '||laTableRes;

  -- je parcours les valeurs de la colonnes passée en paramétre et je rempli ma table de profilage
  -- profilate syntaxique uniquement car le profilage semantique ne pourra se faire que sur la base du résultats du profilage syntaxique
  --CSVName := 'CSVfile';
  myQuery := 'SELECT '||colName || ' FROM '|| laTable;
  open table_cursor for myQuery;
  -- on boucle sur chaque ligne du tableau pour récupérer la longueur max d'une chaine delimiter par LeDelimiter
     loop
      fetch table_cursor INTO myColValues;
      EXIT WHEN table_cursor%NOTFOUND;

        IF myColValues is null THEN
          myColValuesToInsert := 'null';
          colDataType := 'null';
          colLength := 0;
          colNbrMot := 0;
        ELSE
          -- ne pas oublie de rajouter les doubles cote pour les chaine de caractère
          myColValuesToInsert:=''''|| myColValues ||'''';

          -- je détermine le type syntaxique de la colonne
          colDataType :=''''|| getDataType(myColValues) ||'''';

          -- je détermine la longueur de la colonne
          colLength := length(myColValues);

          -- je détermine le nombre de mot de la colonne (séparer par un espaces)
          colNbrMot := REGEXP_COUNT(myColValues, ' ') + 1;

        END IF;

        -- pour le profilage syntaxique on insert les données car la table est vide
        myInsertValueSyntaxique := ' VALUES ('''||CSVName||''','|| myColValuesToInsert ||','|| colDataType ||',' ||colLength ||', '|| colNbrMot ||',null,null,null,null)';
        myInsertQuerySyntaxique := 'INSERT INTO ' || laTableRes ||myInsertValueSyntaxique;
        DBMS_OUTPUT.put_line (myInsertQuerySyntaxique);
        EXECUTE IMMEDIATE myInsertQuerySyntaxique;

        -- je génére une partie de la table DATAREPORT pour le fichier CSV
        dataReportTableName := 'DR_'||CSVName||'_TabCol' ;



        -- pour les données sémantique on fait un update car la lique contient déja des valeurs


     END loop;
 close table_cursor;






END;
/

COMMIT;
