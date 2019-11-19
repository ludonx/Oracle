--M2EID_13/M2EID_13
set serveroutput on
SET TIMING ON;
SET LINES 1000
SET PAGES 1000

COLUMN mykey         FORMAT A30


@exemple.sql
@elim.sql

--select * from TE;
--exec AddColumnKey('TE', 'ID', 'myKey', '$$',40);
--select REGEXP_REPLACE (myKey, ' ','') from TE;
--select myKey from TE;
--update te set mykey = Regexp_replace (mykey, ' ','');


select myKey from TE;
DECLARE
nbrSupprime NUMBER;
laTable VARCHAR2(200);
primaryKeyName VARCHAR2(200);
keyColName VARCHAR2(200);
delim VARCHAR2(200);
seuil NUMBER;
algoDeDetection VARCHAR2(200);
pctMin NUMBER;


BEGIN
laTable := 'TE';
primaryKeyName := 'ID';
keyColName := 'MYKEY';
delim := ' ';
seuil := 40;
algoDeDetection := 'JARO_WINKLER_SIMILARITY';
pctMin := 93;

AddColumnKey(laTable, primaryKeyName, keyColName, delim,10);
nbrSupprime := SupprimerDoublons(laTable,primaryKeyName, keyColName, delim, seuil,algoDeDetection,pctMin);
DBMS_OUTPUT.put_line ('[Algo ] : '|| algoDeDetection || ' [nbr supprimer] : '|| nbrSupprime);
END;
/
select myKey from TE;


/*
--select id from TE MINUS
SELECT id
--UTL_MATCH.JARO_WINKLER_SIMILARITY(mykey,'LEBON$$ADAM$$EPINAYSURSEINE$$FRANCE') as JWS_D,
--UTL_MATCH.JARO_WINKLER_SIMILARITY('LEBON$$ADAM$$EPINAYSURSEINE$$FRANCE',mykey) as JWS_G,
--UTL_MATCH.EDIT_DISTANCE_SIMILARITY('LEBON$$ADAM$$EPINAYSURSEINE$$FRANCE',mykey) as EDS_G
FROM TE
WHERE UTL_MATCH.EDIT_DISTANCE_SIMILARITY(mykey,'LEBON$$ADAM$$EPINAYSURSEINE$$FRANCE') >= 50
MINUS
SELECT id FROM TE
WHERE  UTL_MATCH.EDIT_DISTANCE_SIMILARITY('LEBON$$ADAM$$EPINAYSURSEINE$$FRANCE',mykey) =
(SELECT max(UTL_MATCH.EDIT_DISTANCE_SIMILARITY('LEBON$$ADAM$$EPINAYSURSEINE$$FRANCE',mykey) ) from TE);
*/

--UTL_MATCH.JARO_WINKLER_SIMILARITY(mykey,'LEBON$$ADAM$$EPINAYSURSEINE$$FRANCE') as JWS_D,
--UTL_MATCH.JARO_WINKLER_SIMILARITY('LEBON$$ADAM$$EPINAYSURSEINE$$FRANCE',mykey) as JWS_G,

--FROM TE
--WHERE UTL_MATCH.EDIT_DISTANCE_SIMILARITY(mykey,'LEBON$$ADAM$$EPINAYSURSEINE$$FRANCE') >= 50;

/*
SELECT id
--UTL_MATCH.JARO_WINKLER_SIMILARITY(mykey,'LEBON$$ADAM$$EPINAYSURSEINE$$FRANCE') as JWS_D,
--UTL_MATCH.JARO_WINKLER_SIMILARITY('LEBON$$ADAM$$EPINAYSURSEINE$$FRANCE',mykey) as JWS_G,
--UTL_MATCH.EDIT_DISTANCE_SIMILARITY('LEBON$$ADAM$$EPINAYSURSEINE$$FRANCE',mykey) as EDS_G
FROM TE
WHERE max(UTL_MATCH.EDIT_DISTANCE_SIMILARITY(mykey,'LEBON$$ADAM$$EPINAYSURSEINE$$FRANCE') ) = 100
group by id;
*/
--SELECT UTL_MATCH.EDIT_DISTANCE_SIMILARITY('shackleford','shackelford') FROM DUAL;
--select myKey,UTL_MATCH.EDIT_DISTANCE_SIMILARITY(myKey,'shackelford') from TE;
/*
SELECT
UTL_MATCH.JARO_WINKLER_SIMILARITY  ('110 Peckham Rd, London SE15 5EU, United Kingdom','110 Peckham Road, Southwark, Londres, RU') as JWS_D,
UTL_MATCH.JARO_WINKLER_SIMILARITY  ('110 Peckham Road, Southwark, Londres, RU','110 Peckham Rd, London SE15 5EU, United Kingdom') as JWS_G,
UTL_MATCH.EDIT_DISTANCE_SIMILARITY ('110 PeckEham Rd, London SE15 5EU, United Kingdom','110 Peckham Road, Southwark, Londres, RU') as EDS_D,
UTL_MATCH.EDIT_DISTANCE_SIMILARITY ('110 Peckham Road, Southwark, Londres, RU','110 Peckham Rd, London SE15 5EU, United Kingdom') as EDS_G
FROM DUAL;

SELECT
UTL_MATCH.JARO_WINKLER_SIMILARITY  ('Peckham Rd, London SE15 5EU, United Kingdom','110 Peckham Road, Southwark, Londres, RU') as JWS_D,
UTL_MATCH.JARO_WINKLER_SIMILARITY  ('110Peckham Road, Southwark, Londres, RU','11Peckham Rd, London SE15 5EU, United Kingdom') as JWS_G,
UTL_MATCH.EDIT_DISTANCE_SIMILARITY ('110Peckham Rd, London SE15 5EU, United Kingdom','110Peckham Road, Southwark, Londres, RU') as EDS_D,
UTL_MATCH.EDIT_DISTANCE_SIMILARITY ('110 Peckham Road, Southwark, Londres, RU','110 Peckham Rd, London SE15 5EU, United Kingdom') as EDS_G
FROM DUAL;
*/
/*
SELECT ID,UTL_MATCH.JARO_WINKLER_SIMILARITY(MYKEY,'LEBONADAMEPINAY-SUR') as p FROM TE;

SELECT ID, UTL_MATCH.JARO_WINKLER_SIMILARITY(MYKEY, 'LEBONADAMSEPINAY-SURFRANCE') as p FROM TE;
----------------------------------------------------
SELECT ID, UTL_MATCH.JARO_WINKLER_SIMILARITY(MYKEY, 'LEBONADAMEPINAYSURFRANCE') as p FROM TE;
----------------------------------------------------
SELECT ID, UTL_MATCH.JARO_WINKLER_SIMILARITY(MYKEY, 'BELLECLEMENCENICEFRANCE') as p FROM TE;
---------------------------------------------------;
SELECT ID, UTL_MATCH.JARO_WINKLER_SIMILARITY(MYKEY, 'BELLEC.NICEFRANCE') as p FROM TE;*/
