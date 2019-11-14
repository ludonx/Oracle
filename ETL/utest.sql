CREATE OR REPLACE PROCEDURE GenerateReportTable(laTableReportByCol in VARCHAR2, colName in VARCHAR2, laTableReportTable in VARCHAR2)
  AS
  --- la stucture de la table resultante sera la meme que DATAREPORT
  --- desc DATAREPORT --
  dataReportTable DATAREPORT%ROWTYPE;
  myInsertQuery VARCHAR2(500);
  myInsertValue VARCHAR2(500);

  BEGIN
   EXECUTE IMMEDIATE ' SELECT DISTINCT(CSVName) FROM ' || laTableReportByCol INTO dataReportTable.CSVName ;
   dataReportTable.OLDName := colName;
	 -- NEWVALUES a apfaire apres dans un update
	 dataReportTable.NEWName := 'INCONNU';
	 EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol INTO  dataReportTable.nbrRows ;

   EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE OLDVALUES IS NULL ' INTO  dataReportTable.nbrNullValues  ;
	 EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE OLDVALUES IS NOT NULL ' INTO  dataReportTable.nbrNotNullValues  ;
	 EXECUTE IMMEDIATE ' SELECT MIN(COLUMNWIDHT) FROM  '|| laTableReportByCol INTO  dataReportTable.minLenght ;
	 EXECUTE IMMEDIATE ' SELECT MAX(COLUMNWIDHT) FROM  '|| laTableReportByCol INTO  dataReportTable.maxLength ;
	 --EXECUTE IMMEDIATE ' SELECT MAX(COLUMNWIDHT) FROM  '|| laTableReportByCol INTO  dataReportTable.nbrWords ;
	 dataReportTable.nbrWords := -1;
	 EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE UPPER(SYNTACTICTYPE)  LIKE ''%VARCHAR2%'' ' INTO  dataReportTable.nbrValuesVarcharType ;
   EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE UPPER(SYNTACTICTYPE)  LIKE ''%NUMBER%'' ' INTO  dataReportTable.nbrValuesNumberType ;
   EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE UPPER(SYNTACTICTYPE)  LIKE ''%DATE%'' ' INTO  dataReportTable.nbrValuesDateType ;
	 EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE UPPER(SYNTACTICTYPE)  LIKE ''%BOOLEAN%'' ' INTO  dataReportTable.nbrValuesBooleanType ;
	 EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE UPPER(SYNTACTICTYPE)  is NULL ' INTO  dataReportTable.nbrValuesNullType ;
	 --EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE UPPER(SYNTACTICTYPE)  LIKE ''%NUMBER%'' ' INTO  dataReportTable.nbrOfDifferenteValues ;
   dataReportTable.nbrOfDifferenteValues := -1;

   --EXECUTE IMMEDIATE ' SELECT SYNTACTICTYPE FROM ( SELECT SYNTACTICTYPE ) '|| laTableReportByCol INTO  dataReportTable.theDominantSyntacticType ;
   EXECUTE IMMEDIATE ' CREATE OR REPLACE VIEW todelete as ( SELECT SYNTACTICTYPE, count(*) as nbr from '||laTableReportByCol||' GROUP BY SYNTACTICTYPE )';
   EXECUTE IMMEDIATE ' SELECT SYNTACTICTYPE FROM todelete WHERE nbr = (SELECT MAX(nbr) FROM todelete)' INTO dataReportTable.theDominantSyntacticType;
   EXECUTE IMMEDIATE ' DROP VIEW todelete';

   -- c'est le nombre de valeur differente de la valeur syntaxique dominante
   EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol
   || ' WHERE SYNTACTICTYPE IS NULL OR SYNTACTICTYPE NOT LIKE ''%'||
   dataReportTable.theDominantSyntacticType ||'%'' '  INTO  dataReportTable.NumberOfSyntacticAnomalies ;

   -- c'est le nombre de valeur egale à la valeur syntaxique dominante
   -- ou c'est ( le nombre d'element total ) - dataReportTable.NumberOfSyntacticAnomalies
   EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol
   || ' WHERE SYNTACTICTYPE LIKE ''%'||
   dataReportTable.theDominantSyntacticType ||'%'' '  INTO  dataReportTable.NumberOfSyntacticNormalValues ;


   -- ces 3 données seront initialise plustard en fonction 
   /*
   EXECUTE IMMEDIATE ' SELECT FROM  '|| laTableReportByCol INTO  dataReportTable.theDominantSemanticType ;
   EXECUTE IMMEDIATE ' SELECT FROM  '|| laTableReportByCol INTO  dataReportTable.NumberOfSemanticAnomalies ;
   EXECUTE IMMEDIATE ' SELECT FROM  '|| laTableReportByCol INTO  dataReportTable.NumberOfSemanticNormalValues ;
   */
   dataReportTable.theDominantSemanticType := 'INCONNU';
   dataReportTable.NumberOfSemanticAnomalies := -1;
   dataReportTable.NumberOfSemanticNormalValues := -1;



  --DBMS_OUTPUT.put_line ('dataReportTable.OLDName  : '||dataReportTable.OLDName);
  myInsertValue := ' VALUES ('''|| dataReportTable.CSVName  ||''','''||
				 dataReportTable.OLDName  ||''','''||
				 dataReportTable.NEWName  ||''','||
				 dataReportTable.nbrRows ||','||

				 dataReportTable.nbrNullValues ||','||
				 dataReportTable.nbrNotNullValues ||','||

				 dataReportTable.minLenght ||','||
				 dataReportTable.maxLength ||','||

				 dataReportTable.nbrWords ||','||

				 dataReportTable.nbrValuesVarcharType ||','||
				 dataReportTable.nbrValuesNumberType ||','||
				 dataReportTable.nbrValuesDateType ||','||
				 dataReportTable.nbrValuesBooleanType ||','||
				 dataReportTable.nbrValuesNullType ||','||

				 dataReportTable.nbrOfDifferenteValues ||','''||

				 dataReportTable.theDominantSyntacticType  ||''','||
				 dataReportTable.NumberOfSyntacticAnomalies ||','||
				 dataReportTable.NumberOfSyntacticNormalValues ||','''||

				 dataReportTable.theDominantSemanticType  ||''','||
				 dataReportTable.NumberOfSemanticAnomalies ||','||
				 dataReportTable.NumberOfSemanticNormalValues ||
				 ')';


  dropTable(laTableReportTable);
  EXECUTE IMMEDIATE ' CREATE TABLE '|| laTableReportTable || ' AS SELECT * FROM DATAREPORT';
  myInsertQuery := ' INSERT INTO '||laTableReportTable||' '||myInsertValue;
  --DBMS_OUTPUT.put_line (myInsertQuery);
  EXECUTE IMMEDIATE myInsertQuery;
  END;
  /
