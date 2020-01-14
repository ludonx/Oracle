-- ===============================================================================
-------- Université Sorbonne Paris Cité, Université Paris 13 , Institut Galiée
-------- Master 2 (M2 EID2), Informatique, Ingénieur
-------- Exploration Informatique des Données et Décisionnel
-- ===============================================================================
-------- La Data ; The Data
-------- La Donnée est le monde du futur ; Les données et le monde de l'avenir
-------- The Data is the world of the future ;  The Data and the future's world

-------- DATA -->>> Big Data, Dark Data, Open Data, ... 
-- ===============================================================================
-------- Bases de Données Avancées = Advanced Databases (BDA)
-------- Entrepôts de Données = Data Warehouses (DWH, EDON)
-------- Lacs de Données = Data Lakes (LD, DL)


-------- Directeur :  Dr. M. Faouzi Boufarès (MFB)
-------- Enseignant-Chercheur Responsable      

-------- Page Web : http://www.lipn.univ-paris13.fr/~boufares

-- ==========================================================================================
-- ======= MFB = Recherches d'information avancées ============ recherche intelligente ! ====

-- ===================================================
-- Enrichissement des relations avec client.e.s CRM
-- ===================================================
-- Année Universitaire : 2019-2020
-- ===================================================

-- Binome numéro : Bxy
-- NOM1 Prénom 1 :
-- NOM2 Prénom 2 :

-- ===================================================
-------->>>>>>> BOUZAID Driss, MARTIN Thomy, Groupe 5
-- ===================================================

-- Modification de la structure des données
-- Ajout d'une colonne de mots clés dans la table des clients
--

ALTER TABLE Clients
ADD KeyWordsCli VARCHAR(300);


UPDATE Clients SET KeyWordsCli='Voyages, Mangas, BasketBall, Musique, SuDOKU' WHERE UPPER(CODCLI)='C001';
UPDATE Clients SET KeyWordsCli='Natation, Dessin, Voyages, Bandes Dessinees' WHERE UPPER(CODCLI)='C002';
UPDATE Clients SET KeyWordsCli='Cinema, football, Yoga, Mangas, SuDOKU, BASKETbal, Arts Martiaux, Haute couture' WHERE UPPER(CODCLI)='C003';
UPDATE Clients SET KeyWordsCli='Mangas, football , Theatre, Cinema, Musique, Plongee sous marine' WHERE UPPER(CODCLI)='C004';
UPDATE Clients SET KeyWordsCli='Bandes Dessinees, Handball, Musique, Manga, foot, BasketBall' WHERE UPPER(CODCLI)='C005';
UPDATE Clients SET KeyWordsCli='Plongee sous marine, Mangas, Cinema, FOOTBALL, SuDOKU' WHERE UPPER(CODCLI)='C006';
UPDATE Clients SET KeyWordsCli='Bandes Dessinees, football , Musique, Handball, Voyages' WHERE UPPER(CODCLI)='C007';
UPDATE Clients SET KeyWordsCli='Handball, football, BasketBall' WHERE UPPER(CODCLI)='C008';
UPDATE Clients SET KeyWordsCli='' WHERE UPPER(CODCLI)='C009';
UPDATE Clients SET KeyWordsCli='Handball, Theatre, Voyages, FOOTBALL' WHERE UPPER(CODCLI)='C010';
UPDATE Clients SET KeyWordsCli='Voyages, Mangas' WHERE UPPER(CODCLI)='C011';
UPDATE Clients SET KeyWordsCli='Voyages, FOOTBALL, BasketBall, Mangas' WHERE UPPER(CODCLI)='C012';
UPDATE Clients SET KeyWordsCli='Plongee sous marine, , Natation, , Cinema' WHERE UPPER(CODCLI)='C013';
UPDATE Clients SET KeyWordsCli='Foot, Natation, Mangas, Cinema' WHERE UPPER(CODCLI)='C014';
UPDATE Clients SET KeyWordsCli='FootBALL, Natation, Mangas, Cinema' WHERE UPPER(CODCLI)='C015';
UPDATE Clients SET KeyWordsCli='PARIS, SuDOKU' WHERE UPPER(CODCLI)='C016';
UPDATE Clients SET KeyWordsCli='Plongee sous marine, Voyages, FOOTBALL, Cinema, SUDOKU, Arts martiaux' WHERE UPPER(CODCLI)='C017';
UPDATE Clients SET KeyWordsCli='FootBALL, Natation, Mangas, Cinema' WHERE UPPER(CODCLI)='C018';
COMMIT;
INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI, KeyWordsCli)
VALUES ('C019', 'Madame', 'GENIE', 'GENIALE', 3, '16', 'AVENUE FOCH', '75016', 'PARIS', 'FRANCE','genialegenie@gmail.com', '+33777889900', '@!?');
COMMIT;


