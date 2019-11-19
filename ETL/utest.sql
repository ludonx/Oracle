CREATE OR REPLACE PROCEDURE getTheDominantSemanticType(laTableReportByCol in VARCHAR2, delimiteurOfCategory in VARCHAR2)
RETURN VARCHAR2
IS

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

EXECUTE IMMEDIATE ' DROP VIEW todelete';

RETURN ('maxCategory');
END;
/
