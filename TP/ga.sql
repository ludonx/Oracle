DROP TABLE TOUSDETAILCOM;
CREATE TABLE TOUSDETAILCOM AS
select * from detailcom_fr01
union all
SELECT COL1,COL2,
cast(col3 as number(3)),
cast(REGEXP_REPLACE( substr(col4,1,instr(col4,' ')-1), '\.',',') as number(10,2)),
cast(REGEXP_REPLACE( substr(col5,1,instr(col5,'%')-1), '\.',',') as number(4,2)),
MAGASIN from detailcom_FR02
union all
SELECT COL1,COL2,
cast(col3 as number(3)),
cast(REGEXP_REPLACE( substr(upper(col4),1,instr(upper(col4),upper('Dt'))-1), '\.',',') as number(10,2)),
cast(REGEXP_REPLACE( substr(col5,1,instr(col5,'%')-1) , '\.',',') as number(4,2)),
MAGASIN from detailcom_TN02;
