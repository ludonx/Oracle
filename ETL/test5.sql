set serveroutput on
SET TIMING ON;
SET LINES 1000
SET PAGES 1000
COLUMN BLOCKINGKEY    FORMAT A20
-- M2EID_13/M2EID_13
--@functions_basics.sql
--@functions_transforme_csv2table.sql
--@tables_RegexMFB.sql
@tables_Data_Reporte.sql
@functions_profil_columns.sql

--@tables_liste_villes.sql
--@utest.sql

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
BEGIN
laTable := 'TE';
nbrData := 15;
memorySize := 2;
nbrBlocks := 3;
keyAtributes := 'id,nom';

csvTable := 'CSVfile';
delimiteur := ';';
newTable := 'mytable';


nbrLigne := CSV2TAB(csvTable,delimiteur,newTable);


laTable := 'mytable';
colName := 'col4';
laTableRes := 't_col4';
CSVName := 'CSVfile';
delimiteurOfCategory := '_OR_';
dataReportTableName := laTableRes ||'_stat';
GenerateReportByCol(CSVName,laTable,colName, laTableRes,dataReportTableName );

-----------------------------------------------------------------------------------------
laTable := 'mytable';
colName := 'col4';
laTableRes := 't_col4';
CSVName := 'CSVfile';
--dataReportTableName := ;
--GenerateReportByCol(CSVName,laTable,colName,laTableRes,dataReportTableName);

laTable := 'mytable';
colName := 'col4';
laTableRes := 't_col4';
CSVName := 'CSVfile';
laTable := laTableRes ||'_stat';
delimiteurOfCategory := '_OR_';
--GenerateReportTable(laTableRes, colName,laTable );

laTable := 'mytable';
colName := 'col4';
laTableRes := 't_col4';
CSVName := 'CSVfile';
delimiteurOfCategory := '_OR_';
dataReportTableName := laTableRes ||'_stat';
--GenerateReportByCol(CSVName,laTable,colName, laTableRes,dataReportTableName );

END;
/

select * from t_col4;
select theDominantSemanticType from DR_CSVfile_TabCol;
