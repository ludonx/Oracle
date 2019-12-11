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
    ELSIF (semanticType LIKE 'GENDER') THEN
        newData := CleanData_Gender(data);
    ELSIF (semanticType LIKE 'NAMES') THEN
        newData := CleanData_Names(data);
    ELSIF (semanticType LIKE 'BLOODGROUP') THEN
        newData := null;
    ELSIF (semanticType LIKE 'SIZEDISTANCE_LENGTH') THEN
        newData := null;
    ELSIF (semanticType LIKE 'EMAIL') THEN
        newData := null;
    ELSIF (semanticType LIKE 'GENDER') THEN
        newData := null;
    ELSIF (semanticType LIKE 'GENDER') THEN
        newData := null;
    ELSIF (semanticType LIKE 'GENDER') THEN
        newData := null;
    END IF;

    RETURN (newData);
END;
/

------------------------------------------------------------------

CREATE OR REPLACE FUNCTION CleanData_Date(data IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
regularExpresion VARCHAR2(500);
annee VARCHAR2(500);
mois VARCHAR2(500);
numMois VARCHAR2(500);
jours VARCHAR2(500);
BEGIN
    -- on transfome
    -- date_fr : ([0-2][0-9]|3[0-1])-(0[0-9]|1[0-2])-[0-9]{4}
    -- DATE_FR_2 :
    -- date_usa : (0[0-9]|1[0-2])-([0-2][0-9]|3[0-1])-[0-9]{2}
    -- en DATE_ISO : [0-9]{4}-(0[0-9]|1[0-2])-([0-2][0-9]|3[0-1])

    --jj/mm/aaaa fr
    -- 05-février-2000 fr_2
    --aaaa-mm-jj iso
    --mm-jj-aa usa
    newData := null;
    SELECT SUBCATEGORY INTO subSemanticType
    FROM DDRE
    WHERE ( REGEXP_LIKE (UPPER(data),REGULAREXPRESSION) OR REGEXP_LIKE (data,REGULAREXPRESSION) )
    AND CATEGORY = 'DATE'
    AND ROWNUM = 1;
 -- (-|/)
    --DBMS_OUTPUT.put_line('SEM <--->'||subSemanticType);

    IF(subSemanticType LIKE 'DATE_FR') THEN
        regularExpresion := '([[:digit:]]{2})(-|/)([[:digit:]]{2})(-|/)([[:digit:]]{4})';
        newData := REGEXP_REPLACE(data,regularExpresion,'\5-\3-\1');
    ELSIF (subSemanticType LIKE 'DATE_FR_2') THEN

        regularExpresion := '([[:digit:]]{2})(-|/)([A-Zéæçàa-zéèçàuû]{2,50})(-|/)([[:digit:]]{4})';

        annee := REGEXP_REPLACE(data,regularExpresion,'\5');
        mois := REGEXP_REPLACE(data,regularExpresion,'\3');
        jours := REGEXP_REPLACE(data,regularExpresion,'\1');

        numMois := mois;
        select NUM INTO numMois
        FROM DICOMOIS
        where MOIS_FR like mois
        OR UPPER(MOIS_FR) like UPPER(mois)
        OR MOIS_EN like mois
        OR UPPER(MOIS_EN) like UPPER(mois);

        newData := annee||'-'||numMois||'-'||jours;
     ELSIF (subSemanticType LIKE 'DATE_USA') THEN
        regularExpresion := '([[:digit:]]{2})(-|/)([[:digit:]]{2})(-|/)([[:digit:]]{2})';
        newData := REGEXP_REPLACE(data,regularExpresion,'\5-\1-\3');

    END IF;
    --DBMS_OUTPUT.put_line('SEM <--->'||subSemanticType);
    RETURN (newData);
END;
/
----------------------------------------------------------------
CREATE OR REPLACE FUNCTION CleanData_Temperature(data IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
regularExpresion VARCHAR2(500);

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
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)(\s?(°C|°CELSIUS|CELSIUS))';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'TEMPERATURE_FAHRENHEIT') THEN
        regularExpresion := '^([\+-]?[0-9]+((\.|,)\d+)?)(\s?(°F|°FAHRENHEIT|FAHRENHEIT°))$';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        --(32 °F − 32) × 5/9 = 0 °C
        newData := ( TO_NUMBER(newData) - 32 ) * 5/9 ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'TEMPERATURE_KELVIN') THEN
        regularExpresion := '^([\+-]?[0-9]+((\.|,)\d+)?)(\s?((K|KELVIN)))$';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        --0 K − 273,15 = -273,1 °C
        newData := TO_NUMBER(newData) - 273.15;
        newData := REGEXP_REPLACE(newData,',','.');

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
    END IF;

    RETURN (newData);
END;
/

----------------------------------------------------------------

CREATE OR REPLACE FUNCTION CleanData_Gender(data IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
BEGIN

    newData := null;

    SELECT SUBCATEGORY INTO subSemanticType
    FROM DDRE
    WHERE REGEXP_LIKE (UPPER(data),REGULAREXPRESSION)
    AND CATEGORY = 'GENDER'
    AND ROWNUM = 1;


    IF(subSemanticType LIKE 'GENDER_FR') THEN
        newData := UPPER(data);
    END IF;

    RETURN (newData);
END;
/


----------------------------------------------------------------


CREATE OR REPLACE FUNCTION CleanData_Names(data IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);

regularExpresion VARCHAR2(500);
nbrVille NUMBER;
firstName VARCHAR2(50);
lastName VARCHAR2(50);
civility VARCHAR2(50);
BEGIN

    newData := null;

    SELECT SUBCATEGORY INTO subSemanticType
    FROM DDRE
    WHERE REGEXP_LIKE (UPPER(data),REGULAREXPRESSION)
    AND CATEGORY = 'NAMES'
    AND ROWNUM = 1;

    nbrVille := 0;
    SELECT COUNT(*) INTO nbrVille FROM DICOPAYSVILLE WHERE VILLE = UPPER(data) OR VILLE = data;
    IF nbrVille > 0 THEN
      subSemanticType := 'CITY';
    END IF;

    IF(subSemanticType LIKE 'LASTNAME') THEN

        newData := UPPER(data);

    ELSIF(subSemanticType LIKE 'FIRSTNAME' OR subSemanticType LIKE 'CITY') THEN

        newData := INITCAP(LOWER(data));

    ELSIF(subSemanticType LIKE 'FULLNAME') THEN

        regularExpresion := '^([A-Za-zéèçà]{2,50}(-| )?)(([A-Za-zéèçà]{2,50})?)$';
        firstName := REGEXP_REPLACE(data,regularExpresion,'\1');
        lastName := REGEXP_REPLACE(data,regularExpresion,'\3');

        newData := INITCAP(LOWER(firstName)) ||UPPER(lastName);

    ELSIF(subSemanticType LIKE 'FULLNAME_CIVILITY') THEN

        regularExpresion := '^((M.|Mme|m)\s*)([A-Za-zéèçà]{2,50}(-| )?)(([A-Za-zéèçà]{2,50})?)$';
        -- () -> \i  (()) -> \1 \2
        civility := REGEXP_REPLACE(data,regularExpresion,'\1');
        firstName := REGEXP_REPLACE(data,regularExpresion,'\3');
        lastName := REGEXP_REPLACE(data,regularExpresion,'\5');

        newData := INITCAP(civility)||INITCAP(LOWER(firstName))||UPPER(lastName);
    END IF;
    --DBMS_OUTPUT.put_line('SEM <--->'||subSemanticType);
    RETURN (newData);
END;
/
