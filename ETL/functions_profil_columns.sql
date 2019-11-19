------------------------------------------------+
------------- getDataType                       |
------------------------------------------------+
-- return le type d'une chaine de caractére en fonction de son expression regulier
CREATE OR REPLACE FUNCTION getDataType(data in VARCHAR2)
   RETURN VARCHAR2
   AS
   typeData VARCHAR2(20) := null;
   BEGIN
      FOR i IN (SELECT * FROM DDRE)
      LOOP
        IF REGEXP_LIKE (UPPER(data),i.REGULAREXPRESSION) THEN
          typeData := i.TYPE;
          EXIT;
        END IF;
      END LOOP;
      RETURN(typeData);
   END;
   /

------------------------------------------------+
------------- getDataCategory                   |
------------------------------------------------+
-- return la catégorie d'une chaine de caractére en fonction de son expression regulier
CREATE OR REPLACE PROCEDURE getDataCategory(data IN VARCHAR2, category OUT VARCHAR2,subCategory OUT VARCHAR2, delimiteurOfCategory IN VARCHAR2)
   AS
   first_val BOOLEAN := TRUE;
   nbr number;
   BEGIN
   category := 'INCONNU';
   subCategory := 'INCONNU';
      FOR i IN (SELECT * FROM DDRE)
      LOOP
        IF REGEXP_LIKE (UPPER(data),i.REGULAREXPRESSION) THEN
          -- cas particulier , i.CATEGORY = CITY
          -- donc la data peux être une ville ou un nom
          IF (i.CATEGORY = 'NAMES' AND i.SUBCATEGORY = 'CITY') THEN
            SELECT COUNT(*) INTO nbr FROM DICOPAYSVILLE WHERE VILLE = UPPER(data);
            IF nbr > 0 THEN
              category := i.CATEGORY ;
              subCategory := i.SUBCATEGORY ;
              -- if it is a cile we exit ,
              -- @ludo this may not be the best solution
              EXIT;
            END IF;
          -- on peu rajouter plusieur ELSIF en fonction des cas particuliers
          ELSE
            -- ci-bas les conditions général,
            -- here we construct a list of CATEGORY if the data have mutiple CATEGORY
            IF first_val = TRUE THEN
              category := i.CATEGORY;
              subCategory := i.SUBCATEGORY ;
              first_val := FALSE;
            ELSE
              IF (category NOT LIKE '%'||i.CATEGORY ||'%') THEN
                -- this condition is to not duplicate category if the liste i'm building
                category := category ||delimiteurOfCategory|| i.CATEGORY;
              END IF;
              subCategory := subCategory ||delimiteurOfCategory|| i.SUBCATEGORY;

            END IF;
          END IF;

        END IF;
      END LOOP;
   END;
   /

------------------------------------------------+
------------- getTheDominantSemanticType        |
------------------------------------------------+
-- je prend une liste de valuer avec delimiteur
-- + une table avec la colonnes qui contiendra les valeurs [de meme category que ma liste]

-- je decoupe ma liste,
-- pour chaque element de ma liste je compte le nombre d'occurence (avec un like %xx%)
-- je garde la valuer qui a la max et ne nombre max

-- ( initailement le max = 0 et la valeur max = inconnue)

-- je retourne la valeur max

--select regexp_substr('SMITH,ALLEN,WARD,JONES','[^,]+', 1, level) from dual
--connect by regexp_substr('SMITH,ALLEN,WARD,JONES', '[^,]+', 1, level) is not null;

CREATE OR REPLACE FUNCTION getTheDominantSemanticType(laTableReportByCol in VARCHAR2, delimiteurOfCategory in VARCHAR2)
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

RETURN (maxCategory);
END;
/

