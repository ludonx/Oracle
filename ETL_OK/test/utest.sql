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
-- nettoyage #TODO
    --newValueCol := xxx(oldValueCol,oldValueCol_new,theDominantSemanticType);
    -- remarque : si c'est une chaine ne pas oublier les ''
    --newValueCol := 'EN COURS ... ';

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
            newData := data;

        ELSIF ((dataSyntacticType <> theDominantSyntacticType)) THEN
            -- TODO fctsyn
            newData := data;

        ELSIF ((dataSyntacticType = theDominantSyntacticType) AND (dataSemanticType NOT LIKE '%'||theDominantSemanticType||'%')) THEN
            -- TODO fctsem
            newData := data;
        END IF;




    END IF;

    RETURN (newData);
END;
/

COMMIT;
