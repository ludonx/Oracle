
----- DATA REPORT COL 4  ----
--select * from t_col3;

----- DATA REPORT TABLE  ----
--SELECT CSVName ,OLDName ,NEWName ,nbrRows ,nbrNullValues ,nbrNotNullValues ,minLenght ,maxLength ,nbrWords ,nbrValuesVarcharType ,nbrValuesNumberType ,nbrValuesDateType ,nbrValuesBooleanType ,nbrValuesNullType ,nbrOfDifferenteValues ,theDominantSyntacticType ,NumberOfSyntacticAnomalies ,NumberOfSyntacticNormalValues ,theDominantSemanticType ,NumberOfSemanticAnomalies ,NumberOfSemanticNormalValues FROM DR_CSVfile1_TabCol;

SELECT CSVName ,OLDName ,NEWName ,nbrRows ,nbrNullValues ,nbrNotNullValues  FROM DR_CSVfile1_TabCol;
SELECT OLDName ,NEWName, minLenght ,maxLength ,nbrWords  FROM DR_CSVfile1_TabCol;
SELECT OLDName ,NEWName, nbrValuesVarcharType ,nbrValuesNumberType ,nbrValuesDateType ,nbrValuesBooleanType ,nbrValuesNullType ,nbrOfDifferenteValues  FROM DR_CSVfile1_TabCol;
SELECT OLDName ,NEWName, theDominantSyntacticType ,NumberOfSyntacticAnomalies ,NumberOfSyntacticNormalValues  FROM DR_CSVfile1_TabCol;
SELECT OLDName ,NEWName, theDominantSemanticType ,NumberOfSemanticAnomalies ,NumberOfSemanticNormalValues FROM DR_CSVfile1_TabCol;
