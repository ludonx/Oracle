--@functions_profil_columns.sql
-------------------------------------------------------------------------------------
-- Génération de la Data Report DR_CSVFile_Col_
-- @param :
--      +input :
--          + laTable : le nom de la table qui contient des anomalies :
--          + colName : le nom de la colonnes
--          + laTableRes : le nom de la table de rapport syntaxique et éventuellement sémantique :
-----------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE DetectAnomaly(CSVName in VARCHAR2, laTable in VARCHAR2,  colName in VARCHAR2, laTableRes in VARCHAR2) AS
table_cursor SYS_REFCURSOR;
myQuery VARCHAR2(500);
myInsertQuerySyntaxique VARCHAR2(500);
myInsertValueSyntaxique VARCHAR2(500);
selected_values VARCHAR2(500);
where_conditions VARCHAR2(500);
dataReportTableName VARCHAR2(500);

BEGIN
 dataReportTableName := 'DR_'||CSVName||'_TabCol';

 dropTable(dataReportTableName);
 EXECUTE IMMEDIATE ' CREATE TABLE '|| dataReportTableName || ' AS SELECT * FROM DATAREPORT';

 GenerateReportByCol(CSVName,laTable,colName, laTableRes );

 -- je génére une partie de la table DATAREPORT pour le fichier CSV
 --dataReportTableName := 'DR_'||CSVName||'_TabCol' ;
 GenerateReportTable(laTableRes, colName, dataReportTableName);

 -- pour les colonnes (observation et newValues) on fait un update car la clique contient déja des valeurs
 UpdateReportByCol(laTableRes, colName, dataReportTableName);


END;
/

COMMIT;
