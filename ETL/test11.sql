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
-- @tables_data_csv_file1.sql

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


@functions_NormaliserAndCleanData.sql

--@tables_ETL_Report1.sql

DECLARE
laTable  VARCHAR2(200);
nbrData  NUMBER;
memorySize  NUMBER;
nbrBlocks  NUMBER ;
keyAtributes  VARCHAR2(200);

csvTable  VARCHAR2(50);
delimiteur  VARCHAR2(50);
newTable  VARCHAR2(50);

val VARCHAR2(200) ;
result VARCHAR2(200) ;
nbrLigne NUMBER ;
colName VARCHAR2(200) ;
laTableRes VARCHAR2(200) ;

data VARCHAR2(60) ;
category VARCHAR2(60) ;
subCategory VARCHAR2(60) ;
delimiteurOfCategory VARCHAR2(60) ;
dataReportTableName VARCHAR2(60) ;

CSVName VARCHAR2(60);

theDominantSemanticType  VARCHAR2(200);
theDominantSyntacticType  VARCHAR2(200);
maxLength  VARCHAR2(200);

BEGIN


csvTable := 'CSVfile2';
delimiteur := ';';
newTable := csvTable || '_new';

print_debug (' ** [ FILE : '||csvTable|| ' | DELIMITEUR : '|| delimiteur ||' | NEWTABLE : '||newTable || ' ] **');

nbrLigne := CSV2TAB(csvTable,delimiteur,newTable);

laTable := newTable;
CSVName := csvTable;

DetectAnomaly(CSVName,laTable);

NormaliserAndCleanData(csvTable,newTable);

print_debug (' +---------------------------------------------------------------------+ ');

print_debug (' [ FIN ] ');



data := UPPER('pékin èàçùû');
DBMS_OUTPUT.put_line('87.53°F  '||data);
data := LOWER('pékin èàçùû');
DBMS_OUTPUT.put_line('87.53°F  '||data);

data := CleanData_Weight('42015,79 g');
DBMS_OUTPUT.put_line('42015,79 g  '||data);

data := CleanData_Weight('58,74 KG');
DBMS_OUTPUT.put_line('58,74 KG  '||data);







END;
/
