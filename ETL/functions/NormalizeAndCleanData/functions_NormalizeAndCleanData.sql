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

        --print_debug (myQuery);

        EXECUTE IMMEDIATE myQuery INTO newColName,theDominantSemanticType, theDominantSyntacticType, maxLength;
        --print_debug ('['|| newColName || '--'||theDominantSemanticType||'--'||theDominantSyntacticType||'--'||maxLength||']');

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

------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION getNewCleanValue(
    data IN VARCHAR2,
    CSVName IN VARCHAR2,
    laColonne IN VARCHAR2,

    DR_CSVfile_Coli IN VARCHAR2,
    DR_CSVfile_TabCol IN VARCHAR2)


    RETURN VARCHAR2
AS
myQuery VARCHAR2(500);
dataReportTableName VARCHAR2(500);

dataSemanticType VARCHAR2(500);
dataSyntacticType VARCHAR2(500);

theDominantSemanticType VARCHAR2(500);
theDominantSyntacticType VARCHAR2(500);

newData VARCHAR2(500);
doNotCare VARCHAR2(500);

nbrValue NUMBER;
testCorrectSpecialData BOOLEAN;

BEGIN
    newData := null;
    nbrValue := 0; -- à ce niveau c'est pas nécessaire car on est sur que nbrValue >=1

    -- je récupére le type semantic et syntactic de la data
    EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM '||
        DR_CSVfile_Coli ||' WHERE  ( UPPER(OLDVALUES) = UPPER('''|| data
        ||''') OR OLDVALUES = '''|| data
        ||''' ) AND  UPPER(CSVName) = UPPER('''|| CSVName ||''') AND ROWNUM = 1' INTO nbrValue;
    IF(nbrValue = 0) THEN
        -- si la données est null alors on newData =  null 
        newData := null;
    ELSE
        EXECUTE IMMEDIATE ' SELECT SEMANTICCATEGORY, SYNTACTICTYPE FROM '||
            DR_CSVfile_Coli ||' WHERE ( UPPER(OLDVALUES) = UPPER('''|| data
            ||''') OR OLDVALUES = '''|| data
            ||''') AND  UPPER(CSVName) = UPPER('''|| CSVName ||''') AND ROWNUM = 1' INTO dataSemanticType,dataSyntacticType;
        --print_debug ('-         [--'||dataSemanticType||'--'||dataSyntacticType||'--]'||data);

        -- je récupére le type semantic et syntactic dominant de la colonne de la data
        nbrValue := getInfoCol(CSVName,laColonne,doNotCare,theDominantSemanticType,theDominantSyntacticType,doNotCare);
        --print_debug ('+         [--'||theDominantSemanticType||'--'||theDominantSyntacticType||'--]');

        ------------------------------------------------------------------------------------------------------------
        -- Début de la partie sur la correction
        ------------------------------------------------------------------------------------------------------------
        IF((dataSyntacticType = theDominantSyntacticType) AND (dataSemanticType LIKE '%'||theDominantSemanticType||'%')) THEN
            -- ici on effectue l'homogénisation des données
            newData := CleanData(data,theDominantSemanticType,theDominantSyntacticType);
            --print_debug ('*    [--'||dataSemanticType||'--'||dataSyntacticType||'--]'||data||' -> '||newData);

        ELSE
            -- ici on essaye de corriger les annomalies
            -- TODO
            testCorrectSpecialData := CorrectSpecialData(data,theDominantSemanticType,newData);
            IF ( testCorrectSpecialData = false ) THEN 
                newData := CorrectData(data, laColonne, dataSyntacticType, dataSemanticType, DR_CSVfile_TabCol);
            ELSE
                print_debug (' ******* [ CORRECTION SPECIAL ] ['||data||'] -> ['||newData||'] *******');
            END IF;
            /*

            IF ((dataSyntacticType <> theDominantSyntacticType) AND (dataSemanticType NOT LIKE '%'||theDominantSemanticType||'%')) THEN
                newData := null;--data;

            ELSIF ((dataSyntacticType <> theDominantSyntacticType)) THEN
                -- TODO fctsyn
                newData := null;--data;

            ELSIF ((dataSyntacticType = theDominantSyntacticType) AND (dataSemanticType NOT LIKE '%'||theDominantSemanticType||'%')) THEN
                -- TODO fctsem
                newData := null;--data;
            END IF;
            */
        END IF;


    END IF;

    RETURN (newData);
END;
/
-------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION NormaliserSyntacticType(data IN VARCHAR2,syntacticType IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
BEGIN


    IF(data IS NULL) THEN
        newData := 'null';
    ELSIF(syntacticType ='VARCHAR2' OR syntacticType ='DATE' ) THEN
        newData := ''''||data||'''';
    ELSE
      newData := data;
    END IF;

    RETURN (newData);
END;
/

---------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE NormalizeAndCleanData(CSVName in VARCHAR2, laTable in VARCHAR2) AS
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
    print_debug (' +---------------------------------------------------------------------+ ');
    print_debug (' [ NORMALISATION AND CLEANING DATA ] ');

    dataReportTableName := 'DR_'||CSVName||'_TabCol';
    EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_DATE_FORMAT = ''YYYY-MM-DD'' ';

    --- cette requête permet de récupérer les colonnes qu'une table passer en paramètres
    selected_values := ' COLUMN_NAME ';
    where_conditions := ' where table_name = '''||upper(laTable)||''' AND DATA_TYPE = ''VARCHAR2''';
    myQuery := 'SELECT '|| selected_values ||' FROM user_tab_columns'|| where_conditions;

    open table_cursor for myQuery;
    loop
        fetch table_cursor into colName ;
        EXIT when table_cursor%NOTFOUND;

        nbrValue :=0;
        nbrValue := getInfoCol(CSVName,colName,newColName,theDominantSemanticType,theDominantSyntacticType,maxLength);
        IF (nbrValue > 0 ) THEN

            print_debug (' ----- ['|| newColName ||' '||theDominantSyntacticType||'('||maxLength||') ]');

            -- ajout de la  nouvelle colonne
            getNewtype(theDominantSyntacticType,maxLength,newColType);
            alterAddCol(laTable,newColName,newColType);

            dataReportTableNameByCol := 'DR_'||CSVName||'_'||colName;
            --print_debug ('[ Colonnes: '||colName||' -> '||newColName||' ]');

            --------------------------------------

            myQuery_col := ' SELECT OLDVALUES, NEWVALUES FROM '|| dataReportTableNameByCol ;
            --print_debug(myQuery_col);

            open table_cursor_col for myQuery_col;
            loop
                fetch table_cursor_col into oldValueCol, oldValueCol_new ;
                EXIT when table_cursor_col%NOTFOUND;

                --print_debug('++++++++++++['||oldValueCol);
                -- c'est ici que l'homogénisation des données et les correction éventuelle seront faites
                newValueCol := 'EN COURS ... ';
                newValueCol := getNewCleanValue(
                    oldValueCol,
                    CSVName,
                    colName,
                    dataReportTableNameByCol,
                    dataReportTableName);

                -- remarque : si c'est une chaine ne pas oublier les ''
                newValueCol := NormaliserSyntacticType(newValueCol,theDominantSyntacticType);

                -- sauvegarde de la nouvelle données
                oldValueCol_new := ''''||oldValueCol_new||'''';
                --myUpdateQuery := 'UPDATE '||laTable||' SET '||newColName||' = '||newValueCol||' WHERE '|| colName || ' = '||oldValueCol_new;
                oldValueCol := ''''||oldValueCol||'''';
                myUpdateQuery := 'UPDATE '||laTable||' SET '||newColName||' = '||newValueCol||' WHERE '|| colName || ' = '||oldValueCol;
                --print_debug('++++++++++++['||myUpdateQuery);
                -- TODO : delete that test
                -- IF (theDominantSemanticType = 'GENDER') THEN 
                --     print_debug (' ******* [ CORRECTION SPECIAL ] ['||oldValueCol||'] -> ['||newValueCol||'] *******');
                --     print_debug(myUpdateQuery);
                -- END IF;
                --

                EXECUTE IMMEDIATE myUpdateQuery;


            end loop;
            close table_cursor_col;
            --------------------------------------

            -- suppression de l'ancienne colonne
            alterDropCol(laTable,colName);

            --print_debug ('[------------------------ FIN ----------------------------]');

        ELSE
            print_debug (' ------- [ Colonnes: '||colName||'  ALREADY EXIST ... ] ');

        END IF;

    end loop;
    close table_cursor;

    print_debug (' ---------- [ CHECK TABLE : '|| laTable ||' To See Modification ] ');
    print_debug (' ---------- [ select * from '|| laTable ||'; ] ');

END;
/

COMMIT;
