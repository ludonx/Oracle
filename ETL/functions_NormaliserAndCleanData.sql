--@functions_profil_columns.sql
--@tables_ETL_Report.sql 
--@tables_Data_Reporte.sql
-------------------------------------------------------------------------------------
-- Génération de la Data Report DR_CSVFile_Col_
-- @param :
--      +input :
--          + laTable : le nom de la table qui contient des anomalies :
--          + colName : le nom de la colonnes
--          + dataReportTableNameBycol : le nom de la table de rapport syntaxique et éventuellement sémantique :
-----------------------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION getInfoCol(
    CSVName IN VARCHAR2,
    laColonne IN VARCHAR2,

    newColName OUT VARCHAR2, 
    theDominantSemanticType OUT VARCHAR2,
    theDominantSyntacticType OUT VARCHAR2, 
    maxLength OUT NUMBER)

    RETURN NUMBER
AS
myQuery VARCHAR2(500);
dataReportTableName VARCHAR2(500);

nbrValue NUMBER;

BEGIN
    nbrValue := 0;
    dataReportTableName := 'DR_'||CSVName||'_TabCol';

    myQuery := ' SELECT COUNT(*) FROM '||
    dataReportTableName || 
    ' WHERE UPPER(CSVName) = UPPER('''|| CSVName ||''') AND  UPPER(OLDName) = UPPER(''' ||laColonne || ''')' ;
    EXECUTE IMMEDIATE myQuery INTO nbrValue;

    IF (nbrValue <= 0) THEN 

        newColName := 'INCONNU' ; 
        theDominantSemanticType := 'INCONNU' ;
        theDominantSyntacticType := 'INCONNU' ; 
        maxLength := 0 ;

    ELSE 
        myQuery := ' SELECT NEWName, theDominantSemanticType, theDominantSyntacticType, maxLength FROM '||
        dataReportTableName || 
        ' WHERE UPPER(CSVName) = UPPER('''|| CSVName ||''') AND  UPPER(OLDName) = UPPER(''' ||laColonne || ''') AND ROWNUM = 1' ;
        
        --DBMS_OUTPUT.put_line (myQuery);

        EXECUTE IMMEDIATE myQuery INTO newColName,theDominantSemanticType, theDominantSyntacticType, maxLength;
        --DBMS_OUTPUT.put_line ('['|| newColName || '--'||theDominantSemanticType||'--'||theDominantSyntacticType||'--'||maxLength||']');

    END IF;

    RETURN (nbrValue);

    
END;
/

CREATE OR REPLACE PROCEDURE getNewtype(
    theDominantSyntacticType IN VARCHAR2, 
    maxLength IN VARCHAR2,
    newType OUT VARCHAR2)
AS
myQuery VARCHAR2(500);
dataReportTableName VARCHAR2(500);

BEGIN
    newType := theDominantSyntacticType;
    IF (UPPER(newType) = 'VARCHAR2' ) THEN 
        newType := newType||'('||maxLength ||')';
    END IF;
END;
/



CREATE OR REPLACE PROCEDURE NormaliserAndCleanData(CSVName in VARCHAR2, laTable in VARCHAR2) AS
dataReportTableName VARCHAR2(200);

table_cursor SYS_REFCURSOR;
selected_values VARCHAR2(500);
where_conditions VARCHAR2(500);
myQuery VARCHAR2(500);
colName VARCHAR2(60);

newColName VARCHAR2(60);
theDominantSemanticType  VARCHAR2(200);
theDominantSyntacticType  VARCHAR2(200); 
maxLength  NUMBER;

nbrValue NUMBER;

dataReportTableNameByCol VARCHAR2(100);

newColType VARCHAR2(60);

table_cursor_col SYS_REFCURSOR;
myQuery_col VARCHAR2(500);

oldValueCol VARCHAR2(500);
newValueCol VARCHAR2(500);
oldValueCol_new VARCHAR2(500);

myUpdateQuery VARCHAR2(500);

BEGIN

    dataReportTableName := 'DR_'||CSVName||'_TabCol';

    --- cette requête permet de récupérer les colonnes qu'une table passer en paramètres
    selected_values := ' COLUMN_NAME ';
    where_conditions := ' where table_name = '''||upper(laTable)||''' AND DATA_TYPE = ''VARCHAR2''';
    myQuery := 'SELECT '|| selected_values ||' FROM user_tab_columns'|| where_conditions;


   
    DBMS_OUTPUT.put_line ('[ Normalisation et Nettoyage des données ]');

    open table_cursor for myQuery;
    loop
        fetch table_cursor into colName ;
        EXIT when table_cursor%NOTFOUND;
       
        nbrValue :=0;
        nbrValue := getInfoCol(CSVName,colName,newColName,theDominantSemanticType,theDominantSyntacticType,maxLength);
        IF (nbrValue > 0 ) THEN 

            DBMS_OUTPUT.put_line ('['|| newColName || '--'||theDominantSemanticType||'--'||theDominantSyntacticType||'--'||maxLength||']');

            -- ajout de la  nouvelle colonne
            getNewtype(theDominantSyntacticType,maxLength,newColType);
            alterAddCol(laTable,newColName,newColType);

            dataReportTableNameByCol := 'DR_'||CSVName||'_'||colName;
            DBMS_OUTPUT.put_line ('[ Colonnes: '||colName||' -> '||newColName||' ]');
            
            --------------------------------------

            myQuery_col := ' SELECT OLDVALUES, NEWVALUES FROM '|| dataReportTableNameByCol ;
            DBMS_OUTPUT.put_line(myQuery_col);

            open table_cursor_col for myQuery_col;
            loop
                fetch table_cursor_col into oldValueCol, oldValueCol_new ;
                EXIT when table_cursor_col%NOTFOUND;

                -- nettoyage #TODO
                --newValueCol := xxx(oldValueCol,oldValueCol_new,theDominantSemanticType);
                -- remarque : si c'est une chaine ne pas oublier les ''
                newValueCol := 'EN COURS ... ';
                newValueCol := getNewCleanValue(
                    oldValueCol,
                    CSVName,
                    colName,
                    dataReportTableNameByCol,
                    dataReportTableName);

                -- sauvegarde de la nouvelle données
                myUpdateQuery := 'UPDATE '||laTable||' SET '||newColName||' = '||newValueCol||' WHERE '|| colName || ' = '||oldValueCol;

                --DBMS_OUTPUT.put_line(myUpdateQuery);

                --EXECUTE IMMEDIATE myUpdateQuery;


            end loop;
            close table_cursor_col;
            --------------------------------------

            -- suppression de l'ancienne colonne
            --alterDropCol(laTable,colName);

            --DBMS_OUTPUT.put_line ('[------------------------ FIN ----------------------------]');
        
        ELSE
            DBMS_OUTPUT.put_line ('[ Colonnes: '||colName||'  VIDE ... ]');

        END IF;
        
    end loop;
    close table_cursor;

    DBMS_OUTPUT.put_line ('[]');
    DBMS_OUTPUT.put_line ('[ CHECK TABLE : '|| laTable ||' To See Modification ]');
    DBMS_OUTPUT.put_line ('[ select * from '|| laTable ||'; ]');

END;
/

COMMIT;
