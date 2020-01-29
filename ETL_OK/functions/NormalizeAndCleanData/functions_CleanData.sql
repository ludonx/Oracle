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
    ELSIF (semanticType LIKE 'ID') THEN
        newData := CleanData_Id (data);
    ELSIF (semanticType LIKE 'EMAIL') THEN
        newData := CleanData_Email (data);
    ELSIF (semanticType LIKE 'BLOODGROUP') THEN
        newData := CleanData_BLOODGROUP (data);
    ELSIF (semanticType LIKE 'WEIGHT') THEN
        newData := CleanData_Weight (data);
    ELSIF (semanticType LIKE 'MEAN') THEN
        newData := CleanData_Mean (data);
    ELSIF (semanticType LIKE 'SIZEDISTANCE_LENGTH') THEN
        newData := CleanData_SIZEDISTANCE_LENGTH (data);
    ELSIF (semanticType LIKE 'PHONE') THEN
        newData := CleanData_Phone (data);
    ELSIF (semanticType LIKE 'XXXX') THEN
        newData := null;
    ELSIF (semanticType LIKE 'XXXX') THEN
        newData := null;
    ELSIF (semanticType LIKE 'XXXX') THEN
        newData := null;
    END IF;

    RETURN (newData);
END;
/

-- CleanData_Date ----------------------------------------------------------------

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
    --print_debug(data);
    newData := null;
    SELECT SUBCATEGORY INTO subSemanticType
    FROM DDRE
    WHERE ( REGEXP_LIKE (UPPER(data),REGULAREXPRESSION) OR REGEXP_LIKE (data,REGULAREXPRESSION) )
    AND CATEGORY = 'DATE'
    AND ROWNUM = 1;
 -- (-|/)
    --DBMS_OUTPUT.put_line('SEM <--->'||subSemanticType);
    --print_debug('++++++++++++['||subSemanticType||'--'||data);
    --print_debug(subSemanticType);
    IF(subSemanticType LIKE 'DATE_FR') THEN
        regularExpresion := '([[:digit:]]{2})(-|/)([[:digit:]]{2})(-|/)([[:digit:]]{4})';
        newData := REGEXP_REPLACE(data,regularExpresion,'\5-\3-\1');
    ELSIF (subSemanticType LIKE 'DATE_FR_2') THEN    
        regularExpresion := '([[:digit:]]{2})(-|/)([A-Zéæçàa-zéèçàuû]{2,50})(-|/)([[:digit:]]{4})';

        annee := REGEXP_REPLACE(data,regularExpresion,'\5');
        mois := REGEXP_REPLACE(data,regularExpresion,'\3');
        jours := REGEXP_REPLACE(data,regularExpresion,'\1');
        
        --print_debug(subSemanticType);
        numMois := mois;
        select NUM INTO numMois
        FROM DICOMOIS
        where MOIS_FR like mois
        OR UPPER(MOIS_FR) like UPPER(mois)
        OR MOIS_EN like mois
        OR UPPER(MOIS_EN) like UPPER(mois);

        --print_debug(subSemanticType);
        newData := annee||'-'||numMois||'-'||jours;
        --print_debug(newData);
    ELSIF (subSemanticType LIKE 'DATE_FR_3') THEN  
    --'mercredi 14-novembre-1962  
    
        regularExpresion := '([A-Zéæçàa-zéèçàuû]{2,10})(\s)([[:digit:]]{2})(-|/)([A-Zéæçàa-zéèçàuû]{2,50})(-|/)([[:digit:]]{4})';

        annee := REGEXP_REPLACE(data,regularExpresion,'\7');
        mois := REGEXP_REPLACE(data,regularExpresion,'\5');
        jours := REGEXP_REPLACE(data,regularExpresion,'\3');

        numMois := mois;
        select NUM INTO numMois
        FROM DICOMOIS
        where MOIS_FR like mois
        OR UPPER(MOIS_FR) like UPPER(mois)
        OR MOIS_EN like mois
        OR UPPER(MOIS_EN) like UPPER(mois);

        newData := annee||'-'||numMois||'-'||jours;
     ELSIF (subSemanticType LIKE 'DATE_USA') THEN
        regularExpresion := '([[:digit:]]{2})(-|/)([[:digit:]]{2})(-|/)([[:digit:]]{2,4})';
        newData := REGEXP_REPLACE(data,regularExpresion,'\5-\1-\3');

    END IF;
    --DBMS_OUTPUT.put_line('SEM <--->'||subSemanticType);
    RETURN (newData);
