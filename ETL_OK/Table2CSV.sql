set colsep ';'
set headsep off
--set pagesize 0
SET HEADING ON
set trimspool on
set linesize 1000
set numwidth 20

SET TIMING OFF;
SET LINES 1000
SET PAGES 1000


----------------------------------------------------------------

spool csvfile1_new.csv
select * from csvfile1_new;
spool off

spool csvfile2_new.csv
select * from csvfile2_new;
spool off

spool csvfile3_new.csv
select * from csvfile3_new;
spool off

spool csvfile4_new.csv
select * from csvfile4_new;
spool off

----------------------------------------------------------------

spool DR_CSVfile1_TabCol.csv
SELECT *  FROM DR_CSVfile1_TabCol;
spool off

spool DR_CSVfile2_TabCol.csv
SELECT *  FROM DR_CSVfile2_TabCol;
spool off


spool DR_CSVfile3_TabCol.csv
SELECT *  FROM DR_CSVfile3_TabCol;
spool off

spool DR_CSVfile4_TabCol.csv
SELECT *  FROM DR_CSVfile4_TabCol;
spool off
----------------------------------------------------------------

spool DR_SemanticDependencies.csv
SELECT *  FROM DR_SemanticDependencies;
spool off