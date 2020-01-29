--
CREATE OR REPLACE PROCEDURE MyETL (csvTable  IN VARCHAR2,delimiteur  IN VARCHAR2,newTable  IN VARCHAR2)
AS
nbrLigne NUMBER ;
DR_SemanticDependencies VARCHAR2(50);

BEGIN
    print_debug (' ** [ FILE : '||csvTable|| ' | DELIMITEUR : '|| delimiteur ||' | NEWTABLE : '||newTable || ' ] **');

    nbrLigne := CSV2TAB(csvTable,delimiteur,newTable);
    --nbrLigne := CSV2TAB2(csvTable,delimiteur,delimiteur2,newTable);

    DetectAnomaly(csvTable,newTable);

    NormalizeAndCleanData(csvTable,newTable);

    DR_SemanticDependencies := 'DR_SemanticDependencies';
    VERIFDF_TAB(newTable,DR_SemanticDependencies);


    print_debug (' +---------------------------------------------------------------------+ ');
    print_debug (' [ FIN ] ');
    print_debug (' [ NOMBRE DE LIGNE TRAITÉ  : '|| nbrLigne ||' ] ');

END;
/

------------------------------------------------------------------------------------------------------------
--
CREATE OR REPLACE PROCEDURE MyETL2 (csvTable  IN VARCHAR2,delimiteur  IN VARCHAR2,delimiteur2  IN VARCHAR2,newTable  IN VARCHAR2)
AS
nbrLigne NUMBER ;
DR_SemanticDependencies VARCHAR2(50);

BEGIN
    print_debug (' ** [ FILE : '||csvTable|| ' | DELIMITEUR : '|| delimiteur ||' | NEWTABLE : '||newTable || ' ] **');

    nbrLigne := CSV2TAB2(csvTable,delimiteur,delimiteur2,newTable);

    DetectAnomaly(csvTable,newTable);

    NormalizeAndCleanData(csvTable,newTable);

    DR_SemanticDependencies := 'DR_SemanticDependencies';
    VERIFDF_TAB(newTable,DR_SemanticDependencies);


    print_debug (' +---------------------------------------------------------------------+ ');
    print_debug (' [ FIN ] ');
    print_debug (' [ NOMBRE DE LIGNE TRAITÉ  : '|| nbrLigne ||' ] ');

END;
/

CREATE OR REPLACE PROCEDURE MyETL3 (csvTable  IN VARCHAR2,delimiteur  IN VARCHAR2,newTable  IN VARCHAR2)
AS
nbrLigne NUMBER ;
DR_SemanticDependencies VARCHAR2(50);

BEGIN
    print_debug (' ** [ FILE : '||csvTable|| ' | DELIMITEUR : '|| delimiteur ||' | NEWTABLE : '||newTable || ' ] **');

    --nbrLigne := CSV2TAB(csvTable,delimiteur,newTable);

    --DetectAnomaly(csvTable,newTable);

    NormalizeAndCleanData(csvTable,newTable);

    DR_SemanticDependencies := 'DR_SemanticDependencies';
    --VERIFDF_TAB(newTable,DR_SemanticDependencies);


    print_debug (' +---------------------------------------------------------------------+ ');
    print_debug (' [ FIN ] ');
    print_debug (' [ NOMBRE DE LIGNE TRAITÉ  : '|| nbrLigne ||' ] ');

END;
/