-- ======= MFB = Recherches d'information avancées ============ recherche intelligente ! ===========
/* 
-- Contacter les clients en faisant une recherche sur des mots clés !
-- Les client.e.s qui aiment le football et/ou les mangas (? Code, Civilité, NOM, Prénom, KeyWordsCli)
-- Les client.e.s qui aiment les arts martiaux (? Code, Civilité, NOM, Prénom, KeyWordsCli)
-- Les client.e.s qui aiment les arts martiaux, la haute couture(? Code, Civilité, NOM, Prénom, KeyWordsCli)
-- >>>>>>>>>> MOTS-CLEFS (une seule chaine de caractères) : Football*Sudoku
-- >>>>>>>>>> MOTS-CLEFS (une seule chaine de caractères) : arts martiaux
-- >>>>>>>>>> MOTS-CLEFS (une seule chaine de caractères) : arts martiaux  +  haute couture

Exemple : Le résultat devra être stocké dans une VUE(Code, Civilite, Nom, Prenom, MotsCles) et devra être affiché en seulement DEUX colonnes 
selon les  règles suivantes :
La colonne 1, nommée CLIENT-E-S, est composée de la concaténation du Code, de la civilité (M. ou Mme), du nom (en majuscule) 
et du prénom avec seulement la première lettre en majuscule
La colonne 2, nommée MOTS-CLEFS, est composée de tous les mots clés de la personne en question en majuscule
Les affichages devront être bien alignés (complétés avec des espaces)

C077 M.  LENOUVO    Adel    >>>>> FOOTBALL, MANGAS, SODUKU
C088 Mme LANOUVELLE Adeline >>>>> FOOTBAL, SODUKU, MANGA, CINEMA

Développez une procédure de nom RECHERCHEAVANCEE avec 4 paramètres : LaTable, LaColonne, MotsCles, SeuilSimilr
qui permet de traiter les différents cas schématisés ci-dessous et de couvrir le maximum de cas possibles (répondre au mieux)!

Exemples avec 2 mots clés (MOTS-CLEFS) qui sont donnés sous forme d'une seule chaine de caractères avec éventuellement un opérateur (*,+,/)
(on connait le nom de la colonne sur laquelle devrait porter la recherche : KeyWordsCli)
A20. Les client.e.s qui aiment le football et les mangas (les deux obligatoirement : football * mangas)
Le caractère * désigne le ET/AND
A21. Les client.e.s qui aiment le football ou les mangas (soit le football soit les mangas, un seul suffit : football + mangas)
Le caractère + désigne le OU/OR
A22. Les client.e.s qui aiment soit le football soit les mangas mais pas les deux ensemble (le ou exclusif : football / mangas)
Le caractère / désigne le OU Exclusif / XOR

Exemples avec 3 mots clés ((MOTS-CLEFS ou n mots clés) qui sont donnés sous forme d'une seule chaine de caractères
(on connait le nom de la colonne sur laquelle devrait porter la recherche : KeyWordsCli)
A30. Les client.e.s qui aiment (*) :  Voyages, FOOTBALL, BasketBall (-->>>  Voyages * FOOTBALL * BasketBall)
A31. Les client.e.s qui aiment (+) :  Voyages, FOOTBALL, BasketBall (-->>>  Voyages + FOOTBALL + BasketBall)
A32. Les client.e.s qui aiment (/) :  Voyages, FOOTBALL, BasketBall (-->>>  Voyages / FOOTBALL / BasketBall)

A33. Les client.e.s qui aiment (*) :  Voyages, FOOTBALL, BasketBall, SUDOKOU (-->>>  Voyages * FOOTBALL * BasketBall, SUDOKOU)

Exemples où on ne connait PAS le nom de la colonne sur laquelle devrait porter la recherche (une des n colonnes d'une table !)
A40. Les client.e.s pour lesquels la cahaines de caractères 17 est citée
A42. Les client.e.s pour lesquels le mot Paris est cité 
A43. Les client.e.s pour lesquels le mot SUDOKU est cité 
(cela peut être le nom ou le Prénom ou la ville ou encore les mots clés; on ne sait pas!)
*/

