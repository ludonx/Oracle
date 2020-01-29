

-- je prend une liste de valuer avec delimiteur
-- + une table avec la colonnes qui contiendra les valeurs [de meme category que ma liste]

-- je decoupe ma liste,
-- pour chaque element de ma liste je compte le nombre d'occurence (avec un like %xx%)
-- je garde la valuer qui a la max et ne nombre max

-- ( initailement le max = 0 et la valeur max = inconnue)

-- je retourne la valeur max

--select regexp_substr('SMITH,ALLEN,WARD,JONES','[^,]+', 1, level) from dual
--connect by regexp_substr('SMITH,ALLEN,WARD,JONES', '[^,]+', 1, level) is not null;

CREATE OR REPLACE PROCEDURE getTheDominantSemanticType(laTableReportByCol in VARCHAR2, delimiteurOfCategory in VARCHAR2) AS
table_cursor SYS_REFCURSOR;


theDominantSemanticType VARCHAR2(2000);
regexDelimiteurOfCategory VARCHAR2(20);
myCatagory VARCHAR2(60);
myiCatagory VARCHAR2(60);

maxCategory VARCHAR2(60);
nbrElemCategory NUMBER;
maxNbrElemCategory NUMBER;
BEGIN

EXECUTE IMMEDIATE ' CREATE OR REPLACE VIEW todelete as ( SELECT SEMANTICCATEGORY, count(*) as nbr from '||laTableReportByCol||' GROUP BY SEMANTICCATEGORY )';
EXECUTE IMMEDIATE ' SELECT SEMANTICCATEGORY FROM todelete WHERE nbr = (SELECT MAX(nbr) FROM todelete) AND ROWNUM = 1' INTO theDominantSemanticType;

theDominantSemanticType := ''''|| theDominantSemanticType ||'''';
regexDelimiteurOfCategory := '[^'''|| delimiteurOfCategory ||''']+';

maxCategory := 'INCONNUE';
maxNbrElemCategory := 0;
nbrElemCategory := 0;
FOR i IN ( SELECT regexp_substr(theDominantSemanticType,regexDelimiteurOfCategory, 1, level) as myCatagory from dual
connect by regexp_substr(theDominantSemanticType, regexDelimiteurOfCategory, 1, level) is not null )
LOOP
  --select count(*) from t_col4 where SEMANTICCATEGORY like '%SIZE_SHOES%';
  myiCatagory := '''%'|| i.myCatagory ||'%''';
  EXECUTE IMMEDIATE ' SELECT count(*) FROM '||laTableReportByCol||' WHERE SEMANTICCATEGORY like '||myiCatagory INTO nbrElemCategory;
  --DBMS_OUTPUT.put_line (' SELECT count(*) FROM '||laTableReportByCol||' WHERE SEMANTICCATEGORY like '||myiCatagory);
  IF ( nbrElemCategory > maxNbrElemCategory )THEN
    maxNbrElemCategory := nbrElemCategory;
    maxCategory := i.myCatagory;
  END IF;

END LOOP;

DBMS_OUTPUT.put_line ('------'||maxCategory);
END;
/

BEGIN
  getTheDominantSemanticType('t_col4','/');
  --DBMS_OUTPUT.put_line ('------');
END;
/
