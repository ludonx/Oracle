-------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION CorrectSpecialData(
    data IN VARCHAR2,
    theDominantSemanticType IN VARCHAR2,
    newData OUT VARCHAR2)

    RETURN BOOLEAN
AS
correctionApplied BOOLEAN;
BEGIN
    correctionApplied := false;
    
    IF(theDominantSemanticType LIKE 'GENDER') THEN
        ----------------------------------------------------------------------GENDER
        IF ( data = '1' ) THEN 
            newData := 'M';
            correctionApplied := true;            
        ELSIF ( data = '0') THEN 
            newData := 'F';
            correctionApplied := true;            
        END IF;
        

    --ELSIF (theDominantSemanticType LIKE 'xxxxxxx' )
        ----------------------------------------------------------------------xxxxxxx
        
    END IF;
    ----------------------------------------------------------------------
    RETURN (correctionApplied);
END;
/

-------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION CorrectData(
    data IN VARCHAR2,
    laColonne IN VARCHAR2,
    dataSyntacticType IN VARCHAR2,
    dataSemanticType IN VARCHAR2,
    DR_CSVfile_TabCol IN VARCHAR2)


    RETURN VARCHAR2
AS
myQueryCheck VARCHAR2(500);
myQuery VARCHAR2(500);

nbr NUMBER;
newData VARCHAR2(500);
BEGIN
    newData := null;
    nbr := 0 ;
    myQueryCheck := ' SELECT COUNT(*) FROM '||
            DR_CSVfile_TabCol ||' WHERE UPPER(OLDName) = UPPER('''|| laColonne
            ||''') AND UPPER(theDominantSyntacticType) = UPPER('''|| dataSyntacticType
            ||''') AND UPPER(theDominantSemanticType) = UPPER('''|| dataSemanticType
            ||''')';
        
    EXECUTE IMMEDIATE myQueryCheck INTO nbr;
    IF( nbr = 0 ) THEN
        -- aucune colonnes ne correspond à notre donnée 
        -- TODO implementé une possible solution sino null
        newData := null;
    ELSIF (nbr = 1) THEN 
        -- une seul colonne correspond à notre données 
        -- si la valeur de cette colonne est null, on UPDATE avec la data sinon (c'est comme dans le cas nbr = 0)
        newData := null;
    ELSE
        -- plusieurs colonnes correspond, il faut determiner la colonne la plus compatible
        newData := null;
    END IF;

    -- myQuery := ' SELECT SEMANTICCATEGORY, SYNTACTICTYPE FROM '||
    --         DR_CSVfile_Coli ||' WHERE UPPER(OLDVALUES) = UPPER('''|| data
    --         ||''') AND  UPPER(CSVName) = UPPER('''|| CSVName ||''') AND ROWNUM = 1' INTO dataSemanticType,dataSyntacticType;
        
    

    RETURN (newData);
END;
/

