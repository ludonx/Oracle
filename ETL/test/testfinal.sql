--@resources.sql

DECLARE

csvTable  VARCHAR2(50);
delimiteur  VARCHAR2(50);
newTable  VARCHAR2(50);

nbrLigne NUMBER;
BEGIN


csvTable := 'CSVfile1';
delimiteur := ';';
newTable := csvTable || '_new';

print_debug (' ** [ FILE : '||csvTable|| ' | DELIMITEUR : '|| delimiteur ||' | NEWTABLE : '||newTable || ' ] **');

nbrLigne := CSV2TAB(csvTable,delimiteur,newTable);


DetectAnomaly(csvTable,newTable);

NormalizeAndCleanData(csvTable,newTable);

print_debug (' +---------------------------------------------------------------------+ ');

print_debug (' [ FIN ] ');

print_debug(lower('United-Kingdom'));
print_debug(upper('United-Kingdom'));
print_debug(initcap(lower('United-Kingdom')));


END;
/
