set serveroutput on
SET TIMING ON;
SET LINES 1000
SET PAGES 1000
COLUMN BLOCKINGKEY    FORMAT A20

@2019-11-Bxy-Deduplication.sql -- pour la fonction CreateSortedBlocks

DECLARE
laTable  VARCHAR2(200);
nbrData  NUMBER;
memorySize  NUMBER;
nbrBlocks  NUMBER;
keyAtributes  VARCHAR2(200);

result VARCHAR2(200) ;
BEGIN
laTable := 'TE';
nbrData := 15;
memorySize := 2;
nbrBlocks := 3;
keyAtributes := 'id,nom';

result := CreateSortedBlocks(laTable,nbrData,memorySize,nbrBlocks,keyAtributes);

DBMS_OUTPUT.put_line ('[blocs] : '||result);
END;
/



select * from b1_TE;
select * from b2_TE;
