-- ===============================================================================
-------- Université Sorbonne Paris Cité, Université Paris 13 , Institut Galiée
-------- Master 2, Informatique,
-------- Exploration Informatique des Données et Décisionnel
-------- M2 EID2

-- ===============================================================================
-------- La Data ; The Data
-------- La Donnée est le monde du futur ; Les données et le monde de l'avenir
-------- The Data is the world of the future ;  The Data and the future's world

-------- DATA -->>> Big Data, Dark Data, Open Data, ...
-- ===============================================================================
-------- Bases de Données Avancées = Advanced Databases (BDA)
-------- Entrepôts de Données = Data Warehouses (DWH, EDON)

-------- Directeur :  Dr. M. Faouzi Boufarès
-------- Enseignant-Chercheur Responsable

-------- Page Web : http://www.lipn.univ-paris13.fr/~boufares

-------- http://www.lipn.univ-paris13.fr/~boufares/Master2/*.sql

-- ===============================================================================
-- ===============================================================================
--   Projet  BDM : Big Data Management - Gestion des Données Massives
--
--   Data Manipulation (DM) - Manipulation de Données
--   Data Integration (DI) - Intégration de Données
--   Données structurées ; Données Semi-structurées ; Données NON structurées
--   Structured data; Semi-structured data; NON-structured data

--   Master Data Management (MDM) - Gestion des Données de Référence
--   Data Quality Managment (DQM) - Gestion de la qualité des données
--   Data Cleaning - Nettayage des données
--   Data deduplication - Elimination des doubles et des similaires

--   More semantics to better correct the data
--   Plus de sémantique afin de mieux corriger les données
-- ===============================================================================
-- ===============================================================================
--
--------=============  BIG DATA, DATA BASE, DATA WAREHOUSE =============----------
--
-- Big Data & Clound Computing : Think DIFFERENTLY, BIGGER and SMARTER !
-- The Excellence in Data Use !
-- EID : L'Excellence dans l'Investigation des Données
-- EID : Excellence in Data Investigation
--
-- ===============================================================================
-- Think DIFFERENTLY, BIGGER and SMARTER ! The Excellence in Data Use !
-- MISSION IMPOSSIBLE OU POSSIBLE ????? !!!!!!!!!!!
-- Votre mission, si vous l'acceptez, est : The Excellence in Data Use !
-- Si vous échouez, nous nierons avoir eu connaissance de vos agissements !

-- ===============================================================================
-- Les dictons du jour !
--
-- Aujourd'hui, j'arrête de fumer
-- Le TABAC t'ABAT
-- Fumer nuit grâvement à ta santé et à celle de ton entourage
--
-- M   T   Dents
-- SMILE and the World SMILES with you !
--
-- MANGER + MANGER = GROSSIR (??? M, A, N, G, E, R, O, S, S, I)
--
-- Manger & Bouger,
-- Pour votre santé mangez 5 fruits et légumes par jour
-- Pour votre santé ne mangez pas trop gras, trop salé, trop sucré
-- Pour votre santé faites une activité physique régulière
-- Pour votre santé faites 30 mn de marche par jour
-- Pour votre santé faites des BD !!!
--
-- Dr. M. Faouzi Boufarès
-- ===============================================================================
-- ===============================================================================
--   A new ETL   ETL & DQ : Extract-Transform-Load & Data-Quality
--                    Al ETL Al Jadyd
-- ===============================================================================
-- ===============================================================================

-- ===============================================================================
-- ===============================================================================
-- ===============================================================================
--   Nom du SGBD/DBMS  : ORACLE  /  DB2  /  MySQL  /  ...
--   Date de creation  : jj/mm/20aa
---  Lieu              : Université Sorbonne Paris Cité, Université Paris 13, Institut Galiée
-- ===============================================================================

-- MFB MFB MFB MFB MFB MFB MFB MFB MFB
-- ===============================================================================
-------------------- Master 2 EID2 - Promotion 2019-2020 -------------------------

-- Groupe de Travail N° xy  : Bxy (Exemple B01, B02,... B09, B10, B11...)

-- NOM1 PRENOM1     --->>>>             : np1
-- NOM2 PRENOM2     --->>>>             : np2

-- ====>>> Vos fichiers sql devront s'appeler : Bxy-NomDuFichier.sql
-- ====>>> Ce fichier sql s'appelle : Bxy-G1.sql

-- ===============================================================================
-- MFB MFB MFB MFB MFB MFB MFB MFB MFB

-- ===============================================================================
-- ===============================================================================
--   Problématique    :  Intégration de données hétérogènes

--   Problématique    :  Traitement des anomalies éventuelles
--   Problématique    :  Plusieurs types d'anomalies INTRA-Colonne ; INTER-COLONNES ; INTER-LIGNES

--   Problématique    :  Standardisation de données hétérogènes
--   Problématique    :  Traitement des valeurs invalides syntaxiquement
--   Problématique    :  Traitement des valeurs invalides sémantiquement
--   Problématique    :  Traitement des valeurs nulles
--   Problématique    :  Traitement des redondances sémantiques (Dépendances fonctionnelles)
--   Problématique    :  Elimination des doubles et similaires

-- ===============================================================================
-- ===============================================================================
-- ===============================================================================
-- ===============================================================================
-- ===============================================================================


-- *******************************************************************************
-- *******************************************************************************
-- *******************************************************************************
--       SQL 2 --     SQL 2 -- --       SQL 2 --     SQL 2 --
--       SQL 2 --     SQL 2 -- --       SQL 2 --     SQL 2 --
-- *******************************************************************************
-- *******************************************************************************
-- *******************************************************************************


-- SPOOL Bxy-G1.lst

PROMPT =========================================================
-- Nom du Cas       :  Gestion Commerciale Intelligente : GESCOMI : GCI
-- Nom de SGBD      :  ORACLE DBMS
-- Date de création :  SEPTEMBER 2019
-- Auteur           :  Faouzi BOUFARES
-- Université       :  Université Sorbonne Paris Cité, Université Paris 13
-- Formation        :  Master 2 EID 2
PROMPT =========================================================
PROMPT
PROMPT =========================================================
PROMPT |                                                       |
PROMPT |     Exercice 1 :  BD GCI     avec SQL 2               |
PROMPT |     Manipulations-Interrogations de BD                |
PROMPT |                                                       |
PROMPT =========================================================
PROMPT
PROMPT

PROMPT =========================================================
PROMPT Ceci permet d initialiser le type de la date
PROMPT =========================================================
ALTER SESSION SET NLS_DATE_FORMAT = 'DAY DD-MONTH-YYYY' ;
ALTER SESSION SET NLS_LANGUAGE=ENGLISH;
PROMPT =========================================================


-- Affichage des données ===================================================
-- en SQL 2 ================================================================
-- Affichage des lignes dans les tables ====================================

PROMPT
PROMPT =========================================================
PROMPT Affichage des tables de la bd EN SQL 2
PROMPT =========================================================

SET TIMING ON;
SET LINES 1000
SET PAGES 1000

COLUMN CODCLI  FORMAT A6
COLUMN CIVCLI  FORMAT A8
COLUMN NOMCLI  FORMAT A8
COLUMN PRENCLI FORMAT A8
COLUMN CATCLI  FORMAT 99
COLUMN ADNCLI  FORMAT A6
COLUMN ADRCLI  FORMAT A10
COLUMN CPCLI   FORMAT A5
COLUMN VilCli  FORMAT A6
COLUMN PAYSCLI FORMAT A7
COLUMN MAILCLI FORMAT A10
COLUMN TELCLI  FORMAT A10

COLUMN NUMCOM  FORMAT A10
COLUMN DATCOM  FORMAT A28
COLUMN REFART  FORMAT A8
COLUMN NOMART  FORMAT A25
COLUMN PvArt   FORMAT 999.99
COLUMN QsArt   FORMAT 99
COLUMN PaArt   FORMAT 999.99
COLUMN QTCOM   FORMAT 99
COLUMN PUART   FORMAT 999.99
COLUMN REMISE  FORMAT 999.99

SELECT * FROM CLIENTS;

PROMPT
Pause Tapez sur Enter...
PROMPT

SELECT * FROM COMMANDES;

PROMPT
Pause Tapez sur Enter...
PROMPT

SELECT * FROM ARTICLES;

PROMPT
Pause Tapez sur Enter...
PROMPT

SELECT * FROM DETAILCOM;

PROMPT
pause Tapez sur Enter...
PROMPT

-- ===============================================================================
-- Manipulations-Interrogations des données ========= DEBUT ======================
-- en SQL 2 ======================================================================
-- Requêtes dans les tables ======================================================

PROMPT =========================================================
PROMPT FB-A : Requetes sur la bd EN SQL 2  du type : A, B, C, D, E, F, I, J...
PROMPT =========================================================
PROMPT

-- =======================================================================
-- =======================================================================
-- =======================================================================
/*
Exemples de requêtes à Tester : ----->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Requêtes du type Ai (Sélections + Projections) :
SELECT … FROM …UneTable… WHERE … ;

A01. Les Noms des clients (Avec éventuellement des doublons)
A02. Les Noms des clients (Sans les doublons)
A03. Les articles dont le prix de vente est supérieur ou égal au double du prix d’achat
A04. Les articles dont le prix de vente est soit 4 soit 27 soit 35
A05. Les articles dont le prix de vente est compris entre 30 et 50
A06. Les commandes du mois de septembre 2015
A07. Les détails des commandes d’une année donnée (2012)

A08. Les clients de « Paris » (Civilité Nom Prénom, Ville), le nom de la ville s’écrit comme « Paris »

A09. Les clients dont le nom commence par « C »
A10. Les articles dont le nom commence par « Barrières de »
A11. Les articles du fournisseur « WD »

A12. Les clients pour lesquels on n'a pas de téléphone

A13. Les clients dont le nom de la ville se prononce comme « pari » ou « bariz » ou « pary »
A14. Les clients dont le nom est similaire à « pari » ou « bariz » ou « pary »

A15. Décodification de la catégorie des clients : Transformez la catégorie comme suit : 1 ? Grossiste, 2 ? Demi-Gros, ? Détaillant

Qualité des données : Y-a-t-il des anomalies dans les données ; Quelles sont ces anomalies ?
A16. Les clients pour lesquels le nom et/ou le prénom sont invalides (Code, Nom, et Prénom)
A17. Les clients pour lesquels les mails sont invalides (Code, Nom, et Mail)
A18. Les clients pour lesquels les téléphones sont invalides (Code, Nom, et Mail)
*/

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Complétez vos réponses

PROMPT =========================================================
PROMPT >> Requete A01 : Les Noms des clients (Avec éventuellement des doublons)
PROMPT =========================================================
PROMPT
SELECT NOMCLI FROM Clients ;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A02 : Les Noms des clients (Sans les doublons)
PROMPT =========================================================
PROMPT
SELECT DISTINCT NOMCLI FROM Clients ;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT


SELECT * FROM Articles WHERE PvArt >= 2*(PaArt);
SELECT * FROM Articles WHERE PvArt=4 OR PvArt=27 OR PvArt=35;
SELECT * FROM Articles WHERE PvArt IN (4, 27, 35);
SELECT * FROM Articles WHERE PvArt between 30 AND 50;
SELECT * FROM Commandes WHERE TO_CHAR(datcom,'MM')='09' AND TO_CHAR(datcom,'YYYY')='2015';

SELECT civcli,Nomcli,prencli,VilCli FROM Clients WHERE UPPER(VilCli) = 'PARIS';
SELECT civcli,Nomcli,prencli,VilCli FROM Clients WHERE LOWER(VilCli) = 'paris';
SELECT civcli,Nomcli,prencli,VilCli FROM Clients WHERE VilCli = 'PARIS';
SELECT civcli,Nomcli,prencli,VilCli FROM Clients WHERE VilCli = 'Paris';

