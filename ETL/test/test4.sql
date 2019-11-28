set serveroutput on
SET TIMING ON;
SET LINES 1000
SET PAGES 1000
COLUMN BLOCKINGKEY    FORMAT A20
-- M2EID_13/M2EID_13
--@functions_basics.sql
--@tables_RegexMFB.sql
--@tables_Data_Reporte.sql
--@functions_profil_columns.sql
--@tables_liste_villes.sql
@utest.sql

DECLARE
laTable  VARCHAR2(200);
nbrData  NUMBER;
memorySize  NUMBER;
nbrBlocks  NUMBER;
keyAtributes  VARCHAR2(200);

csvTable  VARCHAR2(50);
delimiteur  VARCHAR2(50);
newTable  VARCHAR2(50);

val VARCHAR2(200) ;
result VARCHAR2(200) ;
nbrLigne NUMBER ;
colName VARCHAR2(200) ;
laTableRes VARCHAR2(200) ;
dataReportTableName VARCHAR2(60) ;

data VARCHAR2(60) ;
category VARCHAR2(60) ;
subCategory VARCHAR2(60) ;
delimiteurOfCategory VARCHAR2(60) ;


CSVName VARCHAR2(60);
BEGIN
laTable := 'TE';
nbrData := 15;
memorySize := 2;
nbrBlocks := 3;
keyAtributes := 'id,nom';

delimiteur := ';';
newTable := 'mytable';

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
data := 'ludovik';
getDataCategory(data,category,subCategory,delimiteurOfCategory);
DBMS_OUTPUT.put_line ('[category] : '||category );
DBMS_OUTPUT.put_line ('[subCategory] : '||subCategory );
DBMS_OUTPUT.put_line ('---------------------------------');

data := 'ludovik@ho.com';
getDataCategory(data,category,subCategory,delimiteurOfCategory);
DBMS_OUTPUT.put_line ('[category] : '||category );
DBMS_OUTPUT.put_line ('[subCategory] : '||subCategory );
DBMS_OUTPUT.put_line ('---------------------------------');

data := '23°c';
getDataCategory(data,category,subCategory,delimiteurOfCategory);
DBMS_OUTPUT.put_line ('[category] : '||category );
DBMS_OUTPUT.put_line ('[subCategory] : '||subCategory );
DBMS_OUTPUT.put_line ('---------------------------------');
--select COLUMNWIDHT into nbrBlocks from DATAREPORTBYCOL;

laTable := 'mytable';
colName := 'col4';
laTableRes := 't_col4';
CSVName := 'CSVfile';
laTable := laTableRes ||'_stat';
delimiteurOfCategory := '_OR_';
--GenerateReportByCol(CSVName,laTable, laTableRes, colName,laTable );

END;
/

--select * from t_col4;
--select * from t_col4_stat;
