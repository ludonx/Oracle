
----- DATA REPORT COL 4  ----
select * from t_col4;

----- DATA REPORT TABLE  ----

SELECT CSVName ,OLDName ,NEWName ,nbrRows ,nbrNullValues ,nbrNotNullValues ,minLenght ,maxLength ,nbrWords ,nbrValuesVarcharType ,nbrValuesNumberType ,nbrValuesDateType ,nbrValuesBooleanType ,nbrValuesNullType ,nbrOfDifferenteValues ,theDominantSyntacticType ,NumberOfSyntacticAnomalies ,NumberOfSyntacticNormalValues ,theDominantSemanticType ,NumberOfSemanticAnomalies ,NumberOfSemanticNormalValues FROM DR_CSVfile_TabCol;
--select theDominantSemanticType

SELECT   nbrRows ,nbrNullValues ,nbrNotNullValues ,minLenght ,maxLength ,nbrWords ,nbrValuesVarcharType ,nbrValuesNumberType ,nbrValuesDateType ,nbrValuesBooleanType ,nbrValuesNullType ,nbrOfDifferenteValues FROM DR_CSVfile_TabCol;

SELECT OLDName ,NEWName ,theDominantSyntacticType ,NumberOfSyntacticAnomalies ,NumberOfSyntacticNormalValues ,theDominantSemanticType ,NumberOfSemanticAnomalies ,NumberOfSemanticNormalValues FROM DR_CSVfile_TabCol;

/*
SELECT

--CSVName ,
OLDName ,
NEWName ,
nbrRows ,
--nbrNullValues ,
--nbrNotNullValues ,
--minLenSELECT

--CSVName ,
OLDName ,
NEWName ,
nbrRows ,
--nbrNullValues ,
--nbrNotNullValues ,
--minLenght ,
--maxLength ,
--nbrWords ,
--nbrValuesVarcharType ,
--nbrValuesNumberType ,
--nbrValuesDateType ,
--nbrValuesBooleanType ,
--nbrValuesNullType ,
--nbrOfDifferenteValues ,
theDominantSyntacticType ,
--NumberOfSyntacticAnomalies ,
--NumberOfSyntacticNormalValues ,
theDominantSemanticType
--NumberOfSemanticAnomalies ,
--NumberOfSemanticNormalValues

FROM DR_CSVfile_TabCol;


SELECT
--maxLength ,
--nbrWords ,
--nbrValuesVarcharType ,
--nbrValuesNumberType ,
--nbrValuesDateType ,
--nbrValuesBooleanType ,
--nbrValuesNullType ,
--nbrOfDifferenteValues ,
theDominantSyntacticType ,
--NumberOfSyntacticAnomalies ,
--NumberOfSyntacticNormalValues ,
theDominantSemanticType
--NumberOfSemanticAnomalies ,
--NumberOfSemanticNormalValues

FROM DR_CSVfile_TabCol;

SELECT


minLenght ,
maxLength ,
nbrWords ,
nbrValuesVarcharType ,
nbrValuesNumberType ,
nbrValuesDateType ,
nbrValuesBooleanType ,
nbrValuesNullType ,
nbrOfDifferenteValues


FROM DR_CSVfile_TabCol;
*/