------------------------------------------------+
------------- GenerateReportTable                    |
------------------------------------------------+
-- return le type d'une chaine de caractére en fonction de son expression regulier
CREATE OR REPLACE PROCEDURE GenerateReportTable(laTableReportByCol in VARCHAR2, colName in VARCHAR2, laTableReportTable in VARCHAR2)
  AS
  --- la stucture de la table resultante sera la meme que DATAREPORT
  --- desc DATAREPORT --
  dataReportTable DATAREPORT%ROWTYPE;
  myInsertQuery VARCHAR2(500);
  myInsertValue VARCHAR2(500);
  delimiteurOfCategory VARCHAR2(50);
  BEGIN
   --EXECUTE IMMEDIATE ' SELECT DISTINCT(CSVName) FROM ' || laTableReportByCol INTO dataReportTable.CSVName ;
   dataReportTable.OLDName := colName;
	 -- NEWVALUES a apfaire apres dans un update
	 dataReportTable.NEWName := 'INCONNU';
	 EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol INTO  dataReportTable.nbrRows ;

   EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE OLDVALUES IS NULL ' INTO  dataReportTable.nbrNullValues  ;
	 EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE OLDVALUES IS NOT NULL ' INTO  dataReportTable.nbrNotNullValues  ;
	 EXECUTE IMMEDIATE ' SELECT MIN(COLUMNWIDHT) FROM  '|| laTableReportByCol INTO  dataReportTable.minLenght ;
	 EXECUTE IMMEDIATE ' SELECT MAX(COLUMNWIDHT) FROM  '|| laTableReportByCol INTO  dataReportTable.maxLength ;
	 --EXECUTE IMMEDIATE ' SELECT MAX(COLUMNWIDHT) FROM  '|| laTableReportByCol INTO  dataReportTable.nbrWords ;
	 dataReportTable.nbrWords := -1;
	 EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE UPPER(SYNTACTICTYPE)  LIKE ''%VARCHAR2%'' ' INTO  dataReportTable.nbrValuesVarcharType ;
   EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE UPPER(SYNTACTICTYPE)  LIKE ''%NUMBER%'' ' INTO  dataReportTable.nbrValuesNumberType ;
   EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE UPPER(SYNTACTICTYPE)  LIKE ''%DATE%'' ' INTO  dataReportTable.nbrValuesDateType ;
	 EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE UPPER(SYNTACTICTYPE)  LIKE ''%BOOLEAN%'' ' INTO  dataReportTable.nbrValuesBooleanType ;
	 EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE UPPER(SYNTACTICTYPE)  is NULL ' INTO  dataReportTable.nbrValuesNullType ;
	 --EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol || ' WHERE UPPER(SYNTACTICTYPE)  LIKE ''%NUMBER%'' ' INTO  dataReportTable.nbrOfDifferenteValues ;
   dataReportTable.nbrOfDifferenteValues := -1;

   --EXECUTE IMMEDIATE ' SELECT SYNTACTICTYPE FROM ( SELECT SYNTACTICTYPE ) '|| laTableReportByCol INTO  dataReportTable.theDominantSyntacticType ;
   EXECUTE IMMEDIATE ' CREATE OR REPLACE VIEW todelete as ( SELECT SYNTACTICTYPE, count(*) as nbr from '||laTableReportByCol||' GROUP BY SYNTACTICTYPE )';
   EXECUTE IMMEDIATE ' SELECT SYNTACTICTYPE FROM todelete WHERE nbr = (SELECT MAX(nbr) FROM todelete)' INTO dataReportTable.theDominantSyntacticType;
   EXECUTE IMMEDIATE ' DROP VIEW todelete';

   -- c'est le nombre de valeur differente de la valeur syntaxique dominante
   EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol
   || ' WHERE SYNTACTICTYPE IS NULL OR SYNTACTICTYPE NOT LIKE ''%'||
   dataReportTable.theDominantSyntacticType ||'%'' '  INTO  dataReportTable.NumberOfSyntacticAnomalies ;

   -- c'est le nombre de valeur egale à la valeur syntaxique dominante
   -- ou c'est ( le nombre d'element total ) - dataReportTable.NumberOfSyntacticAnomalies
   EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol
   || ' WHERE SYNTACTICTYPE LIKE ''%'||
   dataReportTable.theDominantSyntacticType ||'%'' '  INTO  dataReportTable.NumberOfSyntacticNormalValues ;



   -- the dominante SEMANTICCATEGORY
   --EXECUTE IMMEDIATE ' CREATE OR REPLACE VIEW todelete as ( SELECT SEMANTICCATEGORY, count(*) as nbr from '||laTableReportByCol||' GROUP BY SEMANTICCATEGORY )';
   --EXECUTE IMMEDIATE ' SELECT SEMANTICCATEGORY FROM todelete WHERE nbr = (SELECT MAX(nbr) FROM todelete) AND ROWNUM = 1' INTO dataReportTable.theDominantSemanticType;
   --EXECUTE IMMEDIATE ' DROP VIEW todelete';
   delimiteurOfCategory := '/';
   dataReportTable.theDominantSemanticType := getTheDominantSemanticType(laTableReportByCol,delimiteurOfCategory);
   --DBMS_OUTPUT.put_line ('------'||dataReportTable.theDominantSemanticType);

   -- c'est le nombre de valeur differente de la valeur semantique dominante
   EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol
   || ' WHERE SYNTACTICTYPE IS NULL OR SEMANTICCATEGORY NOT LIKE ''%'||
   dataReportTable.theDominantSemanticType ||'%'' '  INTO  dataReportTable.NumberOfSemanticAnomalies ;

   -- c'est le nombre de valeur egale à la valeur semantique dominante
   -- ou c'est ( le nombre d'element total ) - dataReportTable.NumberOfSyntacticAnomalies
   EXECUTE IMMEDIATE ' SELECT COUNT(*) FROM  '|| laTableReportByCol
   || ' WHERE SEMANTICCATEGORY LIKE ''%'||
   dataReportTable.theDominantSemanticType ||'%'' '  INTO  dataReportTable.NumberOfSemanticNormalValues ;




  --DBMS_OUTPUT.put_line ('dataReportTable.OLDName  : '||dataReportTable.OLDName);
  myInsertValue := ' VALUES ('''|| dataReportTable.CSVName  ||''','''||
				 dataReportTable.OLDName  ||''','''||
				 dataReportTable.NEWName  ||''','||
				 dataReportTable.nbrRows ||','||

				 dataReportTable.nbrNullValues ||','||
				 dataReportTable.nbrNotNullValues ||','||

				 dataReportTable.minLenght ||','||
				 dataReportTable.maxLength ||','||

				 dataReportTable.nbrWords ||','||

				 dataReportTable.nbrValuesVarcharType ||','||
				 dataReportTable.nbrValuesNumberType ||','||
				 dataReportTable.nbrValuesDateType ||','||
				 dataReportTable.nbrValuesBooleanType ||','||
				 dataReportTable.nbrValuesNullType ||','||

				 dataReportTable.nbrOfDifferenteValues ||','''||

				 dataReportTable.theDominantSyntacticType  ||''','||
				 dataReportTable.NumberOfSyntacticAnomalies ||','||
				 dataReportTable.NumberOfSyntacticNormalValues ||','''||

				 dataReportTable.theDominantSemanticType  ||''','||
				 dataReportTable.NumberOfSemanticAnomalies ||','||
				 dataReportTable.NumberOfSemanticNormalValues ||
				 ')';


  dropTable(laTableReportTable);
  EXECUTE IMMEDIATE ' CREATE TABLE '|| laTableReportTable || ' AS SELECT * FROM DATAREPORT';
  myInsertQuery := ' INSERT INTO '||laTableReportTable||' '||myInsertValue;
  --DBMS_OUTPUT.put_line (myInsertQuery);
  EXECUTE IMMEDIATE myInsertQuery;
  END;
  /

-------------------------------------------------------------------------------------
-- Génération de la Data Report DR_CSVFile_Col_
-- @param :
--      +input :
--          + laTable : le nom de la table qui contient des anomalies :
--          + colName : le nom de la colonnes
--          + laTableRes : le nom de la table de rapport syntaxique et éventuellement sémantique :
--      +input/output :
--          + dataReportTableName : the name of the table that containe the stat of all column in the table 'laTable'
-----------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE GenerateReportByCol(CSVName in VARCHAR2, laTable in VARCHAR2,  colName in VARCHAR2, laTableRes in VARCHAR2,dataReportTableName IN OUT VARCHAR2 ) AS
table_cursor SYS_REFCURSOR;
myQuery VARCHAR2(500);
myInsertQuerySyntaxique VARCHAR2(500);
myInsertValueSyntaxique VARCHAR2(500);
selected_values VARCHAR2(500);
where_conditions VARCHAR2(500);

colDataType VARCHAR2(60);
colLength NUMBER;
colNbrMot NUMBER;
myColValues VARCHAR2(60);
myColValuesToInsert VARCHAR2(60);

colDataCategory VARCHAR2(2000);
colDataSubCategory VARCHAR2(2000);
delimiteurOfCategory VARCHAR2(60);


--dataReportTableName VARCHAR2(60);
--CSVName VARCHAR2(60); -- contiendra le nom du fichier csv : @ludo a modifier et mettre en parametre -- quoi que pas tres utilil ( voir prof)
--- la stucture de la table resultante sera la meme que DATAREPORTBYCOL
--- desc DATAREPORTBYCOL --
dataReport DATAREPORTBYCOL%ROWTYPE; -- à supprimer si pas utiliser
BEGIN
  -- je crée la table de profilage
  dropTable(laTableRes);
  EXECUTE IMMEDIATE ' CREATE TABLE '|| laTableRes || ' as SELECT * FROM DATAREPORTBYCOL';
  -- je m'assure que la table est bien vide
  EXECUTE IMMEDIATE ' DELETE  FROM '||laTableRes;

  -- je parcours les valeurs de la colonnes passée en paramétre et je rempli ma table de profilage
  -- profilate syntaxique uniquement car le profilage semantique ne pourra se faire que sur la base du résultats du profilage syntaxique
  --CSVName := 'CSVfile';
  myQuery := 'SELECT '||colName || ' FROM '|| laTable;
  open table_cursor for myQuery;
  -- on boucle sur chaque ligne du tableau pour récupérer la longueur max d'une chaine delimiter par LeDelimiter
     loop
      fetch table_cursor INTO myColValues;
      EXIT WHEN table_cursor%NOTFOUND;

        IF myColValues is null THEN
          ------------ SYNTAXIC -----------
          myColValuesToInsert := 'null';
          colDataType := 'null';
          colLength := 0;
          colNbrMot := 0;
          ------------ SEMANTIC -----------
          colDataCategory := 'null';
          colDataSubCategory := 'null';
        ELSE
          ------------ SYNTAXIC -----------
          -- ne pas oublie de rajouter les doubles cote pour les chaine de caractère
          myColValuesToInsert:=''''|| myColValues ||'''';

          -- je détermine le type syntaxique de la colonne
          colDataType :=''''|| getDataType(myColValues) ||'''';

          -- je détermine la longueur de la colonne
          colLength := length(myColValues);

          -- je détermine le nombre de mot de la colonne (séparer par un espaces)
          colNbrMot := REGEXP_COUNT(myColValues, ' ') + 1;


          ------------ SEMANTIC -----------
          -- I determine the semantic type of the column
          --delimiteurOfCategory := '_OR_';
          delimiteurOfCategory := '/';
          getDataCategory(myColValues,colDataCategory,colDataSubCategory,delimiteurOfCategory);
          colDataCategory := ''''|| colDataCategory ||'''';
          colDataSubCategory := ''''|| colDataSubCategory ||'''';

        END IF;

        -- pour le profilage syntaxique on insert les données car la table est vide
        myInsertValueSyntaxique := ' VALUES ('''||CSVName||''','|| myColValuesToInsert ||','|| colDataType ||',' ||colLength ||', '|| colNbrMot ||',null,null,'|| colDataCategory||','|| colDataSubCategory||')';
        myInsertQuerySyntaxique := 'INSERT INTO ' || laTableRes ||myInsertValueSyntaxique;
        --DBMS_OUTPUT.put_line (myInsertQuerySyntaxique);
        EXECUTE IMMEDIATE myInsertQuerySyntaxique;

     END loop;
 close table_cursor;


-- @ludo faire une autre fonction dans laque on apellera cette fonction et celle ci desous
 -- je génére une partie de la table DATAREPORT pour le fichier CSV
 --dataReportTableName := 'DR_'||CSVName||'_TabCol' ;
 GenerateReportTable(laTableRes, colName, dataReportTableName);


 -- pour les données sémantique on fait un update car la lique contient déja des valeurs


END;
/

COMMIT;
