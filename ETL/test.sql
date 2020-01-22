
@functions/SemanticDependencies/functions_SemanticDependencies.sql

DECLARE

csvTable  VARCHAR2(50);
delimiteur  VARCHAR2(50);
newTable  VARCHAR2(50);

nbrLigne NUMBER;
res  VARCHAR2(50);
BEGIN
--print_debug('myQuery');
--res := VERIFDF('CSVfile1_new','DR_SemanticDependencies','COL1_NAMES','COL2_NAMES');
--select * from LISTAVERIFIER_VP0;
--res := VERIFDF('CSVfile1_new','DR_SemanticDependencies','COL2_NAMES','COL3_GENDER');
--res := VERIFDF('CSVfile1_new','DR_SemanticDependencies','COL2_NAMES','COL1_NAMES');
--res := VERIFDF('CSVfile1_new','DR_SemanticDependencies','COL3_GENDER','COL2_NAMES');
--res := VERIFDF('CSVfile1_new','DR_SemanticDependencies','COL3_GENDER','COL1_NAMES');


VERIFDF_TAB('CSVfile1_new','DR_SemanticDependencies');

END;
/
--VARCHAR2(30)
--SELECT 41.522, CAST(41.522 AS VARCHAR2(10)) AS OUTPUT_VALUE FROM dual;
--SELECT 41.522, CAST('5' AS CHAR(10)) AS OUTPUT_VALUE FROM dual;
--select * from DR_SemanticDependencies;
-- M2EID_23/M2EID_23
--@functions/SemanticDependencies/functions_SemanticDependencies.sql