SELECT * FROM Clients WHERE UPPER(Nomcli) LIKE 'C%';
SELECT * FROM Articles WHERE NomArt LIKE 'BARRIERE DE%';
SELECT * FROM Articles WHERE REFART LIKE'WD%';

SELECT * FROM Clients WHERE SOUNDEX(VilCli)=SOUNDEX('PARI') OR SOUNDEX(VilCli)=SOUNDEX('barizzz');

SELECT
Nomcli,
CASE catcli WHEN 1 THEN 'Grossiste' WHEN 2 THEN 'Demi-Gros' ELSE 'detaillant' END AS Categorie
FROM Clients;

-- Utilisez aussi DECODE !


-- =======================================================================
-- =======================================================================
-- =======================================================================
/*
Exemples de requêtes à Tester : ----->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Requêtes du type Bi (Tris + Sélections + Projections + Calculs) :
SELECT …function(…)… FROM … WHERE … ORDER BY …;

B01. Classez les clients par ville, par ordre croissant
B02. Classez les articles de PV < 20, dans l’ordre décroissant du stock
B03. Calculez la marge pour chaque article (marge = PV – PA !), présentez le résultat par ordre décroissant de la marge
B04. Calculez la marge pour tous les sièges, présentez le résultat par ordre croissant de la marge
B05. Calculez le nombre de valeurs nulles ….
*/

PROMPT =========================================================
PROMPT >> Requete B01 : Classez les clients par ville, par ordre croissant
PROMPT =========================================================
PROMPT
SELECT * FROM Clients ORDER BY VilCli ASC;
SELECT * FROM Clients ORDER BY VilCli;
SELECT * FROM CLIENTS ORDER BY 9;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT


SELECT NomArt,QsArt FROM Articles WHERE PvArt< 20 ORDER BY QsArt DESC;
SELECT (PvArt-PaArt) AS Marge FROM Articles;

SELECT NomArt, (PvArt-PaArt) AS Marge  FROM Articles WHERE NomArt LIKE '%SIeGE%';
SELECT NomArt, (PvArt-PaArt) AS Marge  FROM Articles WHERE NomArt LIKE '%SIEGE%';
SELECT NomArt, (PvArt-PaArt) AS Marge  FROM Articles WHERE NomArt LIKE '%SIEge%';

SELECT NomArt, (PvArt-PaArt) AS Marge FROM Articles WHERE NomArt LIKE '%SIEGE%'
ORDER BY Marge DESC;
SELECT NomArt, (PvArt-PaArt) AS Marge FROM Articles WHERE NomArt LIKE '%SIEGE%'
ORDER BY 2 DESC;

-- =======================================================================
-- =======================================================================
-- =======================================================================
/*
Exemples de requêtes à Tester : ----->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Requêtes du type Ci (Calculs + Sélections+ Projections) :
SELECT …function(…)… FROM … WHERE …;

C01. Nombre de clients (Femme + Homme)
C02. Nombre de clientes (Femme)
C03. Nombre de clients (Homme)
C04. Le prix de vente le plus élevé
C05. Moyenne des prix de vente des articles
C06. Le chiffre d’affaires global
C07. Les articles dont le prix de vente est supérieur à la moyenne des prix de vente

*/

PROMPT =========================================================
PROMPT >> Requete C01 : Nombre de clients (Femme + Homme)
PROMPT =========================================================
PROMPT
SELECT COUNT(*) FROM Clients;
SELECT COUNT(*) AS NbrCli FROM Clients;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT


SELECT COUNT(*) FROM Clients WHERE CivCli='Madame' OR CivCli='Mademoiselle';
SELECT COUNT(*) FROM Clients WHERE CivCli='MADame' OR CivCli='MaDEmoisellE';
SELECT COUNT(*) FROM Clients WHERE CivCli='Monsieur';
SELECT MAX(PvArt) FROM Articles;
SELECT AVG(PvArt) FROM Articles;
SELECT SUM(PvArt*qsart) AS chiffre_daffaires FROM Articles;
SELECT * FROM Articles WHERE PvArt >= (SELECT AVG(PvArt) FROM Articles);

-- =======================================================================
-- =======================================================================
-- =======================================================================
/*
Exemples de requêtes à Tester : ----->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Requêtes du type Di (Calculs + Sous-Totaux + Sélections+ Projections + Tris) :
SELECT …function(…)… FROM … WHERE … GROUP BY… ORDER BY …;

D01. Nombre de clients par catégorie
D02. Nombre de clients parisiens par catégorie
D03. Montant de chaque commande
D04. Nombre de clients parisiens par catégorie, nombre > 2
D05. Total des quantités commandées par article

D06. Total des quantités commandées par catégorie d’article
D07. Total du chiffre d’affaires par catégorie d’article
D08. Total, moyenne, min et max du chiffre d’affaires par catégorie d’article
D09. Le chiffre d’affaires par année
D10. Le nombre de valeurs différentes par colonne
*/


PROMPT =========================================================
PROMPT >> Requete D01 : Nombre de clients par catégorie
PROMPT =========================================================
PROMPT
SELECT COUNT(*), CatCli FROM Clients GROUP BY CatCli;
SELECT CatCli, COUNT(*) AS nbr  FROM Clients GROUP BY CatCli;
SELECT CatCli AS Categorie, COUNT(*) AS NombreCli  FROM Clients GROUP BY CatCli;


-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

SELECT COUNT(*) AS nbr,CatCli FROM Clients WHERE SOUNDEX(vilcli) = SOUNDEX('Paris') GROUP BY CatCli;
SELECT SUM(Pvart*qsart),numcom FROM Commandes NATURAL JOIN Detailcom NATURAL JOIN Articles GROUP BY numcom;
SELECT * FROM(SELECT COUNT(*) AS nbr,CatCli FROM Clients WHERE SOUNDEX(vilcli) = SOUNDEX('Paris') GROUP BY CatCli) WHERE nbr >2;

SELECT SUM(qsart),NomArt FROM Articles NATURAL JOIN Commandes GROUP BY NomArt;
SELECT SUM(qsart*Pvart),TO_CHAR(datcom,'YYYY') AS annee FROM Commandes NATURAL JOIN Articles GROUP BY TO_CHAR(datcom,'YYYY');

-- =======================================================================
-- =======================================================================
-- =======================================================================
/*
Exemples de requêtes à Tester : ----->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Requêtes du type Ei (Jointures + Sélections + Projections)
SELECT … FROM …PlusieursTables… WHERE … ;

E01. Différents types de jointures (équi-jointure) : voir pages suivantes
E02. full outer join
E03. left join
E04. right join
E05. Produit Cartésien (Le cas le plus général sans clause WHERE ; la jointure est un cas particulier)
E06. La téta-jointure (téta appartient à < <= > >= <>)
E07.
E08. Jointure & Optimisation des requêtes
E09. Jointure avec une requête dans la clause FROM
E10. Jointure & Ordre d’exécution des tables
*/

PROMPT =========================================================
PROMPT >> Requete E01 : ???????????????????
PROMPT =========================================================
PROMPT
-- SELECT

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT


SELECT * FROM Clients, Commandes WHERE Clients.CODCLI= Commandes.codcli;
SELECT * FROM Clients full OUTER JOIN Commandes ON Clients.codcli= Commandes.codcli;
SELECT * FROM Clients left OUTER JOIN Commandes ON Clients.codcli= Commandes.codcli;
SELECT * FROM Clients right OUTER JOIN Commandes ON Clients.codcli= Commandes.codcli;
SELECT * FROM Clients, Commandes;

SELECT Clients.codcli, Commandes.datcom
FROM Clients, Commandes
WHERE Clients.codcli=Commandes.codcli AND Clients.vilcli=LOWER('PARIS');

SELECT Clients.codcli, Clients.Nomcli
FROM Clients, Commandes
WHERE Clients.codcli = Commandes.codcli AND Clients.vilcli = LOWER('paris');

SELECT t.codcli, datcom
FROM (SELECT * FROM Clients WHERE vilcli = 'Paris') t, Commandes
WHERE t.codcli = Commandes.codcli;

SELECT Clients.codcli,Commandes.datcom
FROM Commandes, Clients
WHERE Clients.codcli = Commandes.codcli AND Clients.vilcli='PARIS';

SELECT * FROM Clients NATURAL JOIN Commandes WHERE TO_CHAR(datcom,'MM')=9 AND TO_CHAR(datcom,'YYYY')=2011;
SELECT SUM(qsart*Pvart) FROM Articles NATURAL JOIN Commandes WHERE TO_CHAR(datcom,'MM')=9 AND TO_CHAR(datcom,'YYYY')=2011;

SELECT REFART FROM Detailcom
WHERE NUMCOM IN (SELECT NUMCOM FROM Commandes) GROUP BY REFART HAVING COUNT(*) = (SELECT COUNT(DISTINCT NUMCOM) FROM Commandes);

CREATE OR REPLACE VIEW CommandesParisiens AS
SELECT * FROM Detailcom WHERE numcom IN (SELECT numcom FROM Commandes WHERE codcli IN (SELECT codcli FROM Clients WHERE vilcli = 'PARIS'  ));

SELECT REFART FROM Detailcom WHERE numcom IN (SELECT numcom FROM CommandesParisiens)
GROUP BY REFART HAVING COUNT(*) = (SELECT COUNT(DISTINCT NUMCOM) FROM CommandesParisiens);
DROP VIEW CommandesParisiens;


--- MFB MFB

-- E01. Le Produit Cartésien : Croisement de chacune des lignes de la table des clients avec toutes les lignes de la table des commandes

SELECT * FROM Clients, Commandes ;



-- La jointure et ses variantes, constituent des cas particuliers du produit cartésien avec la clause WHERE :
SELECT … FROM Table1, Table2 WHERE Table1.Colonne θ Table2.Colonne ;


-- E02. Les clients ayant commandé et leurs commandes
TTITLE 'Jointure : Les clients ayant commandé et leurs commandes '
SELECT * FROM Clients, Commandes WHERE Clients.codecli= Commandes.codecli;

-- E03. Les clients ayant commandé et leurs commandes
TTITLE 'Full outer join : Les clients ayant commandé et leurs commandes'
SELECT * FROM Clients full outer join Commandes on Clients.codecli = Commandes.codecli;

-- E04. Les clients ayant commandé et leurs commandes
TTITLE 'Left join : Les clients ayant commandé et leurs commandes'
SELECT * FROM Clients left outer join Commandes on Clients.codecli = Commandes.codecli;

-- E05. Les clients ayant commandé et leurs commandes
TTITLE 'Right join : Les clients ayant commandé et leurs commandes'
SELECT * FROM Clients right outer join Commandes on Clients.codecli = Commandes.codecli;

-- E06. Les dates des commandes des clients de PARIS
TTITLE 'Jointure : Les dates des commandes des clients de PARIS '
SELECT Clients.codecli, Commandes.datecom FROM Clients, Commandes
where Clients.codecli= Commandes.codecli and Clients.villcli=LOWER('paris');

SELECT Clients.codecli, Commandes.datecom FROM Clients, Commandes
where Clients.codecli= Commandes.codecli and Clients.villcli=UPPER('PARIS');


-- Les requêtes ci-dessous ne donnent pas le même résultat à cause des majuscules-minuscules !
SELECT Clients.codecli, Commandes.datecom FROM Clients, Commandes
where Clients.codecli= Commandes.codecli and Clients.villcli='PARIS';

SELECT Clients.codecli, Commandes.datecom FROM Clients, Commandes
where Clients.codecli= Commandes.codecli and Clients.villcli='paris';

SELECT Clients.codecli, Commandes.datecom FROM Clients, Commandes
where Clients.codecli= Commandes.codecli and Clients.villcli='Paris';



-- Jointure & Optimisation des requêtes, Les différentes formulations, ci-dessous, ne donnent pas les mêmes performances

