select newname from DR_CSVfile2_TabCol where newname like '%INCON%';
select * from DR_CSVfile2_COL11;
desc csvfile2_new;

@queriesFile2.sql


select * from ETL_REPORT;
select count(*) from ETL_REPORT;
-- UPDATE CSVfile1_new SET COL3_GENDER = 'M' WHERE COL3 = '1|<!?!>ANOMALIES_SYNTACTIC'