END;
/
-- CleanData_Temperature --------------------------------------------------------------
CREATE OR REPLACE FUNCTION CleanData_Temperature(dataIN IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
regularExpresion VARCHAR2(500);
data VARCHAR2(500);

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
    data := dataIN;

    SELECT SUBCATEGORY INTO subSemanticType
    FROM DDRE
    WHERE (REGEXP_LIKE (UPPER(data),REGULAREXPRESSION) OR REGEXP_LIKE (data,REGULAREXPRESSION))
    AND CATEGORY = 'TEMPERATURE'
    AND ROWNUM = 1;
    -- comm UPPER(°c) = °C on peux tous mettre en majuscule avant de faire la convertion
    -- si UPPER(°c) <> °C il aurait fallut modifier le regex et mettre le cas de valeur min
    data := UPPER(data); 
    IF(subSemanticType LIKE 'TEMPERATURE_CELSIUS') THEN
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)(\s?(°C|°CELSIUS|CELSIUS))';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'TEMPERATURE_FAHRENHEIT') THEN
        regularExpresion := '^([\+-]?[0-9]+((\.|,)\d+)?)(\s?(°F|°FAHRENHEIT|FAHRENHEIT°))$';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        --(32 °F − 32) × 5/9 = 0 °C
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := ( TO_NUMBER(newData) - 32 ) * 5/9 ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'TEMPERATURE_KELVIN') THEN
        regularExpresion := '^([\+-]?[0-9]+((\.|,)\d+)?)(\s?((K|KELVIN)))$';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        --0 K − 273,15 = -273,1 °C
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) - 273.15;
        newData := REGEXP_REPLACE(newData,',','.');

    END IF;

    RETURN (newData);
END;
/
-- CleanData_Age --------------------------------------------------------------

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

-- CleanData_Gender --------------------------------------------------------------

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


-- CleanData_Names --------------------------------------------------------------


CREATE OR REPLACE FUNCTION CleanData_Names(data IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);

regularExpresion VARCHAR2(500);
nbr NUMBER;
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

    ---------------------------------------------------------------------------------------
    IF isCity(data) = true THEN
      subSemanticType := 'CITY';
    END IF;
    ---------------------------------------------------------------------------------------
    IF isCountry(data) = true THEN
      subSemanticType := 'COUNTRY';
    END IF;
    ---------------------------------------------------------------------------------------
    IF isContinent(data) = true THEN
      subSemanticType := 'CONTINENT';
    END IF;
    ---------------------------------------------------------------------------------------


    -- TODO : modifier la langue d'intérprétation des caractéres de ORACLE ( voir TRICK)
    -- solution Provisoire : évité d'utilisé LOWER 
    IF(subSemanticType LIKE 'LASTNAME' OR subSemanticType LIKE 'CONTINENT' ) THEN

        newData := UPPER(data);

    ELSIF(subSemanticType LIKE 'FIRSTNAME' OR subSemanticType LIKE 'CITY' OR subSemanticType LIKE 'COUNTRY') THEN

        newData := INITCAP(LOWER(data));
        --print_debug('+++++++['||newData);
        --newData := INITCAP(data);

    ELSIF(subSemanticType LIKE 'CIVILITY_FR' OR subSemanticType LIKE 'CIVILITY_EN') THEN
        newData := UPPER(data);
        
    ELSIF(subSemanticType LIKE 'FULLNAME') THEN

        regularExpresion := '^([A-Za-zéèçà]{2,50}(-| )?)(([A-Za-zéèçà]{2,50})?)$';
        firstName := REGEXP_REPLACE(data,regularExpresion,'\1');
        lastName := REGEXP_REPLACE(data,regularExpresion,'\3');

        newData := INITCAP(firstName) ||UPPER(lastName);

    ELSIF(subSemanticType LIKE 'FULLNAME_CIVILITY') THEN
        --print_debug('++++++++++++++++++++++++++++++++++');

        regularExpresion := '^((M.|Mme|m)\s*)([A-Za-zéèçà]{2,50}(-| )?)(([A-Za-zéèçà]{2,50})?)$';
        -- () -> \i  (()) -> \1 \2
        civility := REGEXP_REPLACE(data,regularExpresion,'\1');
        firstName := REGEXP_REPLACE(data,regularExpresion,'\3');
        lastName := REGEXP_REPLACE(data,regularExpresion,'\5');
        -- TODO : modifier la langue d'intérprétation des caractéres de ORACLE ( voir TRICK)
        newData := INITCAP(LOWER(civility))||INITCAP(LOWER(firstName))||UPPER(lastName);
        --print_debug(newData);
        -- solution Provisoire : évité d'utilisé LOWER 
        --newData := INITCAP(civility)||INITCAP(firstName)||UPPER(lastName);
    END IF;
    --DBMS_OUTPUT.put_line('SEM <--->'||subSemanticType);
    RETURN (newData);
