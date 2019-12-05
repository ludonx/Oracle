-- ===============================================================================
-------- Universit� Sorbonne Paris Cit�, Universit� Paris 13 , Institut Gali�e
-------- Master 2, Informatique, Exploration Informatique des Donn�es et D�cisionnel, M2 EID2
-------- Ing�nieurs en informatique

-- ===============================================================================
-------- La Data ; The Data
-------- La Donn�e est le monde du futur ; Les donn�es et le monde de l'avenir
-------- The Data is the world of the future ;  The Data and the future's world
-- ===============================================================================
-------- DATA -->>>
-------- Bases de Donn�es Avanc�es = Advanced Databases (BDA)
-------- Entrep�ts de Donn�es = Data Warehouses (DWH, EDON)
-------- Lacs de Donn�es = Data Lakes
-------- Big Data, Dark Data, Open Data, Master Data...
-- ===============================================================================

-------- Directeur :  Dr. M. Faouzi Boufar�s
-------- Enseignant-Chercheur Responsable

-------- Page Web : http://www.lipn.univ-paris13.fr/~boufares

-------- http://www.lipn.univ-paris13.fr/~boufares/Master2EID2/*.sql

-- ===============================================================================
--   Projet  Smart Data : Big Data Management - Gestion des Donn�es Massives
-- ===============================================================================
--   Projet  Smart Data : Gestion des Donn�es Massives, H�t�rog�nes et de qualit� variable
--   Donn�es structur�es ; Donn�es Semi-structur�es ; Donn�es NON structur�es
--   Structured data; Semi-structured data; NON-structured data

--   Data Integration (DI) - Int�gration de Donn�es
--   Data Manipulation (DM) - Manipulation de Donn�es

--   Master Data Management (MDM) - Gestion des Donn�es de R�f�rence
--   Data Quality Managment (DQM) - Gestion de la qualit� des donn�es
--   Data Cleaning - Nettayage des donn�es
--   Data deduplication - Elimination des doubles et des similaires

--   More semantics to better correct the data
--   Plus de s�mantique afin de mieux corriger les donn�es
-- ===============================================================================
-- ===============================================================================
--
-- Big Data & Clound Computing : Think DIFFERENTLY, BIGGER and SMARTER !
-- The Excellence in Data Use !
-- EID : L'Excellence dans l'Investigation des Donn�es
-- EID : Excellence in Data Investigation
--
-- ===============================================================================
-- Think DIFFERENTLY, BIGGER and SMARTER ! The Excellence in Data Use !
-- MISSION IMPOSSIBLE OU POSSIBLE ????? !!!!!!!!!!!
-- Votre mission, si vous l�acceptez, est : The Excellence in Data Use !
-- Si vous �chouez, nous nierons avoir eu connaissance de vos agissements !

-- ===============================================================================
-- Les dictons du jour !
--
-- Aujourd'hui, j'arr�te de fumer
-- Le TABAC t'ABAT
-- Fumer nuit gr�vement � ta sant� et � celle de ton entourage
--
-- M   T   Dents
-- SMILE and the World SMILES with you !
--
-- MANGER + MANGER = GROSSIR (??? M, A, N, G, E, R, O, S, S, I)
--
-- Manger & Bouger,
-- Pour votre sant� mangez 5 fruits et l�gumes par jour
-- Pour votre sant� ne mangez pas trop gras, trop sal�, trop sucr�
-- Pour votre sant� faites une activit� physique r�guli�re
-- Pour votre sant� faites 30 mn de marche par jour
-- Pour votre sant� faites des BD !!!
--
-- Dr. M. Faouzi Boufar�s
-- ===============================================================================
-- ===============================================================================
-- iDQMS ... Al ETL Al Jadyd
--   A new ETL   ETL & DQ : Extract-Transform-Load & Data-Quality
-- ===============================================================================
-- ===============================================================================

-- ===============================================================================
-- ===============================================================================
-- ===============================================================================
--   Nom du SGBD/DBMS  : ORACLE  /  DB2  /  MySQL  /  MongoDB...
--   Date de creation  : 28/11/2019
---  Lieu              : Universit� Sorbonne Paris Cit�, Universit� Paris 13, Institut Gali�e
-- ===============================================================================
-- ===============================================================================
-------------------- Master 2 EID2 - Promotion 2019-2020 -------------------------

-- Groupe de Travail N� ??  : B??

-- NOM1 PRENOM1                  : np1
-- NOM2 PRENOM2                  : np2

-- ====>>> Vos fichiers sql devront s'appeler : Bxy-G2.sql


-- ===============================================================================
-- ===============================================================================
-- ===============================================================================
--   Probl�matique    :  Int�gration de donn�es h�t�rog�nes,  de qualit� variable

--   Probl�matique    :  Traitement des anomalies �ventuelles
--   Probl�matique    :  Plusieurs types d'anomalies INTRA-Colonne ; INTER-COLONNES ; INTER-LIGNES

--   Probl�matique    :  Standardisation de donn�es h�t�rog�nes
--   Probl�matique    :  Traitement des valeurs invalides syntaxiquement
--   Probl�matique    :  Traitement des valeurs invalides s�mantiquement
--   Probl�matique    :  Traitement des valeurs nulles
--   Probl�matique    :  Traitement des redondances (D�pendances fonctionnelles)
--   Probl�matique    :  Elimination des doubles et similaires

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


SPOOL GCI-03.lst

SET TIMING ON;
SET LINES 1000
SET PAGES 1000

PROMPT
PROMPT =========================================================
PROMPT |                                                       |
PROMPT |     Exercice 3 :  BD GESCOMI avec SQL 2               |
PROMPT |     Int�gration de BD                                 |
PROMPT |                                                       |
PROMPT =========================================================
PROMPT
PROMPT

PROMPT =========================================================
PROMPT Ceci permet d initialiser le type de la date
PROMPT =========================================================
/*
-- Initialiser le type de la date avec ...
ALTER SESSION SET NLS_DATE_FORMAT = 'DAY DD-MONTH-YYYY' ;
ALTER SESSION SET NLS_DATE_FORMAT = '???? HiHi HaHa' ; ???
ALTER SESSION SET    Quelle langue ?
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'DAY DD-MONTH-YYYY' ;
ALTER SESSION SET NLS_LANGUAGE=ENGLISH;
PROMPT =========================================================


/*

Entre parenth�ses hihi haha FFF !

Etant donn� la table CACLI suivante :
Elle est issue de plusieurs calculs sur les tables de la BD GesComI...
Faire les requ�tes ci-dessous : Statistiques sur le chiffre d�affaires
*/

/*
CREATE TABLE CACLI (DATECA DATE, MONTANTCA NUMBER);
INSERT INTO CACLI VALUES ('01-01-2010', 72);
INSERT INTO CACLI VALUES ('01-02-2010', 88);
INSERT INTO CACLI VALUES ('01-03-2010', 90);
INSERT INTO CACLI VALUES ('01-04-2010', 74);
INSERT INTO CACLI VALUES ('01-05-2010', 79);
INSERT INTO CACLI VALUES ('01-06-2010', 72);
INSERT INTO CACLI VALUES ('01-07-2010', 76);
INSERT INTO CACLI VALUES ('01-08-2010', 89);
INSERT INTO CACLI VALUES ('01-09-2010', 90);
INSERT INTO CACLI VALUES ('01-10-2010', 80);
INSERT INTO CACLI VALUES ('01-11-2010', 69);
INSERT INTO CACLI VALUES ('01-12-2010', 90);
INSERT INTO CACLI VALUES ('01-01-2011', 78);
INSERT INTO CACLI VALUES ('01-02-2011', 93);
INSERT INTO CACLI VALUES ('01-03-2011', 81);
INSERT INTO CACLI VALUES ('01-04-2011', 72);
INSERT INTO CACLI VALUES ('01-05-2011', 94);
INSERT INTO CACLI VALUES ('01-06-2011', 70);
INSERT INTO CACLI VALUES ('01-07-2011', 93);
INSERT INTO CACLI VALUES ('01-08-2011', 72);
INSERT INTO CACLI VALUES ('01-09-2011', 82);
INSERT INTO CACLI VALUES ('01-10-2011', 74);
INSERT INTO CACLI VALUES ('01-11-2011', 90);
INSERT INTO CACLI VALUES ('01-12-2011', 73);
INSERT INTO CACLI VALUES ('01-01-2012', 63);
INSERT INTO CACLI VALUES ('01-02-2012', 67);
INSERT INTO CACLI VALUES ('01-03-2012', 74);
INSERT INTO CACLI VALUES ('01-04-2012', 64);
INSERT INTO CACLI VALUES ('01-05-2012', 66);
INSERT INTO CACLI VALUES ('01-06-2012', 60);
INSERT INTO CACLI VALUES ('01-07-2012', 69);
INSERT INTO CACLI VALUES ('01-08-2012', 68);
INSERT INTO CACLI VALUES ('01-09-2012', 69);
INSERT INTO CACLI VALUES ('01-10-2012', 75);
INSERT INTO CACLI VALUES ('01-11-2012', 61);
INSERT INTO CACLI VALUES ('01-12-2012', 60);
INSERT INTO CACLI VALUES ('01-01-2013', 75);
INSERT INTO CACLI VALUES ('01-02-2013', 63);
INSERT INTO CACLI VALUES ('01-03-2013', 69);
INSERT INTO CACLI VALUES ('01-04-2013', 61);
INSERT INTO CACLI VALUES ('01-05-2013', 63);
INSERT INTO CACLI VALUES ('01-06-2013', 62);
INSERT INTO CACLI VALUES ('01-07-2013', 58);
INSERT INTO CACLI VALUES ('01-08-2013', 60);
INSERT INTO CACLI VALUES ('01-09-2013', 61);
INSERT INTO CACLI VALUES ('01-10-2013', 59);
INSERT INTO CACLI VALUES ('01-11-2013', 72);
INSERT INTO CACLI VALUES ('01-12-2013', 59);
INSERT INTO CACLI VALUES ('01-01-2014', 50);
INSERT INTO CACLI VALUES ('01-02-2014', 54);
INSERT INTO CACLI VALUES ('01-03-2014', 59);
INSERT INTO CACLI VALUES ('01-04-2014', 60);
INSERT INTO CACLI VALUES ('01-05-2014', 50);
INSERT INTO CACLI VALUES ('01-06-2014', 54);
INSERT INTO CACLI VALUES ('01-07-2014', 55);
INSERT INTO CACLI VALUES ('01-08-2014', 58);
INSERT INTO CACLI VALUES ('01-09-2014', 60);
INSERT INTO CACLI VALUES ('01-10-2014', 56);
INSERT INTO CACLI VALUES ('01-11-2014', 56);
INSERT INTO CACLI VALUES ('01-12-2014', 55);
INSERT INTO CACLI VALUES ('01-01-2015', 55);
INSERT INTO CACLI VALUES ('01-02-2015', 55);
INSERT INTO CACLI VALUES ('01-03-2015', 51);
INSERT INTO CACLI VALUES ('01-04-2015', 55);
INSERT INTO CACLI VALUES ('01-05-2015', 56);
INSERT INTO CACLI VALUES ('01-06-2015', 56);
INSERT INTO CACLI VALUES ('01-07-2015', 56);
INSERT INTO CACLI VALUES ('01-08-2015', 52);
INSERT INTO CACLI VALUES ('01-09-2015', 58);
INSERT INTO CACLI VALUES ('01-10-2015', 59);
INSERT INTO CACLI VALUES ('01-11-2015', 57);
INSERT INTO CACLI VALUES ('01-12-2015', 50);
INSERT INTO CACLI VALUES ('01-01-2016', 18);
INSERT INTO CACLI VALUES ('01-02-2016', 16);
INSERT INTO CACLI VALUES ('01-03-2016', 18);
INSERT INTO CACLI VALUES ('01-04-2016', 19);
INSERT INTO CACLI VALUES ('01-05-2016', 20);
INSERT INTO CACLI VALUES ('01-06-2016', 10);
INSERT INTO CACLI VALUES ('01-07-2016', 18);
INSERT INTO CACLI VALUES ('01-08-2016', 13);
INSERT INTO CACLI VALUES ('01-09-2016', 19);
INSERT INTO CACLI VALUES ('01-10-2016', 18);
INSERT INTO CACLI VALUES ('01-11-2016', 20);
INSERT INTO CACLI VALUES ('01-12-2016', 12);
INSERT INTO CACLI VALUES ('01-01-2017', 14);
INSERT INTO CACLI VALUES ('01-02-2017', 12);
INSERT INTO CACLI VALUES ('01-03-2017', 17);
INSERT INTO CACLI VALUES ('01-04-2017', 12);
INSERT INTO CACLI VALUES ('01-05-2017', 20);
INSERT INTO CACLI VALUES ('01-06-2017', 14);
INSERT INTO CACLI VALUES ('01-07-2017', 16);
INSERT INTO CACLI VALUES ('01-08-2017', 19);
INSERT INTO CACLI VALUES ('01-09-2017', 12);
INSERT INTO CACLI VALUES ('01-10-2017', 12);
INSERT INTO CACLI VALUES ('01-11-2017', 19);
INSERT INTO CACLI VALUES ('01-12-2017', 20);
INSERT INTO CACLI VALUES ('01-01-2018', 15);
INSERT INTO CACLI VALUES ('01-02-2018', 11);
INSERT INTO CACLI VALUES ('01-03-2018', 14);
INSERT INTO CACLI VALUES ('01-04-2018', 17);
INSERT INTO CACLI VALUES ('01-05-2018', 13);
INSERT INTO CACLI VALUES ('01-06-2018', 13);
INSERT INTO CACLI VALUES ('01-07-2018', 11);
INSERT INTO CACLI VALUES ('01-08-2018', 10);
INSERT INTO CACLI VALUES ('01-09-2018', 13);
COMMIT;
*/
/*
A vous les requetes suivantes :
Donnez la repr�sentation graphique sous EXCEL !
Gestion des "Reporting"

Chiffre d�affaires pour l�ann�e 2010
Chiffre d�affaires pour l�ann�e 2011

Chiffre d�affaires pour l�ann�e 2018
Chiffre d�affaires de 2018 par trimestre
Chiffre d�affaires de 2018 par semestre

Chiffre d�affaires pour les deux ann�es 2012 et 2013
Chiffre d�affaires de 2010 � 2018

Chiffre d�affaires de 2010 � 2018 par trimestre
Chiffre d�affaires de 2010 � 2018 par semestre

Statistiques sur le chiffre d�affaires � P�riode de 2010 � 2018

*/