-- E07. Les clients (Codes & Noms des clients) de Paris ayant commandé

TTITLE '1. Jointure première écriture : Les clients de paris ayant commandé'
SELECT Clients.Codecli, Clients.Nomcli FROM Clients, Commandes
WHERE Clients.codecli= Commandes.codecli AND Clients.villcli=LOWER('paris');

TTITLE '2. Jointure deuxième écriture : Les clients de paris ayant commandé'
SELECT Clients.Codecli, Clients.Nomcli FROM Clients,
WHERE Clients.vilcli=LOWER('paris')
AND Clients.codecli  IN (SELECT Commandes.codecli FROM Commandes);

TTITLE '3. Jointure troisième écriture : Les clients de paris ayant commandé'
SELECT Clients.Codecli, Clients.Nomcli FROM Clients,
WHERE Clients.vilcli=LOWER('paris')
AND Clients.codecli  = ANY (SELECT Commandes.codecli FROM Commandes);

TTITLE '4. Jointure quatrième écriture : Les clients de paris ayant commandé'
SELECT Clients.Codecli, Clients.Nomcli FROM Clients,
WHERE Clients.vilcli=LOWER('paris')
AND EXISTS (SELECT * FROM Commandes WHERE Commandes.codecli = Clients.codecli);

TTITLE '5. Jointure cinquième écriture : Les clients de paris ayant commandé'
SELECT Clients.Codecli, Clients.Nomcli FROM Clients,
WHERE Clients.vilcli=LOWER('paris')
AND 0 < (SELECT COUNT(*) FROM Commandes WHERE Commandes.codecli = Clients.codecli);


-- E08. Les clients (Code des clients et Dates des commandes) de Paris ayant commandé

TTITLE '6. Jointure : Requête SELECT dans le FROM'
SELECT t.codecli, Commandes.datecom
FROM (SELECT * FROM Clients WHERE UPPER(vilcli)='PARIS') t, Commandes
WHERE t.codecli= Commandes.codecli;


-- Jointure & choix de l’ordre d’exécution des tables pour des raisons de performances !
-- SELECT /* + ordered */  --->>>>> ceci s’appelle le hint !

-- E09. Les clients (Code des clients et Dates des commandes) de Paris ayant commandé

TTITLE '7. Jointure : Choix de l’ordre d’exécution des tables Commandes et Clients '
SELECT /* + ordered */ Clients.codecli, Commandes.datecom FROM Commandes, Clients
WHERE Clients.codecli= Commandes.codecli AND UPPER(Clients.vilcli)='PARIS';

TTITLE '8. Jointure : Choix de l’ordre d’exécution des tables Clients et Commandes'
SELECT /* + ordered */ Clients.codecli, Commandes.datecom FROM Clients, Commandes
WHERE Clients.codecli= Commandes.codecli AND UPPER(Clients.vilcli)='PARIS';


-- =======================================================================
-- =======================================================================
-- =======================================================================
/*
Exemples de requêtes à Tester : ----->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Requêtes du type Fi (Calculs + Sous-Totaux + Unions + Intersections + Différences + Jointures)
SELECT … FROM …PlusieursTables… WHERE … ;

SELECT … FROM … WHERE … UNION S F W ;
SELECT … FROM … WHERE … MINUS S F W ;
SELECT … FROM … WHERE … INTERSECT S F W ;

F01. Clients ayant commandé en septembre 2011
F02. Montant total des commandes de septembre 2011
F03. Commandes ayant des articles dont le prix vente est supérieur à 20 (Commande, Article, PV)
F04. Commandes ayant des articles dont le prix vente est supérieur à 20 (Commande, Nombre)
F05. Commandes ayant 4 articles dont le prix vente est supérieur à 20
F06. Les clients de paris qui n’ont pas commandé en octobre 2011
F07. Les clients de paris ou ceux ayant commandé en octobre 2011

*/


PROMPT =========================================================
PROMPT >> Requete F01 : Clients ayant commandé en septembre 2011
PROMPT =========================================================
PROMPT
-- SELECT

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

-- F06. Les clients de paris qui n’ont pas commandé en octobre 2011
SELECT * FROM Clients WHERE UPPER(VillCli) = ‘PARIS’
AND CodeCli NOT IN
(SELECT CodeCli FROM Commandes WHERE DateCom LIKE ‘%10/2011’);

-- F07. Les clients de paris qui n’ont pas commandé en octobre 2011
SELECT * FROM Clients WHERE UPPER(VillCli) = ‘PARIS’
MINUS
SELECT CodeCli FROM Commandes WHERE DateCom LIKE ‘%10/2011’;


-- F08. Les clients de paris ou ceux ayant commandé en octobre 2011
SELECT CodeCli FROM Clients WHERE UPPER(VillCli) = ‘PARIS’
UNION
SELECT CodeCli FROM Commandes WHERE DateCom LIKE ‘%10/2011’;


-- =======================================================================
-- =======================================================================
-- =======================================================================
/*
Exemples de requêtes à Tester : ----->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Requêtes du type Gi (Divisions)
SELECT … FROM …PlusieursTables… WHERE … ;

G01. Les articles qui figurent sur toutes les commandes !
G02. Articles commandés par tous les parisiens
G03. Les articles qui figurent sur toutes les commandes d’une période donnée !

*/

PROMPT =====================================================================
PROMPT >> Requete G02. Articles commandés par tous les parisiens
PROMPT =====================================================================
PROMPT
TTITLE CENTER 'Requete: les articles qui sont commandés par tous les parisiens' skip 1 -
       LEFT   '=========================================================================' skip 0
SELECT	REFART, NOMART
FROM	ARTICLES
WHERE	NOT EXISTS
	(SELECT *
	 FROM	CLIENTS
	 WHERE	UPPER(VilCli) = 'PARIS'
	 AND	NOT EXISTS
		(SELECT *
		 FROM	COMMANDES, DETAILCOM
		 WHERE	COMMANDES.NUMCOM = DETAILCOM.NUMCOM
		 AND	DETAILCOM.REFART = ARTICLES.REFART
		 AND	COMMANDES.CODCLI = CLIENTS.CODCLI));

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

-- On pourrait appliquer une suite d'opérations, de l'Algèbre relationnelle, qui définissent la division !



-- =======================================================================
-- =======================================================================
-- =======================================================================
/*
Exemples de requêtes à Tester : ----->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Requêtes du type Hi (SQL Avancé, SQL pour le multidimensionnel)
CUBE ; ROLLUP ; RANK() OVER

H01. Nombre de clients
H02. Nombre de pays
H03. Nombre de clients par catégorie
H04. Nombre de clients par catégorie et par ville
H05. Nombre de clients par ville et par catégorie
H06. Nombre de clients par catégorie et par ville : fonction CUBE
H07. Nombre de clients par catégorie et par ville : fonction ROLLUP

H08. Classez les clients par ordre décroissant du chiffre d’affaires CA
H09. Classez les clients par ordre décroissant du CA, donnez le rang
H10. Classez les clients par ordre décroissant du CA, donnez le rang : RANK() OVER…
H11. Clients par ordre décroissant du CA et de la catégorie, donnez le rang
H12. Clients par ordre décroissant du CA et de la catégorie, donnez le rang

*/


PROMPT =========================================================
PROMPT >> Requete H01. Nombre de clients
PROMPT =========================================================
PROMPT

-- H01. Nombre de clients
SELECT COUNT(*) FROM Clients;
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

-- H01. Nombre de clients
ttitle 'Nombre de clients'
SELECT COUNT(codecli) AS nbclients FROM Clients;
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

SELECT PaysCli AS Pays, COUNT(*) AS NbrCli FROM Clients GROUP BY PaysCli;
SELECT CatCli AS Categorie, COUNT(*) AS NbrCli FROM Clients GROUP BY CatCli;
SELECT CatCli AS Category, VilCli AS City, COUNT(*) AS nbcv FROM Clients GROUP BY VilCli, CatCli;
SELECT vilcli, catcli, COUNT(*) FROM Clients GROUP BY vilcli, catcli;
SELECT catcli, vilcli, COUNT(*) FROM Clients GROUP BY CUBE(catcli,vilcli);
SELECT catcli, vilcli, COUNT(*) FROM Clients GROUP BY ROLLUP (catcli, vilcli);

-- H02. Nombre de pays
ttitle 'Nombre de pays'
select count(distinct paycli) as nbpays from Clients;

-- H03. Nombre de clients par catégorie
ttitle 'Nombre de clients par catégorie'
select catcli as categorie, count(*) as nbc from Clients
group by catecli;

-- H04. Nombre de clients par catégorie et par ville
ttitle 'Nombre de clients par catégorie et par ville'
select catecli as categorie, villcli as ville, count(*) as nbcv from Clients
group by catecli, villcli;

-- H05. Nombre de clients par ville et par catégorie
ttitle 'Nombre de clients par catégorie et par ville'
select villcli as ville, catecli as categorie, count(*) as nbcv from Clients
group by villcli, catecli;

-- H06. Nombre de clients par catégorie et par ville  fonction CUBE
ttitle 'Nombre de clients par catégorie et par ville CUBE'
select catecli as categorie, villcli as ville, count(*) as nbcv from Clients
group by CUBE(catecli, villcli);

-- H07. Nombre de clients par catégorie et par ville  fonction ROLLUP
ttitle 'Nombre de clients par catégorie et par ville ROLLUP'
select catcli as categorie, vilcli as ville, count(*) as nbcv from Clients
group by ROLLUP(catcli, vilcli);

-- H08. Classez les clients par ordre décroissant du chiffre d’affaires CA
ttitle 'Les clients par ordre décroissant du CA'
select * from cli??? Est-une Vue order by cacli desc;

-- H09. Classez les clients par ordre décroissant du ca, donnez le rang
ttitle 'Les clients par ordre décroissant du CA, donnez le rang'
select (select count(*)+1 from cli C2 where C1.cacli<C2.cacli) as rang,
cacli, codecli, nomcli, catcli, vilcli, paycli
from cli C1
order by rang;

-- H10. Classez les clients par ordre décroissant du ca, donnez le rang : RANK() OVER…
ttitle 'Classez les clients par ordre décroissant du ca, donnez le rang'
select rank() over(order by cacli desc) as rang,
cacli, codecli, nomcli, catcli, vilcli, paycli
from cli;

-- H11. Clients par ordre décroissant du ca et de la catégorie, donnez le rang
ttitle 'Clients par ordre décroissant du ca et de la catégorie, donnez le rang'
select rank() over (order by cacli desc, catcli desc) as rang,
cacli, codecli, nomcli, catcli, vilcli, paycli
from cli;

-- H12. Clients par ordre décroissant du ca et de la catégorie, donnez le rang
ttitle 'Clients par ordre décroissant du ca et de la catégorie, donnez le rang'
select count(C2.cacli) as rang,
C1.cacli, C1.codecli, C1.nomcli, C1.catcli, C1.vilcli, C1.paycli
from cli C1, cli C2
where C1.cacli <= C2.cacli or (C1.cacli=C2.cacli and C1.catcli=C2.catcli)
group by C1.catcli, C1.cacli, C1.codecli, C1.nomcli, C1.vilcli, C1.paycli
order by C1.cacli desc, C1.catcli desc;
/*
Remarques :
La première partie de la clause WHERE C1.cacli <= C2.cacli permet de ne pas compter le nombre d’occurrences
où la valeur de la colonne cacli est <= à elle-même.
Si la colonne cacli ne contient pas de doublons, cette partie de la clause
where serait en elle-même suffisante pour générer le rang correct.
La deuxième partie de la clause WHERE or (C1.cacli=C2.cacli and C1.catcli=C2.catcli),
garantit qu’en présence de doublons dans la colonne cacli, chaque valeur obtiendrait le correct.

A VERIFIER pour les clients ex æquo
*/