END;
/


-- CleanData_Weight -------------------------------------------------------------- 
CREATE OR REPLACE FUNCTION CleanData_Weight (dataIN IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
regularExpresion VARCHAR2(500);
data VARCHAR2(500);

facteur NUMBER ;

BEGIN

    newData := null;
    data := dataIN;

    SELECT SUBCATEGORY INTO subSemanticType
    FROM DDRE
    WHERE (REGEXP_LIKE (UPPER(data),REGULAREXPRESSION) OR REGEXP_LIKE (data,REGULAREXPRESSION))
    AND CATEGORY = 'WEIGHT'
    AND ROWNUM = 1;
    -- comm UPPER(°c) = °C on peux tous mettre en majuscule avant de faire la convertion
    -- si UPPER(°c) <> °C il aurait fallut modifier le regex et mettre le cas de valeur min
    data := UPPER(data); 


    IF(subSemanticType LIKE 'WEIGHT_FR_KG' OR subSemanticType LIKE 'WEIGHT_EN_KG' ) THEN
        ------------------------------------------------------------------- WEIGHT_FR_KG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        newData := REGEXP_REPLACE(newData,',','.');
        

    ELSIF (subSemanticType LIKE 'WEIGHT_FR_G' OR subSemanticType LIKE 'WEIGHT_EN_G') THEN
        ------------------------------------------------------------------- WEIGHT_FR_G
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/1000 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');
    
    ELSIF (subSemanticType LIKE 'WEIGHT_TO' OR subSemanticType LIKE 'WEIGHT_TO') THEN
        ------------------------------------------------------------------- WEIGHT_TO
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1000 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'WEIGHT_FR_LB' OR subSemanticType LIKE 'WEIGHT_EN_LB') THEN
        ------------------------------------------------------------------- WEIGHT_FR_LB
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/2.205 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'WEIGHT_OZ' OR subSemanticType LIKE 'WEIGHT_OZ') THEN
        ------------------------------------------------------------------- WEIGHT_OZ
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/35.274 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'WEIGHT_FR_MGG' OR subSemanticType LIKE 'WEIGHT_EN_MGG') THEN
        ------------------------------------------------------------------- WEIGHT_FR_MGG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1000000 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'WEIGHT_FR_GG' OR subSemanticType LIKE 'WEIGHT_EN_GG') THEN
        ------------------------------------------------------------------- WEIGHT_FR_GG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1000000000 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'WEIGHT_FR_TG' OR subSemanticType LIKE 'WEIGHT_EN_TG') THEN
        ------------------------------------------------------------------- WEIGHT_FR_TG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1000000000000 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');


    ELSIF (subSemanticType LIKE 'WEIGHT_FR_EG' OR subSemanticType LIKE 'WEIGHT_EN_EG') THEN
        ------------------------------------------------------------------- WEIGHT_FR_EG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1000000000000000 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'WEIGHT_FR_ZG' OR subSemanticType LIKE 'WEIGHT_EN_ZG') THEN
        ------------------------------------------------------------------- WEIGHT_OZ
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1000000000000000000 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'WEIGHT_FR_YG' OR subSemanticType LIKE 'WEIGHT_EN_YG') THEN
        ------------------------------------------------------------------- WEIGHT_FR_YG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1000000000000000000000 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'WEIGHT_FR_HG' OR subSemanticType LIKE 'WEIGHT_EN_HG') THEN
        ------------------------------------------------------------------- WEIGHT_FR_HG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/10 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');
    
    ELSIF (subSemanticType LIKE 'WEIGHT_FR_DAG' OR subSemanticType LIKE 'WEIGHT_EN_DAG') THEN
        ------------------------------------------------------------------- WEIGHT_FR_DAG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/100 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'WEIGHT_FR_DG' OR subSemanticType LIKE 'WEIGHT_EN_DG') THEN
        ------------------------------------------------------------------- WEIGHT_FR_DG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/10000 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'WEIGHT_FR_CG' OR subSemanticType LIKE 'WEIGHT_EN_CG') THEN
        ------------------------------------------------------------------- WEIGHT_FR_CG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/100000 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'WEIGHT_FR_MG' OR subSemanticType LIKE 'WEIGHT_EN_MG') THEN
        ------------------------------------------------------------------- WEIGHT_FR_MG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/1000000 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'WEIGHT_FR_μG' OR subSemanticType LIKE 'WEIGHT_EN_μG') THEN
        ------------------------------------------------------------------- WEIGHT_FR_G
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/1000000000 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

     ELSIF (subSemanticType LIKE 'WEIGHT_FR_NG' OR subSemanticType LIKE 'WEIGHT_EN_NG') THEN
        ------------------------------------------------------------------- WEIGHT_FR_NG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/1000000000000 ;
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSE
        newData := null;
    END IF;
    --print_debug('++++++++++++['||newData||'--'||data);
    RETURN (newData);
