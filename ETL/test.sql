
--@functions/SemanticDependencies/functions_SemanticDependencies.sql

--VARCHAR2(30)
--SELECT 41.522, CAST(41.522 AS VARCHAR2(10)) AS OUTPUT_VALUE FROM dual;
--SELECT 41.522, CAST('5' AS CHAR(10)) AS OUTPUT_VALUE FROM dual;
--select * from DR_SemanticDependencies;
-- M2EID_23/M2EID_23
--@functions/SemanticDependencies/functions_SemanticDependencies.sql
@functions/CSV2TAB/functions_transforme_csv2table_version2

DECLARE

csvTable  VARCHAR2(50);
delimiter  VARCHAR2(50);
delimiter2  VARCHAR2(50);
newTable  VARCHAR2(50);
maxLength2 NUMBER;
maxLength NUMBER;
nbrLigne NUMBER;
maxValues NUMBER;
res  VARCHAR2(50);
str VARCHAR2(500);
str2 VARCHAR2(500);
myInsertValues VARCHAR2(500);
BEGIN
--print_debug('myQuery');
--res := VERIFDF('CSVfile1_new','DR_SemanticDependencies','COL1_NAMES','COL2_NAMES');
--select * from LISTAVERIFIER_VP0;
--res := VERIFDF('CSVfile1_new','DR_SemanticDependencies','COL2_NAMES','COL3_GENDER');
--res := VERIFDF('CSVfile1_new','DR_SemanticDependencies','COL2_NAMES','COL1_NAMES');
--res := VERIFDF('CSVfile1_new','DR_SemanticDependencies','COL3_GENDER','COL2_NAMES');
--res := VERIFDF('CSVfile1_new','DR_SemanticDependencies','COL3_GENDER','COL1_NAMES');
-- nbrLigne := getMaxLength('csvfile3','col',';');
-- nbrLigne := getMaxLength2('csvfile3','col',';',' ',maxLength,maxLength2);

-- print_debug(nbrLigne);
-- print_debug(maxLength);
-- print_debug(maxLength2);

--SELECT trim(regexp_substr('mystring; 7 5; p', '[^; ]+', 1, LEVEL))  FROM dual CONNECT BY LEVEL <= 2
delimiter := ';';
delimiter2 := ' ';
nbrLigne := getMaxLength2('csvfile3','col',delimiter,delimiter2,maxLength,maxLength2);
maxValues := maxLength + maxLength2;
print_debug(nbrLigne);
print_debug(maxLength);
print_debug(maxLength2);
str := 'M. Clement LEGRAND;M;AB+;Londres;RU';
--str := 'M. Adam BEN TRAIFOR ;M;A+;Paris;France';
myInsertValues := createInsertValues2 (str,delimiter,delimiter2,maxValues);
print_debug(myInsertValues);
myInsertValues := createInsertValues (str,delimiter,maxLength);
print_debug(myInsertValues);
--VERIFDF_TAB('CSVfile1_new','DR_SemanticDependencies');

    nbrLigne := CSV2TAB('csvfile3',delimiter,'tes1');
    nbrLigne := CSV2TAB2('csvfile3',delimiter,delimiter2,'tes2');


END;
/