-- =======================================================================
-- =======================================================================
-- =======================================================================
/*
Exemples de requêtes à Tester : ----->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Requêtes du type Ii (SQL Gestion de Gros volumes de Données - Export / Import)

I01. Export depuis une BD gérée par un SGBD vers des fichiers (Extraction/Export/Déchargement)

Utilisation de l’utilitaire SPOOLER pour extraire/exporter les tables d’une BD vers des fichiers textes
(sql> spool nomdefichier.txt 		sql>select… 			sql> spool off)
(sql> spool nomdefichier.lst 		sql>select…				sql> spool off)

Déchargez toutes les tables de la BD GCI dans des fichiers CSV en utilisant le « ; » comme séparateur de colonnes.

I02. Import Depuis des fichiers vers une BD gérée par un SGBD (Import/Chargement)
Importer/Chargez toutes les tables de la BD GCI à partir de fichiers de différents types tels que CSV, Excel et autres.
Le « ; » est utilisé comme séparateur de colonnes.

*/


PROMPT =====================================================================
PROMPT Affichage des magasins de  l entreprise BB EN SQL 2
PROMPT =====================================================================
PROMPT

COLUMN NUMMAG		FORMAT A4
COLUMN NOMMAG		FORMAT A8
COLUMN TELMAG		FORMAT A10
COLUMN ADRNUMMAG	FORMAT A5
COLUMN ADRRUEMAG	FORMAT A10
COLUMN ADRCPMAG		FORMAT A7
COLUMN ADRVILLEMAG	FORMAT A10
COLUMN ADRPAYSMAG	FORMAT A10
COLUMN MAILMAG	    FORMAT A10

SELECT * FROM MAGASINS;

PROMPT
Pause Tapez sur Enter...
PROMPT

--====================================================================================
--====================================================================================
--====================================================================================
--==================== Modification de la structure des données ======================
--==================== ATTENTION : CETTE ACTION EST DANGEREUSE !!! ===================
--==================== ATTENTION :  A UTILISER/CONSOMMER AVEC MODERATION !!!==========
--====================================================================================
--====================================================================================
-- Modifiez la structure de la table MAGASINS
-- Ajoutez la colonne MAILMAG de type VARCHAR(30)

ALTER TABLE MAGASINS
ADD MAILMAG VARCHAR(30);

-- Développez une procédure CREERMAILMAG qui permet d Insérer les nouvelles données dans cette colonne
-- Le mail d un magasin (en minuscule) est composé de : 'bb' + NUMMAG + '@gmail.com'

CREATE OR REPLACE PROCEDURE CREERMAILMAG IS
BEGIN
EXECUTE IMMEDIATE 'UPDATE MAGASINS SET MAILMAG=concat(concat(''bb'',nummag),''@gmail.com'')';
END;
/

EXEC CREERMAILMAG;

--======================================================================================
--======================================================================================
--======================================================================================
-- MFB FFF ++++++++ Déchargement des données des magasins dans un fichier au format CSV
-- MFB FFF ++++++++ Le séparateur est ;
--======================================================================================
SPOOL listemag.csv

SELECT
NUMMAG      || ';' ||
NOMMAG      || ';' ||
TELMAG      || ';' ||
ADRNUMMAG   || ';' ||
ADRRUEMAG   || ';' ||
ADRCPMAG    || ';' ||
ADRVILLEMAG || ';' ||
ADRPAYSMAG  || ';' ||
ADRVILLEMAG || ';' ||
MAILMAG
FROM MAGASINS;

SPOOL OFF

-- =========================================================================

-- ??? A QUOI CORRESPONDENT LES 4 REQUETES CI-DESSOUS
-- PLACEZ LES DANS LA CATEGORIE DE REQUETES CORRESPONDANTE

SELECT codcli, SUM(ca) FROM (SELECT codcli, numcom, SUM((puart * QTCOM)*(1-remise/100)) AS CA
FROM Clients  NATURAL JOIN Commandes NATURAL JOIN Detailcom NATURAL JOIN Articles GROUP BY numcom, codcli)
GROUP BY codcli ORDER BY SUM(ca) DESC;

SELECT (SELECT COUNT(*)+1 FROM Clients c2 WHERE c1.catcli<c2.catcli) AS rang, catcli,codcli,Nomcli,catcli,vilcli,PaysCli
FROM Clients c1 ORDER BY rang;

SELECT RANK() OVER(ORDER BY catcli DESC) AS rang, catcli,codcli, Nomcli,catcli,vilcli,PaysCli FROM Clients;

SELECT RANK() OVER (ORDER BY catcli DESC,catcli DESC) AS rang, catcli, codcli,Nomcli, catcli,vilcli,PaysCli FROM Clients;

-- =========================================================================


PROMPT =====================================================================
PROMPT >> Requete FB01 : Articles commandés toujours en quantité > 5
PROMPT =====================================================================
PROMPT
TTITLE CENTER 'Requete: les articles toujours commandés en quantité superieure à 5' skip 1 -
       LEFT   '=========================================================================' skip 0
SELECT d.NUMCOM, a.REFART, a.NOMART
FROM   ARTICLES a, DETAILCOM d
WHERE  a.REFART = d.REFART
AND    d.QTCOM > 5;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =====================================================================
PROMPT >> Requete FB02 : Articles sans remise depuis le 1er JANUARY 2005
PROMPT =====================================================================
PROMPT
TTITLE CENTER 'Requete: Articles sans remise depuis le 1er JANUARY 2005' skip 1 -
       LEFT   '=========================================================================' skip 0
SELECT	d.NUMCOM, a.REFART, a.NOMART
FROM	ARTICLES a, DETAILCOM d, COMMANDES c
WHERE	EXTRACT(YEAR FROM DATCOM) > 2004
AND	c.NUMCOM = d.NUMCOM
AND	d.REFART = a.REFART
AND	d.REMISE = 0;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

-- =================================================================
-- ========= Quelques requetes de suivi du chiffre d affaires DEBUT
-- =================================================================

-- ????????????      FB FB FB FB FB FB A compléter ??????????????

PROMPT =========================================================
PROMPT >> Requete FB03 : Chiffre d affaires global du magasin en question
PROMPT =========================================================
PROMPT
SELECT
SUM((PUART*QTCOM)*(1-REMISE/100.0)) AS CHIFFRE_AFFAIRES
FROM DETAILCOM;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete FB04 : Chiffre d affaires par jour
PROMPT =========================================================
PROMPT
SELECT
C.DATCOM,SUM((D.PUART*D.QTCOM)*(1-D.REMISE/100.0)) AS CHIFFRE_AFFAIRES
FROM DETAILCOM D JOIN COMMANDES C ON C.NUMCOM=D.NUMCOM
GROUP BY C.DATCOM
ORDER BY C.DATCOM;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete FB05 : Chiffre d affaires par mois
PROMPT =========================================================
PROMPT
SELECT
EXTRACT(MONTH FROM C.DATCOM) AS MOIS,
SUM((D.PUART*D.QTCOM)*(1-D.REMISE/100.0)) AS CHIFFRE_AFFAIRES
FROM DETAILCOM D JOIN COMMANDES C ON C.NUMCOM=D.NUMCOM
GROUP BY EXTRACT(MONTH FROM C.DATCOM)
ORDER BY EXTRACT(MONTH FROM C.DATCOM);

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete FB06 : Chiffre d affaires par année
PROMPT =========================================================
PROMPT
SELECT
EXTRACT(YEAR FROM C.DATCOM) AS ANNEE,
SUM((D.PUART*D.QTCOM)*(1-D.REMISE/100.0)) AS CHIFFRE_AFFAIRES
FROM DETAILCOM D JOIN COMMANDES C ON C.NUMCOM=D.NUMCOM
GROUP BY EXTRACT(YEAR FROM C.DATCOM)
ORDER BY EXTRACT(YEAR FROM C.DATCOM);

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete FB07 : Chiffre d affaires par ville du client
PROMPT =========================================================
PROMPT
SELECT UPPER(LTRIM(RTRIM(VilCli))) AS VILLE,
sum((D.PUART*D.QTCOM)*(1-D.REMISE/100.0)) as CHIFFRE_AFFAIRES
FROM DETAILCOM D JOIN COMMANDES C ON C.NUMCOM=D.NUMCOM
JOIN CLIENTS ON CLIENTS.CODCLI=C.CODCLI
GROUP BY UPPER(LTRIM(RTRIM(VilCli)))
ORDER BY UPPER(LTRIM(RTRIM(VilCli)));

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete FB08 : Chiffre d affaires par pays du client
PROMPT =========================================================
PROMPT
TTITLE CENTER 'Requete: permet de determiner le chiffre d affaires par pays' skip 1 -
       LEFT   '=========================================================================' skip 0
SELECT	c.PAYSCLI, SUM((d.PUART*d.QTCOM) * (1-(d.REMISE/100))) AS chiffre_affaires
FROM	DETAILCOM d, CLIENTS c, COMMANDES k
WHERE	d.NUMCOM  = k.NUMCOM
AND	 	c.CODCLI = k.CODCLI
GROUP BY c.PAYSCLI;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ------------------------------ ---------------
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete FB09 : Chiffre d affaires par pays et par ville du client
PROMPT =========================================================
PROMPT
SELECT
UPPER(LTRIM(RTRIM(PAYSCLI))) AS PAYS,
UPPER(LTRIM(RTRIM(VilCli))) AS VILLE,
SUM((D.PUART*D.QTCOM)*(1-D.REMISE/100.0)) AS CHIFFRE_AFFAIRES
FROM DETAILCOM D JOIN COMMANDES C ON C.NUMCOM=D.NUMCOM
JOIN CLIENTS ON CLIENTS.CODCLI=C.CODCLI
GROUP BY UPPER(LTRIM(RTRIM(PAYSCLI))),UPPER(LTRIM(RTRIM(VilCli)))
ORDER BY UPPER(LTRIM(RTRIM(PAYSCLI))),UPPER(LTRIM(RTRIM(VilCli)));

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ------------------------------ ---------------
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

-- =================================================================
-- ========= Quelques requetes de suivi du chiffre d affaires FIN
-- =================================================================





--======================================================================================
--======================================================================================
--======================================================================================

--======================================================================================
--======================================================================================
--======================================================================================

--======================================================================================
--======================================================================================
--======================================================================================
-- MFB FFF +++++++++++++++++++   QUALITE DES DONNEES !! DATA QUALITY !!
-- MFB FFF +++++++++++++++++++   NETTOYAGE DES DONNEES !! DATA CLEANING !!
--======================================================================================
-- Qualité des données ::: Y-a-t-il des anomalies dans les données ?
-- Quelles sont ces anomalies ? Comment les détecter et comment les corriger ?
--======================================================================================
--======================================================================================
--==== Vérification de la validité (véracité) des données de l'entreprise BB ===========
--========== Donnée valide ? Donnée INVALIDE ===========================================
--======================================================================================
--======================================================================================

-- Quelques règles de gestion afin d'homogénéiser et normaliser les données
-- La colonne NOMCLI n'est pas bien renseignée ni commentée NO COMMENT !
-- Les seules contraintes définies sur la colonne NOMCLI sont :
------ Son type syntaxique >> NOMCLI VARCHAR2(20),
------ Son type/caratère obligatoire >> CONSTRAINT NN_CLIENTS_NOMCLI CHECK(NOMCLI IS NOT NULL),
-- Il faudrait par exemple ajouter :
-- la majuscule >> CONSTRAINT CK_CLIENTS_NOMCLI	CHECK(NOMCLI = UPPER(NOMCLI)),
-- l'expression régulière qui permet de définir la règle alphabétique
/*
LE PROBLEME EST : La Détection et La Correction des anomalies dans les données
Mesures de la qualité des Données ; Profilage des données

*/


-- ????????????      FB FB FB FB FB FB A compléter ??????????????