--======================================================================================
--======================================================================================
--======================================================================================


-- ===============================================================================
-- D�finition de la structure des donn�es ================= DEBUT    =============
-- en SQL 2 ======================================================================
-- Utilisation des tables ========== Magasin FR01 ====== PARIS   =================
-- CLIENTS, ARTICLES, COMMANDES et DETAILCOM

-- Cr�ation des tables ============= Magasin FR02 ====== PARIS   =================
-- Cr�ation des tables ============= Magasin TN02 ====== SOUSSE  =================


-- INTEGRATION DE BASES DE DONNEES ; DATA INTEGRATION
-- QUALITE DES DONNEES ; DATA QUALITY

--======================================================================================
--======================================================================================
--======================================================================================

/*
-- Etant donn� l'ensemble des magasins

-- Chaque bin�me aura � c�er sa propore BD GesComI (On verra ult�rieurement!)!

-- Afficher la table MAGASINS

-- D�veloppez une proc�dure AJOUTECOLONNE qui permet d'ajouter � une table une colonne qui porte le nom de MAGASIN
-- Le contenu de cette colonne est l'identifiant du magasin NUMMAG
-- En entr�e le nom de la table et le contenu de la colonne ; En sortie une nouvelle table dont le nom est le nom de la table en entr�e concat�n� au _NUMMAG */

CREATE OR REPLACE PROCEDURE AJOUTECOLONNE (p_table IN VARCHAR2,p_numag in VARCHAR2)
AUTHID CURRENT_USER IS
TABLE2 VARCHAR2(50);
BEGIN
TABLE2 := p_table||'_'||p_numag ;
--EXECUTE IMMEDIATE 'DROP TABLE '||TABLE2;
EXECUTE IMMEDIATE 'CREATE TABLE '||TABLE2||' AS SELECT * FROM '||p_table;
EXECUTE IMMEDIATE 'ALTER TABLE '||TABLE2||' ADD (MAGASIN VARCHAR2(25))';
EXECUTE IMMEDIATE 'UPDATE '||TABLE2||' SET MAGASIN= :1' USING p_numag;
END;
/

/*
-- L'ex�cution de la proc�dure permet donc d'affecter les donn�es � un seul magasin
-- On consid�re que les donn�es dans les tables CLIENTS, ARTICLES, COMMANDES et DETAILCOM sont celles du magasin FR01
*/

DROP TABLE DETAILCOM;
DROP TABLE ARTICLES;
DROP TABLE COMMANDES;
DROP TABLE CLIENTS;
PROMPT
Pause Tapez sur Enter...
PROMPT
PROMPT =========================================================
PROMPT Cr�ation des tables de la bd GESCOMI EN SQL 2
PROMPT =========================================================
PROMPT
PROMPT =========================================================
PROMPT >> Table : CLIENTS
PROMPT =========================================================
PROMPT
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
	VILCLI		VARCHAR2(20),
	PAYSCLI		VARCHAR2(30),
	MAILCLI		VARCHAR2(30),
	TELCLI		VARCHAR2(20),
	CONSTRAINT PK_CLIENTS				PRIMARY KEY(CODCLI),
	CONSTRAINT CK_CLIENTS_CIVCLI		CHECK(CIVCLI IN ('Mademoiselle', 'Madame', 'Monsieur')),
	CONSTRAINT CK_CLIENTS_CATCLI		CHECK(CATCLI BETWEEN 1 and 7),
	CONSTRAINT NN_CLIENTS_NOMCLI		CHECK(NOMCLI IS NOT NULL),
	CONSTRAINT NN_CLIENTS_PRENCLI		CHECK(PRENCLI IS NOT NULL),
	CONSTRAINT NN_CLIENTS_CATCLI		CHECK(CATCLI IS NOT NULL),
	CONSTRAINT CK_CLIENTS_VILCLI		CHECK(VILCLI = UPPER(VILCLI)),
	CONSTRAINT CK_CLIENTS_PAYSCLI		CHECK(PAYSCLI = UPPER(PAYSCLI))
);
PROMPT
Pause Tapez sur Enter...
PROMPT
PROMPT =========================================================
PROMPT >> Table : COMMANDES
PROMPT =========================================================
PROMPT
CREATE TABLE COMMANDES
(
	NUMCOM 		VARCHAR2(10),
	CODCLI		VARCHAR2(10),
	DATCOM		DATE,
	CONSTRAINT PK_COMMANDES					PRIMARY KEY(NUMCOM),
	CONSTRAINT NN_COMMANDES_DATCOM			CHECK(DATCOM IS NOT NULL),
	CONSTRAINT FK_COMMANDES_CODCLI_CLIENTS	FOREIGN KEY(CODCLI)	REFERENCES CLIENTS(CODCLI)
);
PROMPT
Pause Tapez sur Enter...
PROMPT
PROMPT =========================================================
PROMPT >> Table : ARTICLES
PROMPT =========================================================
PROMPT
CREATE TABLE ARTICLES
(
	REFART 		VARCHAR2(10),
	NOMART		VARCHAR2(50),
	PVART		NUMBER(10, 2),
	QSART		NUMBER(3),
	PAART		NUMBER(10, 2),
	CONSTRAINT PK_ARTICLES				PRIMARY KEY(REFART),
	CONSTRAINT NN_ARTICLES_NOMART		CHECK(NOMART IS NOT NULL),
	CONSTRAINT CK_ARTICLES_QSART		CHECK(QSART < 1000)
);
PROMPT
Pause Tapez sur Enter...
PROMPT
PROMPT =========================================================
PROMPT >> Table : DETAILCOM
PROMPT =========================================================
PROMPT
CREATE TABLE DETAILCOM
(
	NUMCOM 		VARCHAR2(10),
	REFART		VARCHAR2(10),
	QTCOM		NUMBER(3),
	PUART		NUMBER(10, 2),
	REMISE		NUMBER(4, 2),
	CONSTRAINT PK_DETAILCOM					PRIMARY KEY(NUMCOM, REFART),
	CONSTRAINT CK_DETAILCOM_QTCOM			CHECK(QTCOM < 1000),
	CONSTRAINT NN_DETAILCOM_QTCOM			CHECK(QTCOM IS NOT NULL),
	CONSTRAINT NN_DETAILCOM_PUART			CHECK(PUART IS NOT NULL),
	CONSTRAINT NN_DETAILCOM_REMISE			CHECK(REMISE IS NOT NULL),
	CONSTRAINT FK_DETAILCOM_NUMCOM_COM		FOREIGN KEY(NUMCOM)	REFERENCES COMMANDES(NUMCOM),
	CONSTRAINT FK_DETAILCOM_REFART_ARTICLES	FOREIGN KEY(REFART)	REFERENCES ARTICLES(REFART)
);
/*
DROP TABLE HISTORIQUE_MVTS_CLIENTS;
CREATE TABLE HISTORIQUE_MVTS_CLIENTS
(
	NOMUSER		VARCHAR2(15),
	TYPEMVT		VARCHAR2(15),
	CODCLI		VARCHAR2(10),
	CIVCLI		VARCHAR2(12),
	NOMCLI		VARCHAR2(20),
	PRENCLI		VARCHAR2(20),
	CATCLI		NUMBER(1),
	ADNCLI		VARCHAR2(10),
	ADRCLI		VARCHAR2(50),
	CPCLI		VARCHAR2(10),
	VILCLI		VARCHAR2(20),
	PAYSCLI		VARCHAR2(30),
	MAILCLI		VARCHAR2(30),
	TELCLI		VARCHAR2(20),
	DATMVT		DATE
);

DROP TRIGGER MOUVEMENTS_CLIENTS;
CREATE OR REPLACE TRIGGER MOUVEMENTS_CLIENTS
	AFTER UPDATE OR INSERT OR DELETE ON CLIENTS
	FOR EACH ROW
DECLARE
	V_ADNCLI		VARCHAR2(10)	:= :OLD.ADNCLI;
	V_ADRCLI		VARCHAR2(50)	:= :OLD.ADRCLI;
	V_CPCLI			VARCHAR2(10)	:= :OLD.CPCLI;
	V_VILCLI		VARCHAR2(20)	:= :OLD.VILCLI;
	V_PAYSCLI		VARCHAR2(30)	:= :OLD.PAYSCLI;
	V_MAILCLI		VARCHAR2(30)	:= :OLD.MAILCLI;
	V_TELCLI		VARCHAR2(20)	:= :OLD.TELCLI;

	VI_ADNCLI		VARCHAR2(10)	:= :NEW.ADNCLI;
	VI_ADRCLI		VARCHAR2(50)	:= :NEW.ADRCLI;
	VI_CPCLI		VARCHAR2(10)	:= :NEW.CPCLI;
	VI_VILCLI		VARCHAR2(20)	:= :NEW.VILCLI;
	VI_PAYSCLI		VARCHAR2(30)	:= :NEW.PAYSCLI;
	VI_MAILCLI		VARCHAR2(30)	:= :NEW.MAILCLI;
	VI_TELCLI		VARCHAR2(20)	:= :NEW.TELCLI;

BEGIN
	IF UPDATING THEN
		INSERT INTO HISTORIQUE_MVTS_CLIENTS (NOMUSER,TYPEMVT,CODCLI,CIVCLI,ADNCLI,ADRCLI,CPCLI,VILCLI,PAYSCLI,MAILCLI,TELCLI,DATMVT)
		VALUES (USER, 'UPDATE', V_ADNCLI, V_ADRCLI, V_CPCLI, V_VILCLI, V_PAYSCLI,V_MAILCLI,V_TELCLI, SYSDATE);
	END IF;

	IF DELETING THEN
		INSERT INTO HISTORIQUE_MVTS_CLIENTS (NOMUSER,TYPEMVT,CODCLI,CIVCLI,ADNCLI,ADRCLI,CPCLI,VILCLI,PAYSCLI,MAILCLI,TELCLI,DATMVT)
		VALUES (USER, 'DELETE', V_ADNCLI, V_ADRCLI, V_CPCLI, V_VILCLI, V_PAYSCLI,V_MAILCLI,V_TELCLI, SYSDATE);
	END IF;

	IF INSERTING THEN
		INSERT INTO HISTORIQUE_MVTS_CLIENTS (NOMUSER,TYPEMVT,CODCLI,CIVCLI,ADNCLI,ADRCLI,CPCLI,VILCLI,PAYSCLI,MAILCLI,TELCLI,DATMVT)
		VALUES (USER, 'INSERT', VI_ADNCLI, VI_ADRCLI, VI_CPCLI, VI_VILCLI, VI_PAYSCLI,VI_MAILCLI,VI_TELCLI, SYSDATE);
	END IF;
END;
/
*/
DROP TABLE HISTORIQUE_MVTS_CLIENTS;