-- ======= MFB = Recherches d'information avancées ============ recherche intelligente ! ===========

-- Contacter les clients en faisant une recherche sur des mots clés !


PROMPT
PROMPT =========================================================
PROMPT Affichage des résultats
PROMPT =========================================================

SET TIMING ON;
SET LINES 1000
SET PAGES 1000

SET SERVEROUTPUT ON;

COLUMN CODCLI 			FORMAT A6
COLUMN CIVCLI 			FORMAT A8
COLUMN NOMCLI 			FORMAT A8
COLUMN PRENCLI			FORMAT A8
COLUMN KEYWORDSCLI		FORMAT A100

-- A20. Les client.e.s qui aiment le football et (*) les mangas (? Code, Nom, Prénom, KeyWordsCli)

PROMPT >> Les client_e_s qui aiment le football et (*) les mangas
SELECT CODCLI || ' ' || CIVCLI || ' ' || NOMCLI || ' ' || PRENCLI AS CLIENT_E_S, KEYWORDSCLI AS MOTSCLEF
FROM CLIENTS
WHERE KEYWORDSCLI LIKE '%foot%' AND KEYWORDSCLI LIKE '%manga%';

  -- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ??? 

PROMPT
PAUSE Tapez sur Enter...
PROMPT 

SELECT CODCLI || ' ' || CIVCLI || ' ' || NOMCLI || ' ' || PRENCLI AS CLIENT_E_S, KEYWORDSCLI AS MOTSCLEF
FROM CLIENTS
WHERE UPPER(KEYWORDSCLI) LIKE '%FOOT%' AND UPPER(KEYWORDSCLI) LIKE '%MANGA%'; 

SELECT CODCLI || ' ' || CIVCLI || ' ' || NOMCLI || ' ' || PRENCLI AS CLIENT_E_S, KEYWORDSCLI AS MOTSCLEF
FROM CLIENTS
WHERE UPPER(KEYWORDSCLI) LIKE '%FOOT%MANGA%'; 

SELECT CODCLI || ' ' || CIVCLI || ' ' || NOMCLI || ' ' || PRENCLI AS CLIENT_E_S, KEYWORDSCLI AS MOTSCLEF
FROM CLIENTS
WHERE UPPER(KEYWORDSCLI) LIKE '%FOOT%%MANGA%' AND UPPER(KEYWORDSCLI) LIKE '%MANGA%FOOT%'; 


-- A21. Les client.e.s qui aiment le football ou (+) les mangas (? Code, Nom, Prénom, KeyWordsCli)

PROMPT >> Les client_e_s qui aiment le football ou (+) les mangas
SELECT CODCLI || ' ' || CIVCLI || ' ' || NOMCLI || ' ' || PRENCLI AS CLIENT_E_S, KEYWORDSCLI AS MOTSCLEF
FROM CLIENTS
WHERE UPPER(KEYWORDSCLI) LIKE '%FOOT%' OR UPPER(KEYWORDSCLI) LIKE '%MANGA%';


