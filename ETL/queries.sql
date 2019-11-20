
----- DATA REPORT COL 4  ----
select * from t_col4;

----- DATA REPORT STAT COL 4  ----
select * from t_col4_stat;
----- DATA REPORT TABLE  ----
--SELECT CSVName ,OLDName ,NEWName ,nbrRows ,nbrNullValues ,nbrNotNullValues ,minLenght ,maxLength ,nbrWords ,nbrValuesVarcharType ,nbrValuesNumberType ,nbrValuesDateType ,nbrValuesBooleanType ,nbrValuesNullType ,nbrOfDifferenteValues ,theDominantSyntacticType ,NumberOfSyntacticAnomalies ,NumberOfSyntacticNormalValues ,theDominantSemanticType ,NumberOfSemanticAnomalies ,NumberOfSemanticNormalValues FROM DR_CSVfile_TabCol;

SELECT CSVName ,OLDName ,NEWName ,nbrRows ,nbrNullValues ,nbrNotNullValues  FROM DR_CSVfile_TabCol;
SELECT minLenght ,maxLength ,nbrWords  FROM DR_CSVfile_TabCol;
SELECT nbrValuesVarcharType ,nbrValuesNumberType ,nbrValuesDateType ,nbrValuesBooleanType ,nbrValuesNullType ,nbrOfDifferenteValues  FROM DR_CSVfile_TabCol;
SELECT theDominantSyntacticType ,NumberOfSyntacticAnomalies ,NumberOfSyntacticNormalValues  FROM DR_CSVfile_TabCol;
SELECT theDominantSemanticType ,NumberOfSemanticAnomalies ,NumberOfSemanticNormalValues FROM DR_CSVfile_TabCol;
