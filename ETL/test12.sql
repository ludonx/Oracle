-- test CSV2TAB(...) DetectAnomaly(...) NormaliserAndCleanData(...)
set serveroutput on
SET TIMING ON;
SET LINES 1000
SET PAGES 1000
-- M2EID_23/M2EID_23
--@functions_basics.sql
-- @tables_data_csv_file.sql
--@functions_transforme_csv2table.sql
--@format_colonnes.sql
-- --@tables_data_csv_file.sql
--EXEC droptable('CSVfile1');
--EXEC droptable('CSVfile2');
--EXEC droptable('CSVfile3');
--EXEC droptable('CSVfile4');
--@tables_data_csv_file1.sql

--@tables_RegexMFB.sql
-- @tables_liste_villes.sql

-- @tables_Data_Reporte.sql
-- @tables_ETL_Report.sql
--@tables_ETL_Report1.sql
--@functions_profil_columns.sql
--@functions_Detection_Anomalies.sql


--@tables_liste_villes.sql
--@tables_liste_mois.sql
@functions_CleanData.sql
--@functions_CorrectData.sql
--@utest.sql


--@functions_NormaliserAndCleanData.sql

--@tables_ETL_Report1.sql

DECLARE

csvTable  VARCHAR2(50);
delimiteur  VARCHAR2(50);
newTable  VARCHAR2(50);

nbrLigne NUMBER;
BEGIN


csvTable := 'CSVfile2';
delimiteur := ';';
newTable := csvTable || '_new';

print_debug (' ** [ FILE : '||csvTable|| ' | DELIMITEUR : '|| delimiteur ||' | NEWTABLE : '||newTable || ' ] **');

nbrLigne := CSV2TAB(csvTable,delimiteur,newTable);


DetectAnomaly(csvTable,newTable);

NormaliserAndCleanData(csvTable,newTable);

print_debug (' +---------------------------------------------------------------------+ ');

print_debug (' [ FIN ] ');

print_debug(lower('United-Kingdom'));
print_debug(upper('United-Kingdom'));
print_debug(initcap(lower('United-Kingdom')));


END;
/