END;
/

-- CleanData_Mean --------------------------------------------------------------

CREATE OR REPLACE FUNCTION CleanData_Mean (data IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
BEGIN

    newData := null;

    SELECT SUBCATEGORY INTO subSemanticType
    FROM DDRE
    WHERE REGEXP_LIKE (UPPER(data),REGULAREXPRESSION)
    AND CATEGORY = 'MEAN'
    AND ROWNUM = 1;


    IF(subSemanticType LIKE 'MEAN') THEN
        newData := REGEXP_REPLACE(data,',','.');
    END IF;

    RETURN (newData);
END;
/

-- CleanData_Id --------------------------------------------------------------

CREATE OR REPLACE FUNCTION CleanData_Id (data IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
BEGIN

    newData := null;

    SELECT SUBCATEGORY INTO subSemanticType
    FROM DDRE
    WHERE REGEXP_LIKE (UPPER(data),REGULAREXPRESSION)
    AND CATEGORY = 'ID'
    AND ROWNUM = 1;


    IF(subSemanticType LIKE 'ID') THEN
        newData := UPPER(data);
    END IF;

    RETURN (newData);
END;
/

-- CleanData_SIZEDISTANCE_LENGTH -------------------------------------------------------------- 
CREATE OR REPLACE FUNCTION CleanData_SIZEDISTANCE_LENGTH (dataIN IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
regularExpresion VARCHAR2(500);
data VARCHAR2(500);

facteur NUMBER ;

BEGIN

    newData := null;
    data := dataIN;

    SELECT SUBCATEGORY INTO subSemanticType
    FROM DDRE
    WHERE (REGEXP_LIKE (UPPER(data),REGULAREXPRESSION) OR REGEXP_LIKE (data,REGULAREXPRESSION))
    AND CATEGORY = 'SIZEDISTANCE_LENGTH'
    AND ROWNUM = 1;
    -- comm UPPER(°c) = °C on peux tous mettre en majuscule avant de faire la convertion
    -- si UPPER(°c) <> °C il aurait fallut modifier le regex et mettre le cas de valeur min
    data := UPPER(data); 


    IF(subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_KM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_KM' ) THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_KG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1 ; -- conversion en KM
        facteur := facteur * 1000 ; -- conversion en MÈTRES
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');
        

    ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_M' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_M') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_G
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/1000 ; -- conversion en KM
        facteur := facteur * 1000 ; -- conversion en MÈTRES
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');


    ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_MGM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_MGM') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_MGG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1000000 ;
        facteur := facteur * 1000 ; -- conversion en MÈTRES
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_GM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_GM') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_GG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1000000000 ;
        facteur := facteur * 1000 ; -- conversion en MÈTRES
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_TM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_TM') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_TG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1000000000000 ;
        facteur := facteur * 1000 ; -- conversion en MÈTRES
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');


    ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_EM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_EM') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_EG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1000000000000000 ;
        facteur := facteur * 1000 ; -- conversion en MÈTRES

        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_ZM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_ZM') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_OZ
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1000000000000000000 ;
        facteur := facteur * 1000 ; -- conversion en MÈTRES

        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_YM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_YM') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_YG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1000000000000000000000 ;
        facteur := facteur * 1000 ; -- conversion en MÈTRES

        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_HM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_HM') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_HG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/10 ;
        facteur := facteur * 1000 ; -- conversion en MÈTRES
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');
    
    ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_DAM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_DAM') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_DAG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/100 ;
        facteur := facteur * 1000 ; -- conversion en MÈTRES
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_DM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_DM') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_DG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/10000 ;
        facteur := facteur * 1000 ; -- conversion en MÈTRES
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_CM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_CM') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_CG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/100000 ;
        facteur := facteur * 1000 ; -- conversion en MÈTRES
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_MM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_MM') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_MG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/1000000 ;
        facteur := facteur * 1000 ; -- conversion en MÈTRES
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_μM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_μM') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_G
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/1000000000 ;
        facteur := facteur * 1000 ; -- conversion en MÈTRES
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

     ELSIF (subSemanticType LIKE 'SIZEDISTANCE_LENGTH_FR_NM' OR subSemanticType LIKE 'SIZEDISTANCE_LENGTH_EN_NM') THEN
        ------------------------------------------------------------------- SIZEDISTANCE_LENGTH_FR_NG
        regularExpresion := '([\+-]?[0-9]+((\.|,)\d+)?)([[:alpha:] ]*)';
        newData := REGEXP_REPLACE(data,regularExpresion,'\1');
        facteur := 1/1000000000000 ;
        facteur := facteur * 1000 ; -- conversion en MÈTRES
        
        newData := REGEXP_REPLACE(newData,'\.',',');
        newData := TO_NUMBER(newData) * facteur ;
        newData := REGEXP_REPLACE(newData,',','.');

    ELSE
        newData := null;
    END IF;
    --print_debug('++++++++++++['||newData||'--'||data);
    RETURN (newData);
END;
/


-- CleanData_Email --------------------------------------------------------------

CREATE OR REPLACE FUNCTION CleanData_Email (data IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
BEGIN

    newData := null;

    SELECT SUBCATEGORY INTO subSemanticType
    FROM DDRE
    WHERE ( REGEXP_LIKE (UPPER(data),REGULAREXPRESSION) OR  REGEXP_LIKE (data,REGULAREXPRESSION) )
    AND CATEGORY = 'EMAIL'
    AND ROWNUM = 1;


    IF(subSemanticType LIKE 'EMAIL') THEN
        newData := data;
    END IF;

    RETURN (newData);
END;
/


-- CleanData_BLOODGROUP --------------------------------------------------------------

CREATE OR REPLACE FUNCTION CleanData_BLOODGROUP (data IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
BEGIN

    newData := null;

    SELECT SUBCATEGORY INTO subSemanticType
    FROM DDRE
    WHERE ( REGEXP_LIKE (UPPER(data),REGULAREXPRESSION) OR  REGEXP_LIKE (data,REGULAREXPRESSION) )
    AND CATEGORY = 'BLOODGROUP'
    AND ROWNUM = 1;


    IF(subSemanticType LIKE 'BLOODGROUP') THEN
        newData := UPPER(data);
    END IF;

    RETURN (newData);
END;
/

-- CleanData_Phone --------------------------------------------------------------

CREATE OR REPLACE FUNCTION CleanData_Phone (data IN VARCHAR2)
    RETURN VARCHAR2
AS
newData VARCHAR2(500);
subSemanticType VARCHAR2(500);
regularExpresion VARCHAR2(500);
BEGIN

    newData := null;

    SELECT SUBCATEGORY INTO subSemanticType
    FROM DDRE
    WHERE ( REGEXP_LIKE (UPPER(data),REGULAREXPRESSION) OR  REGEXP_LIKE (data,REGULAREXPRESSION) )
    AND CATEGORY = 'PHONE'
    AND ROWNUM = 1;


    IF(subSemanticType LIKE 'PHONE') THEN
        regularExpresion := '^(+)?[0-9]{10,15}$';
        newData := data;--REGEXP_REPLACE(data,regularExpresion,'(\2) \4 \6');
    END IF;

    RETURN (newData);
END;
/