CREATE TABLE HISTORIQUE_MVTS_CLIENTS
(
	NOMUSER	        VARCHAR2(15),
	TYPEMVT	        VARCHAR2(15),
	CODCLI          VARCHAR2(10),
	OLDCIVCLI	 	VARCHAR2(12),
	OLDNOMCLI	 	VARCHAR2(20),
	OLDPRENCLI 		VARCHAR2(20),
	OLDCATCLI 		NUMBER(1),
	OLDADNCLI	 	VARCHAR2(10),
	OLDADRCLI	 	VARCHAR2(50),
	OLDCPCLI	 	VARCHAR2(10),
	OLDVILCLI	 	VARCHAR2(20),
	OLDPAYSCLI	 	VARCHAR2(30),
	OLDMAILCLI	 	VARCHAR2(30),
	OLDTELCLI	 	VARCHAR2(20),
	NEWCIVCLI	 	VARCHAR2(12),
	NEWNOMCLI	 	VARCHAR2(20),
	NEWPRENCLI 		VARCHAR2(20),
	NEWCATCLI 		NUMBER(1),
	NEWADNCLI	 	VARCHAR2(10),
	NEWADRCLI	 	VARCHAR2(50),
	NEWCPCLI	 	VARCHAR2(10),
	NEWVILCLI	 	VARCHAR2(20),
	NEWPAYSCLI	 	VARCHAR2(30),
	NEWMAILCLI	 	VARCHAR2(30),
	NEWTELCLI	 	VARCHAR2(20),
	DATMVT	 	    DATE,
	CONSTRAINT NN_HIST_CLIENTS2_NOMUSER 	CHECK(NOMUSER IS NOT NULL),
	CONSTRAINT NN_HIST_CLIENTS2_TYPEMVT 	CHECK(TYPEMVT IS NOT NULL)
);

CREATE OR REPLACE TRIGGER MOUVEMENTS_CLIENTS
	AFTER UPDATE OR INSERT OR DELETE ON CLIENTS
	FOR EACH ROW
DECLARE
	V_CODCLI        VARCHAR2(10) := :OLD.CODCLI;
	V_CIVCLI	 	VARCHAR2(12) := :OLD.CIVCLI;
	V_NOMCLI	 	VARCHAR2(20) := :OLD.NOMCLI;
	V_PRENCLI 		VARCHAR2(20) := :OLD.PRENCLI;
	V_CATCLI 		NUMBER(1)    := :OLD.CATCLI;
	V_ADNCLI	 	VARCHAR2(10) := :OLD.ADNCLI;
	V_ADRCLI	 	VARCHAR2(50) := :OLD.ADRCLI;
	V_CPCLI 	 	VARCHAR2(10) := :OLD.CPCLI;
	V_VILCLI	 	VARCHAR2(20) := :OLD.VILCLI;
	V_PAYSCLI	 	VARCHAR2(30) := :OLD.PAYSCLI;
	V_MAILCLI	 	VARCHAR2(30) := :OLD.MAILCLI;
	V_TELCLI	 	VARCHAR2(20) := :OLD.TELCLI;

	VI_CODCLI               VARCHAR2(10) := :NEW.CODCLI;
	VI_CIVCLI	 	VARCHAR2(12) := :NEW.CIVCLI;
	VI_NOMCLI	 	VARCHAR2(20) := :NEW.NOMCLI;
	VI_PRENCLI 		VARCHAR2(20) := :NEW.PRENCLI;
	VI_CATCLI 		NUMBER(1)    := :NEW.CATCLI;
	VI_ADNCLI	 	VARCHAR2(10) := :NEW.ADNCLI;
	VI_ADRCLI	 	VARCHAR2(50) := :NEW.ADRCLI;
	VI_CPCLI 	 	VARCHAR2(10) := :NEW.CPCLI;
	VI_VILCLI	 	VARCHAR2(20) := :NEW.VILCLI;
	VI_PAYSCLI	 	VARCHAR2(30) := :NEW.PAYSCLI;
	VI_MAILCLI	 	VARCHAR2(30) := :NEW.MAILCLI;
	VI_TELCLI	 	VARCHAR2(20) := :NEW.TELCLI;

BEGIN
	IF UPDATING THEN
		INSERT INTO HISTORIQUE_MVTS_CLIENTS (NOMUSER, TYPEMVT, CODCLI, OLDCIVCLI, OLDNOMCLI, OLDPRENCLI, OLDCATCLI, OLDADNCLI, OLDADRCLI, OLDCPCLI, OLDVILCLI, OLDPAYSCLI,OLDMAILCLI, OLDTELCLI, NEWCIVCLI, NEWNOMCLI, NEWPRENCLI, NEWCATCLI, NEWADNCLI, NEWADRCLI, NEWCPCLI, NEWVILCLI, NEWPAYSCLI, NEWMAILCLI, NEWTELCLI, DATMVT)
		VALUES (USER, 'UPDATE', V_CODCLI, V_CIVCLI, V_NOMCLI, V_PRENCLI, V_CATCLI, V_ADNCLI, V_ADRCLI, V_CPCLI, V_VILCLI, V_PAYSCLI,V_MAILCLI, V_TELCLI, VI_CIVCLI, VI_NOMCLI, VI_PRENCLI, VI_CATCLI, VI_ADNCLI, VI_ADRCLI, VI_CPCLI, VI_VILCLI, VI_PAYSCLI, VI_MAILCLI, VI_TELCLI, SYSDATE);
	END IF;

	IF DELETING THEN
		INSERT INTO HISTORIQUE_MVTS_CLIENTS (NOMUSER, TYPEMVT, CODCLI, OLDCIVCLI, OLDNOMCLI, OLDPRENCLI, OLDCATCLI, OLDADNCLI, OLDADRCLI, OLDCPCLI, OLDVILCLI, OLDPAYSCLI,OLDMAILCLI, OLDTELCLI, DATMVT)
		VALUES (USER, 'DELETE', V_CODCLI, V_CIVCLI, V_NOMCLI, V_PRENCLI, V_CATCLI, V_ADNCLI, V_ADRCLI, V_CPCLI, V_VILCLI, V_PAYSCLI,V_MAILCLI, V_TELCLI, SYSDATE);

	END IF;

	IF INSERTING THEN
		INSERT INTO HISTORIQUE_MVTS_CLIENTS (NOMUSER, TYPEMVT, CODCLI, NEWCIVCLI, NEWNOMCLI, NEWPRENCLI, NEWCATCLI, NEWADNCLI, NEWADRCLI, NEWCPCLI, NEWVILCLI, NEWPAYSCLI, NEWMAILCLI, NEWTELCLI, DATMVT)
		VALUES (USER, 'INSERT', VI_CODCLI, VI_CIVCLI, VI_NOMCLI, VI_PRENCLI, VI_CATCLI, VI_ADNCLI, VI_ADRCLI, VI_CPCLI, VI_VILCLI, VI_PAYSCLI, VI_MAILCLI, VI_TELCLI, SYSDATE);
	END IF;
END;
/

DROP TABLE HISTORIQUE_MVTS_ARTICLES;
CREATE TABLE HISTORIQUE_MVTS_ARTICLES
(
	NOMUSER		VARCHAR2(15),
	TYPEMVT		VARCHAR2(15),
	REFART 		VARCHAR2(10),
	NOMART		VARCHAR2(50),
	PVART		NUMBER(10, 2),
	PAART		NUMBER(10, 2),
	QSART		NUMBER(3),
	DATMVT		DATE,
	CONSTRAINT NN_HIST_ARTICLES_NOMART	CHECK(NOMART IS NOT NULL),
	CONSTRAINT NN_HIST_ARTICLES_NOMUSER	CHECK(NOMUSER IS NOT NULL),
	CONSTRAINT NN_HIST_ARTICLES_NOMTYPEMVT	CHECK(TYPEMVT IS NOT NULL)
);

DROP TRIGGER MOUVEMENTS_ARTICLES;
CREATE OR REPLACE TRIGGER MOUVEMENTS_ARTICLES
	AFTER UPDATE OR INSERT OR DELETE ON ARTICLES
	FOR EACH ROW
DECLARE
	V_REFART	VARCHAR2(10)	:= :OLD.REFART;
	V_NOMART	VARCHAR2(50)	:= :OLD.NOMART;
	V_PVART		NUMBER(10, 2)	:= :OLD.PVART;
	V_PAART		NUMBER(10, 2)	:= :OLD.PAART;
	V_QSART		NUMBER(3)	:= :OLD.QSART;

	VI_REFART	VARCHAR2(10)	:= :NEW.REFART;
	VI_NOMART	VARCHAR2(50)	:= :NEW.NOMART;
	VI_PVART	NUMBER(10, 2)	:= :NEW.PVART;
	VI_PAART	NUMBER(10, 2)	:= :NEW.PAART;
	VI_QSART	NUMBER(3)	:= :NEW.QSART;

BEGIN
	IF UPDATING THEN
		INSERT INTO HISTORIQUE_MVTS_ARTICLES (NOMUSER, TYPEMVT, REFART, NOMART, PVART, PAART, QSART, DATMVT)
		VALUES (USER, 'UPDATE', V_REFART, V_NOMART, V_PVART, V_PAART, V_QSART, SYSDATE);
	END IF;

	IF DELETING THEN
		INSERT INTO HISTORIQUE_MVTS_ARTICLES (NOMUSER, TYPEMVT, REFART, NOMART, PVART, PAART, QSART, DATMVT)
		VALUES (USER, 'DELETE', V_REFART, V_NOMART, V_PVART, V_PAART, V_QSART, SYSDATE);
	END IF;

	IF INSERTING THEN
		INSERT INTO HISTORIQUE_MVTS_ARTICLES (NOMUSER, TYPEMVT, REFART, NOMART, PVART, PAART, QSART, DATMVT)
		VALUES (USER, 'INSERT', VI_REFART, VI_NOMART, VI_PVART, VI_PAART, VI_QSART, SYSDATE);
	END IF;
END;
/

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C001', 'Madame', 'CLEM@ENT', 'EVE', 1, '18', 'BOULEVARD FOCH', '91000', 'EPINAY-SUR-ORGE', 'FRANCE','eve.clement@gmail.com', '+33777889911');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C002', 'Madame', 'LESEUL', 'MARIE', 1, '21', 'AVENUE D ITALIE', '75013', 'PARIS', 'FRANCE','marieleseul@yahoo.fr', '0617586565');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C003', 'Madame', 'UNIQUE', 'MARINE', 2, '77', 'RUE DE LA LIBERTE', '13001', 'MARCHEILLE', 'FRANCE','munique@gmail.com', '+33777889922');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C004', 'Madame', 'CLEMENCE', 'EVELYNE', 3, '8 BIS', 'BOULEVARD FOCH', '93800', 'EPINAY-SUR-SEINE', 'FRANCE','clemence evelyne@gmail.com', '+33777889933');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C005', 'Madame', 'FORT', 'JEANNE', 3, '55', 'RUE DU JAPON', '94310', 'ORLY-VILLE', 'FRANCE','jfort\@hotmail.fr', '+33777889944');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C006', 'Mademoiselle', 'LE BON', 'CLEMENCE', 1, '18', 'BOULEVARD FOCH', '93800', 'EPINAY-SUR-SEINE', 'FRANCE','clemence.le bon@cfo.fr', '0033777889955');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C007', 'Mademoiselle', 'TRAIFOR', 'ALICE', 2, '6', 'RUE DE LA ROSIERE', '75015', 'PARIS', 'FRANCE','alice.traifor@yahoo.fr', '+33777889966');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C008', 'Monsieur', 'VIVANT', 'JEAN-BAPTISTE', 1, '13', 'RUE DE LA PAIX', '93800', 'EPINAY-SUR-SEINE', 'FRANCE','jeanbaptiste@', '0607');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C009', 'Monsieur', 'CLEMENCE', 'ALEXANDRE', 1, '5', 'RUE DE BELLEVILLE', '75019', 'PARIS', 'FRANCE','alexandre.clemence@up13.fr', '+33149404071');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C010', 'Monsieur', 'TRAIFOR', 'ALEXANDRE', 1, '16', 'AVENUE FOCH', '75016', 'PARIS', 'FRA','alexandre.traifor@up13.fr', '06070809');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C011', 'Monsieur', 'PREMIER', 'JOS//EPH', 2, '77', 'RUE DE LA LIBERTE', '13001', 'MARCHEILLE', 'FRANCE','josef@premier', '+33777889977');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C012', 'Monsieur', 'CLEMENT', 'ADAM', 2, '13', 'AVENUE JEAN BAPTISTE CLEMENT', '9430', 'VILLETANEUSE', 'FRANCE','adam.clement@gmail.com', '+33149404072');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C013', 'Monsieur', 'FORT', 'GABRIEL', 5, '1', 'AVENUE DE CARTAGE', '99000', 'TUNIS', 'TUNISIE','gabriel.fort@yahoo.fr', '+21624801777');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C014', 'Monsieur', 'ADAM', 'DAVID', 5, '1', 'AVENUE DE ROME', '99001', 'ROME', 'ITALIE','david.adam�@gmail com', '');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C015', 'Monsieur', 'Labsent', 'pala', 7, '1', 'rue des absents', '000', 'BAGDAD', 'IRAQ','pala-labsent@paici', '');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C016', 'Madame', 'obsolete', 'kadym', 7, '1', 'rue des anciens', '000', 'CARTHAGE', 'IFRIQIA','inexistant', 'inexistant');

INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('C017', 'Madame', 'RAHYM', 'KARYM', 1, '1', 'RUE DES GENTILS', '1000', 'CARTHAGE', 'TUNISIE','karym.rahym@gmail.com', '+21624808444');

PROMPT
Pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Insertion dans la Table : COMMANDES
PROMPT =========================================================
PROMPT
INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20001AB', 'C012', 'SUNDAY 17-SEPTEMBER-2000');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20002AB', 'C001', 'SUNDAY 17-SEPTEMBER-2000');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20003AB', 'C006', ' MONDAY 16-OCTOBER-2000');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20004AB', 'C006', 'TUESDAY 24-OCTOBER-2000');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20011RB', 'C012', 'MONDAY 22-JANUARY-2001');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20012RB', 'C012', 'TUESDAY 13-MARCH-2001');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20031FB', 'C001', 'FRIDAY 14-FEBRUARY-2003');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20051FB', 'C003', 'FRIDAY 07-JANUARY-2005');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20052FB', 'C003', 'Wednesday 12-JANUARY-2005');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20053FB', 'C012', 'THURSDAY 10-MARCH-2005');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20054FB', 'C007', 'MONDAY 14-MARCH-2005');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20055FB', 'C012', 'FRIDAY 11-MARCH-2005');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20056FB', 'C013', 'MONDAY 14-MARCH-2005');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20057FB', 'C014', 'FRIDAY 11-MARCH-2005');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20061FB', 'C010', 'FRIDAY 14-FEBRUARY-2003');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20062FB', 'C009', 'FRIDAY 14-FEBRUARY-2003');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20065FB', 'C007', 'FRIDAY 14-FEBRUARY-2003');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20066FB', 'C002', 'FRIDAY 14-FEBRUARY-2003');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20067FB', 'C002', 'FRIDAY 14-FEBRUARY-2003');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20068FB', 'C002', 'FRIDAY 14-FEBRUARY-2003');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20069FB', 'C002', 'TUESDAY 30-JANUARY-2007');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20070FB', 'C002', 'TUESDAY 30-JANUARY-2007');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20071FB', 'C013', 'TUESDAY 30-JANUARY-2007');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20072FB', 'C013', 'TUESDAY 30-JANUARY-2007');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20073FB', 'C014', 'TUESDAY 30-JANUARY-2007');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20074FB', 'C014', 'TUESDAY 30-JANUARY-2007');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20184FB', 'C014', 'MONDAY 17-SEPTEMBER-2018');

INSERT INTO COMMANDES (NUMCOM, CODCLI, DATCOM)
VALUES ('20181AB', 'C012', 'MONDAY 17-SEPTEMBER-2018');

PROMPT
Pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Insertion dans la Table : ARTICLES
PROMPT =========================================================
PROMPT
INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.001', 'SIEGE DE TABLE', 35.00, 10, 26.43);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.002', 'CASQUE CYCLISTE PROTECTION', 27.00, 20, 20.00);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.003', 'BONNET PARE-CHOCS', 10.71, 100, 5.71);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.004', 'STORE DE PROTECTION', 7.43, 5, 4.29);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.005', 'COINS DE PROTECTION', 4.00, 100, 1.71);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.006', 'CACHE PRISE DE COURANT', 2.29, 500, 0.71);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.007', 'BLOQUE PORTE', 5.00, 4, 2.29);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.008', 'BANDE DE FERMETURE', 3.29, 4, 1.71);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.009', 'PROTECTION DE FOUR', 37.86, 10, 26.43);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.010', 'PROTECTION DE CUISINIERE', 30.71, 10, 22.86);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.011', 'BABY PHONE', 80.71, 3, 45.71);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.012', 'BRETELLE DE SECURITE', 15.57, 8, 11.43);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.013', 'HAUSSE-CHAISE', 42.71, 1, 25.43);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F1.014', 'COUVRE ROBINETTERIE', 7.86, 12, 4.29);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F2.001', 'BARRIERE DE PORTE, EN BOIS', 32.71, 2, 25.71);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F2.002', 'BARRIERE DE PORTE, EN METAL', 49.14, 3, 28.43);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F2.003', 'BARRIERE DE LIT', 23.71, 10, 15.71);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F2.004', 'PORTE-BEBE', 44.86, 6, 34.29);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F2.005', 'SIEGE-AUTO COSMOS', 126.86, 2, 71.43);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('F2.006', 'SIEGE-AUTO EUROSEAT', 121.29, 2, 71.43);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('FB.001', 'DVD-SPIRIT', 24.90, 2, 12.00);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('FB.002', 'DVD-SPIDER MAN', 24.90, 2, 12.00);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('FB.003', 'DVD-SPIDER MAN 2', 24.90, 2, 12.00);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('WD.001', 'K7 VIDEO-TOY STORY', 21.29, 10, 9.29);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('WD.002', 'DVD-TOY STORY 2', 34.29, 10, 12.14);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('WD.003', 'K7 VIDEO-WINNIE L OURSON', 22.86, 5, 9.29);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('WD.004', 'DVD-FRERES DES OURS', 35.00, 3, 13.00);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('WD.005', 'K7 VIDEO-LE ROI LION', 30.00, 1, 13.00);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('WD.006', 'K7 VIDEO-LE ROI LION 2', 30.00, 4, 13.00);

INSERT INTO ARTICLES (REFART, NOMART, PVART, QSART, PAART)
VALUES ('WD.007', 'K7 VIDEO-LE ROI LION 3', 30.00, 3, 13.00);

PROMPT
Pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Insertion dans la Table : DETAILCOM
PROMPT =========================================================
PROMPT
INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20001AB', 'F1.001', 2, 35.00, 2.50);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20001AB', 'F1.003', 4, 10.71, 3.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20001AB', 'F1.013', 2, 49.14, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20001AB', 'WD.001', 1, 21.29, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20002AB', 'F1.001', 2, 33.00, 3.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20002AB', 'WD.001', 1, 21.29, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20002AB', 'WD.002', 1, 34.29, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20002AB', 'WD.003', 1, 22.86, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20003AB', 'FB.001', 5, 21.00, 4.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20003AB', 'WD.002', 1, 34.29, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20003AB', 'WD.003', 1, 22.86, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20004AB', 'F1.008', 2, 3.29, 3.50);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20004AB', 'WD.001', 1, 21.29, 2.50);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20012RB', 'F1.007', 5, 5.00, 3.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20012RB', 'F1.009', 1, 37.86, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20012RB', 'FB.003', 5, 24.00, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20031FB', 'F1.008', 2, 3.29, 3.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20031FB', 'F2.001', 1, 30.71, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20031FB', 'FB.001', 5, 21.00, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20051FB', 'F1.008', 2, 3.29, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20051FB', 'FB.001', 5, 21.00, 4.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20052FB', 'F1.001', 2, 35.00, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20052FB', 'F1.003', 4, 10.71, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20052FB', 'F1.013', 2, 49.14, 3.50);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20052FB', 'WD.001', 1, 21.29, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20052FB', 'WD.003', 1, 22.86, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20053FB', 'WD.003', 1, 22.86, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20054FB', 'WD.003', 1, 22.86, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20055FB', 'F1.008', 5, 3.29, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20055FB', 'F1.009', 1, 37.86, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20055FB', 'F1.011', 2, 80.71, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20055FB', 'F2.001', 1, 30.71, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20056FB', 'F1.011', 2, 80.71, 0.00);

