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

CREATE OR REPLACE FUNCTION CleanData_Date(data IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
BEGIN
    -- on transfome 
    -- date_fr : ([0-2][0-9]|3[0-1])-(0[0-9]|1[0-2])-[0-9]{4}
    -- date_usa : (0[0-9]|1[0-2])-([0-2][0-9]|3[0-1])-[0-9]{2}
    -- en DATE_ISO : [0-9]{4}-(0[0-9]|1[0-2])-([0-2][0-9]|3[0-1])

    --jj/mm/aaaa fr
    --aaaa-mm-jj iso
    --mm-jj-aa usa
    newData := null;

    SELECT SUBCATEGORY INTO subSemanticType 
    FROM DDRE 
    WHERE REGEXP_LIKE (UPPER(data),REGULAREXPRESSION) 
    AND CATEGORY = 'DATE'
    AND ROWNUM = 1;
   
    
    IF(subSemanticType LIKE 'DATE_FR') THEN
        newData := REGEXP_REPLACE(data,
                    '([[:digit:]]{2})-([[:digit:]]{2})-([[:digit:]]{4})',
                    '\3-\2-\1');
    ELSIF (subSemanticType LIKE 'DATE_USA') THEN
        newData := REGEXP_REPLACE(data,
                    '([[:digit:]]{2})-([[:digit:]]{2})-([[:digit:]]{2})',
                    '\3-\1-\2');

    END IF;

    RETURN (newData);
END;
/
----------------------------------------------------------------
CREATE OR REPLACE FUNCTION CleanData_Temperature(data IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
BEGIN
    -- on transfome 
    -- temperature F : xx °F
    -- en temperature C : xx °C
    -- tempC := (TO_NUMBER(tempF) -32)*5/9;

    --TEMPERATURE_CELSIUS', '^([\+-]?[0-9]+((\.|,)\d+)?\s?(°C|°CELSIUS|CELSIUS))$');
    --TEMPERATURE_FAHRENHEIT', '^([\+-]?[0-9]+((\.|,)\d+)?\s?(°F|°FAHRENHEIT|FAHRENHEIT°))$');
    --TEMPERATURE_KELVIN', '^[\+-]?[0-9]+((\.|,)\d+)?\s?((K|KELVIN))$');
    -- 0 K − 273,15 = -273,1 °C
    -- (32 °F − 32) × 5/9 = 0 °C

    newData := null;

    SELECT SUBCATEGORY INTO subSemanticType 
    FROM DDRE 
    WHERE REGEXP_LIKE (UPPER(data),REGULAREXPRESSION) 
    AND CATEGORY = 'TEMPERATURE'
    AND ROWNUM = 1;
   
    
    IF(subSemanticType LIKE 'TEMPERATURE_CELSIUS') THEN
        newData := REGEXP_REPLACE(data,
                        '([\+-]?[0-9]+((\.|,)\d+)?)(\s?(°C|°CELSIUS|CELSIUS))',
                        '\1');
        
    ELSIF (subSemanticType LIKE 'TEMPERATURE_FAHRENHEIT') THEN
        newData := REGEXP_REPLACE(data,
                    '^([\+-]?[0-9]+((\.|,)\d+)?)(\s?(°F|°FAHRENHEIT|FAHRENHEIT°))$',
                    '\1');
        --(32 °F − 32) × 5/9 = 0 °C
        newData := ( TO_NUMBER(newData) - 32 ) * 5/9 ;
        
    ELSIF (subSemanticType LIKE 'TEMPERATURE_KELVIN') THEN
        newData := REGEXP_REPLACE(data,
                    '^([\+-]?[0-9]+((\.|,)\d+)?)(\s?((K|KELVIN)))$',
                    '\1');
        --0 K − 273,15 = -273,1 °C
        newData := TO_NUMBER(newData) - 273.15;

    END IF;

    RETURN (newData);
END;
/
----------------------------------------------------------------

CREATE OR REPLACE FUNCTION CleanData_Age(data IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
BEGIN
    
    newData := null;

    SELECT SUBCATEGORY INTO subSemanticType 
    FROM DDRE 
    WHERE REGEXP_LIKE (UPPER(data),REGULAREXPRESSION) 
    AND CATEGORY = 'AGE'
    AND ROWNUM = 1;
   
    
    IF(subSemanticType LIKE 'AGE') THEN
        newData := TO_NUMBER(data);
    ELSIF (subSemanticType LIKE 'AGE') THEN
        newData := TO_NUMBER(data);

    END IF;

    RETURN (newData);
END;
/
----------------------------------------------------------------
CREATE OR REPLACE FUNCTION CleanData(
    data IN VARCHAR2,
    semanticType IN VARCHAR2,
    syntacticType IN VARCHAR2
    )
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
BEGIN
    newData := null;
    
    IF(semanticType LIKE 'DATE') THEN
        newData := CleanData_Date(data);
    ELSIF (semanticType LIKE 'TEMPERATURE') THEN
        newData := CleanData_Temperature(data);
    ELSIF (semanticType LIKE 'AGE') THEN
        newData := CleanData_Age(data);
    END IF;

    RETURN (newData);
END;
/

------------------------------------------------------------------

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
            newData := data;

            newData := CleanData(data,theDominantSemanticType,theDominantSyntacticType);
            DBMS_OUTPUT.put_line ('*    [--'||dataSemanticType||'--'||dataSyntacticType||'--]'||data||' -> '||newData);

        ELSIF ((dataSyntacticType <> theDominantSyntacticType) AND (dataSemanticType NOT LIKE '%'||theDominantSemanticType||'%')) THEN 
            newData := null;

        ELSIF ((dataSyntacticType <> theDominantSyntacticType)) THEN 
            -- TODO fctsyn
            newData := null;

        ELSIF ((dataSyntacticType = theDominantSyntacticType) AND (dataSemanticType NOT LIKE '%'||theDominantSemanticType||'%')) THEN 
            -- TODO fctsem
            newData := null;
        END IF;


    END IF;

    RETURN (newData);
END;
/

COMMIT;
