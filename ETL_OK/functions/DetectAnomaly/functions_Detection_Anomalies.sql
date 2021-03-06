--@functions_profil_columns.sql
--@tables_ETL_Report.sql 
--@tables_Data_Reporte.sql
-------------------------------------------------------------------------------------
-- Génération de la Data Report DR_CSVFile_Col_
-- @param :
--      +input :
--          + laTable : le nom de la table qui contient des anomalies :
--          + colName : le nom de la colonnes
--          + dataReportTableNameBycol : le nom de la table de rapport syntaxique et éventuellement sémantique :
-----------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE DetectAnomaly(CSVName in VARCHAR2, laTable in VARCHAR2) AS
table_cursor SYS_REFCURSOR;
myQuery VARCHAR2(500);
myInsertQuerySyntaxique VARCHAR2(500);
myInsertValueSyntaxique VARCHAR2(500);
selected_values VARCHAR2(500);
where_conditions VARCHAR2(500);
dataReportTableName VARCHAR2(500);

ETLtable VARCHAR2(200) := 'ETL_REPORT';


colName VARCHAR2(60);
dataReportTableNameByCol VARCHAR2(100);

BEGIN
    print_debug (' +---------------------------------------------------------------------+ ');
    print_debug (' [ DETECT ANOMALY ON COLUMNS ] ');

    -- on crée la table des statistique pour la table passer en parametrer
    dataReportTableName := 'DR_'||CSVName||'_TabCol';
    dropTable(dataReportTableName);
    EXECUTE IMMEDIATE ' CREATE TABLE '|| dataReportTableName || ' AS SELECT * FROM DATAREPORT';

    --- cette requête permet de récupérer les colonnes qu'une table passer en paramètres
    selected_values := ' COLUMN_NAME ';
    where_conditions := ' where table_name = '''||upper(laTable)||''' AND DATA_TYPE = ''VARCHAR2''';
    myQuery := 'SELECT '|| selected_values ||' FROM user_tab_columns'|| where_conditions;

    --- pour chaque colonne récupérée, je lance la detection d'annomalie
    --- donc pour chaque colonne on auras une une table datareport qui sera créeé 
    --- et une ligne qui sera rajouté a la table de stat de la table

    open table_cursor for myQuery;
    loop
        fetch table_cursor into colName ;
        EXIT when table_cursor%NOTFOUND;
        dataReportTableNameByCol := 'DR_'||CSVName||'_'||colName;
        print_debug (' ----- [ Colonnes: '||colName||'] [ Table des statistiques '||dataReportTableNameByCol ||']');
        
        GenerateReportByCol(CSVName,laTable,colName, dataReportTableNameByCol );

        -- je génére une partie de la table DATAREPORT pour le fichier CSV
        --dataReportTableName := 'DR_'||CSVName||'_TabCol' ;
        
        GenerateReportTable(dataReportTableNameByCol, colName, dataReportTableName);
        --print_debug('ici++++');
        -- pour les colonnes (observation et newValues) on fait un update car la clique contient déja des valeurs
        UpdateReportByCol(dataReportTableNameByCol, colName, dataReportTableName);
        
        insertIntoETLtable(ETLtable,CSVName, laTable ,colName ,dataReportTableName,dataReportTableNameByCol);

        --print_debug ('[------------------------ FIN ----------------------------]');
    end loop;
    close table_cursor;

    print_debug (' ---------- [ Data Report : '|| dataReportTableName ||' ] ');
    print_debug (' ---------- [ CHECK TABLE : '|| ETLtable ||' For Resume ] ');
    print_debug (' ---------- [ select * from '|| ETLtable ||'; ] ');

END;
/

COMMIT;
