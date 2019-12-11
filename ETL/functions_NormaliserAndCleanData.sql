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

BEGIN
    newData := null;
    nbrValue := 0; -- à ce niveau c'est pas nécessaire car on est sur que nbrValue >=1

    -- je récupére le type semantic et syntactic de la data
    EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM '||
        DR_CSVfile_Coli ||' WHERE UPPER(OLDVALUES) = UPPER('''|| data
        ||''') AND  UPPER(CSVName) = UPPER('''|| CSVName ||''') AND ROWNUM = 1' INTO nbrValue;
    IF(nbrValue = 0) THEN
        newData := null;
    ELSE
        EXECUTE IMMEDIATE ' SELECT SEMANTICCATEGORY, SYNTACTICTYPE FROM '||
            DR_CSVfile_Coli ||' WHERE UPPER(OLDVALUES) = UPPER('''|| data
            ||''') AND  UPPER(CSVName) = UPPER('''|| CSVName ||''') AND ROWNUM = 1' INTO dataSemanticType,dataSyntacticType;
        --DBMS_OUTPUT.put_line ('-         [--'||dataSemanticType||'--'||dataSyntacticType||'--]'||data);

        -- je récupére le type semantic et syntactic dominant de la colonne de la data
        nbrValue := getInfoCol(CSVName,laColonne,doNotCare,theDominantSemanticType,theDominantSyntacticType,doNotCare);
        --DBMS_OUTPUT.put_line ('+         [--'||theDominantSemanticType||'--'||theDominantSyntacticType||'--]');

        ------------------------------------------------------------------------------------------------------------
        -- Début de la partie sur la correction
        ------------------------------------------------------------------------------------------------------------
        IF((dataSyntacticType = theDominantSyntacticType) AND (dataSemanticType LIKE '%'||theDominantSemanticType||'%')) THEN

            newData := CleanData(data,theDominantSemanticType,theDominantSyntacticType);
            --DBMS_OUTPUT.put_line ('*    [--'||dataSemanticType||'--'||dataSyntacticType||'--]'||data||' -> '||newData);

        ELSIF ((dataSyntacticType <> theDominantSyntacticType) AND (dataSemanticType NOT LIKE '%'||theDominantSemanticType||'%')) THEN
            newData := null;--data;

        ELSIF ((dataSyntacticType <> theDominantSyntacticType)) THEN
            -- TODO fctsyn
            newData := null;--data;

        ELSIF ((dataSyntacticType = theDominantSyntacticType) AND (dataSemanticType NOT LIKE '%'||theDominantSemanticType||'%')) THEN
            -- TODO fctsem
            newData := null;--data;
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
    EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_DATE_FORMAT = ''YYYY-MM-DD'' ';

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

                newValueCol := NormaliserSyntacticType(newValueCol,theDominantSyntacticType);
                oldValueCol_new := ''''||oldValueCol_new||'''';

                -- sauvegarde de la nouvelle données
                myUpdateQuery := 'UPDATE '||laTable||' SET '||newColName||' = '||newValueCol||' WHERE '|| colName || ' = '||oldValueCol_new;

                --DBMS_OUTPUT.put_line(myUpdateQuery);

                EXECUTE IMMEDIATE myUpdateQuery;


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