PROMPT =========================================================
PROMPT >> Requete : Les Noms des clients NON MAJUSCULEs !
PROMPT =========================================================
PROMPT
SELECT NOMCLI FROM CLIENTS WHERE NOMCLI <> UPPER(NOMCLI);

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete : Les Noms des clients NON Alphabétiques !
PROMPT =========================================================
PROMPT

SELECT NOMCLI FROM CLIENTS WHERE NOT REGEXP_LIKE (REPLACE(NOMCLI,' ',''),'^[A-Za-z]+$');
SELECT NOMCLI FROM CLIENTS WHERE NOT REGEXP_LIKE (NOMCLI,'^[A-Za-z ]+$');
SELECT NOMCLI FROM CLIENTS WHERE NOT REGEXP_LIKE (NOMCLI,'^[[:alpha:] ]+$');

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT


/*
Etant donné les requêtes ci-dessous qui permettent de voir aisément qu’il y a des anomalies dans les données !
La question qui se pose est « Comment détecter et corriger les anomalies dans les données ? ».
*/

REM Liste des pays
TTITLE 'Liste des pays'
SELECT DISTINCT paycli AS Pays FROM Clients;

REM Nombre de pays
TTITLE 'Nombre de pays'
SELECT COUNT(DISTINCT paycli) AS NbPays FROM Clients;

REM Liste des villes
TTITLE 'Liste des villes'
SELECT DISTINCT vilcli AS Villes FROM Clients;

REM Nombre de villes
TTITLE 'Nombre de villes'
SELECT COUNT(DISTINCT vilcli) AS NbVilles FROM Clients;


/*
CREATE TABLE CLIENTS
(
	CODCLI		VARCHAR2(10),
	CIVCLI		VARCHAR2(12),
	NOMCLI		VARCHAR2(20),
	PRENCLI		VARCHAR2(20),
	CATCLI		NUMBER(1),
	ADNCLI		VARCHAR2(10),
	ADRCLI		VARCHAR2(50),
	CPCLI		VARCHAR2(10),
	VilCli		VARCHAR2(20),
	PAYSCLI		VARCHAR2(30),
	MAILCLI		VARCHAR2(30),
	TELCLI		VARCHAR2(20),
	CONSTRAINT PK_CLIENTS				PRIMARY KEY(CODCLI),
	CONSTRAINT CK_CLIENTS_CIVCLI		CHECK(CIVCLI IN ('Mademoiselle', 'Madame', 'Monsieur')),
	CONSTRAINT CK_CLIENTS_CATCLI		CHECK(CATCLI BETWEEN 1 and 7),
	CONSTRAINT NN_CLIENTS_NOMCLI		CHECK(NOMCLI IS NOT NULL),
	CONSTRAINT NN_CLIENTS_PRENCLI		CHECK(PRENCLI IS NOT NULL),
	CONSTRAINT NN_CLIENTS_CATCLI		CHECK(CATCLI IS NOT NULL),
	CONSTRAINT CK_CLIENTS_VilCli		CHECK(VilCli = UPPER(VilCli)),
	CONSTRAINT CK_CLIENTS_PAYSCLI		CHECK(PAYSCLI = UPPER(PAYSCLI))
);
*/
-- Vérifier toutes les informations relatives aux clients...

-- Afficher les clients pour lesquels on n'a pas de téléphone (Code, Nom, Tel)
CREATE OR REPLACE VIEW CLISANSTEL (Code, Nom, Tel)
AS SELECT CODCLI, NOMCLI, TELCLI FROM CLIENTS WHERE TELCLI IS NULL;
SELECT * FROM CLISANSTEL;
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

-- Afficher les clients pour lesquels les mails sont invalides ou qui n'ont pas de mail (Code, Nom, Mail)
CREATE OR REPLACE VIEW CLIINVALIDMAIL (Code, Nom, Mail)
AS SELECT CODCLI, NOMCLI, MAILCLI FROM CLIENTS
WHERE MAILCLI IS NULL
OR NOT REGEXP_LIKE (LTRIM(RTRIM(MAILCLI)),'^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');
SELECT * FROM CLIINVALIDMAIL;
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

-- Afficher les clients pour lesquels les téléphones sont invalides (Code, Nom, Tel)
CREATE OR REPLACE VIEW CLIINVALIDTEL (Code, Nom, Tel)
AS SELECT CODCLI, NOMCLI, TELCLI FROM CLIENTS
WHERE TELCLI IS NULL
OR NOT REGEXP_LIKE (LTRIM(RTRIM(TELCLI)),'^((([\+]|[0]{2})([1-9]{3}|[1-9]{2}))|([0]))[1-9]([0-9]{8}|[0-9]{7})$');
SELECT * FROM CLIINVALIDTEL;
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT

-- Afficher les clients pour lesquels le nom ou le prénom n'est pas alphabétique (Code, Nom, Prénom)
-- ou que le nom n'est pas en MAJUSCULE
-- ou que le prénom n'est pas "Première lettre en Majuscule et le reste en minuscule
CREATE OR REPLACE VIEW CLIINVALIDNAME (Code, Nom, Prenom)
AS SELECT CODCLI, NOMCLI, PRENCLI FROM CLIENTS
WHERE
NOMCLI NOT REGEXP_LIKE (LTRIM(RTRIM(NOMCLI)),'^[A-Z ]+$') OR
PRENCLI NOT REGEXP_LIKE (LTRIM(RTRIM(PRENCLI)),'^[A-Z][a-z ]+$') ;
SELECT * FROM CLIINVALIDNAME;
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
-- ???

PROMPT
pause Tapez sur Enter...
PROMPT


--====================================================================================
--====================================================================================
-- Développer le mécanisme (procédure et/ou fonction) qui le fait avec comme paramètres par exemple :
-- les noms de la table et de la colonne à vérifier moyennant une EXPRESSION REGULIERE ou autre
-- Créer une table pour stocker les expressions régulières par catégorie sémantique de données
--====================================================================================
--====================================================================================
CREATE TABLE REGULAREXPRES
(
CATEGORY 								VARCHAR2(20),
REGULAREXPR 							VARCHAR2(200),
CONSTRAINT PK_REGULAREXPRES				PRIMARY KEY(CATEGORY),
CONSTRAINT CK_REGULAREXPRES_CATEGORY	CHECK(CATEGORY = UPPER(CATEGORY))
);

-- Des catégories sémantiques de données définies avec des expressions régulières
-- Le nombre de valeurs clés est infini
INSERT INTO REGULAREXPRES VALUES
('MAIL','^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');
INSERT INTO REGULAREXPRES VALUES
('TELFR-I','^(([\+]|[0]{2})([3]{2}))[1-9]([0-9]{8})$');
INSERT INTO REGULAREXPRES VALUES
('TELFR','^[0][1-9][0-9]{8}$');
INSERT INTO REGULAREXPRES VALUES
('TELBE-I', '^(([\+]|[0]{2})[3][2])[4]([5-9]{1})([0-9]{7})$');
INSERT INTO REGULAREXPRES VALUES
('TELBE', '^[0][4]([5-9]{1})([0-9]{7})$');
INSERT INTO REGULAREXPRES VALUES
('TELTN-I', '^(([\+]|[0]{2})[2][1][6])[1-9]([0-9]{7})$');
INSERT INTO REGULAREXPRES VALUES
('TELTN', '^[0][1-9]([0-9]{7})$');
-- et d'autres téléphone selon votre pays d origine et plus
INSERT INTO REGULAREXPRES VALUES
('DATEFR', '^(([0-2][0-9]|3[0-1])/(0[0-9]|1[0-2])/[0-9]{4})$');
INSERT INTO REGULAREXPRES VALUES
('DATEAM', '^((0[0-9]|1[0-2])/([0-2][0-9]|3[0-1])/[0-9]{4})$');
INSERT INTO REGULAREXPRES VALUES
('ALPHABETIQUE', '^[[:alpha:] ]+$');
INSERT INTO REGULAREXPRES VALUES
('NUMERIQUE', '^[[:digit:]]+$');
INSERT INTO REGULAREXPRES VALUES
('TEMPERATURECF', '^[-[:digit:].°C]+$');

-- Des catégories sémantiques de données définies avec des expressions régulières
-- Le nombre de valeurs (ou mots) clés est fini
-- La civilité (CIVILITY) est définie par exemple par :
/*
Madame, MADAME, MAdame, Mme, MME... Mademoiselle, MADEMOISELLE, MADEMoiselle, Mlle...
Madam, MADAM, MaDAm, Mrs, MRS, Miss, MISS...
Monsieur, MONSIEUR, M., ...
Sir, SIR, Mr., M.,...
*/

INSERT INTO REGULAREXPRES VALUES ('MADEMOISELLE', 'MADEMOISELLE|MLLE|Mademoiselle|MADEMoiselle|Miss|MISS');
INSERT INTO REGULAREXPRES VALUES ('MADAME', 'MADAME|MAdame|Mme|MME|Madam|MADAM|MaDAm|Mrs|MRS');
INSERT INTO REGULAREXPRES VALUES ('MONSIEUR', 'MONSIEUR|MR|M\.|Sir|SIR|Mr\.');
-- Le sexe (SEX) est défini par exemple par :
/*
Femme, FEMME, Femelle, F
Woman, Wife, Female, F
Homme, HOMME, Male, MALe, M, H
MAN, Man, Male, MALe, M
*/
INSERT INTO REGULAREXPRES VALUES ('FEMALE', 'Femme|FEMME|Femelle|F|Woman|Wife|Female');
INSERT INTO REGULAREXPRES VALUES ('MALE', 'Homme|HOMME|Male|MALe|M|H|MAN|Man|Male|MALe');
-- Le groupe sanguin (BLOODGROUP) est définie par les seules valeurs MAJUSCULES
-- fondées sur les systèmes ABO et Rhésus :
/*
A+, A-, B+, B-, AB+, AB-, O+ et O-
*/
INSERT INTO REGULAREXPRES VALUES ('BLOODGROUP', 'A-|A+|B-|B+|AB-|AB+|O-|O+');

COMMIT;


-- Créeer une fonction qui permet de dire si une valeur vérifie une expression régulière
-- CREATE OR REPLACE FUNCTION VerifRegExpr (...Valeur ...CategExpReg) renvoie Vrai ou Faux

CREATE OR REPLACE FUNCTION VerifRegExpr( p_variable IN varchar2, p_category IN varchar2 )
RETURN VARCHAR2
IS
RESULT varchar2(50);
REGULAR VARCHAR2(250);
BEGIN
	SELECT REGULAREXPR INTO REGULAR FROM REGULAREXPRES WHERE Category=p_category ;
	SELECT CASE WHEN (SELECT count(*) FROM DUAL
	WHERE NOT REGEXP_LIKE (p_variable ,REGULAR ))> 0 THEN 'FALSE' ELSE 'TRUE' END INTO RESULT FROM DUAL ;
RETURN(RESULT);
END;
/
SELECT VerifRegExpr('0555555555','TELFR') AS resultat_verification FROM dual;

-------------------------------PROCEDURE GENERALE

CREATE OR REPLACE PROCEDURE VerifRegExpr(p_table IN varchar2, p_colonne IN varchar2, p_category IN varchar2)
AUTHID CURRENT_USER IS
BEGIN
	FOR i IN (SELECT REGULAREXPR FROM REGULAREXPRES WHERE Category=p_category)
		LOOP
			EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW VueVerif ('||p_colonne||'_NonValide)
			AS SELECT '||p_colonne||' from '||p_table||' where not REGEXP_LIKE ('||p_colonne||','''||i.REGULAREXPR||''')';
		END LOOP;
END;
/
EXEC VerifRegExpr('clients','TELCLI','TELFR');


-- ????????????      FB FB FB FB FB FB A compléter ??????????????



