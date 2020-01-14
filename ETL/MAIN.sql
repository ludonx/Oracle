@resources.sql
--ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
DECLARE
csvTable  VARCHAR2(50);
delimiteur  VARCHAR2(50);
newTable  VARCHAR2(50);

BEGIN
    --EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_DATE_FORMAT = ''YYYY-MM-DD'' ';
    csvTable := 'CSVfile1';
    delimiteur := ';';
    newTable := csvTable || '_new';
    MyETL (csvTable ,delimiteur ,newTable );

    -- MyETL ('CSVfile1' ,';' ,'CSVfile1_new' );
    -- MyETL ('CSVfile2' ,';' ,'CSVfile2_new' );
    -- MyETL ('CSVfile3' ,';' ,'CSVfile3_new' );
    -- MyETL ('CSVfile4' ,';' ,'CSVfile4_new' );


END;
/
@queries/queriesFile1.sql


-- @queries/queriesFile1.sql
-- @queries/queriesFile2.sql
-- @queries/queriesFile3.sql
-- @queries/queriesFile4.sql