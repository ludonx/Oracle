
--
CREATE OR REPLACE PROCEDURE EliminateDoubles_v1 (tableName  IN VARCHAR2, selectValue  IN VARCHAR2, tableName_new IN VARCHAR2)
AS
nbrLigne NUMBER ;

myQuery_count VARCHAR2(50);
myQuery_create VARCHAR2(50);
myQuery VARCHAR2(50);
nbrDouble NUMBER;
BEGIN
    print_debug (' +---------------------------------------------------------------------+ ');
    print_debug (' [CORRECTION DES DOUBLE VERSION 1 ] ');

    myQuery_count := 'SELECT '||selectValue
    ||' COUNT(*) mycount FROM ' || tableName
    ||' GROUP BY '||selectValue||' HAVING mycount > 1';

    myQuery := 'SELECT '||selectValue||' FROM '|| ' ( '||myQuery_count ||' )';

    dropTable(tableName_new);
    myQuery_create := 'CREATE TABLE '||tableName_new||' AS 'myQuery;

    EXECUTE IMMEDIATE myQuery ;

    print_debug (' +---------------------------------------------------------------------+ ');


END;
/
--@test_double.sql
--EXEC EliminateDoubles_v1('csvfile3_new','COL1_NAMES,COL2_NAMES,COL3_NAMES','test1');