--======================================================================================
--======================================================================================
--======================================================================================
--======================================================================================
--======================================================================================
--======================================================================================
--==================== TRAITEMENT DE CERTAINES ANOMALIES ===============================
--==================== INTRA-COLONNE ===================================================
--==================== INTER-COLONNES (Dépendances sémantiques, DF) ====================
--==================== INTER-LIGNES (Doubles et similaires =============================

PROMPT =========================================================
-- Nom du Cas       :  TRAITEMENT DE CERTAINES ANOMALIES (INTRA-COLONNE et INTER-COLONNES)
-- Nom de SGBD      :  ORACLE DBMS
-- Date de création :  SEPTEMBER 2019
-- Auteur           :  Faouzi BOUFARES
-- Université       :  Université Sorbonne Paris Cité, Université Paris 13
-- Formation        :  Master 2 EID 2
PROMPT =========================================================
PROMPT
PROMPT =========================================================
PROMPT |                                                       |
PROMPT |     Exercice 2 :  VILPAYS    avec SQL 2               |
PROMPT |     Manipulations-Interrogations de BD                |
PROMPT |                                                       |
PROMPT =========================================================
PROMPT
PROMPT

/*
Entre parenthèses hihi haha FFF ! (...)

Etant donné la table VILPAYS suivante :
Elle est issue des tables de la BD GesComI...
Faire les requêtes ci-dessous :
Calculs dans la table VILPAYS !
*/

CREATE TABLE VILPAYS (COL1 VARCHAR2(20), COL2 VARCHAR2(20));

INSERT INTO VILPAYS VALUES ('EPINAY-SUR-SEINE', 'FRANCE');
INSERT INTO VILPAYS VALUES ('PARIS', 'FRANCE');
INSERT INTO VILPAYS VALUES ('VILLETANEUSE', 'FRANCE');
INSERT INTO VILPAYS VALUES ('EPINAY-SUR-SEINE', '');
INSERT INTO VILPAYS VALUES ('EPINAY SUR SEINE', 'FRANCE');
INSERT INTO VILPAYS VALUES ('PARIS', 'FRANCE');
INSERT INTO VILPAYS VALUES ('PARIS', '');
INSERT INTO VILPAYS VALUES ('PARIS', 'FRANCE');
INSERT INTO VILPAYS VALUES ('MARCHEILLE', 'FRANCE');
INSERT INTO VILPAYS VALUES ('PARIS', '');
INSERT INTO VILPAYS VALUES ('ORLY-VILLE', 'FRANCE');
INSERT INTO VILPAYS VALUES ('MARCHEILLE', 'FRANC');
INSERT INTO VILPAYS VALUES ('PARYS', 'FR');
INSERT INTO VILPAYS VALUES ('EPINAY-SUR-SEINE', 'FRANCE');
INSERT INTO VILPAYS VALUES ('Paris', '');
INSERT INTO VILPAYS VALUES ('PARIS', 'france');
INSERT INTO VILPAYS VALUES ('Bruxelles', 'Belgique');
INSERT INTO VILPAYS VALUES ('Bruxelles', 'Belgique');
INSERT INTO VILPAYS VALUES ('Bruxelles', 'Belgique');
INSERT INTO VILPAYS VALUES ('Bruxelles', 'Belgique');
INSERT INTO VILPAYS VALUES ('Brusselle', 'Belgic');
INSERT INTO VILPAYS VALUES ('Berlin', 'ALLEMANGNE');
INSERT INTO VILPAYS VALUES ('Berlin', 'ALLEMANGNE');
INSERT INTO VILPAYS VALUES ('Berlin', 'ALLEMANGNE');
INSERT INTO VILPAYS VALUES ('Dublin', 'ALEMANGNE');
INSERT INTO VILPAYS VALUES ('TUNIS', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('SOUSSE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('SOUSSE', 'Italie');
INSERT INTO VILPAYS VALUES ('SOUSSE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('SOUSSE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('SOUSSE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('SOUSSE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('SOUcE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('SOUSSE', '');
INSERT INTO VILPAYS VALUES ('SOUSSE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('SOUSSE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('BIZERTE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('BIZERTE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('BIZERTE', '');
INSERT INTO VILPAYS VALUES ('BIZERTE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('BIZERTE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('DJERBA', 'France');
INSERT INTO VILPAYS VALUES ('HAMMAMET', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('HAMMAMET', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('HAMMAMET', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('HAMMAMET', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('SOUScE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('SOUSSE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('SOUSSE', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('TUNIS', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('DJERBA', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('DJERBA', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('DJERBA', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('DJERBA', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('JERBA', 'TUNISIE');
INSERT INTO VILPAYS VALUES ('PARIS', 'FRANCE');
INSERT INTO VILPAYS VALUES ('VILLETANEUSE', 'FRANC');
INSERT INTO VILPAYS VALUES ('EPINAY-SUR-SEINE', 'FRANCE');
INSERT INTO VILPAYS VALUES ('PARIS', 'FRANC');
INSERT INTO VILPAYS VALUES ('VILLETANEUSE', 'FRANC');
INSERT INTO VILPAYS VALUES ('EPINAY-SUR-SEINE', 'FRANCE');
INSERT INTO VILPAYS VALUES ('VILLETANEUSE', 'FRANC');
INSERT INTO VILPAYS VALUES ('EPINAY-SUR-SEINE', 'FRANCE');
INSERT INTO VILPAYS VALUES ('PARIS', 'FRANC');
INSERT INTO VILPAYS VALUES ('VILLETANEUSE', 'FRANC');
INSERT INTO VILPAYS VALUES ('EPINAY-SUR-SEINE', 'FRANCE');
INSERT INTO VILPAYS VALUES ('VILETANEUSE', 'FRANC');
INSERT INTO VILPAYS VALUES ('EPINAY-SUR-SEINE', 'FRANCE');
INSERT INTO VILPAYS VALUES ('PARIS', 'FRANC');
INSERT INTO VILPAYS VALUES ('VILLETANEUSE', 'FRANC');
INSERT INTO VILPAYS VALUES ('EPINAY-SUR-SEINE', 'FRANCE');
INSERT INTO VILPAYS VALUES ('ROME', 'ITALIE');
INSERT INTO VILPAYS VALUES ('ROME', 'ITALIA');
INSERT INTO VILPAYS VALUES ('MADRID', 'Espagne');
INSERT INTO VILPAYS VALUES ('MADRID', 'Spain');
INSERT INTO VILPAYS VALUES ('Dakar', 'SENEGAL');
INSERT INTO VILPAYS VALUES ('Dakar', 'SENEGAL');
INSERT INTO VILPAYS VALUES ('Dakar', 'SENEGAL');
INSERT INTO VILPAYS VALUES ('Dakar', 'SENEGUAL');
INSERT INTO VILPAYS VALUES ('Dacar', 'SENEGAL');
INSERT INTO VILPAYS VALUES ('Dakar', 'SENEGAL');
INSERT INTO VILPAYS VALUES ('Alger', 'ALGERIE');
INSERT INTO VILPAYS VALUES ('Alger', 'ALGERIE');
INSERT INTO VILPAYS VALUES ('Alger', 'ALGERIE');
INSERT INTO VILPAYS VALUES ('Alger', 'ALGERIA');
INSERT INTO VILPAYS VALUES ('Alger', 'ALGERIE');
INSERT INTO VILPAYS VALUES ('Alger', 'ALGERIE');
INSERT INTO VILPAYS VALUES ('ALGER', 'ALGER');
INSERT INTO VILPAYS VALUES ('CAIRO', 'Egypt');
INSERT INTO VILPAYS VALUES ('Marrakech', 'Marroc');
INSERT INTO VILPAYS VALUES ('Fès', 'Maroc');
INSERT INTO VILPAYS VALUES ('Rabat', 'Marok');
INSERT INTO VILPAYS VALUES ('Rabat', 'Maroc');
INSERT INTO VILPAYS VALUES ('Rabat', 'Maroc');
INSERT INTO VILPAYS VALUES ('Rabat', 'Maroc');
INSERT INTO VILPAYS VALUES ('Rabat', 'Maroc');
INSERT INTO VILPAYS VALUES ('Casablanca', 'Maroc');
INSERT INTO VILPAYS VALUES ('Casablanka', 'Maroc');
INSERT INTO VILPAYS VALUES ('Rabat', '');
INSERT INTO VILPAYS VALUES ('PARI', 'FRANCE');
INSERT INTO VILPAYS VALUES ('PARISI', 'FRANCE');
INSERT INTO VILPAYS VALUES ('BAGDAD', 'IRAQ');
INSERT INTO VILPAYS VALUES ('BAGDAD', 'IRAQ');
INSERT INTO VILPAYS VALUES ('BAGDAD', 'IRAQ');
INSERT INTO VILPAYS VALUES ('BAGDADE', 'IRAQ');
INSERT INTO VILPAYS VALUES ('TEHERAN', 'IRAN');
INSERT INTO VILPAYS VALUES ('TEHERAN', 'IRAN');
INSERT INTO VILPAYS VALUES ('TEHERAN', 'IRAN');
INSERT INTO VILPAYS VALUES ('TEHERAN', 'IRA');
INSERT INTO VILPAYS VALUES ('TEHERAN', 'IRAN');
INSERT INTO VILPAYS VALUES ('TEHERAN', '');
INSERT INTO VILPAYS VALUES ('TEERAN', 'IRAN');
INSERT INTO VILPAYS VALUES ('TEHERAN', 'YRAN');
INSERT INTO VILPAYS VALUES ('TEHERAN', 'IRANE');
COMMIT;

--======================================================================================
--======================================================================================
--======================================================================================

REM VISUALISATION DES DONNEES
SELECT * FROM VILPAYS;

REM HOMOGENEISATION DES DONNEES : TOUT EN MAJUSCULE
UPDATE VILPAYS SET COL1 = UPPER(COL1);
UPDATE VILPAYS SET COL2 = UPPER(COL2);
COMMIT;
SELECT * FROM VILPAYS;

REM Calcul du nombre de lignes dans la table
SELECT COUNT(*) FROM VILPAYS;

REM Calcul du nombre de villes et du nombre de pays
SELECT COUNT(COL1) AS NBVILLES, COUNT(COL2) AS NBPAYS FROM VILPAYS;

REM Calcul du nombre de villes et du nombre de pays
SELECT COUNT(DISTINCT COL1) AS NBVILLES, COUNT(DISTINCT COL2) AS NBPAYS FROM VILPAYS;

REM Compter le nombre d occurrences par valeur de COL1 et valeur de COL2 afin de détecter d éventuelles anomalies
CREATE OR REPLACE VIEW V1 (VILLE, NOMBRE) AS SELECT COL1, COUNT(*) FROM VILPAYS GROUP BY COL1 ORDER BY 1;
SELECT * FROM V1;
CREATE OR REPLACE VIEW V2 (PAYS, NOMBRE) AS SELECT COL2, COUNT(*) FROM VILPAYS GROUP BY COL2 ORDER BY 1;
SELECT * FROM V2;

REM On considère que la valeur la plus fréquente (pour chaque groupe de valeurs similaires) est la chaine de caractères valide
REM Développez le processus qui permet de détecter les anomalies et éventuellement les corriger

-- ????????????      FB FB FB FB FB FB A compléter ??????????????
-- A VOUS ! -- BON COURAGE -- MFB
-- ????????????      FB FB FB FB FB FB A compléter ??????????????

CREATE OR REPLACE PROCEDURE corrigerVille
AUTHID CURRENT_USER IS
   a number(2) := 10;
BEGIN
   WHILE a > 0  LOOP

EXECUTE IMMEDIATE  'CREATE OR REPLACE VIEW V1 (VILLE, NOMBRE) AS SELECT COL1, COUNT(*) FROM VILPAYS GROUP BY COL1 ORDER BY 1';

EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW Vcor1 (VILLE1, NOMBRE1,VILLE2,nombre2,similarity,distance,prononce,score,correction)
		AS
		SELECT t1.ville,t1.nombre,t2.ville,t2.nombre,UTL_MATCH.jaro_winkler_similarity(t1.ville,t2.ville ) as similarity,UTL_MATCH.edit_distance_similarity(t1.ville,t2.ville ) as distance,
		UTL_MATCH.jaro_winkler_similarity(SOUNDEX(t1.ville),SOUNDEX(t2.ville)) as prononce,
		(UTL_MATCH.jaro_winkler_similarity(t1.ville,t2.ville )+UTL_MATCH.edit_distance_similarity(t1.ville,t2.ville )+
		UTL_MATCH.jaro_winkler_similarity(SOUNDEX(t1.ville),SOUNDEX(t2.ville)))/3.0 AS SCORE,CASE WHEN t1.nombre>t2.nombre THEN t1.ville else t2.ville end as correction from v1 t1
		join v1 t2 on t1.ville<t2.ville
		where  ((UTL_MATCH.jaro_winkler_similarity(t1.ville,t2.ville )+UTL_MATCH.edit_distance_similarity(t1.ville,t2.ville )+
		UTL_MATCH.jaro_winkler_similarity(SOUNDEX(t1.ville),SOUNDEX(t2.ville)))/3.0) >=85
		group by t1.ville,t2.ville,t1.nombre,t2.nombre
		order by SCORE';

EXECUTE IMMEDIATE 'UPDATE VILPAYS
set col1=(select correction from vcor1 where (col1=ville1 or col1=ville2) and rownum = 1)
where col1 in (select ville1 from vcor1) or col1 in (select ville2 from vcor1)' ;

SELECT count(*) INTO a FROM Vcor1;

   END LOOP;
END;
/

EXEC corrigerVille;


CREATE OR REPLACE PROCEDURE corrigerPays
AUTHID CURRENT_USER IS
   a number(2) := 10;
BEGIN
   WHILE a > 0  LOOP

EXECUTE IMMEDIATE  'CREATE OR REPLACE VIEW V2 (PAYS, NOMBRE) AS SELECT COL2, COUNT(*) FROM VILPAYS GROUP BY COL2 ORDER BY 1';

EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW Vcor2 (PAYS1, NOMBRE1,PAYS2,nombre2,similarity,distance,prononce,score,correction)
		AS
		SELECT t1.PAYS,t1.nombre,t2.PAYS,t2.nombre,UTL_MATCH.jaro_winkler_similarity(t1.PAYS,t2.PAYS ) as similarity,UTL_MATCH.edit_distance_similarity(t1.PAYS,t2.PAYS ) as distance,
		UTL_MATCH.jaro_winkler_similarity(SOUNDEX(t1.PAYS),SOUNDEX(t2.PAYS)) as prononce,
		(UTL_MATCH.jaro_winkler_similarity(t1.PAYS,t2.PAYS )+UTL_MATCH.edit_distance_similarity(t1.PAYS,t2.PAYS )+
		UTL_MATCH.jaro_winkler_similarity(SOUNDEX(t1.PAYS),SOUNDEX(t2.PAYS)))/3.0 AS SCORE,CASE WHEN t1.nombre>t2.nombre THEN t1.PAYS else t2.PAYS end as correction from V2 t1
		join V2 t2 on t1.PAYS<t2.PAYS
		where  ((UTL_MATCH.jaro_winkler_similarity(t1.PAYS,t2.PAYS )+UTL_MATCH.edit_distance_similarity(t1.PAYS,t2.PAYS )+
		UTL_MATCH.jaro_winkler_similarity(SOUNDEX(t1.PAYS),SOUNDEX(t2.PAYS)))/3.0) >=85
		group by t1.PAYS,t2.PAYS,t1.nombre,t2.nombre
		order by SCORE';

EXECUTE IMMEDIATE 'UPDATE VILPAYS
set col2=(select correction from vcor2 where (col2=PAYS1 or col2=PAYS2) and rownum = 1)
where col2 in (select PAYS1 from vcor2) or col2 in (select PAYS2 from vcor2)' ;

SELECT count(*) INTO a FROM Vcor2;

   END LOOP;
END;
/

EXEC corrigerPays;


CREATE OR REPLACE PROCEDURE corrigervillepays
AUTHID CURRENT_USER IS
   a number(2) := 10;
BEGIN
   WHILE a > 0  LOOP
      dbms_output.put_line('value of a: ' || a);
      EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW V3 (VILLEPAYS, NOMBRE) AS SELECT COL1||'';''||COL2, COUNT(*) FROM VILPAYS GROUP BY COL1||'';''||COL2  ORDER BY 1;';
      EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW Vcor3 (VILLEPAYS1, NOMBRE1, VILLEPAYS2, nombre2, similarity, distance, prononce, score, correction, nbrcor)
		AS
		SELECT t1.VILLEPAYS,t1.nombre,t2.VILLEPAYS,t2.nombre,UTL_MATCH.jaro_winkler_similarity(t1.VILLEPAYS,t2.VILLEPAYS ) as similarity,UTL_MATCH.edit_distance_similarity(t1.VILLEPAYS,t2.VILLEPAYS ) as distance,
		UTL_MATCH.jaro_winkler_similarity(SOUNDEX(t1.VILLEPAYS),SOUNDEX(t2.VILLEPAYS)) as prononce,
		(UTL_MATCH.jaro_winkler_similarity(t1.VILLEPAYS,t2.VILLEPAYS )+UTL_MATCH.edit_distance_similarity(t1.VILLEPAYS,t2.VILLEPAYS )+
		UTL_MATCH.jaro_winkler_similarity(SOUNDEX(t1.VILLEPAYS),SOUNDEX(t2.VILLEPAYS)))/3.0 AS SCORE,CASE WHEN t1.nombre>t2.nombre THEN t1.VILLEPAYS else t2.VILLEPAYS end as correction,CASE WHEN t1.nombre > t2.nombre THEN t1.nombre else t2.nombre end as nbrcor from v3 t1
		join v3 t2 on t1.VILLEPAYS<t2.VILLEPAYS
		where  ((UTL_MATCH.jaro_winkler_similarity(t1.VILLEPAYS,t2.VILLEPAYS )+UTL_MATCH.edit_distance_similarity(t1.VILLEPAYS,t2.VILLEPAYS )+
		UTL_MATCH.jaro_winkler_similarity(SOUNDEX(t1.VILLEPAYS),SOUNDEX(t2.VILLEPAYS)))/3.0) >=75
		group by t1.VILLEPAYS,t2.VILLEPAYS,t1.nombre,t2.nombre
		order by nbrcor RESC';
      EXECUTE IMMEDIATE 'UPDATE VILPAYS set col1=(select SUBSTR(correction,0,INSTR(correction,'';'')-1) from vcor3 where (VILLEPAYS1 = COL1||'';''||COL2 or VILLEPAYS2= COL1||'';''||COL2) and rownum = 1) , col2=(select SUBSTR(correction,INSTR(correction,'';'')+1) from vcor3 where (VILLEPAYS1 = COL1||'';''||COL2 or VILLEPAYS2= COL1||'';''||COL2) and rownum = 1)
                         where COL1||'';''||COL2 in (select VILLEPAYS1 from vcor3) or COL1||'';''||COL2 in (select VILLEPAYS2 from vcor3)' ;
      SELECT count(*) INTO a FROM Vcor3;
   END LOOP;
END;
/

EXEC corrigervillepays;

--======================================================================================
--======================================================================================
--======================================================================================
--==================== TRAITEMENT DE CERTAINES ANOMALIES ===============================
--==================== INTER-LIGNES ====================================================
/*
Entre parenthèses hihi haha FFF ! (...)

Etant donné la table TABCLI suivante :
Elle est issue des tables de la BD GesComI...
Faire les requêtes ci-dessous :
Eliminer les doubles et les similaires !
*/

CREATE TABLE TABCLI (COL1 VARCHAR(10), COL2 VARCHAR(12), COL3 VARCHAR(10), COL4 VARCHAR(10), COL5 VARCHAR(1));

INSERT INTO TABCLI VALUES ('2994570', 'Madame', 'RAHMA', 'CLEMENCE', '3');
INSERT INTO TABCLI VALUES ('2996100', 'Monsieur', 'CLEMENCE', 'ALEXANDRE', '1');
INSERT INTO TABCLI VALUES ('3000107', 'MO NSIEUR', 'ONRI', 'PANDA', '2');
INSERT INTO TABCLI VALUES ('2997777', 'Mademoiselle', 'LE BON', 'CLEMENTINE', '1');
INSERT INTO TABCLI VALUES ('299PPPP', 'Mlle', 'BON', 'CLEMENTINE', '1');
INSERT INTO TABCLI VALUES ('2997007', 'Monsieur', 'TRAIFOR', 'ADAM', '2');
INSERT INTO TABCLI VALUES ('2998500', 'Monsieur', 'CHEVALIER', 'INES', '1');
INSERT INTO TABCLI VALUES ('3000106', 'Monsieur', 'HARISSA', 'FORD', '1');
INSERT INTO TABCLI VALUES ('3000108', 'Madame', 'EDITE', 'FIAT', '1');
INSERT INTO TABCLI VALUES ('3000109', 'Madame', 'TOYOTA', 'JACKSON', '3');
INSERT INTO TABCLI VALUES ('3000111', 'Madame', 'GENEREUX', 'EVE', '1');
INSERT INTO TABCLI VALUES ('3001778', 'Mr', 'COURTOIS', 'Bruno', '1');
INSERT INTO TABCLI VALUES ('3001779', 'Monsieur', 'VANDERHOTE', 'Ivan', '1');
INSERT INTO TABCLI VALUES ('3001780', 'Monsieur', 'Hollanda', 'Francis', '1');
INSERT INTO TABCLI VALUES ('3001781', 'Monsieur', 'Bernard', 'Hugues', '1');
INSERT INTO TABCLI VALUES ('3001782', 'Monsieur', 'LATIFOU', 'Ilyas', '1');
INSERT INTO TABCLI VALUES ('3001783', 'Madame', 'LALLEMAND', 'Ines', '1');
INSERT INTO TABCLI VALUES ('3001784', 'Monsieur', 'DEUTCH', 'Hans', '1');
INSERT INTO TABCLI VALUES ('3001785', 'Madame', 'ALMANI', 'Eve', '1');
INSERT INTO TABCLI VALUES ('3001786', 'Madame', 'MERQUELLE', 'Angela', '1');
INSERT INTO TABCLI VALUES ('3001', 'M.', 'LE BON', 'Adam', '1');
INSERT INTO TABCLI VALUES ('3001777', 'Mr', 'LE BON', 'Adem', '1');
INSERT INTO TABCLI VALUES ('3001777', 'Monsieur', 'LE BON', 'Adam', '1');
INSERT INTO TABCLI VALUES ('2998505', 'Mademoiselle', 'TRAIFOR', 'ALICE', '2');
INSERT INTO TABCLI VALUES ('3000110', 'MADAME', 'ONRI', 'HONDA', '2');
INSERT INTO TABCLI VALUES ('3001777', 'Monsieur', 'LE BON', 'Adam', '1');
INSERT INTO TABCLI VALUES ('3001777', 'Monsieur', 'LE BON', 'Adam', '1');
INSERT INTO TABCLI VALUES ('3001777', 'Monsieur', 'LE BON', 'Adam', '');
INSERT INTO TABCLI VALUES ('3001777', 'Monsieur', 'LE BON', 'Adam', '1');
INSERT INTO TABCLI VALUES ('3001777', 'Monsieùr', 'LE BON', 'Adam', '1');
COMMIT;


---Elimination des doubles

create table tabcli_temp as
select col1,col2,col3,col4,col5
from tabcli
group by col1,col2,col3,col4,col5
having count(*)>1;

delete from tabcli t
where exists
(select * from tabcli_temp t2 where t2.col1=t.col1
and t2.col2=t.col2
and t2.col3=t.col3
and t2.col4=t.col4
and t2.col5=t.col5
group by t2.col1,t2.col2,t2.col3,t2.col4,t2.col5);

insert into tabcli
select * from tabcli_temp;

---Detection et elimination des SIMILAIRES

CREATE OR REPLACE PROCEDURE corrigerSimilaire
AUTHID CURRENT_USER IS
   a number(2) := 10;
BEGIN
   WHILE a > 0  LOOP

EXECUTE IMMEDIATE  'update tabcli set col5=0 where col5 is null';

EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW Vtabcli (col11,col12,col13,col14,col15,col21,col22,col23,col24,col25,SImilarity)
		AS
		select t1.*,t2.*,(UTL_MATCH.jaro_winkler_similarity(t1.col2,t2.col2)+
		UTL_MATCH.jaro_winkler_similarity(t1.col3,t2.col3)+UTL_MATCH.jaro_winkler_similarity(t1.col4,t2.col4)
		+(0.001*UTL_MATCH.jaro_winkler_similarity(t1.col5,t2.col5)))/3.001 as similarity
		from tabcli t1 join tabcli t2 on 1=1
		where (UTL_MATCH.jaro_winkler_similarity(t1.col2,t2.col2)+
		UTL_MATCH.jaro_winkler_similarity(t1.col3,t2.col3)+UTL_MATCH.jaro_winkler_similarity(t1.col4,t2.col4)
		+(0.001*UTL_MATCH.jaro_winkler_similarity(t1.col5,t2.col5)))/3.001 between 80 and 99.99
		order by similarity';

EXECUTE IMMEDIATE 'delete from tabcli t
where exists
(
select distinct t.* from Vtabcli t2
where t2.col21=t.col1
and t2.col22=t.col2
and t2.col23=t.col3
and t2.col24=t.col4
and t2.col25=t.col5
) and rownum = 1';


SELECT count(*) INTO a FROM VTABCLI;

   END LOOP;
END;
/

EXEC corrigerSimilaire;

--======================================================================================
--======================================================================================
--======================================================================================

REM VISUALISATION DES DONNEES
SELECT COUNT(*) AS NbrCli FROM TABCLI;
SELECT * FROM TABCLI;

REM ??? Que font les commandes SQL ci-dessous ?
SELECT COUNT(DISTINCT *) FROM TABCLI ;
--reponse : elle donne le nombre de couple(ville,pays) distincts dans la table tabcli

SELECT DISTINCT * FROM TABCLI ;
--reponse : elle affiche les couples(ville,pays) distincts dans la table tabcli

-- ????????????      FB FB FB FB FB FB A compléter ??????????????
-- A VOUS ! -- BON COURAGE -- MFB
-- ????????????      FB FB FB FB FB FB A compléter ??????????????

--======================================================================================
--======================================================================================
--======================================================================================
--======================================================================================
--======================================================================================
--======================================================================================
--==================== TRAITEMENT DE CERTAINES ANOMALIES ===============================
--==================== DES CONTRAINTES DEFINIES PAR L UTILSATEUR =======================

-- Développez une procédure PL/SQL qui permet de vérifier la cohérence de la BD :
-- Vérifiez si toutes les commandes portent au moins sur un article
-- Affichez celles qui sont donc vides !

PROMPT =====================================================================
PROMPT >> Requete : Procedure PL/SQL => vérification cohérence de la BD
PROMPT =====================================================================
PROMPT
REM Verifier si toutes les commandes portent au moins sur un article et
REM afficher celles qui sont donc vides!

TTITLE CENTER 'Verification de la cohérence de la base de données' skip 1 -
       LEFT   '=========================================================================' skip 0

SET SERVEROUTPUT ON;

PROMPT =====================================================================
PROMPT Suppression et création de la procédure COHERENCE_BD
PROMPT =====================================================================
PROMPT
DROP PROCEDURE COHERENCE_BD;

CREATE OR REPLACE PROCEDURE COHERENCE_BD IS
	CURSOR curseur IS
	SELECT NUMCOM FROM COMMANDES
	MINUS (SELECT NUMCOM FROM DETAILCOM);

BEGIN
	DBMS_OUTPUT.PUT_LINE('Le(s) numéro(s) de commande vide(s) sont :');
	FOR i IN curseur LOOP
		DBMS_OUTPUT.PUT_LINE('-  ' || i.NUMCOM);
	END LOOP;
END;
/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =====================================================================
PROMPT Execution de la procédure COHERENCE_BD
PROMPT =====================================================================
PROMPT
EXECUTE COHERENCE_BD;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
--
-- Le(s) numéro(s) de commande vide(s) sont :
--  ????

PROMPT
pause Tapez sur Enter...
PROMPT

--====================================================================================
--====================================================================================
--====================================================================================
--==================== Modification de la structure des données ======================
--========================== Diagnostiquer les anomalies =============================
--====================================================================================
--====================================================================================

-- Ajoutez 4 colonnes à la table CLIENTS afin de diagnostiquer les éventuelles anomalies
-- ANOMALIES de type VARCHAR(20), VALIDCOL NUMBER(2), INVALIDCOL NUMBER(2), NULLCOL NUMBER(2)

CREATE TABLE DIAGNOSTICDATA
(ANOMALIES VARCHAR(20), VALIDCOL NUMBER(2), INVALIDCOL NUMBER(2), NULLCOL NUMBER(2));
INSERT INTO DIAGNOSTICDATA values ('', 0, 0, 0);
/*
CREATE OR REPLACE VIEW DIAGNOCLIENTS
AS SELECT * FROM CLIENTS, DIAGNOSTICDATA;
SELECT * FROM DIAGNOCLIENTS;
*/

DROP TABLE DIAGNOCLIENTS;
CREATE TABLE DIAGNOCLIENTS
AS SELECT * FROM CLIENTS, DIAGNOSTICDATA;
SELECT * FROM DIAGNOCLIENTS;

-- Ajoutez 4 colonnes à la table CLIENTS afin de diagnostiquer les éventuelles anomalies
ALTER TABLE CLIENTS
ADD	ANOMALIES VARCHAR(20)
ADD VALIDCOL NUMBER(2)
ADD INVALIDCOL NUMBER(2)
ADD  NULLCOL NUMBER(2);


-- Développez le mécanisme VERIFYDATACLI qui permet de faire :
-- Pour chaque ligne de la table
-- Vérifier la validité de chaque colonne
-- ErrorIndicator = ''  -- ErrorIndicator est une chaine vide au départ
-- NbreT = 0    NbrF = 0 NbrN = 0
-- Si la donnée est valide alors ErrorIndicator = ErrorIndicator || 'T' et NbrT = NbrT + 1
-- Si la donnée est INvalide alors ErrorIndicator = ErrorIndicator || 'F' et NbrF = NbrF + 1
-- Si la donnée est vide alors ErrorIndicator = ErrorIndicator || 'N' et NbrN = NbrN + 1
-- Insérer à la fin de chaque ligne la valeur ErrorIndicator dans la colonne ANOMALIES
-- ErrorIndicator permet de diagnostiquer le contenu d une ligne entiere
-- Insérer à la fin de chaque ligne le nombre de valeurs valides (nombre de T)
-- Insérer à la fin de chaque ligne le nombre de valeurs invalides (nombre de F)
-- Insérer à la fin de chaque ligne le nombre de valeurs nulles (nombre de N)
-- La colonne ANOMALIES et les 3 autres colonnes permettent de diagnostiquer le contenu de la table entiere

-- Filtrez (découpez) la table en plusieurs parties :
-- Les données VALIDES, les "WARNING" et les "INVALIDES"
-- Affichez les lignes INVALIDES avec messages d'erreur

-- Proposez des corrections...

-- ????????????      FB FB FB FB FB FB A compléter ??????????????


DROP TABLE VERIFICATION;
CREATE TABLE VERIFICATION (COLONNE VARCHAR2(125),CATEGORY VARCHAR2(125));
SET SERVEROUTPUT ON;

create or replace procedure VERIFYDATACLI IS

V_NOMCLI VARCHAR2(120);
V_PRENCLI VARCHAR2(120);
V_VilCli VARCHAR2(120);
V_PAYSCLI VARCHAR(130);
V_MAILCLI VARCHAR(130);
V_TELCLI VARCHAR(120);
ErrorIndicator VARCHAR2(150);
NbrT number(2);
NbrF number(2);
NbrN number(2);
V_CODCLI VARCHAR(130);
V_COLONNE VARCHAR2(150);
V_CATEGORY VARCHAR2(150);
result varchar2(50);


CURSOR curseur IS
SELECT CODCLI,NOMCLI,PRENCLI,VilCli,PAYSCLI,MAILCLI,TELCLI FROM CLIENTS;

CURSOR curseur2 IS
SELECT Colonne,Category FROM Verification;

BEGIN
OPEN curseur;

LOOP
	FETCH curseur INTO V_CODCLI,V_NOMCLI,V_PRENCLI,V_VilCli,V_PAYSCLI,V_MAILCLI,V_TELCLI ;
	EXIT WHEN NOT curseur%FOUND;
	SELECT '' INTO ErrorIndicator FROM dual;
	SELECT 0 INTO NbrT FROM dual;
	SELECT 0 INTO NbrF FROM dual;
	SELECT 0 INTO NbrN FROM dual;

	EXECUTE IMMEDIATE 'DELETE FROM VERIFICATION';
	EXECUTE IMMEDIATE 'INSERT INTO VERIFICATION VALUES('''||V_NOMCLI||''',''ALPHABETIQUE'')';
	EXECUTE IMMEDIATE 'INSERT INTO VERIFICATION VALUES('''||V_PRENCLI||''',''ALPHABETIQUE'')';
	EXECUTE IMMEDIATE 'INSERT INTO VERIFICATION VALUES('''||V_VilCli||''',''ALPHABETIQUE'')';
	EXECUTE IMMEDIATE 'INSERT INTO VERIFICATION VALUES('''||V_PAYSCLI||''',''ALPHABETIQUE'')';
	EXECUTE IMMEDIATE 'INSERT INTO VERIFICATION VALUES('''||V_MAILCLI||''',''MAIL'')';
	EXECUTE IMMEDIATE 'INSERT INTO VERIFICATION VALUES('''||V_TELCLI||''',''TELFR'')';

	OPEN curseur2;

	LOOP
	FETCH curseur2 INTO V_COlONNE, V_CATEGORY ;
	EXIT WHEN NOT curseur2%FOUND;

	IF V_COLONNE IS NULL THEN
		SELECT concat(ErrorIndicator,'N') INTO ErrorIndicator FROM dual;
		SELECT NbrN+1 INTO NbrN FROM dual;
	ELSE
		SELECT VerifRegExpr(V_COLONNE,V_CATEGORY) into result from dual;
		IF RESULT='FALSE' THEN
			SELECT concat(ErrorIndicator,'F') INTO ErrorIndicator FROM dual;
			SELECT NbrF+1 INTO NbrF FROM dual;
		ELSE
			SELECT concat(ErrorIndicator,'T') INTO ErrorIndicator FROM dual;
			SELECT NbrT+1 INTO NbrT FROM dual;
		END IF;
	END IF;



	END LOOP;

	CLOSE curseur2;

	update clients
	set ANOMALIES=ErrorIndicator ,VALIDCOL=NbrT ,INVALIDCOL=NbrF ,NULLCOL=NbrN
	where codcli=v_codcli;


END LOOP;

CLOSE curseur;
END;
/

exec VERIFYDATACLI;


--======================================================================================
--======================================================================================
--======================================================================================
--======================================================================================
--======================================================================================
--======================================================================================
-- MFB FFF +++++++++++++++++++++++++++++++++++++++++++
COMMIT;
SET TIMING OFF;
SPOOL OFF;
