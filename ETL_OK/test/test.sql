set serveroutput on
SET TIMING ON;
SET LINES 1000
SET PAGES 1000
COLUMN BLOCKINGKEY    FORMAT A20
-- M2EID_13/M2EID_13
@functions_basics.sql
@functions_transforme_csv2table.sql

DECLARE
laTable  VARCHAR2(200);
nbrData  NUMBER;
memorySize  NUMBER;
nbrBlocks  NUMBER;
keyAtributes  VARCHAR2(200);

csvTable  VARCHAR2(50);
delimiteur  VARCHAR2(50);
newTable  VARCHAR2(50);


result VARCHAR2(200) ;
nbrLigne NUMBER ;
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
/*
EXECUTE IMMEDIATE 'COLUMN COL1 FORMAT A10';
EXECUTE IMMEDIATE 'COLUMN COL2 FORMAT A10';
EXECUTE IMMEDIATE 'COLUMN COL3 FORMAT A10';
EXECUTE IMMEDIATE 'COLUMN COL4 FORMAT A10';
EXECUTE IMMEDIATE 'COLUMN COL5 FORMAT A10';
EXECUTE IMMEDIATE 'COLUMN COL6 FORMAT A10';
*/
--result := CreateSortedBlocks(laTable,nbrData,memorySize,nbrBlocks,keyAtributes);

DBMS_OUTPUT.put_line ('[Nombre de ligne convertie ] : '||nbrLigne);
END;
/
COLUMN COL1 FORMAT A10
COLUMN COL2 FORMAT A10
COLUMN COL3 FORMAT A10
COLUMN COL4 FORMAT A10
COLUMN COL5 FORMAT A10
COLUMN COL6 FORMAT A10

select * from mytable;
--desc mytable;
