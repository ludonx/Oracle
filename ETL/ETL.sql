--
CREATE OR REPLACE PROCEDURE MyETL (csvTable  IN VARCHAR2,delimiteur  IN VARCHAR2,newTable  IN VARCHAR2)
AS
nbrLigne NUMBER ;

BEGIN
    print_debug (' ** [ FILE : '||csvTable|| ' | DELIMITEUR : '|| delimiteur ||' | NEWTABLE : '||newTable || ' ] **');

    nbrLigne := CSV2TAB(csvTable,delimiteur,newTable);

    DetectAnomaly(csvTable,newTable);

    NormalizeAndCleanData(csvTable,newTable);

    print_debug (' +---------------------------------------------------------------------+ ');
    print_debug (' [ FIN ] ');
    print_debug (' [ NOMBRE DE LIGNE TRAITÉ  : '|| nbrLigne ||' ] ');

END;
/