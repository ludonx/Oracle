set serveroutput on
SET TIMING ON;
SET LINES 1000
SET PAGES 1000
COLUMN BLOCKINGKEY    FORMAT A20
-- M2EID_13/M2EID_13
--@functions_basics.sql
--@tables_RegexMFB.sql
@tables_Data_Reporte.sql
@functions_profil_columns.sql
--@utest.sql

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

CSVName VARCHAR2(60);
BEGIN
laTable := 'TE';
nbrData := 15;
memorySize := 2;
nbrBlocks := 3;
keyAtributes := 'id,nom';

delimiteur := ';';
newTable := 'mytable';

val:='25-11-2020';
result := getDataType(val);
DBMS_OUTPUT.put_line('LE TYPE de '||val|| ' est : ' ||length(null));

val:='5°C';
result := getDataType(val);
DBMS_OUTPUT.put_line('LE TYPE de '||val|| ' est : ' ||result);

val:='5�F';
result := getDataType(val);
DBMS_OUTPUT.put_line('LE TYPE de '||val|| ' est : ' ||result);

laTable := 'mytable';
colName := 'col4';
laTableRes := 't_col4';
CSVName := 'CSVfile';
GenerateReportByCol(CSVName,laTable,colName,laTableRes);

laTable := 'mytable';
colName := 'col3';
laTableRes := 't_col3';
CSVName := 'CSVfile';
--GenerateReportByCol(CSVName,laTable,colName,laTableRes);

--select COLUMNWIDHT into nbrBlocks from DATAREPORTBYCOL;
--DBMS_OUTPUT.put_line ('[Nombre de ligne convertie ] : '||nbrBlocks);
END;
/

select * from t_col4;
--exec dropTable('t_col3');
--exec dropTable('t_col1');
--select * from DDRE;