-- A22. Les client.e.s qui aiment soit le football soit les mangas mais pas les deux ensemble

PROMPT >> Les client_e_s qui aiment soit le football soit les mangas mais pas les deux ensemble
SELECT CODCLI || ' ' || CIVCLI || ' ' || NOMCLI || ' ' || PRENCLI AS CLIENT_E_S, KEYWORDSCLI AS MOTSCLEF
FROM CLIENTS
WHERE UPPER(KEYWORDSCLI) LIKE '%FOOT%'  AND UPPER(KEYWORDSCLI) NOT LIKE '%MANGA%'
   OR UPPER(KEYWORDSCLI) LIKE '%MANGA%' AND UPPER(KEYWORDSCLI) NOT LIKE '%FOOT%';

-- =========================================================================
/*
Développez une procédure de nom RECHERCHEAVANCEE avec 4 paramètres : 
LaTable, LaColonne, MotsCles, seuil (nombre de lettre différentes quand on compare deux mots)
qui permet de traiter les différents cas schématisés ci-dessous et de couvrir le maximum de cas possibles 
et (répondre au mieux)!!
*/


CREATE OR REPLACE PROCEDURE RECHERCHEAVANCEE (LaTable VARCHAR2, LaColonne VARCHAR2, MotsCles CLIENTS.KEYWORDSCLI%TYPE) IS

    -- Variable contenant le nombre de mots dans MotsCles
    nombre_de_mots NUMBER;
    -- Variable contenant la requete finale à éxécuter
    req VARCHAR2(200);
    -- Curseur contenant les différents mots présent dans MotsCles
    CURSOR C_mots_etoile IS SELECT regexp_substr(MotsCles,'[^*]+', 1, level) FROM DUAL 
	CONNECT BY regexp_substr(MotsCles, '[^*]+', 1, level) IS NOT NULL;
    CURSOR C_mots_plus IS SELECT regexp_substr(MotsCles,'[^+]+', 1, level) FROM DUAL 
	CONNECT BY regexp_substr(MotsCles, '[^+]+', 1, level) IS NOT NULL;
    CURSOR C_mots_slash IS SELECT regexp_substr(MotsCles,'[^/]+', 1, level) FROM DUAL 
	CONNECT BY regexp_substr(MotsCles, '[^/]+', 1, level) IS NOT NULL;
    -- Reccord permettant de parcourir le curseur C_mots
    Mot VARCHAR2(20);
    -- Définition de la sortie
    TYPE TypeResultat IS REF CURSOR;
    res TypeResultat;
    r_record CLIENTS%ROWTYPE;

  BEGIN
      -- Définition de la requete de base
      req := 'SELECT CODCLI, NOMCLI, PRENCLI, KEYWORDSCLI FROM ' || LaTable || ' WHERE ';

      -- Traitement en fonction de l'opérateur présent dans MotsCles
      IF MotsCles LIKE '%*%' THEN
          nombre_de_mots := length(MotsCles) - length(replace(MotsCles, '*', '')) + 1 ;
          -- Ouverture du curseur et définition de la suite de la requete req
          OPEN C_mots_etoile;
          FOR i IN 1 .. nombre_de_mots LOOP

            IF i = 1 THEN
              FETCH C_mots_etoile INTO Mot;
              req := req || 'UPPER(' || LaColonne || ') LIKE ''%' || UPPER(SUBSTR(Mot, 0, 4)) || '%'' ';
            END IF;

            IF i > 1 AND i < nombre_de_mots THEN
              FETCH C_mots_etoile INTO Mot;
              req := req || 'AND UPPER(' || LaColonne || ') LIKE ''%' || UPPER(SUBSTR(Mot, 0, 4)) || '%'' ';
            END IF;

            IF i = nombre_de_mots THEN
              FETCH C_mots_etoile INTO Mot;
              req := req || 'AND UPPER(' || LaColonne || ') LIKE ''%' || UPPER(SUBSTR(Mot, 0, 4)) || '%'';';
            END IF;

          END LOOP;
        dbms_output.put_line(req);
      END IF;

      IF MotsCles LIKE '%+%' THEN
         nombre_de_mots := length(MotsCles) - length(replace(MotsCles, '+', '')) + 1 ;
        -- Ouverture du curseur et définition de la suite de la requete req
         OPEN C_mots_plus;
          FOR i IN 1 .. nombre_de_mots LOOP

            IF i = 1 THEN
              FETCH C_mots_plus INTO Mot;
              req := req || 'UPPER(' || LaColonne || ') LIKE ''%' || UPPER(SUBSTR(Mot, 0, 4)) || '%'' ';
            END IF;

            IF i > 1 AND i < nombre_de_mots THEN
              FETCH C_mots_plus INTO Mot;
              req := req || 'OR UPPER(' || LaColonne || ') LIKE ''%' || UPPER(SUBSTR(Mot, 0, 4)) || '%'' ';
            END IF;

            IF i = nombre_de_mots THEN
              FETCH C_mots_plus INTO Mot;
              req := req || 'OR UPPER(' || LaColonne || ') LIKE ''%' || UPPER(SUBSTR(Mot, 0, 4)) || '%'';';
            END IF;

          END LOOP;
        dbms_output.put_line(req);
      END IF;

      IF MotsCles LIKE '%/%' THEN
         nombre_de_mots := length(MotsCles) - length(replace(MotsCles, '/', '')) + 1 ;
        -- Ouverture du curseur et définition de la suite de la requete req
         OPEN C_mots_slash;
          FOR i IN 1 .. nombre_de_mots LOOP

            IF i = 1 THEN
              FETCH C_mots_slash INTO Mot;
              req := req || 'UPPER(' || LaColonne || ') LIKE ''%' || UPPER(SUBSTR(Mot, 0, 4)) || '%'' ';
            END IF;

            IF i > 1 AND i < nombre_de_mots THEN
              FETCH C_mots_slash INTO Mot;
              req := req || 'AND NOT UPPER(' || LaColonne || ') LIKE ''%' || UPPER(SUBSTR(Mot, 0, 4)) || '%'' ';
            END IF;

            IF i = nombre_de_mots THEN
              FETCH C_mots_slash INTO Mot;
              req := req || 'AND NOT UPPER(' || LaColonne || ') LIKE ''%' || UPPER(SUBSTR(Mot, 0, 4)) || '%'';';
            END IF;

          END LOOP;
        dbms_output.put_line(req);
      END IF;

      -- Exécution de la requete
      OPEN res FOR req;
      LOOP
      FETCH res INTO r_record;
        dbms_output.put_line(r_record.CODCLI || ',' || r_record.NOMCLI || ',' || r_record.PRENCLI || ',' || r_record.KEYWORDSCLI);
      EXIT WHEN res%NOTFOUND;
      END LOOP;

      --EXECUTE IMMEDIATE req INTO res;

   END;
   /

-- =========================================================================
-- Exemples d'Exécutions de la procédure RECHERCHEAVANCEE

-- DEUX mots clés associés avec le ET (*)
EXECUTE RECHERCHEAVANCEE('CLIENTS', 'KEYWORDSCLI', 'football*manga');
-- TROIS mots clés associés avec le ET (*)
EXECUTE RECHERCHEAVANCEE('CLIENTS', 'KEYWORDSCLI', 'football*manga*basketball');

-- DEUX mots clés associés avec le OU (+)
EXECUTE RECHERCHEAVANCEE('CLIENTS', 'KEYWORDSCLI', 'football+manga');

-- DEUX mots clés associés avec le OUEXCLUSIF (/)
EXECUTE RECHERCHEAVANCEE('CLIENTS', 'KEYWORDSCLI', 'football/manga');

-- =========================================================================