INSERT INTO DETAILCOM (NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20057FB', 'F2.001', 1, 30.71, 0.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20061FB', 'FB.003', 5, 24.00, 0.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20062FB', 'FB.003', 5, 24.00, 0.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20065FB', 'FB.003', 5, 24.00, 0.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20066FB', 'FB.003', 5, 24.00, 0.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20067FB', 'FB.001', 22, 24.00, 0.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20068FB', 'FB.001', 22, 24.00, 0.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20069FB', 'FB.001', 25, 58.00, 0.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20070FB', 'FB.001', 50, 24.00, 0.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20071FB', 'FB.001', 37, 27.90, 0.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20072FB', 'FB.001', 8, 34.00, 0.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20073FB', 'FB.001', 35, 15.50, 0.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20074FB', 'FB.001', 12, 19.99, 0.00);

INSERT INTO DETAILCOM(NUMCOM, REFART, QTCOM, PUART, REMISE)
VALUES ('20181AB', 'FB.001', 7, 17.77, 0.00);

PROMPT =========================================================
PROMPT Validation des insertions dans la bd EN SQL 2
PROMPT =========================================================

COMMIT;

DROP TABLE CLIENTS_FR01;
DROP TABLE COMMANDES_FR01;
DROP TABLE DETAILCOM_FR01;
DROP TABLE ARTICLES_FR01;
DROP TABLE HISTORIQUE_MVTS_CLIENTS_FR01;
DROP TABLE HISTORIQUE_MVTS_ARTICLES_FR01;

EXEC AJOUTECOLONNE('CLIENTS', 'FR01');
EXEC AJOUTECOLONNE('COMMANDES', 'FR01');
EXEC AJOUTECOLONNE('DETAILCOM', 'FR01');
EXEC AJOUTECOLONNE('ARTICLES', 'FR01');
EXEC AJOUTECOLONNE('HISTORIQUE_MVTS_CLIENTS','FR01');
EXEC AJOUTECOLONNE('HISTORIQUE_MVTS_ARTICLES','FR01');

-- Les clients du magasin FR02 c est celui de Paris en France

DROP TABLE DETAILCOM;
DROP TABLE ARTICLES;
DROP TABLE COMMANDES;
DROP TABLE CLIENTS;


CREATE TABLE CLIENTS (Col1 VARCHAR(50), Col2 VARCHAR(50), Col3 VARCHAR(50), Col4 VARCHAR(50), Col5 VARCHAR(50), Col6 VARCHAR(50), Col7 VARCHAR(50), Col8 VARCHAR(50), Col9 VARCHAR(50), Col10 VARCHAR(50), Col11 VARCHAR(20));
CREATE TABLE ARTICLES (Col1 VARCHAR(50), Col2 VARCHAR(50), Col3 VARCHAR(50), Col4 VARCHAR(50), Col5 VARCHAR(50));
CREATE TABLE COMMANDES (Col1 VARCHAR(50), Col2 VARCHAR(50), Col3 VARCHAR(50));
CREATE TABLE DETAILCOM (Col1 VARCHAR(50), Col2 VARCHAR(50), Col3 VARCHAR(50), Col4 VARCHAR(50), Col5 VARCHAR(50));

DROP TABLE HISTORIQUE_MVTS_CLIENTS;

CREATE TABLE HISTORIQUE_MVTS_CLIENTS
(
	NOMUSER	        VARCHAR2(15),
	TYPEMVT	        VARCHAR2(15),
	CODCLI          VARCHAR2(10),
	OLDCIVCLI	 	VARCHAR2(12),
	OLDNOMCLI	 	VARCHAR2(20),
	OLDPRENCLI 		VARCHAR2(20),
	OLDCATCLI 		VARCHAR2(1),
	OLDADNCLI	 	VARCHAR2(10),
	OLDADRCLI	 	VARCHAR2(50),
	OLDCPCLI	 	VARCHAR2(10),
	OLDVILCLI	 	VARCHAR2(20),
	OLDPAYSCLI	 	VARCHAR2(30),
	OLDMAILCLI	 	VARCHAR2(30),
	OLDTELCLI	 	VARCHAR2(20),
	NEWCIVCLI	 	VARCHAR2(12),
	NEWNOMCLI	 	VARCHAR2(20),
	NEWPRENCLI 		VARCHAR2(20),
	NEWCATCLI 		VARCHAR2(1),
	NEWADNCLI	 	VARCHAR2(10),
	NEWADRCLI	 	VARCHAR2(50),
	NEWCPCLI	 	VARCHAR2(10),
	NEWVILCLI	 	VARCHAR2(20),
	NEWPAYSCLI	 	VARCHAR2(30),
	NEWMAILCLI	 	VARCHAR2(30),
	NEWTELCLI	 	VARCHAR2(20),
	DATMVT	 	    DATE,
	CONSTRAINT NN_HIST_CLIENTS2_NOMUSER 	CHECK(NOMUSER IS NOT NULL),
	CONSTRAINT NN_HIST_CLIENTS2_NOMTYPEMVT 	CHECK(TYPEMVT IS NOT NULL)
);
--COL1  ,COL2  ,COL3    ,COL4    ,COL5   ,COL6            ,COL7  ,COL8   ,COL9    ,COL10   ,COL11
--CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI + ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI

CREATE OR REPLACE TRIGGER MOUVEMENTS_CLIENTS
	AFTER UPDATE OR INSERT OR DELETE ON CLIENTS
	FOR EACH ROW
DECLARE
	V_CODCLI                VARCHAR2(10) := :OLD.COL1;
	V_CIVCLI	 	VARCHAR2(12) := :OLD.COL2;
	V_NOMCLI	 	VARCHAR2(20) := :OLD.COL3;
	V_PRENCLI 		VARCHAR2(20) := :OLD.COL4;
	V_CATCLI 		VARCHAR2(1)  := :OLD.COL5;
	V_ADRCLI	 	VARCHAR2(50) := :OLD.COL6;
	V_CPCLI 	 	VARCHAR2(10) := :OLD.COL7;
	V_VILCLI	 	VARCHAR2(20) := :OLD.COL8;
	V_PAYSCLI	 	VARCHAR2(30) := :OLD.COL9;
	V_MAILCLI	 	VARCHAR2(30) := :OLD.COL10;
	V_TELCLI	 	VARCHAR2(20) := :OLD.COL11;

	VI_CODCLI               VARCHAR2(10) := :NEW.COL1;
	VI_CIVCLI	 	VARCHAR2(12) := :NEW.COL2;
	VI_NOMCLI	 	VARCHAR2(20) := :NEW.COL3;
	VI_PRENCLI 		VARCHAR2(20) := :NEW.COL4;
	VI_CATCLI 		VARCHAR2(1)  := :NEW.COL5;
	VI_ADRCLI	 	VARCHAR2(50) := :NEW.COL6;
	VI_CPCLI 	 	VARCHAR2(10) := :NEW.COL7;
	VI_VILCLI	 	VARCHAR2(20) := :NEW.COL8;
	VI_PAYSCLI	 	VARCHAR2(30) := :NEW.COL9;
	VI_MAILCLI	 	VARCHAR2(30) := :NEW.COL10;
	VI_TELCLI	 	VARCHAR2(20) := :NEW.COL11;

BEGIN
	IF UPDATING THEN
		INSERT INTO HISTORIQUE_MVTS_CLIENTS (NOMUSER, TYPEMVT, CODCLI, OLDCIVCLI, OLDNOMCLI, OLDPRENCLI, OLDCATCLI, OLDADRCLI, OLDCPCLI, OLDVILCLI, OLDPAYSCLI,OLDMAILCLI, OLDTELCLI, NEWCIVCLI, NEWNOMCLI, NEWPRENCLI, NEWCATCLI, NEWADRCLI, NEWCPCLI, NEWVILCLI, NEWPAYSCLI, NEWMAILCLI, NEWTELCLI, DATMVT)
		VALUES (USER, 'UPDATE', V_CODCLI, V_CIVCLI, V_NOMCLI, V_PRENCLI, V_CATCLI, V_ADRCLI, V_CPCLI, V_VILCLI, V_PAYSCLI,V_MAILCLI, V_TELCLI, VI_CIVCLI, VI_NOMCLI, VI_PRENCLI, VI_CATCLI, VI_ADRCLI, VI_CPCLI, VI_VILCLI, VI_PAYSCLI, VI_MAILCLI, VI_TELCLI, SYSDATE);
	END IF;

	IF DELETING THEN
		INSERT INTO HISTORIQUE_MVTS_CLIENTS (NOMUSER, TYPEMVT, CODCLI, OLDCIVCLI, OLDNOMCLI, OLDPRENCLI, OLDCATCLI, OLDADRCLI, OLDCPCLI, OLDVILCLI, OLDPAYSCLI,OLDMAILCLI, OLDTELCLI, DATMVT)
		VALUES (USER, 'DELETE', V_CODCLI, V_CIVCLI, V_NOMCLI, V_PRENCLI, V_CATCLI, V_ADRCLI, V_CPCLI, V_VILCLI, V_PAYSCLI,V_MAILCLI, V_TELCLI, SYSDATE);

	END IF;

	IF INSERTING THEN
		INSERT INTO HISTORIQUE_MVTS_CLIENTS (NOMUSER, TYPEMVT, CODCLI, NEWCIVCLI, NEWNOMCLI, NEWPRENCLI, NEWCATCLI, NEWADRCLI, NEWCPCLI, NEWVILCLI, NEWPAYSCLI, NEWMAILCLI, NEWTELCLI, DATMVT)
		VALUES (USER, 'INSERT', VI_CODCLI, VI_CIVCLI, VI_NOMCLI, VI_PRENCLI, VI_CATCLI, VI_ADRCLI, VI_CPCLI, VI_VILCLI, VI_PAYSCLI, VI_MAILCLI, VI_TELCLI, SYSDATE);
	END IF;
END;
/

--COL1    COL2    COL3   COL4   COL5
--REFART, NOMART, PVART, QSART, PAART
DROP TABLE HISTORIQUE_MVTS_ARTICLES;
CREATE TABLE HISTORIQUE_MVTS_ARTICLES
(
	NOMUSER		VARCHAR2(15),
	TYPEMVT		VARCHAR2(15),
	REFART 		VARCHAR2(10),
	NOMART		VARCHAR2(50),
	PVART		VARCHAR2(20),
	PAART		VARCHAR2(20),
	QSART		VARCHAR2(20),
	DATMVT		DATE,
	CONSTRAINT NN_HIST_ARTICLES_NOMART	CHECK(NOMART IS NOT NULL),
	CONSTRAINT NN_HIST_ARTICLES_NOMUSER	CHECK(NOMUSER IS NOT NULL),
	CONSTRAINT NN_HIST_ARTICLES_NOMTYPEMVT	CHECK(TYPEMVT IS NOT NULL)
);

DROP TRIGGER MOUVEMENTS_ARTICLES;
CREATE OR REPLACE TRIGGER MOUVEMENTS_ARTICLES
	AFTER UPDATE OR INSERT OR DELETE ON ARTICLES
	FOR EACH ROW
DECLARE
	V_REFART	VARCHAR2(10)	:= :OLD.COL1;
	V_NOMART	VARCHAR2(50)	:= :OLD.COL2;
	V_PVART		VARCHAR2(20)	:= :OLD.COL3;
	V_PAART		VARCHAR2(20)	:= :OLD.COL5;
	V_QSART		VARCHAR2(20)	:= :OLD.COL4;

	VI_REFART	VARCHAR2(10)	:= :NEW.COL1;
	VI_NOMART	VARCHAR2(50)	:= :NEW.COL2;
	VI_PVART	VARCHAR2(20)	:= :NEW.COL3;
	VI_PAART	VARCHAR2(20)	:= :NEW.COL5;
	VI_QSART	VARCHAR2(20)	:= :NEW.COL4;

BEGIN
	IF UPDATING THEN
		INSERT INTO HISTORIQUE_MVTS_ARTICLES (NOMUSER, TYPEMVT, REFART, NOMART, PVART, PAART, QSART, DATMVT)
		VALUES (USER, 'UPDATE', V_REFART, V_NOMART, V_PVART, V_PAART, V_QSART, SYSDATE);
	END IF;

	IF DELETING THEN
		INSERT INTO HISTORIQUE_MVTS_ARTICLES (NOMUSER, TYPEMVT, REFART, NOMART, PVART, PAART, QSART, DATMVT)
		VALUES (USER, 'DELETE', V_REFART, V_NOMART, V_PVART, V_PAART, V_QSART, SYSDATE);
	END IF;

	IF INSERTING THEN
		INSERT INTO HISTORIQUE_MVTS_ARTICLES (NOMUSER, TYPEMVT, REFART, NOMART, PVART, PAART, QSART, DATMVT)
		VALUES (USER, 'INSERT', VI_REFART, VI_NOMART, VI_PVART, VI_PAART, VI_QSART, SYSDATE);
	END IF;
END;
/

INSERT INTO CLIENTS VALUES ('2994570', 'Madame', 'RAHMA', 'CLEMENCE', '3', '8, BOULEVARD FOCH', '93800', 'EPINAY-SUR-SEINE', 'FRANCE', 'clemence.rahma@up13.fr', '+33617586565');
INSERT INTO CLIENTS VALUES ('2996100', 'Monsieur', 'CLEMENCE', 'ALEXANDRE', '1', '5, RUE DE BELLEVILLE', '75019', 'PARIS', 'FRANCE', 'alexandre.clemence@up13.fr', '+33617586566');
INSERT INTO CLIENTS VALUES ('2997007', 'Monsieur', 'TRAIFOR', 'ADAM', '2', '13, AVENUE J. B. CLEMENT', '93430', 'VILLETANEUSE', 'FRANCE', 'adam.traifor@up13.fr', '+33617586567');
INSERT INTO CLIENTS VALUES ('2997777', 'Mademoiselle', 'LE BON', 'CLEMENTINE', '1', '18, BOULEVARD FOCH', '93800', 'EPINAY-SUR-SEINE', '', 'clementine.le bon@up13.fr', '+33617586568');
INSERT INTO CLIENTS VALUES ('2998500', 'Monsieur', 'CHEVALIER', 'INES', '1', '13, RUE DE LA PAIX', '93800', 'EPINAY SUR SEINE', 'FRANCE', 'ines.chevalier@up13.fr', '0717586560');
INSERT INTO CLIENTS VALUES ('3001777', 'Monsieur', 'LE BON', 'Adam', '1', '186, AVENUE D ITALIE', '75013', 'PARIS', 'FRANCE', 'adam.le bon@up13.fr', '0717586561');
INSERT INTO CLIENTS VALUES ('2998505', 'Mademoiselle', 'TRAIFOR', 'ALICE', '2', '6, RUE DE LA ROSIERE', '75015', 'PARIS', '', 'alice.traifor@up13.fr', '0717586562');
INSERT INTO CLIENTS VALUES ('3000106', 'Monsieur', 'HARISSA', 'FORD', '1', '16, AVENUE FOCH', '75016', 'PARIS', 'FRANCE', 'ford.harissa@up13.fr', '0606');
INSERT INTO CLIENTS VALUES ('3000107', 'MO�NSIEUR', 'ONRI', 'PANDA', '2', '77, RUE DE LA LIBERTE', '13001', 'MARSEILLE', 'FRANCE', 'panda.onri@up13.fr', '+33');
INSERT INTO CLIENTS VALUES ('3000108', 'Madame', 'EDITE', 'FIAT', '1', '21, AVENUE D ITALIE', '75013', 'PARIS', '', 'fiat.edite@up13.fr', '');
INSERT INTO CLIENTS VALUES ('3000109', 'Madame', 'TOYOTA', 'JACKSON', '3', '55, RUE DU JAPON', '94310', 'ORLY VILLE', 'FRANCE', 'jackson.toyota@up13.fr', '');
INSERT INTO CLIENTS VALUES ('3000110', 'MADAME', 'ONRI', 'HONDA', '2', '77, RUE DE LA LIBERTE', '13001', 'MARSEILLE', 'FRANC', 'honda.onri@up13.fr', '');
INSERT INTO CLIENTS VALUES ('3000111', 'Madame', 'GENEREUX', 'EVE', '1', '18, BOULEVARD KELLERMAN', '75013', 'PARYS', 'FR', 'eve.genereux@up13.fr', '');
INSERT INTO CLIENTS VALUES ('299PPPP', 'Mlle', 'BON', 'CLEMENTINE', '1', '18, BOULEVARD FOCH', '93800', 'EPINAY-SUR-SEINE', 'FRANCE', 'clementine.bon@up13.fr', '+21624801801');
INSERT INTO CLIENTS VALUES ('3001', 'M.', 'LE BON', 'Adam', '1', '186, AVENUE D ITALIE', '75013', 'Paris', '', 'adam.le bon@up13.fr', '');
INSERT INTO CLIENTS VALUES ('3001777', 'Mr', 'LE BON', 'Adem', '1', '186, AVENUE D ITALIE', '75013', 'PARIS', 'france', 'adem.le bon@up13.fr', '');
INSERT INTO CLIENTS VALUES ('3001778', 'Mr', 'COURTOIS', 'Bruno', '1', '', '', 'Bruxelles', 'Belgique', 'bruno.courtois@gmail.com', '');
INSERT INTO CLIENTS VALUES ('3001779', 'Monsieur', 'VANDERHOTE', 'Ivan', '1', '', '', 'Bruxelles', 'Belgique', 'ivan.vanderhote@gmail.com', '');
INSERT INTO CLIENTS VALUES ('3001780', 'Monsieur', 'Hollanda', 'Francis', '1', '', '', 'Bruxelles', 'Belgique', 'francis.hollanda@gmail.com', '');
INSERT INTO CLIENTS VALUES ('3001781', 'Monsieur', 'Bernard', 'Hugues', '1', '', '', 'Bruxelles', 'Belgique', 'hugues.bernard@gmail.com', '');
INSERT INTO CLIENTS VALUES ('3001782', 'Monsieur', 'LATIFOU', 'Ilyas', '1', '', '', 'Brusselle', 'Belgic', 'ilyas.latifou@gmail.com', '');
INSERT INTO CLIENTS VALUES ('3001783', 'Madame', 'LALLEMAND', 'Ines', '1', '', '', 'Berlin', 'ALLEMANGNE', 'ines.lallemand@gmail.com', '');
INSERT INTO CLIENTS VALUES ('3001784', 'Monsieur', 'DEUTCH', 'Hans', '1', '', '', 'Berlin', 'ALLEMANGNE', 'hans.deutch@gmail.com', '');
INSERT INTO CLIENTS VALUES ('3001785', 'Madame', 'ALMANI', 'Eve', '1', '', '', 'Berlin', 'ALLEMANGNE', 'eve.almani@gmail.com', '');
INSERT INTO CLIENTS VALUES ('3001786', 'Madame', 'MERQUELLE', 'Ange', '1', '', '', 'Dublin', 'ALEMANGNE', 'angela.merquelle@gmail.com', '');

-- Les articles du magasin FR02 c est celui de Paris en France

INSERT INTO ARTICLES VALUES ('00.37291', 'SIEGE DE TABLE', '55.00 �', '10', '26.43 �');
INSERT INTO ARTICLES VALUES ('00.37325', 'CASQUE CYCLISTE PROTECTION', '27.00 �', '20', '20.00 �');
INSERT INTO ARTICLES VALUES ('00.37341', 'BONNET PARE-CHOCS', '10.71 �', '100', '05.71 �');
INSERT INTO ARTICLES VALUES ('00.37366', 'STORE DE PROTECTION', '07.43 �', '5', '04.29 �');
INSERT INTO ARTICLES VALUES ('00.37408', 'COINS DE PROTECTION', '04.00 �', '100', '01.71 �');
INSERT INTO ARTICLES VALUES ('00.37424', 'CACHE PRISE DE COURANT', '02.29 �', '500', '00.71 �');
INSERT INTO ARTICLES VALUES ('00.37432', 'BLOQUE PORTE', '05.00 �', '4', '02.29 �');
INSERT INTO ARTICLES VALUES ('00.37457', 'BANDE DE FERMETURE', '02.29 �', '4', '01.71 �');
INSERT INTO ARTICLES VALUES ('00.37465', 'PROTECTION DE FOUR', '37.86 �', '10', '26.43 �');
INSERT INTO ARTICLES VALUES ('00.37473', 'PROTECTION DE CUISINIERE', '30.71 �', '10', '22.86 �');
INSERT INTO ARTICLES VALUES ('00.37515', 'BABY PHONE', '80.71 �', '3', '45.71 �');
INSERT INTO ARTICLES VALUES ('00.37630', 'BRETELLE DE SECURITE REMOND', '15.57 �', '8', '11.43 �');
INSERT INTO ARTICLES VALUES ('00.39321', 'HAUSSE-CHAISE', '42.71 �', '1', '25.43 �');
INSERT INTO ARTICLES VALUES ('00.39495', 'COUVRE ROBINETTERIE', '07.86 �', '12', '04.29 �');
INSERT INTO ARTICLES VALUES ('11.36613', 'BARRIERE DE PORTE, EN BOIS', '32.71 �', '2', '25.71 �');
INSERT INTO ARTICLES VALUES ('11.36639', 'BARRIERE DE PORTE, EN METAL', '79.14 �', '3', '28.43 �');
INSERT INTO ARTICLES VALUES ('11.36860', 'BARRIERE DE LIT', '23.71 �', '10', '15.71 �');
INSERT INTO ARTICLES VALUES ('11.37108', 'PORTE-BEBE', '44.86 �', '6', '34.29 �');
INSERT INTO ARTICLES VALUES ('11.37173', 'SIEGE-AUTO COSMOS', '126.86 �', '2', '71.43 �');
INSERT INTO ARTICLES VALUES ('11.37280', 'SIEGE-AUTO EUROSEAT', '121.29 �', '2', '71.43 �');
INSERT INTO ARTICLES VALUES ('WD.001', 'K7 VIDEO - TOY STORY', '21.29 �', '10', '09.29 �');
INSERT INTO ARTICLES VALUES ('WD.002', 'DVD - TOY STORY 2', '34.29 �', '10', '12.14 �');
INSERT INTO ARTICLES VALUES ('WD.003', 'K7 VIDEO - WINNIE L OURSON', '32.86 �', '5', '09.29 �');
INSERT INTO ARTICLES VALUES ('MV.001', 'Jeux Vid�o PS4 SPIDER-MAN', '59.00 �', '250', '19.00 �');

-- Les commandes du magasin FR02 c est celui de Paris en France

INSERT INTO COMMANDES VALUES ('20150917BB0001', '2997007', '17/09/2015');
INSERT INTO COMMANDES VALUES ('20150917BB0002', '2998500', '17/09/2015');
INSERT INTO COMMANDES VALUES ('20151016BB0001', '2996100', '16/10/2015');
INSERT INTO COMMANDES VALUES ('20151024BB0001', '2996100', '24/10/2015');
INSERT INTO COMMANDES VALUES ('20120156BB0001', '2996100', '16/01/2012');
INSERT INTO COMMANDES VALUES ('20120157BB0007', '2996100', '17/01/2012');
INSERT INTO COMMANDES VALUES ('20180917BB0007', '3001777', '17/09/2018');

-- Les d�tails des commandes du magasin FR02 c est celui de Paris en France

INSERT INTO DETAILCOM VALUES ('20150917BB0001', '00.37291', '2', '35.00 �', '10.00%');
INSERT INTO DETAILCOM VALUES ('20150917BB0001', '00.37341', '4', '10.71 �', '10.00%');
INSERT INTO DETAILCOM VALUES ('20150917BB0001', '11.36639', '2', '49.14 �', '00.00%');
INSERT INTO DETAILCOM VALUES ('20150917BB0001', 'WD.001', '1', '21.29 �', '00.00%');
INSERT INTO DETAILCOM VALUES ('20150917BB0002', '00.37291', '2', '35.00 �', '00.00%');
INSERT INTO DETAILCOM VALUES ('20150917BB0002', 'WD.001', '1', '21.29 �', '00.00%');
INSERT INTO DETAILCOM VALUES ('20150917BB0002', 'WD.002', '1', '34.29 �', '00.00%');
INSERT INTO DETAILCOM VALUES ('20150917BB0002', 'WD.003', '1', '22.86 �', '00.00%');
INSERT INTO DETAILCOM VALUES ('20151016BB0001', 'WD.001', '1', '21.29 �', '20.00%');
INSERT INTO DETAILCOM VALUES ('20151016BB0001', 'WD.002', '1', '34.29 �', '00.00%');
INSERT INTO DETAILCOM VALUES ('20151016BB0001', 'WD.003', '1', '22.86 �', '00.00%');
INSERT INTO DETAILCOM VALUES ('20151024BB0001', '00.37457', '2', '03.29 �', '00.00%');
INSERT INTO DETAILCOM VALUES ('20120156BB0001', 'WD.003', '2', '25.00 �', '00.00%');
INSERT INTO DETAILCOM VALUES ('20120157BB0007', 'WD.001', '5', '22.00 �', '50.00%');
INSERT INTO DETAILCOM VALUES ('20120157BB0007', 'WD.002', '10', '34.29 �', '50.00%');
INSERT INTO DETAILCOM VALUES ('20180917BB0007', 'MV.001', '2', '59.00 �', '10.00%');

COMMIT;

DROP TABLE CLIENTS_FR02;
DROP TABLE COMMANDES_FR02;
DROP TABLE DETAILCOM_FR02;
DROP TABLE ARTICLES_FR02;
DROP TABLE HISTORIQUE_MVTS_CLIENTS_FR02;
DROP TABLE HISTORIQUE_MVTS_ARTICLES_FR02;

EXEC AJOUTECOLONNE('CLIENTS', 'FR02');
EXEC AJOUTECOLONNE('COMMANDES', 'FR02');
EXEC AJOUTECOLONNE('DETAILCOM', 'FR02');
EXEC AJOUTECOLONNE('ARTICLES', 'FR02');
EXEC AJOUTECOLONNE('HISTORIQUE_MVTS_CLIENTS','FR02');
EXEC AJOUTECOLONNE('HISTORIQUE_MVTS_ARTICLES','FR02');

/*
-- Corrigez le contenu de la nouvelle table CLIENTS_FR02 ; Comment savoir si elle contient des anomalies et lesquelles ?
*/

-- Les clients du magasin TN02 c est celui de Sousse en Tunisie

DROP TABLE DETAILCOM;
DROP TABLE ARTICLES;
DROP TABLE COMMANDES;
DROP TABLE CLIENTS;

CREATE TABLE CLIENTS (Col1 VARCHAR(50), Col2 VARCHAR(50), Col3 VARCHAR(50), Col4 VARCHAR(50), Col5 VARCHAR(50), Col6 VARCHAR(50), Col7 VARCHAR(50), Col8 VARCHAR(50), Col9 VARCHAR(50), Col10 VARCHAR(50), Col11 VARCHAR(20));
CREATE TABLE ARTICLES (Col1 VARCHAR(50), Col2 VARCHAR(50), Col3 VARCHAR(50), Col4 VARCHAR(50), Col5 VARCHAR(50));
CREATE TABLE COMMANDES (Col1 VARCHAR(50), Col2 VARCHAR(50), Col3 VARCHAR(50));
CREATE TABLE DETAILCOM (Col1 VARCHAR(50), Col2 VARCHAR(50), Col3 VARCHAR(50), Col4 VARCHAR(50), Col5 VARCHAR(50));

DROP TABLE HISTORIQUE_MVTS_CLIENTS;

CREATE TABLE HISTORIQUE_MVTS_CLIENTS
(
	NOMUSER	        VARCHAR2(15),
	TYPEMVT	        VARCHAR2(15),
	CODCLI          VARCHAR2(10),
	OLDCIVCLI	 	VARCHAR2(12),
	OLDNOMCLI	 	VARCHAR2(20),
	OLDPRENCLI 		VARCHAR2(20),
	OLDCATCLI 		VARCHAR2(1),
	OLDADNCLI	 	VARCHAR2(10),
	OLDADRCLI	 	VARCHAR2(50),
	OLDCPCLI	 	VARCHAR2(10),
	OLDVILCLI	 	VARCHAR2(20),
	OLDPAYSCLI	 	VARCHAR2(30),
	OLDMAILCLI	 	VARCHAR2(30),
	OLDTELCLI	 	VARCHAR2(20),
	NEWCIVCLI	 	VARCHAR2(12),
	NEWNOMCLI	 	VARCHAR2(20),
	NEWPRENCLI 		VARCHAR2(20),
	NEWCATCLI 		VARCHAR2(1),
	NEWADNCLI	 	VARCHAR2(10),
	NEWADRCLI	 	VARCHAR2(50),
	NEWCPCLI	 	VARCHAR2(10),
	NEWVILCLI	 	VARCHAR2(20),
	NEWPAYSCLI	 	VARCHAR2(30),
	NEWMAILCLI	 	VARCHAR2(30),
	NEWTELCLI	 	VARCHAR2(20),
	DATMVT	 	    DATE,
	CONSTRAINT NN_HIST_CLIENTS2_NOMUSER 	CHECK(NOMUSER IS NOT NULL),
	CONSTRAINT NN_HIST_CLIENTS2_NOMTYPEMVT 	CHECK(TYPEMVT IS NOT NULL)
);
--COL1  ,COL2  ,COL3    ,COL4    ,COL5   ,COL6            ,COL7  ,COL8   ,COL9    ,COL10   ,COL11
--CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI + ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI

CREATE OR REPLACE TRIGGER MOUVEMENTS_CLIENTS
	AFTER UPDATE OR INSERT OR DELETE ON CLIENTS
	FOR EACH ROW
DECLARE
	V_CODCLI        VARCHAR2(10) := :OLD.COL1;
	V_CIVCLI	 	VARCHAR2(12) := :OLD.COL2;
	V_NOMCLI	 	VARCHAR2(20) := :OLD.COL3;
	V_PRENCLI 		VARCHAR2(20) := :OLD.COL4;
	V_CATCLI 		VARCHAR2(1)  := :OLD.COL5;
	V_ADRCLI	 	VARCHAR2(50) := :OLD.COL6;
	V_CPCLI 	 	VARCHAR2(10) := :OLD.COL7;
	V_VILCLI	 	VARCHAR2(20) := :OLD.COL8;
	V_PAYSCLI	 	VARCHAR2(30) := :OLD.COL9;
	V_MAILCLI	 	VARCHAR2(30) := :OLD.COL10;
	V_TELCLI	 	VARCHAR2(20) := :OLD.COL11;

	VI_CODCLI       VARCHAR2(10) := :NEW.COL1;
	VI_CIVCLI	 	VARCHAR2(12) := :NEW.COL2;
	VI_NOMCLI	 	VARCHAR2(20) := :NEW.COL3;
	VI_PRENCLI 		VARCHAR2(20) := :NEW.COL4;
	VI_CATCLI 		VARCHAR2(1)  := :NEW.COL5;
	VI_ADRCLI	 	VARCHAR2(50) := :NEW.COL6;
	VI_CPCLI 	 	VARCHAR2(10) := :NEW.COL7;
	VI_VILCLI	 	VARCHAR2(20) := :NEW.COL8;
	VI_PAYSCLI	 	VARCHAR2(30) := :NEW.COL9;
	VI_MAILCLI	 	VARCHAR2(30) := :NEW.COL10;
	VI_TELCLI	 	VARCHAR2(20) := :NEW.COL11;

BEGIN
	IF UPDATING THEN
		INSERT INTO HISTORIQUE_MVTS_CLIENTS (NOMUSER, TYPEMVT, CODCLI, OLDCIVCLI, OLDNOMCLI, OLDPRENCLI, OLDCATCLI, OLDADRCLI, OLDCPCLI, OLDVILCLI, OLDPAYSCLI,OLDMAILCLI, OLDTELCLI, NEWCIVCLI, NEWNOMCLI, NEWPRENCLI, NEWCATCLI, NEWADRCLI, NEWCPCLI, NEWVILCLI, NEWPAYSCLI, NEWMAILCLI, NEWTELCLI, DATMVT)
		VALUES (USER, 'UPDATE', V_CODCLI, V_CIVCLI, V_NOMCLI, V_PRENCLI, V_CATCLI, V_ADRCLI, V_CPCLI, V_VILCLI, V_PAYSCLI,V_MAILCLI, V_TELCLI, VI_CIVCLI, VI_NOMCLI, VI_PRENCLI, VI_CATCLI, VI_ADRCLI, VI_CPCLI, VI_VILCLI, VI_PAYSCLI, VI_MAILCLI, VI_TELCLI, SYSDATE);
	END IF;

	IF DELETING THEN
		INSERT INTO HISTORIQUE_MVTS_CLIENTS (NOMUSER, TYPEMVT, CODCLI, OLDCIVCLI, OLDNOMCLI, OLDPRENCLI, OLDCATCLI, OLDADRCLI, OLDCPCLI, OLDVILCLI, OLDPAYSCLI,OLDMAILCLI, OLDTELCLI, DATMVT)
		VALUES (USER, 'DELETE', V_CODCLI, V_CIVCLI, V_NOMCLI, V_PRENCLI, V_CATCLI, V_ADRCLI, V_CPCLI, V_VILCLI, V_PAYSCLI,V_MAILCLI, V_TELCLI, SYSDATE);

	END IF;

	IF INSERTING THEN
		INSERT INTO HISTORIQUE_MVTS_CLIENTS (NOMUSER, TYPEMVT, CODCLI, NEWCIVCLI, NEWNOMCLI, NEWPRENCLI, NEWCATCLI, NEWADRCLI, NEWCPCLI, NEWVILCLI, NEWPAYSCLI, NEWMAILCLI, NEWTELCLI, DATMVT)
		VALUES (USER, 'INSERT', VI_CODCLI, VI_CIVCLI, VI_NOMCLI, VI_PRENCLI, VI_CATCLI, VI_ADRCLI, VI_CPCLI, VI_VILCLI, VI_PAYSCLI, VI_MAILCLI, VI_TELCLI, SYSDATE);
	END IF;
END;
/

--COL1    COL2    COL3   COL4   COL5
--REFART, NOMART, PVART, QSART, PAART
DROP TABLE HISTORIQUE_MVTS_ARTICLES;
CREATE TABLE HISTORIQUE_MVTS_ARTICLES
(
	NOMUSER		VARCHAR2(15),
	TYPEMVT		VARCHAR2(15),
	REFART 		VARCHAR2(10),
	NOMART		VARCHAR2(50),
	PVART		VARCHAR2(20),
	PAART		VARCHAR2(20),
	QSART		VARCHAR2(20),
	DATMVT		DATE,
	CONSTRAINT NN_HIST_ARTICLES_NOMART	CHECK(NOMART IS NOT NULL),
	CONSTRAINT NN_HIST_ARTICLES_NOMUSER	CHECK(NOMUSER IS NOT NULL),
	CONSTRAINT NN_HIST_ARTICLES_NOMTYPEMVT	CHECK(TYPEMVT IS NOT NULL)
);

DROP TRIGGER MOUVEMENTS_ARTICLES;
CREATE OR REPLACE TRIGGER MOUVEMENTS_ARTICLES
	AFTER UPDATE OR INSERT OR DELETE ON ARTICLES
	FOR EACH ROW
DECLARE
	V_REFART	VARCHAR2(10)	:= :OLD.COL1;
	V_NOMART	VARCHAR2(50)	:= :OLD.COL2;
	V_PVART		VARCHAR2(20)	:= :OLD.COL3;
	V_PAART		VARCHAR2(20)	:= :OLD.COL5;
	V_QSART		VARCHAR2(20)	:= :OLD.COL4;

	VI_REFART	VARCHAR2(10)	:= :NEW.COL1;
	VI_NOMART	VARCHAR2(50)	:= :NEW.COL2;
	VI_PVART	VARCHAR2(20)	:= :NEW.COL3;
	VI_PAART	VARCHAR2(20)	:= :NEW.COL5;
	VI_QSART	VARCHAR2(20)	:= :NEW.COL4;

BEGIN
	IF UPDATING THEN
		INSERT INTO HISTORIQUE_MVTS_ARTICLES (NOMUSER, TYPEMVT, REFART, NOMART, PVART, PAART, QSART, DATMVT)
		VALUES (USER, 'UPDATE', V_REFART, V_NOMART, V_PVART, V_PAART, V_QSART, SYSDATE);
	END IF;

	IF DELETING THEN
		INSERT INTO HISTORIQUE_MVTS_ARTICLES (NOMUSER, TYPEMVT, REFART, NOMART, PVART, PAART, QSART, DATMVT)
		VALUES (USER, 'DELETE', V_REFART, V_NOMART, V_PVART, V_PAART, V_QSART, SYSDATE);
	END IF;

	IF INSERTING THEN
		INSERT INTO HISTORIQUE_MVTS_ARTICLES (NOMUSER, TYPEMVT, REFART, NOMART, PVART, PAART, QSART, DATMVT)
		VALUES (USER, 'INSERT', VI_REFART, VI_NOMART, VI_PVART, VI_PAART, VI_QSART, SYSDATE);
	END IF;
END;
/

INSERT INTO CLIENTS VALUES ('TN0001', 'Madame', 'RAHMA', 'LINA', '3', '', '', 'TUNIS', 'TUNISIE', 'lina.rahma@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0002', 'Madame', 'SFAXI', 'KENZA', '3', '', '', 'SOUSSE', 'TUNISIE', 'kenza.sfaxi@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0003', 'Madame', 'GARROU', 'LINDA', '3', '', '', 'SOUSSE', 'Italie', 'linda.garrou@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0004', 'Madame', 'FARES', 'LEILA', '3', '', '', 'SOUSSE', 'TUNISIE', 'leila.fares@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0005', 'Madame', 'FARES', 'INES', '3', '', '', 'SOUSSE', 'TUNISIE', 'ines.fares@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0006', 'Madame', 'FARES', 'INES', '3', '', '', 'SOUSSE', 'TUNISIE', 'ines.fares@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0007', 'Madame', 'FARES', 'MARIA', '3', '', '', 'SOUSSE', 'TUNISIE', 'maria.fares@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0008', 'Madame', 'FARES', 'INES', '1', '', '', 'SOUSSE', 'TUNISIE', 'ines.fares@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0009', 'Madame', 'DIAB', 'SONIA', '2', '', '', 'SOUSSE', 'TUNISIE', 'sonia.diab@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0010', 'Madame', 'MAGREBI', 'HAYET', '1', '', '', 'SOUSSE', 'TUNISIE', 'hayet.magrebi@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0011', 'Madame', 'SLIMANE', 'AZIZA', '3', '', '', 'SOUSSE', 'TUNISIE', 'aziza.slimane@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0012', 'Madame', 'SLIMANE', 'BEYYA', '2', '', '', 'BIZERTE', 'TUNISIE', 'beyya.slimane@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0013', 'Madame', 'SAHLOUL', 'MERIAM', '1', '', '', 'BIZERTE', 'TUNISIE', 'meriam.sahloul@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0014', 'Monsieur', 'BONBON', 'FAOUZI', '1', '', '', 'BIZERTE', 'TUNISIE', 'faouzi.bonbon@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0015', 'Monsieur', 'ZIZOU', 'ADAM', '1', '', '', 'BIZERTE', 'TUNISIE', 'adam.zizou@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0016', 'Monsieur', 'TOUNSI', 'ADEM', '1', '', '', 'BIZERTE', 'TUNISIE', 'adem.tounsi@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0017', 'Monsieur', 'ZATLA', 'SERGIO', '1', '', '', 'DJERBA', 'France', 'sergio.zatla@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0018', 'Monsieur', 'ZIDANE', 'ALI', '1', '', '', 'HAMMAMET', 'TUNISIE', 'ali.zidane@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0019', 'Monsieur', 'MOHAMED', 'MOHAMED', '1', '', '', 'HAMMAMET', 'TUNISIE', 'mohamed.mohamed@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0020', 'Monsieur', 'LATIFOU', 'ELIAS', '1', '', '', 'HAMMAMET', 'TUNISIE', 'elias.latifou@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0021', 'Monsieur', 'LATIFOU', 'ABDERRAOUF', '1', '', '', 'HAMMAMET', 'TUNISIE', 'abderraouf.latifou@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0022', 'Monsieur', 'SOUSSI', 'KARIM', '1', '', '', 'SOUSSE', 'TUNISIE', 'karim.soussi@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0023', 'Monsieur', 'SOURIR', 'FATHI', '1', '', '', 'SOUSSE', 'TUNISIE', 'fathi.sourir@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0024', 'Monsieur', 'BAJBOUJ', 'BEJI', '1', '', '', 'SOUSSE', 'TUNISIE', 'beji.bajbouj@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('TN0025', 'Monsieur', 'RAIS', 'TAFI', '1', '', '', 'TUNIS', 'TUNISIE', 'tafi.rais@gmail.com', '+21624801801');
INSERT INTO CLIENTS VALUES ('2997007', 'Monsieur', 'TRAIFOR', 'ADAM', '2', '13, AVENUE J. B. CLEMENT', '93430', 'VILLETANEUSE', 'FRANCE', 'adam.traifor@up13.fr', '+33617586567');

-- Les articles du magasin TN02 c est celui de Sousse en Tunisie

INSERT INTO ARTICLES VALUES ('00.37291', 'SIEGE DE TABLE', '95.15 Dt', '10', '79.29 Dt');
INSERT INTO ARTICLES VALUES ('00.37325', 'CASQUE CYCLISTE PROTECTION', '72.00 Dt', '20', '60.00 Dt');
INSERT INTO ARTICLES VALUES ('00.37341', 'BONNET PARE-CHOCS', '20.56 Dt', '100', '17.13 Dt');
INSERT INTO ARTICLES VALUES ('00.37366', 'STORE DE PROTECTION', '15.44 Dt', '5', '12.87 Dt');
INSERT INTO ARTICLES VALUES ('00.37408', 'COINS DE PROTECTION', '06.16 Dt', '100', '05.13 Dt');
INSERT INTO ARTICLES VALUES ('00.37424', 'CACHE PRISE DE COURANT', '02.56 Dt', '500', '02.13 Dt');
INSERT INTO ARTICLES VALUES ('00.37432', 'BLOQUE PORTE', '08.24 Dt', '4', '06.87 Dt');
INSERT INTO ARTICLES VALUES ('00.37457', 'BANDE DE FERMETURE', '06.16 Dt', '4', '05.13 Dt');
INSERT INTO ARTICLES VALUES ('00.37465', 'PROTECTION DE FOUR', '95.15 Dt', '10', '79.29 Dt');
INSERT INTO ARTICLES VALUES ('00.37473', 'PROTECTION DE CUISINIERE', '82.30 Dt', '10', '68.58 Dt');
INSERT INTO ARTICLES VALUES ('00.37515', 'BABY PHONE', '164.56 Dt', '3', '137.13 Dt');
INSERT INTO ARTICLES VALUES ('00.37630', 'BRETELLE DE SECURITE REMOND', '41.15 Dt', '8', '34.29 Dt');
INSERT INTO ARTICLES VALUES ('00.39321', 'HAUSSE-CHAISE', '91.55 Dt', '1', '76.29 Dt');
INSERT INTO ARTICLES VALUES ('00.39495', 'COUVRE ROBINETTERIE', '15.44 Dt', '12', '12.87 Dt');
INSERT INTO ARTICLES VALUES ('11.36613', 'BARRIERE DE PORTE, EN BOIS', '92.56 Dt', '2', '77.13 Dt');
INSERT INTO ARTICLES VALUES ('11.36639', 'BARRIERE DE PORTE, EN METAL', '102.35 Dt', '3', '85.29 Dt');
INSERT INTO ARTICLES VALUES ('11.36860', 'BARRIERE DE LIT', '56.56 Dt', '10', '47.13 Dt');
INSERT INTO ARTICLES VALUES ('11.37108', 'PORTE-BEBE', '123.44 Dt', '6', '102.87 Dt');
INSERT INTO ARTICLES VALUES ('11.37173', 'SIEGE-AUTO COSMOS', '257.15 Dt', '2', '214.29 Dt');
INSERT INTO ARTICLES VALUES ('11.37280', 'SIEGE-AUTO EUROSEAT', '257.15 Dt', '2', '214.29 Dt');
INSERT INTO ARTICLES VALUES ('WD.001', 'K7 VIDEO - TOY STORY', '33.44 Dt', '10', '27.87 Dt');
INSERT INTO ARTICLES VALUES ('WD.002', 'DVD - TOY STORY 2', '43.70 Dt', '10', '36.42 Dt');
INSERT INTO ARTICLES VALUES ('WD.003', 'K7 VIDEO - WINNIE L OURSON', '33.44 Dt', '5', '27.87 Dt');
INSERT INTO ARTICLES VALUES ('MV.001', 'Jeu Vid�o PS4 SPIDER-MAN', '68.40 Dt', '250', '57.00 Dt');

-- Les commandes du magasin TN02 c est celui de Sousse en Tunisie

INSERT INTO COMMANDES VALUES ('KTN001', 'TN0001', '17/09/2015');
INSERT INTO COMMANDES VALUES ('KTN002', 'TN0002', '17/09/2015');
INSERT INTO COMMANDES VALUES ('KTN003', 'TN0003', '16/10/2015');
INSERT INTO COMMANDES VALUES ('KTN004', 'TN0004', '24/10/2015');
INSERT INTO COMMANDES VALUES ('KTN005', 'TN0001', '16/01/2012');
INSERT INTO COMMANDES VALUES ('KTN006', 'TN0022', '17/01/2017');
INSERT INTO COMMANDES VALUES ('KTN007', 'TN0022', '17/09/2018');

-- Les d�tails des commandes du magasin TN02 c est celui de Sousse en Tunisie

INSERT INTO DETAILCOM VALUES ('KTN001', '00.37291', '2', '95.15 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN001', '00.37341', '4', '20.56 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN001', '11.36639', '2', '102.35 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN001', 'WD.001', '1', '33.44 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN002', '00.37291', '2', '95.15 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN002', 'WD.001', '1', '33.44 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN002', 'WD.002', '1', '43.70 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN002', 'WD.003', '1', '33.44 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN001', 'WD.001', '1', '33.44 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN001', 'WD.002', '1', '43.70 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN001', 'WD.003', '1', '33.44 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN001', '00.37457', '2', '06.16 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN001', 'WD.003', '2', '33.44 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN005', 'WD.001', '5', '33.44 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN007', 'WD.002', '10', '43.70 Dt', '30.00%');
INSERT INTO DETAILCOM VALUES ('KTN007', 'MV.001', '2', '68.40 Dt', '30.00%');

COMMIT;

DROP TABLE CLIENTS_TN02;
DROP TABLE COMMANDES_TN02;
DROP TABLE DETAILCOM_TN02;
DROP TABLE ARTICLES_TN02;
DROP TABLE HISTORIQUE_MVTS_CLIENTS_TN02;
DROP TABLE HISTORIQUE_MVTS_ARTICLES_TN02;

EXEC AJOUTECOLONNE('CLIENTS', 'TN02');
EXEC AJOUTECOLONNE('COMMANDES', 'TN02');
EXEC AJOUTECOLONNE('DETAILCOM', 'TN02');
EXEC AJOUTECOLONNE('ARTICLES', 'TN02');
EXEC AJOUTECOLONNE('HISTORIQUE_MVTS_CLIENTS','TN02');
EXEC AJOUTECOLONNE('HISTORIQUE_MVTS_ARTICLES','TN02');

-- Assembler (int�grer, fusionner) dans une nouvelle table, de nom TOUSCLIENTS, tous les clients des diff�rents magasins
/*DROP TABLE TOUSCLIENTS;
create table TOUSCLIENTS AS
(select * from CLIENTS_FR01
union all
select col1,col2,col3,col4,cast(col5 as number(1)),substr(COL6,1,instr(COL6,',')-1),substr(COL6,instr(COL6,',',-1)+1),col7,col8,col9,col10,col11,MAGASIN FROM CLIENTS_FR02
union all
select col1,col2,col3,col4,cast(col5 as number(1)),substr(COL6,1,instr(COL6,',')-1),substr(COL6,instr(COL6,',',-1)+1),col7,col8,col9,col10,col11,MAGASIN FROM CLIENTS_TN02);*/

DROP TABLE TOUSCLIENTS;
CREATE TABLE TOUSCLIENTS AS
(select CODCLI,CIVCLI,NOMCLI,PRENCLI,CATCLI,concat(concat(ADNCLI,', '),ADRCLI) as ADRCLI,CPCLI,VILCLI,PAYSCLI,MAILCLI,TELCLI,MAGASIN from CLIENTS_FR01
union all
select col1,col2,col3,col4,cast(col5 as number(1)),COL6,col7,col8,col9,col10,col11,MAGASIN FROM CLIENTS_FR02
union all
select col1,col2,col3,col4,cast(col5 as number(1)),COL6,col7,col8,col9,col10,col11,MAGASIN FROM CLIENTS_TN02);

DROP TABLE TOUS_HISTORIQUE_MVT_CLIENTS;
CREATE TABLE TOUS_HISTORIQUE_MVT_CLIENTS AS
(SELECT NOMUSER, TYPEMVT, CODCLI, OLDCIVCLI, OLDNOMCLI, OLDPRENCLI, OLDCATCLI,concat(concat(OLDADNCLI,', '),OLDADRCLI) as OLDADRCLI, OLDCPCLI, OLDVILCLI, OLDPAYSCLI,OLDMAILCLI, OLDTELCLI, NEWCIVCLI, NEWNOMCLI, NEWPRENCLI, NEWCATCLI,concat(concat(NEWADNCLI,', '),NEWADRCLI) as NEWADRCLI , NEWCPCLI, NEWVILCLI, NEWPAYSCLI, NEWMAILCLI, NEWTELCLI, DATMVT,MAGASIN FROM HISTORIQUE_MVTS_CLIENTS_FR01
UNION ALL
SELECT NOMUSER, TYPEMVT, CODCLI, OLDCIVCLI, OLDNOMCLI, OLDPRENCLI, CAST(OLDCATCLI as number(1)), OLDADRCLI, OLDCPCLI, OLDVILCLI, OLDPAYSCLI,OLDMAILCLI, OLDTELCLI, NEWCIVCLI, NEWNOMCLI, NEWPRENCLI, CAST(NEWCATCLI as number(1)), NEWADRCLI, NEWCPCLI, NEWVILCLI, NEWPAYSCLI, NEWMAILCLI, NEWTELCLI, DATMVT,MAGASIN FROM HISTORIQUE_MVTS_CLIENTS_FR02
UNION ALL
SELECT NOMUSER, TYPEMVT, CODCLI, OLDCIVCLI, OLDNOMCLI, OLDPRENCLI, CAST(OLDCATCLI as number(1)), OLDADRCLI, OLDCPCLI, OLDVILCLI, OLDPAYSCLI,OLDMAILCLI, OLDTELCLI, NEWCIVCLI, NEWNOMCLI, NEWPRENCLI, CAST(NEWCATCLI as number(1)), NEWADRCLI, NEWCPCLI, NEWVILCLI, NEWPAYSCLI, NEWMAILCLI, NEWTELCLI, DATMVT,MAGASIN FROM HISTORIQUE_MVTS_CLIENTS_TN02);

-- Corrigez le contenu de la nouvelle table TOUSCLIENTS ; Comment savoir si elle contient des anomalies et lesquelles ? et lesquelles ?
-- Faire de m�me pour les toutes les autres tables !!!

-- Assemblez (int�grer, fusionner) dans une nouvelle BDDWBD l'ensemble des tables des diff�rents magasins et tout le n�cessaire
DROP TABLE TOUSCOMMANDES;
CREATE TABLE TOUSCOMMANDES AS
select NUMCOM,CODCLI,DATCOM,MAGASIN from commandes_FR01
union all
select col1,col2,To_date(To_Date(col3,'DD/MM/YYYY'),'DAY DD-MONTH-YYYY'),MAGASIN from commandes_FR02
union all
select col1,col2,To_date(To_Date(col3,'DD/MM/YYYY'),'DAY DD-MONTH-YYYY'),MAGASIN from commandes_TN02;

DROP TABLE TOUSARTICLES;
CREATE TABLE TOUSARTICLES AS
select * from articles_FR01
union all
SELECT COL1,col2,
cast(REGEXP_REPLACE( substr(col3,1,instr(col3,' ')-1), '\.',',') as number(10,2)) as COL3,
cast(col4 as NUMBER(3)) as COL4,
cast(REGEXP_REPLACE( substr(col5,1,instr(col5,' ')-1), '\.',',') as number(10,2)) as COL5,
MAGASIN  from articles_FR02
union all
SELECT
COL1,col2,
cast(REGEXP_REPLACE( substr(upper(col3),1,instr(upper(col3),upper('Dt'))-1), '\.',',')*0.31 as number(10,2))as col3,
cast(col4 as number(3)) as col4,
cast(REGEXP_REPLACE( substr(upper(col5),1,instr(upper(col5),upper('Dt'))-1), '\.',',')*0.31 as number(10,2))as col5,
MAGASIN
from articles_TN02;


DROP TABLE TOUS_HISTORIQUE_MVT_ARTICLES;
CREATE TABLE TOUS_HISTORIQUE_MVT_ARTICLES AS
SELECT * FROM HISTORIQUE_MVTS_ARTICLES_FR01
UNION ALL
SELECT NOMUSER, TYPEMVT, REFART, NOMART,
 CAST(REGEXP_REPLACE( SUBSTR(PVART,1,INSTR(PVART,' ')-1), '\.',',') AS number(10,2)) AS PVART,
 CAST(REGEXP_REPLACE( SUBSTR(PAART,1,INSTR(PAART,' ')-1), '\.',',') AS number(10,2)) AS PAART,
 CAST(QSART as number(3)) as QSART, DATMVT ,
 MAGASIN FROM HISTORIQUE_MVTS_ARTICLES_FR02
 UNION ALL
 SELECT NOMUSER, TYPEMVT, REFART, NOMART,
 CAST(REGEXP_REPLACE( SUBSTR(PVART,1,INSTR(PVART,' ')-1), '\.',',') AS number(10,2)) AS PVART,
 CAST(REGEXP_REPLACE( SUBSTR(PAART,1,INSTR(PAART,' ')-1), '\.',',') AS number(10,2)) AS PAART,
 CAST(QSART as number(3)) as QSART, DATMVT ,
 MAGASIN FROM HISTORIQUE_MVTS_ARTICLES_TN02;

DROP TABLE TOUSDETAILCOM;
CREATE TABLE TOUSDETAILCOM AS
select * from detailcom_fr01
union all
SELECT COL1,COL2,
cast(col3 as number(3)),
cast(REGEXP_REPLACE( substr(col4,1,instr(col4,' ')-1), '\.',',') as number(10,2)),
cast(REGEXP_REPLACE( substr(col5,1,instr(col5,'%')-1), '\.',',') as number(4,2)),
MAGASIN from detailcom_FR02
union all
SELECT COL1,COL2,
cast(col3 as number(3)),
cast(REGEXP_REPLACE( substr(upper(col4),1,instr(upper(col4),upper('Dt'))-1), '\.',',') as number(10,2)),
cast(REGEXP_REPLACE( substr(col5,1,instr(col5,'%')-1) , '\.',',') as number(4,2)),
MAGASIN from detailcom_TN02;
-- Le r�sultat est : TOUSCLIENTS (avec l'historique des mouvements), TOUSARTICLES (avec l'historique des mouvements), TOUSCOMMANDES, TOUSDETAILSCOM, TOUSMAGASINS (avec l'historique des mouvements), etc...

--=====================================================================================================================
--=====================================================================================================================
-- NOUVELLES DONNEES == NOUVELLES DONNEES  == NOUVELLES DONNEES
--=====================================================================================================================
--=====================================================================================================================

--=====================================================================================================================
--=====================================================================================================================
-- NOUVELLES DONNEES == NOUVELLES DONNEES  == NOUVELLES DONNEES
--=====================================================================================================================
--=====================================================================================================================
