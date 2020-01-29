
SELECT CSVName ,OLDName ,NEWName ,nbrRows ,nbrNullValues ,nbrNotNullValues  FROM DR_CSVfile2_TabCol;
SELECT OLDName ,NEWName, minLength ,maxLength ,nbrWords  FROM DR_CSVfile2_TabCol;
SELECT OLDName ,NEWName, nbrValuesVarcharType ,nbrValuesNumberType ,nbrValuesDateType ,nbrValuesBooleanType ,nbrValuesNullType ,nbrOfDifferenteValues  FROM DR_CSVfile2_TabCol;
SELECT OLDName ,NEWName, theDominantSyntacticType ,NumberOfSyntacticAnomalies ,NumberOfSyntacticNormalValues  FROM DR_CSVfile2_TabCol;
SELECT OLDName ,NEWName, theDominantSemanticType ,NumberOfSemanticAnomalies ,NumberOfSemanticNormalValues FROM DR_CSVfile2_TabCol;
