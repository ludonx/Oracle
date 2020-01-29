------------------------------------------------------------------------+
---------           Groupe          :  13                ---------------|
---------           Nom             :  TEKAM LUDOVIK     ---------------|
---------           Numéro étudiant :  11706765          ---------------|
------------------------------------------------------------------------+


-- SPOOL Bxy-G1.lst

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
COLUMN KEYWORDSCLI    FORMAT A20

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


PROMPT =========================================================
PROMPT FB-A : Requetes sur la bd EN SQL 2  du type : A, B, C, D, E, F, I, J, H
PROMPT =========================================================
PROMPT

PROMPT =========================================================
PROMPT FB-A : Requetes du type Ai (Sélections + Projections) :
PROMPT =========================================================
PROMPT

PROMPT =========================================================
PROMPT >> Requete A01 : Les Noms des clients (Avec éventuellement des doublons)
PROMPT =========================================================
PROMPT
SELECT NOMCLI FROM Clients ;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
NOMCLI
--------
CLEM@ENT
LESEUL
UNIQUE
CLEMENCE
FORT
LE BON
TRAIFOR
VIVANT

CLEMENCE
TRAIFOR
PREMIER
CLEMENT
FORT
ADAM
Labsent
obsolete
RAHYM
GENIE
GENIE
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A02 : Les Noms des clients (Sans les doublons)
PROMPT =========================================================
PROMPT
SELECT DISTINCT NOMCLI FROM Clients ;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
NOMCLI
--------
LE BON
VIVANT
UNIQUE
PREMIER
CLEM@ENT
CLEMENT

obsolete
CLEMENCE
FORT
TRAIFOR
ADAM
RAHYM
GENIE
LESEUL
Labsent

*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A03 : Les articles dont le prix de vente est supérieur ou égal au double du prix d’achat
PROMPT =========================================================
PROMPT
SELECT * FROM Articles WHERE PvArt >= 2*(PaArt);
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

REFART   NOMART                      PVART QSART   PAART
-------- ------------------------- ------- ----- -------
F1.005   COINS DE PROTECTION          4.00   ###    1.71
F1.006   CACHE PRISE DE COURANT       2.29   ###     .71
F1.007   BLOQUE PORTE                 5.00     4    2.29
FB.001   DVD-SPIRIT                  24.90     2   12.00
FB.002   DVD-SPIDER MAN              24.90     2   12.00
FB.003   DVD-SPIDER MAN 2            24.90     2   12.00
WD.001   K7 VIDEO-TOY STORY          21.29    10    9.29
WD.002   DVD-TOY STORY 2             34.29    10   12.14
WD.003   K7 VIDEO-WINNIE L OURSON    22.86     5    9.29
WD.004   DVD-FRERES DES OURS         35.00     3   13.00
WD.005   K7 VIDEO-LE ROI LION        30.00     1   13.00

WD.006   K7 VIDEO-LE ROI LION 2      30.00     4   13.00
WD.007   K7 VIDEO-LE ROI LION 3      30.00     3   13.00
*/


PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A04 : Les articles dont le prix de vente est soit 4 soit 27 soit 35
PROMPT =========================================================
PROMPT
SELECT * FROM Articles WHERE PvArt IN (4, 27, 35);

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

REFART   NOMART                      PVART QSART   PAART
-------- ------------------------- ------- ----- -------
F1.001   SIEGE DE TABLE              35.00    10   26.43
F1.002   CASQUE CYCLISTE PROTECTIO   27.00    20   20.00
         N

F1.005   COINS DE PROTECTION          4.00   ###    1.71
WD.004   DVD-FRERES DES OURS         35.00     3   13.00
*/


PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A05 : Les articles dont le prix de vente est compris entre 30 et 50
PROMPT =========================================================
PROMPT
SELECT * FROM Articles WHERE PvArt between 30 AND 50;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
REFART   NOMART                      PVART QSART   PAART
-------- ------------------------- ------- ----- -------
F1.001   SIEGE DE TABLE              35.00    10   26.43
F1.009   PROTECTION DE FOUR          37.86    10   26.43
F1.010   PROTECTION DE CUISINIERE    30.71    10   22.86
F1.013   HAUSSE-CHAISE               42.71     1   25.43
F2.001   BARRIERE DE PORTE, EN BOI   32.71     2   25.71
         S

F2.002   BARRIERE DE PORTE, EN MET   49.14     3   28.43
         AL

F2.004   PORTE-BEBE                  44.86     6   34.29
WD.002   DVD-TOY STORY 2             34.29    10   12.14

WD.004   DVD-FRERES DES OURS         35.00     3   13.00
WD.005   K7 VIDEO-LE ROI LION        30.00     1   13.00
WD.006   K7 VIDEO-LE ROI LION 2      30.00     4   13.00
WD.007   K7 VIDEO-LE ROI LION 3      30.00     3   13.00

12 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A06 : Les commandes du mois de septembre 2015
PROMPT =========================================================
PROMPT
-- SELECT * FROM Commandes WHERE TO_CHAR(datcom,'MM')='09' AND TO_CHAR(datcom,'YYYY')='2015';
select * from commandes where extract(month from DATCOM) =9 and extract(YEAR from DATCOM) =2015;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

no rows selected
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A07 : Les détails des commandes d’une année donnée (2012)
PROMPT =========================================================
PROMPT
select * from commandes where extract(YEAR from DATCOM) =2012;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

no rows selected
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A08 : Les clients de « Paris » (Civilité Nom Prénom, Ville), le nom de la ville s’écrit comme « Paris »
PROMPT =========================================================
PROMPT
SELECT civcli,Nomcli,prencli,VilCli FROM Clients WHERE UPPER(VilCli) = 'PARIS';

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CIVCLI   NOMCLI   PRENCLI  VILCLI
-------- -------- -------- ------
Madame   LESEUL   M@RIE    PARIS
Mademois TRAIFOR  ALICE    PARIS

elle

Monsieur CLEMENCE ALEXANDR PaRiS
                  E

Monsieur TRAIFOR  ALEXANDR PARIS
                  E

Madame   GENIE    GENIALE  PARIS
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A09 : Les clients dont le nom commence par « C »
PROMPT =========================================================
PROMPT
SELECT * FROM Clients WHERE UPPER(Nomcli) LIKE 'C%';

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CODCLI CIVCLI   NOMCLI   PRENCLI  CATCLI ADNCLI ADRCLI     CPCLI VILCLI PAYSCLI MAILCLI    TELCLI     KEYWORDSCLI
------ -------- -------- -------- ------ ------ ---------- ----- ------ ------- ---------- ---------- --------------------
C001   Madame   CLEM@ENT EVE           1 18     BOULEVARD  91000 EPINAY FRANCE  eve.clemen +337778899 Voyages, Mangas, Bas
                                                FOCH             -SUR-O         t@gmail.co 11         ketBall, Musique
                                                                 RGE            m

C004   Madame   CLEMENCE EVELYNE       3 8 BIS  BOULEVARD  93800 EPINAY FRANCE  clemence e +337778899 Mangas, football , T
                                                FOCH             -SUR-S         velyne@gma 33         heatre, Cinema, Musi
                                                                 EINE           il.com                que, Plongee sous ma
                                                                                                      rine

C009   Monsieur CLEMENCE ALEXANDR      1 5      RUE DE BEL 75019 PaRiS  FRANCE  alexandre. +331494040
                         E                      LEVILLE                         clemence@u 71
                                                                                p13.fr

C012   Monsieur CLEMENT  ADAM          2 13     AVENUE JEA 9430  VILLET FRANCE  adam.cleme +331494040 Voyages, FOOTBALL, B
                                                N BAPTISTE       ANEUSE         nt@gmail.c 72         asketBall, Mangas
                                                 CLEMENT                        om


Elapsed: 00:00:00.00
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A10: Les articles dont le nom commence par « Barrières de »
PROMPT =========================================================
PROMPT
SELECT * FROM Articles WHERE NomArt LIKE 'BARRIERE DE%';

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
REFART   NOMART                      PVART QSART   PAART
-------- ------------------------- ------- ----- -------
F2.001   BARRIERE DE PORTE, EN BOI   32.71     2   25.71

         S

F2.002   BARRIERE DE PORTE, EN MET   49.14     3   28.43
         AL

F2.003   BARRIERE DE LIT             23.71    10   15.71

*/


PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A11: Les articles du fournisseur « WD »
PROMPT =========================================================
PROMPT
SELECT * FROM Articles WHERE REFART LIKE'WD%';

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
REFART   NOMART                      PVART QSART   PAART
-------- ------------------------- ------- ----- -------
WD.001   K7 VIDEO-TOY STORY          21.29    10    9.29
WD.002   DVD-TOY STORY 2             34.29    10   12.14

WD.003   K7 VIDEO-WINNIE L OURSON    22.86     5    9.29
WD.004   DVD-FRERES DES OURS         35.00     3   13.00
WD.005   K7 VIDEO-LE ROI LION        30.00     1   13.00
WD.006   K7 VIDEO-LE ROI LION 2      30.00     4   13.00
WD.007   K7 VIDEO-LE ROI LION 3      30.00     3   13.00

7 rows selected.

*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A12 : Les clients pour lesquels on n a pas de téléphone
PROMPT =========================================================
PROMPT
select * from clients where TELCLI = null ;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
no rows selected
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A13: Les clients dont le nom de la ville se prononce comme « pari » ou « bariz » ou « pary »
PROMPT =========================================================
PROMPT
SELECT * FROM Clients WHERE SOUNDEX(VilCli)=SOUNDEX('PARIS') OR SOUNDEX(VilCli)=SOUNDEX('bariz');

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CODCLI CIVCLI   NOMCLI   PRENCLI  CATCLI ADNCLI ADRCLI     CPCLI VILCLI PAYSCLI MAILCLI    TELCLI     KEYWORDSCLI
------ -------- -------- -------- ------ ------ ---------- ----- ------ ------- ---------- ---------- --------------------
C002   Madame   LESEUL   M@RIE         1 21     AVENUE D I 75013 PARIS  FRANCE  marieleseu 0617586565 Natation, Dessin, Vo
                                                TALIE                           l@yahoo.fr            yages, Bandes Dessin
                                                                                                      ees

C007   Mademois TRAIFOR  ALICE         2 6      RUE DE LA  75015 PARIS  FRANCE  alice.trai +337778899 Bandes Dessinees, fo
       elle                                     ROSIERE                         for@yahoo. 66         otball , Musique, Ha
                                                                                fr                    ndball, Voyages

C009   Monsieur CLEMENCE ALEXANDR      1 5      RUE DE BEL 75019 PaRiS  FRANCE  alexandre. +331494040
                         E                      LEVILLE                         clemence@u 71
                                                                                p13.fr

C010   Monsieur TRAIFOR  ALEXANDR      1 16     AVENUE FOC 75016 PARIS  FRA     alexandre. 06070809   Handball, Theatre, V
                         E                      H                               traifor@up            oyages, FOOTBALL
                                                                                13.fr

C019   Madame   GENIE    GENIALE       3 16     AVENUE FOC 75016 PARIS  FRANCE  genialegen +337778899 @!?
                                                H                               ie@gmail.c 00
                                                                                om


Elapsed: 00:00:00.00
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A14: Les clients dont le nom est similaire à « pari » ou « bariz » ou « pary »
PROMPT =========================================================
PROMPT
select * from clients
where UPPER(VILCLI) like '%ARI%'
or UPPER(VILCLI) like '%ARY%';
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CODCLI CIVCLI   NOMCLI   PRENCLI  CATCLI ADNCLI ADRCLI     CPCLI VILCLI PAYSCLI MAILCLI    TELCLI     KEYWORDSCLI
------ -------- -------- -------- ------ ------ ---------- ----- ------ ------- ---------- ---------- --------------------
C002   Madame   LESEUL   M@RIE         1 21     AVENUE D I 75013 PARIS  FRANCE  marieleseu 0617586565 Natation, Dessin, Vo
                                                TALIE                           l@yahoo.fr            yages, Bandes Dessin
                                                                                                      ees

C007   Mademois TRAIFOR  ALICE         2 6      RUE DE LA  75015 PARIS  FRANCE  alice.trai +337778899 Bandes Dessinees, fo
       elle                                     ROSIERE                         for@yahoo. 66         otball , Musique, Ha
                                                                                fr                    ndball, Voyages

C009   Monsieur CLEMENCE ALEXANDR      1 5      RUE DE BEL 75019 PaRiS  FRANCE  alexandre. +331494040
                         E                      LEVILLE                         clemence@u 71
                                                                                p13.fr

C010   Monsieur TRAIFOR  ALEXANDR      1 16     AVENUE FOC 75016 PARIS  FRA     alexandre. 06070809   Handball, Theatre, V
                         E                      H                               traifor@up            oyages, FOOTBALL
                                                                                13.fr

C019   Madame   GENIE    GENIALE       3 16     AVENUE FOC 75016 PARIS  FRANCE  genialegen +337778899 @!?
                                                H                               ie@gmail.c 00
                                                                                om


Elapsed: 00:00:00.01
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A15 : Décodification de la catégorie des clients : Transformez la catégorie comme suit : 1 ? Grossiste, 2 ? Demi-Gros, ? Détaillant
PROMPT =========================================================
PROMPT
/*SELECT
Nomcli,
CASE catcli WHEN 1 THEN 'Grossiste' WHEN 2 THEN 'Demi-Gros' ELSE 'detaillant' END AS Categorie
FROM Clients;*/
select Nomcli, DECODE(CATCLI,1,'Grossiste',2,'Demi-Gros','Detaillant' ) as Categorie
from clients;
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

NOMCLI   CATEGORIE
-------- ----------
CLEM@ENT Grossiste
LESEUL   Grossiste
UNIQUE   Demi-Gros

CLEMENCE detaillant
FORT     detaillant
LE BON   Grossiste
TRAIFOR  Demi-Gros
VIVANT   Grossiste
CLEMENCE Grossiste
TRAIFOR  Grossiste
PREMIER  Demi-Gros
CLEMENT  Demi-Gros
FORT     detaillant
ADAM     detaillant
Labsent  detaillant
obsolete detaillant
RAHYM    Grossiste
GENIE    detaillant
GENIE    detaillant

19 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A16 : Les clients pour lesquels le nom et/ou le prénom sont invalides (Code, Nom, et Prénom)
PROMPT =========================================================
PROMPT
select CODCLI, NOMCLI,PRENCLI from clients
where not (REGEXP_LIKE(NOMCLI,'^[A-Za-z]+$')
and REGEXP_LIKE(PRENCLI,'^[A-Za-z]+$') );
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CODCLI NOMCLI   PRENCLI

------ -------- --------
C001   CLEM@ENT EVE
C002   LESEUL   M@RIE
C006   LE BON   CLEMENCE
C008   VIVANT   JEAN-BAP
                TISTE

C011   PREMIER  JOS//EPH

*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A17 : Les clients pour lesquels les mails sont invalides (Code, Nom, et Mail)
PROMPT =========================================================
PROMPT
select CODCLI, NOMCLI,PRENCLI ,MAILCLI from clients
where not REGEXP_LIKE(MAILCLI,'^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CODCLI NOMCLI   PRENCLI  MAILCLI
------ -------- -------- ----------
C004   CLEMENCE EVELYNE  clemence e
                         velyne@gma
                         il.com

C005   FORT     JEANNE   jfort\@hot
                         mail.fr


C006   LE BON   CLEMENCE clemence.l
                         e bon@cfo.
                         fr

C008   VIVANT   JEAN-BAP jeanbaptis
                TISTE    te@

C011   PREMIER  JOS//EPH josef@prem
                         ier

C014   ADAM     DAVID    david.adam
                         é@gmail c
                         om

C015   Labsent  pala     pala-labse
                         nt@paici

C016   obsolete kadym    inexistant
C018   GENIE    ADAM     adam.géni
                         e@gmail.co
                         m
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete A18 : Les clients pour lesquels les téléphones sont invalides (Code, Nom, et Mail)
PROMPT =========================================================
PROMPT
select CODCLI, NOMCLI,PRENCLI ,TELCLI from clients
where not REGEXP_LIKE(TELCLI,'^\+[0-9]{9,13}$');
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CODCLI NOMCLI   PRENCLI  TELCLI
------ -------- -------- ----------
C002   LESEUL   M@RIE    0617586565

C006   LE BON   CLEMENCE 0033777889
                         955

C008   VIVANT   JEAN-BAP 0607
                TISTE

C010   TRAIFOR  ALEXANDR 06070809
                E

C016   obsolete kadym    inexistant

*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete SUPPLEMENTAIRE
PROMPT =========================================================
PROMPT


----------------------------+
-- QUESTIONS SUPPLEMENTAIRE |
----------------------------+
-- detecter les lignes avec plusieurs lettres
-- ajoutont une ligne
/*
INSERT INTO CLIENTS (CODCLI, CIVCLI, NOMCLI, PRENCLI, CATCLI, ADNCLI, ADRCLI, CPCLI, VILCLI, PAYSCLI, MAILCLI, TELCLI)
VALUES ('CNEW', 'Madame', 'AAAAA', 'BBBBB', 1, '18', 'BOULEVARD FOCH', '91000', 'EPINAY-SUR-ORGE', 'FRANCE','eve.clement@gmail.com', '+33777889911');
*/
-- les clients qui ont des @ dans leur nom/prenom
select CODCLI, NOMCLI,PRENCLI from clients
where  not (REGEXP_LIKE(NOMCLI,'@')
or REGEXP_LIKE(PRENCLI,'@')) ;

/*
CODCLI NOMCLI   PRENCLI
------ -------- --------
C003   UNIQUE   MARINE
C004   CLEMENCE EVELYNE
C005   FORT     JEANNE
C006   LE BON   CLEMENCE
C007   TRAIFOR  ALICE

C008   VIVANT   JEAN-BAP
                TISTE

C009   CLEMENCE ALEXANDR
                E

C010   TRAIFOR  ALEXANDR
                E

C011   PREMIER  JOS//EPH
C012   CLEMENT  ADAM
C013   FORT     GABRIEL
C014   ADAM     DAVID
C015   Labsent  pala
C016   obsolete kadym
C017   RAHYM    KARYM
C018   GENIE    ADAM
C019   GENIE    GENIALE

17 rows selected.
*/

-- detecter les clients avec le même caractère qui se suit plus d'une fois dans son nom ou prenom
select CODCLI, NOMCLI,PRENCLI from clients where REGEXP_LIKE(NOMCLI,'A{2,}');


---- correction de certaine annomalie
-- transformer la premier lettre en Majuscule
-- update clients set NOMCLI = INITCAP(NOMCLI);


-- mettre une colonne en Majuscule
-- update clients set VILCLI = UPPER(VILCLI);
-- update clients set NOMCLI = UPPER(NOMCLI);


-- =======================================================================
-- =======================================================================
-- =======================================================================

PROMPT =========================================================
PROMPT FB-B : Requêtes du type Bi (Tris + Sélections + Projections + Calculs)
PROMPT =========================================================
PROMPT


PROMPT =========================================================
PROMPT >> Requete B01 : Classez les clients par ville, par ordre croissant
PROMPT =========================================================
PROMPT
SELECT CODCLI, NOMCLI, PRENCLI, VILCLI FROM Clients ORDER BY VilCli ASC;
/*SELECT * FROM Clients ORDER BY VilCli;
SELECT * FROM CLIENTS ORDER BY 9;*/

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CODCLI NOMCLI   PRENCLI  VILCLI
------ -------- -------- ------

C015   Labsent  pala     BAGDAD
C016   obsolete kadym    CARTHA
                         GE

C017   RAHYM    KARYM    CARTHA
                         GE

C018   GENIE    ADAM     EPINAY
                          SUR S
                         EINE

C001   CLEM@ENT EVE      EPINAY
                         -SUR-O
                         RGE

C004   CLEMENCE EVELYNE  EPINAY
                         -SUR-S
                         EINE

C006   LE BON   CLEMENCE EPINAY
                         -SUR-S
                         EINE
                         C008   VIVANT   JEAN-BAP EPINAY
                TISTE    -SUR-S
                         EINE


C003   UNIQUE   MARINE   MARCHE
                         ILLE

C011   PREMIER  JOS//EPH MARCHE
                         ILLE

C005   FORT     JEANNE   ORLY-V
                         ILLE

C010   TRAIFOR  ALEXANDR PARIS
                E

C007   TRAIFOR  ALICE    PARIS
C019   GENIE    GENIALE  PARIS
C002   LESEUL   M@RIE    PARIS
C009   CLEMENCE ALEXANDR PaRiS
                E

C014   ADAM     DAVID    ROME
C013   FORT     GABRIEL  TUNIS
C012   CLEMENT  ADAM     VILLET
                         ANEUSE
19 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete B02 : Classez les articles de PV < 20, dans l’ordre décroissant du stock
PROMPT =========================================================
PROMPT
SELECT NomArt,QsArt FROM Articles WHERE PvArt< 20 ORDER BY QsArt DESC;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
NOMART                    QSART
------------------------- -----
CACHE PRISE DE COURANT      ###
COINS DE PROTECTION         ###
BONNET PARE-CHOCS           ###
COUVRE ROBINETTERIE          12
BRETELLE DE SECURITE          8
STORE DE PROTECTION           5
BLOQUE PORTE                  4
BANDE DE FERMETURE            4

8 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete B03 : Calculez la marge pour chaque article (marge = PV – PA !), présentez le résultat par ordre décroissant de la marge
PROMPT =========================================================
PROMPT
SELECT NomArt,(PvArt-PaArt) AS Marge FROM Articles;


-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
NOMART                         MARGE
------------------------- ----------
SIEGE DE TABLE                  8,57

CASQUE CYCLISTE PROTECTIO          7
N

BONNET PARE-CHOCS                  5
STORE DE PROTECTION             3,14
COINS DE PROTECTION             2,29
CACHE PRISE DE COURANT          1,58
BLOQUE PORTE                    2,71
BANDE DE FERMETURE              1,58
PROTECTION DE FOUR             11,43
PROTECTION DE CUISINIERE        7,85
BABY PHONE                        35
BRETELLE DE SECURITE            4,14
HAUSSE-CHAISE                  17,28
COUVRE ROBINETTERIE             3,57
BARRIERE DE PORTE, EN BOI          7
S

BARRIERE DE PORTE, EN MET      20,71
AL
BARRIERE DE LIT                    8
PORTE-BEBE                     10,57
SIEGE-AUTO COSMOS              55,43
SIEGE-AUTO EUROSEAT            49,86

DVD-SPIRIT                      12,9
DVD-SPIDER MAN                  12,9
DVD-SPIDER MAN 2                12,9
K7 VIDEO-TOY STORY                12
DVD-TOY STORY 2                22,15
K7 VIDEO-WINNIE L OURSON       13,57
DVD-FRERES DES OURS               22
K7 VIDEO-LE ROI LION              17
K7 VIDEO-LE ROI LION 2            17
K7 VIDEO-LE ROI LION 3            17

30 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete B04 : Calculez la marge pour tous les sièges, présentez le résultat par ordre croissant de la marge
PROMPT =========================================================
PROMPT
SELECT NomArt, (PvArt-PaArt) AS Marge FROM Articles WHERE UPPER(NomArt) LIKE '%SIEGE%'
ORDER BY Marge ASC;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

NOMART                         MARGE
------------------------- ----------
SIEGE DE TABLE                  8,57
SIEGE-AUTO EUROSEAT            49,86
SIEGE-AUTO COSMOS              55,43
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete B05 : Calculez le nombre de valeurs nulles ….
PROMPT =========================================================
PROMPT
select  count(REFART) as nbrElemNull_Pvart from articles where  Pvart= null;
select  count(REFART) as nbrElemNull_NomArt from articles where  NomArt= null;
select  count(REFART) as nbrElemNull_QSART from articles where  QSART= null;
select  count(REFART) as nbrElemNull_PAART from articles where  PAART= null;


-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
NBRELEMNULL_PVART
-----------------
                0

Elapsed: 00:00:00.00

NBRELEMNULL_NOMART
------------------
                 0

Elapsed: 00:00:00.01

NBRELEMNULL_QSART
-----------------
                0

Elapsed: 00:00:00.00

NBRELEMNULL_PAART
-----------------
                0
*/

-- =======================================================================
-- =======================================================================
-- =======================================================================

PROMPT =========================================================
PROMPT FB-C : Requêtes du type Ci (Calculs + Sélections+ Projections) :
PROMPT =========================================================
PROMPT


PROMPT =========================================================
PROMPT >> Requete C01 : Nombre de clients (Femme + Homme)
PROMPT =========================================================
PROMPT
SELECT COUNT(*) AS NbrCli FROM Clients;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

    NBRCLI
----------
        19

*/


PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete C02 : Nombre de clientes (Femme)
PROMPT =========================================================
PROMPT
SELECT COUNT(*) as nbr_femme FROM Clients WHERE UPPER(CivCli)='MADAME' OR UPPER(CivCli)='MADEMOISELLE';

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

 NBR_FEMME
----------
        11
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete C03 : Nombre de clients (Homme)
PROMPT =========================================================
PROMPT
SELECT COUNT(*) as nbr_homme FROM Clients WHERE UPPER(CivCli)='MONSIEUR';

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
NBR_HOMME
----------
        8
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete C04 : Le prix de vente le plus élevé
PROMPT =========================================================
PROMPT
SELECT MAX(PvArt) FROM Articles;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
MAX(PVART)
----------
    126,86
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete C05 : Moyenne des prix de vente des articles
PROMPT =========================================================
PROMPT
SELECT AVG(PvArt) FROM Articles;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
AVG(PVART)
----------
    32,895
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete C06 : Le chiffre d’affaires global
PROMPT =========================================================
PROMPT
SELECT SUM(PvArt*qsart) AS chiffre_daffaires FROM Articles;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CHIFFRE_DAFFAIRES
-----------------
          7145,63
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete C07 : Les articles dont le prix de vente est supérieur à la moyenne des prix de vente
PROMPT =========================================================
PROMPT
SELECT * FROM Articles WHERE PvArt >= (SELECT AVG(PvArt) FROM Articles);

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
REFART   NOMART                      PVART QSART   PAART
-------- ------------------------- ------- ----- -------
F1.001   SIEGE DE TABLE              35.00    10   26.43
F1.009   PROTECTION DE FOUR          37.86    10   26.43
F1.011   BABY PHONE                  80.71     3   45.71
F1.013   HAUSSE-CHAISE               42.71     1   25.43
F2.002   BARRIERE DE PORTE, EN MET   49.14     3   28.43
         AL

F2.004   PORTE-BEBE                  44.86     6   34.29
F2.005   SIEGE-AUTO COSMOS          126.86     2   71.43
F2.006   SIEGE-AUTO EUROSEAT        121.29     2   71.43
WD.002   DVD-TOY STORY 2             34.29    10   12.14
WD.004   DVD-FRERES DES OURS         35.00     3   13.00

10 rows selected.
*/


-- =======================================================================
-- =======================================================================
-- =======================================================================

PROMPT =========================================================
PROMPT FB-D : Requêtes du type Di (Calculs + Sous-Totaux + Sélections+ Projections + Tris) :
PROMPT =========================================================
PROMPT


PROMPT =========================================================
PROMPT >> Requete D01 : Nombre de clients par catégorie
PROMPT =========================================================
PROMPT
SELECT CatCli AS Categorie, COUNT(*) AS NombreCli  FROM Clients GROUP BY CatCli;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CATEGORIE  NOMBRECLI
---------- ----------
        1          7
        2          4
        5          2
        3          4
        7          2

Elapsed: 00:00:00.00

*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete D02 : Nombre de clients parisiens par catégorie
PROMPT =========================================================
PROMPT
SELECT COUNT(*) AS nbr,CatCli FROM Clients WHERE SOUNDEX(vilcli) = SOUNDEX('Paris') GROUP BY CatCli;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
NBR CATCLI
---------- ------
  3      1
  1      2
  1      3

*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete D03 :  Montant de chaque commande
PROMPT =========================================================
PROMPT
SELECT SUM(PUART*QTCOM),numcom FROM Commandes NATURAL JOIN Detailcom GROUP BY numcom;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
SUM(PUART*QTCOM) NUMCOM
---------------- ----------
          232,41 20001AB
          144,44 20002AB
          162,15 20003AB

           27,87 20004AB
          182,86 20012RB
          142,29 20031FB
          111,58 20051FB
          255,27 20052FB
           22,86 20053FB
           22,86 20054FB
          246,44 20055FB
          161,42 20056FB
           30,71 20057FB
             120 20061FB
             120 20062FB
             120 20065FB
             120 20066FB
             528 20067FB
             528 20068FB
            1450 20069FB
            1200 20070FB
          1032,3 20071FB
             272 20072FB
           542,5 20073FB
          239,88 20074FB
          124,39 20181AB

26 rows selected.
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete D04 : Nombre de clients parisiens par catégorie, nombre > 2
PROMPT =========================================================
PROMPT
SELECT * FROM(SELECT COUNT(*) AS nbr,CatCli FROM Clients WHERE SOUNDEX(vilcli) = SOUNDEX('Paris') GROUP BY CatCli) WHERE nbr >2;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

       NBR CATCLI
---------- ------
         3      1
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete D05 :  Total des quantités commandées par article
PROMPT =========================================================
PROMPT
SELECT SUM(QTCOM),NomArt FROM Articles NATURAL JOIN detailcom GROUP BY NomArt;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
SUM(QTCOM) NOMART
---------- -------------------------

         8 BONNET PARE-CHOCS
         5 BLOQUE PORTE
         4 HAUSSE-CHAISE
        25 DVD-SPIDER MAN 2
        11 BANDE DE FERMETURE
         2 DVD-TOY STORY 2
         2 PROTECTION DE FOUR
       233 DVD-SPIRIT
         5 K7 VIDEO-WINNIE L OURSON
         6 SIEGE DE TABLE
         3 BARRIERE DE PORTE, EN BOI
           S

         4 K7 VIDEO-TOY STORY
         4 BABY PHONE

13 rows selected.
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete D06 : Total des quantités commandées par catégorie d’article
PROMPT =========================================================
PROMPT

SELECT SUBSTR(REFART,0,2) as categorie,SUM(QTCOM) FROM Articles NATURAL JOIN detailcom GROUP BY SUBSTR(REFART,0,2);

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CA SUM(QTCOM)
-- ----------
F1         40

WD         11
F2          3
FB        258
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete D07 : Total du chiffre d’affaires par catégorie d’article
PROMPT =========================================================
PROMPT
SELECT SUBSTR(REFART,0,2) as categorie,SUM(PvArt*qsart) AS chiffre_daffaires FROM Articles GROUP BY SUBSTR(REFART,0,2);

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CA CHIFFRE_DAFFAIRES
-- -----------------
F1           4765,73
WD            1015,1
F2            1215,4
FB             149,4

Elapsed: 00:00:00.01
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete D08 : Total, moyenne, min et max du chiffre d’affaires par catégorie d’article
PROMPT =========================================================
PROMPT
SELECT SUBSTR(REFART,0,2) as categorie,
SUM(PvArt*qsart) AS total_chiffre_daffaires,
AVG(PvArt*qsart) AS moyenne_chiffre_daffaires,
MIN(PvArt*qsart) AS min_chiffre_daffaires,
MAX(PvArt*qsart) AS max_chiffre_daffaires
FROM Articles GROUP BY SUBSTR(REFART,0,2);


-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

CA TOTAL_CHIFFRE_DAFFAIRES MOYENNE_CHIFFRE_DAFFAIRES MIN_CHIFFRE_DAFFAIRES MAX_CHIFFRE_DAFFAIRES
-- ----------------------- ------------------------- --------------------- ---------------------
F1                 4765,73                340,409286                 13,16                  1145
WD                  1015,1                145,014286                    30                 342,9
F2                  1215,4                202,566667                 65,42                269,16
FB                   149,4                      49,8                  49,8                  49,8

Elapsed: 00:00:00.00

*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete D09 : Le chiffre d’affaires par année
PROMPT =========================================================
PROMPT
SELECT SUM(qsart*Pvart),TO_CHAR(datcom,'YYYY') AS annee FROM Commandes NATURAL JOIN Articles GROUP BY TO_CHAR(datcom,'YYYY');

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
SUM(QSART*PVART) ANNE
---------------- ----
        28582,52 2000
        14291,26 2001
        50019,41 2003
        50019,41 2005
        42873,78 2007
        14291,26 2018

6 rows selected.
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete D10 : Le nombre de valeurs différentes par colonne
PROMPT =========================================================
PROMPT

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

*/

-- =======================================================================
-- =======================================================================
-- =======================================================================

PROMPT =========================================================
PROMPT FB-E : Requêtes du type Ei (Jointures + Sélections + Projections)
PROMPT =========================================================
PROMPT


PROMPT =========================================================
PROMPT >> Requete E01 :  Le Produit Cartésien : Les clients ayant commandé et leurs commandes
PROMPT =========================================================
PROMPT
SELECT * FROM Clients, Commandes WHERE Clients.CODCLI= Commandes.codcli;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

28 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete E02 :  full outer join : Les clients ayant commandé et leurs commandes
PROMPT =========================================================
PROMPT
SELECT * FROM Clients full OUTER JOIN Commandes ON Clients.codcli= Commandes.codcli;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
37 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete E03 : left join : Les clients ayant commandé et leurs commandes
PROMPT =========================================================
PROMPT
SELECT * FROM Clients left OUTER JOIN Commandes ON Clients.codcli= Commandes.codcli;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

37 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete E04 : right join : Les clients ayant commandé et leurs commandes
PROMPT =========================================================
PROMPT
SELECT * FROM Clients right OUTER JOIN Commandes ON Clients.codcli= Commandes.codcli;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

28 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete E05 : Produit Cartésien (Le cas le plus général sans clause WHERE ; la jointure est un cas particulier)
PROMPT =========================================================
PROMPT
SELECT * FROM Clients, Commandes;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
532 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete E06 : Les dates des commandes des clients de PARIS
PROMPT =========================================================
PROMPT
SELECT Clients.codcli, Commandes.datcom
FROM Clients, Commandes
WHERE Clients.codcli=Commandes.codcli AND UPPER(Clients.vilcli)='PARIS';

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CODCLI DATCOM
------ ----------------------------
C007   MONDAY    14-MARCH    -2005

C010   FRIDAY    14-FEBRUARY -2003
C009   FRIDAY    14-FEBRUARY -2003
C007   FRIDAY    14-FEBRUARY -2003
C002   FRIDAY    14-FEBRUARY -2003
C002   FRIDAY    14-FEBRUARY -2003
C002   FRIDAY    14-FEBRUARY -2003
C002   TUESDAY   30-JANUARY  -2007
C002   TUESDAY   30-JANUARY  -2007

9 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete E07 : Les clients (Codes et Noms des clients) de Paris ayant commandé
PROMPT =========================================================
PROMPT
SELECT Clients.codcli, Clients.Nomcli
FROM Clients, Commandes
WHERE Clients.codcli=Commandes.codcli AND UPPER(Clients.vilcli)='PARIS';

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CODCLI NOMCLI
------ --------

C007   TRAIFOR
C010   TRAIFOR
C009   CLEMENCE
C007   TRAIFOR
C002   LESEUL
C002   LESEUL
C002   LESEUL
C002   LESEUL
C002   LESEUL

9 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete E08 : Les clients (Code des clients et Dates des commandes) de Paris ayant commandé
PROMPT =========================================================
PROMPT
SELECT t.codcli, datcom
FROM (SELECT * FROM Clients WHERE UPPER(vilcli)='PARIS') t, Commandes
WHERE t.codcli = Commandes.codcli;
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CODCLI DATCOM
------ ----------------------------

C007   MONDAY    14-MARCH    -2005
C010   FRIDAY    14-FEBRUARY -2003
C009   FRIDAY    14-FEBRUARY -2003
C007   FRIDAY    14-FEBRUARY -2003
C002   FRIDAY    14-FEBRUARY -2003
C002   FRIDAY    14-FEBRUARY -2003
C002   FRIDAY    14-FEBRUARY -2003
C002   TUESDAY   30-JANUARY  -2007
C002   TUESDAY   30-JANUARY  -2007

9 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete E09 :  Les clients (Code des clients et Dates des commandes) de Paris ayant commandé
PROMPT =========================================================
PROMPT
SELECT Clients.codcli,Commandes.datcom
FROM Commandes, Clients
WHERE Clients.codcli = Commandes.codcli AND UPPER(Clients.vilcli)='PARIS';

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CODCLI DATCOM

------ ----------------------------
C007   MONDAY    14-MARCH    -2005
C010   FRIDAY    14-FEBRUARY -2003
C009   FRIDAY    14-FEBRUARY -2003
C007   FRIDAY    14-FEBRUARY -2003
C002   FRIDAY    14-FEBRUARY -2003
C002   FRIDAY    14-FEBRUARY -2003
C002   FRIDAY    14-FEBRUARY -2003
C002   TUESDAY   30-JANUARY  -2007
C002   TUESDAY   30-JANUARY  -2007

9 rows selected.
*/

PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete E10 : Jointure & Ordre d’exécution des tables
PROMPT =========================================================
PROMPT

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

*/

-- =======================================================================
-- =======================================================================
-- =======================================================================

PROMPT =========================================================
PROMPT FB-F : Requêtes du type Fi (Calculs + Sous-Totaux + Unions + Intersections + Différences + Jointures)
PROMPT =========================================================
PROMPT


PROMPT =========================================================
PROMPT >> Requete F01 : Clients ayant commandé en septembre 2011
PROMPT =========================================================
PROMPT
SELECT Clients.codcli,Commandes.datcom
FROM Commandes, Clients
WHERE Clients.codcli = Commandes.codcli
AND TO_CHAR(Commandes.datcom,'YYYY')='2011'
AND TO_CHAR(Commandes.datcom,'MM')='09';

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
no rows selected
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete F02 :  Montant total des commandes de septembre 2011
PROMPT =========================================================
PROMPT
SELECT SUM(PUART*QTCOM) as total_cmd
FROM Commandes NATURAL JOIN Detailcom
WHERE TO_CHAR(Commandes.datcom,'YYYY')='2011'
AND TO_CHAR(Commandes.datcom,'MM')='09';


-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

TOTAL_CMD
----------
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete F03 : Commandes ayant des articles dont le prix vente est supérieur à 20 (Commande, Article, PV)
PROMPT =========================================================
PROMPT
SELECT NUMCOM,NomArt, PvArt
FROM Detailcom NATURAL JOIN Articles
WHERE PvArt >20;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
NUMCOM     NOMART                      PVART
---------- ------------------------- -------
20002AB    SIEGE DE TABLE              35.00
20052FB    SIEGE DE TABLE              35.00
20001AB    SIEGE DE TABLE              35.00
20012RB    PROTECTION DE FOUR          37.86
20055FB    PROTECTION DE FOUR          37.86
20056FB    BABY PHONE                  80.71
20055FB    BABY PHONE                  80.71
20001AB    HAUSSE-CHAISE               42.71
20052FB    HAUSSE-CHAISE               42.71
20031FB    BARRIERE DE PORTE, EN BOI   32.71
           S

20057FB    BARRIERE DE PORTE, EN BOI   32.71
           S

20055FB    BARRIERE DE PORTE, EN BOI   32.71
           S

20031FB    DVD-SPIRIT                  24.90
20051FB    DVD-SPIRIT                  24.90
20072FB    DVD-SPIRIT                  24.90
20003AB    DVD-SPIRIT                  24.90

20181AB    DVD-SPIRIT                  24.90
20073FB    DVD-SPIRIT                  24.90
20070FB    DVD-SPIRIT                  24.90
20069FB    DVD-SPIRIT                  24.90
20068FB    DVD-SPIRIT                  24.90
20067FB    DVD-SPIRIT                  24.90
20074FB    DVD-SPIRIT                  24.90
20071FB    DVD-SPIRIT                  24.90
20012RB    DVD-SPIDER MAN 2            24.90
20066FB    DVD-SPIDER MAN 2            24.90
20065FB    DVD-SPIDER MAN 2            24.90
20062FB    DVD-SPIDER MAN 2            24.90
20061FB    DVD-SPIDER MAN 2            24.90
20001AB    K7 VIDEO-TOY STORY          21.29
20052FB    K7 VIDEO-TOY STORY          21.29
20004AB    K7 VIDEO-TOY STORY          21.29
20002AB    K7 VIDEO-TOY STORY          21.29
20002AB    DVD-TOY STORY 2             34.29
20003AB    DVD-TOY STORY 2             34.29
20053FB    K7 VIDEO-WINNIE L OURSON    22.86
20054FB    K7 VIDEO-WINNIE L OURSON    22.86
20002AB    K7 VIDEO-WINNIE L OURSON    22.86
20003AB    K7 VIDEO-WINNIE L OURSON    22.86
20052FB    K7 VIDEO-WINNIE L OURSON    22.86

40 rows selected.

*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete F04 : Commandes ayant des articles dont le prix vente est supérieur à 20 (Commande, Nombre)
PROMPT =========================================================
PROMPT
SELECT NUMCOM,COUNT(REFART) as nombre
FROM Detailcom NATURAL JOIN Articles
WHERE PvArt >20 GROUP BY NUMCOM ;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
NUMCOM         NOMBRE
---------- ----------
20056FB             1

20031FB             2
20003AB             3
20068FB             1
20067FB             1
20074FB             1
20054FB             1
20001AB             3
20073FB             1
20070FB             1
20051FB             1
20069FB             1
20066FB             1
20062FB             1
20061FB             1
20002AB             4
20072FB             1
20071FB             1
20004AB             1
20052FB             4
20012RB             2
20181AB             1
20053FB             1
20055FB             3
20057FB             1
20065FB             1
26 rows selected.
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete F05 : Commandes ayant 4 articles dont le prix vente est supérieur à 20
PROMPT =========================================================
PROMPT
SELECT NUMCOM,COUNT(REFART) as nombre
FROM Detailcom NATURAL JOIN Articles
WHERE PvArt >20
GROUP BY NUMCOM
HAVING COUNT(REFART) = 4;


-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
NUMCOM         NOMBRE
---------- ----------
20002AB             4
20052FB             4

*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete F06 : Les clients de paris qui n’ont pas commandé en octobre 2011
PROMPT =========================================================
PROMPT
SELECT CODCLI,NOMCLI,PRENCLI
FROM clients WHERE CODCLI NOT IN (
  SELECT Clients.codcli
  FROM Commandes, Clients
  WHERE Clients.codcli = Commandes.codcli
  AND TO_CHAR(Commandes.datcom,'YYYY')='2011'
  AND TO_CHAR(Commandes.datcom,'MM')='10'
);

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CODCLI NOMCLI   PRENCLI
------ -------- --------
C003   UNIQUE   MARINE
C017   RAHYM    KARYM

C019   GENIE    GENIALE
C009   CLEMENCE ALEXANDR
                E

C008   VIVANT   JEAN-BAP
                TISTE

C004   CLEMENCE EVELYNE
C013   FORT     GABRIEL
C006   LE BON   CLEMENCE
C005   FORT     JEANNE
C018   GENIE    ADAM
C014   ADAM     DAVID
C007   TRAIFOR  ALICE
C010   TRAIFOR  ALEXANDR
                E

C002   LESEUL   M@RIE
C016   obsolete kadym
C015   Labsent  pala
C011   PREMIER  JOS//EPH
C012   CLEMENT  ADAM
C001   CLEM@ENT EVE

19 rows selected.

*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete F07 : Les clients de paris ou ceux ayant commandé en octobre 2011
PROMPT =========================================================
PROMPT
SELECT CODCLI,NOMCLI,PRENCLI,VILCLI
FROM clients
WHERE UPPER(VILCLI)='PARIS'
OR
CODCLI IN (
  SELECT Clients.codcli
  FROM Commandes, Clients
  WHERE Clients.codcli = Commandes.codcli
  AND TO_CHAR(Commandes.datcom,'YYYY')='2011'
  AND TO_CHAR(Commandes.datcom,'MM')='10'
);

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

CODCLI NOMCLI   PRENCLI  VILCLI
------ -------- -------- ------
C002   LESEUL   M@RIE    PARIS
C007   TRAIFOR  ALICE    PARIS
C009   CLEMENCE ALEXANDR PaRiS
                E

C010   TRAIFOR  ALEXANDR PARIS
                E

C019   GENIE    GENIALE  PARIS
*/
-- =======================================================================
-- =======================================================================
-- =======================================================================
PROMPT =========================================================
PROMPT FB-G : Requêtes du type Gi (Divisions)
PROMPT =========================================================
PROMPT


PROMPT =========================================================
PROMPT >> Requete G01 : Les articles qui figurent sur toutes les commandes !
PROMPT =========================================================
PROMPT
-- DECLARE
-- BEGIN
--   FOR i in (select distinct(NUMCOM) from Detailcom )
--   LOOP
--     select
--   END LOOP;
-- END;
-- /
-- SELECT numcom, REFART ,COUNT(*) FROM Detailcom  group by numcom,REFART;
-- SELECT REFART FROM Articles INTERSECT SELECT REFART FROM Detailcom;
--  NATURAL JOIN Detailcom;

/*SELECT REFART, NomArt
FROM Articles NATURAL JOIN Detailcom
*/

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*


*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete G02 :  Articles commandés par tous les parisiens
PROMPT =========================================================
PROMPT
SELECT	REFART, NOMART
FROM	ARTICLES
WHERE	EXISTS
	(SELECT *
	 FROM	CLIENTS
	 WHERE	UPPER(VilCli) = 'PARIS'
	 AND	EXISTS
		(SELECT *
		 FROM	COMMANDES, DETAILCOM
		 WHERE	COMMANDES.NUMCOM = DETAILCOM.NUMCOM
		 AND	DETAILCOM.REFART = ARTICLES.REFART
		 AND	COMMANDES.CODCLI = CLIENTS.CODCLI));

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

REFART   NOMART
-------- -------------------------
FB.001   DVD-SPIRIT
WD.003   K7 VIDEO-WINNIE L OURSON
FB.003   DVD-SPIDER MAN 2

Elapsed: 00:00:00.01
*/
PROMPT
pause Tapez sur Enter...
PROMPT

PROMPT =========================================================
PROMPT >> Requete G03 : Les articles qui figurent sur toutes les commandes d’une période donnée !
PROMPT =========================================================
PROMPT
-- SELECT

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*


*/

-- =======================================================================
-- =======================================================================
-- =======================================================================
PROMPT =========================================================
PROMPT FB-H : Requêtes du type Hi (SQL Avancé, SQL pour le multidimensionnel)
PROMPT =========================================================
PROMPT

PROMPT =========================================================
PROMPT >> Requete H01 : Nombre de clients
PROMPT =========================================================
PROMPT

SELECT COUNT(*) AS nbclients FROM Clients;
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
NBCLIENTS
----------
       19

*/
PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete H02 : Nombre de pays
PROMPT =========================================================
PROMPT

SELECT COUNT(distinct(PaysCli)) AS NbrPays FROM Clients;
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

   NBRPAYS
----------
         6

*/
PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete H03 : Nombre de clients par catégorie
PROMPT =========================================================
PROMPT


SELECT CatCli AS Categorie, COUNT(*) AS NbrCli FROM Clients GROUP BY CatCli;
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*


 CATEGORIE     NBRCLI
---------- ----------
         1          7
         2          4
         5          2
         3          4
         7          2

Elapsed: 00:00:00.00
*/
PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete H04 : Nombre de clients par catégorie et par ville
PROMPT =========================================================
PROMPT
SELECT catcli, vilcli, COUNT(*) as NbrCli FROM Clients GROUP BY catcli,vilcli;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CATCLI VILCLI     NBRCLI
------ ------ ----------
     2 PARIS           1
     1 PaRiS           1
     2 MARCHE          2
       ILLE

     3 PARIS           1
     7 BAGDAD          1
     3 EPINAY          1
       -SUR-S
       EINE

     1 EPINAY          2
       -SUR-S
       EINE

     2 VILLET          1
       ANEUSE

     1 CARTHA          1
       GE

     1 PARIS           2
     3 ORLY-V          1
       ILLE

     5 ROME            1
     7 CARTHA          1
       GE

     5 TUNIS           1
     1 EPINAY          1
       -SUR-O
       RGE

     3 EPINAY          1
        SUR S
       EINE


16 rows selected.

*/
PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete H05 : Nombre de clients par ville et par catégorie
PROMPT =========================================================
PROMPT
select vilcli as ville, catcli as categorie, count(*) as NbrCli from Clients
group by vilcli, catcli;

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
VILLE                 CATEGORIE       NBCV
-------------------- ---------- ----------
EPINAY-SUR-SEINE              3          1
CARTHAGE                      1          1
CARTHAGE                      7          1
PARIS                         3          1
EPINAY-SUR-ORGE               1          1
EPINAY SUR SEINE              3          1
ORLY-VILLE                    3          1
PARIS                         2          1
PaRiS                         1          1
PARIS                         1          2
ROME                          5          1
VILLETANEUSE                  2          1
MARCHEILLE                    2          2
EPINAY-SUR-SEINE              1          2
TUNIS                         5          1
BAGDAD                        7          1

*/
PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete H06 : Nombre de clients par catégorie et par ville : fonction CUBE
PROMPT =========================================================
PROMPT
select catcli as categorie, vilcli as ville, count(*) as nbcv from Clients
group by CUBE(catcli, vilcli);
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*

CATEGORIE VILLE                      NBCV
---------- -------------------- ----------
                                        19
           ROME                          1
           PARIS                         4
           PaRiS                         1
           TUNIS                         1
           BAGDAD                        1
           CARTHAGE                      2
           MARCHEILLE                    2
           ORLY-VILLE                    1
           VILLETANEUSE                  1
           EPINAY-SUR-ORGE               1
           EPINAY SUR SEINE              1
           EPINAY-SUR-SEINE              3
         1                               7
         1 PARIS                         2
         1 PaRiS                         1
         1 CARTHAGE                      1
         1 EPINAY-SUR-ORGE               1
         1 EPINAY-SUR-SEINE              2
         2                               4
         2 PARIS                         1
         2 MARCHEILLE                    2
         2 VILLETANEUSE                  1
         3                               4
         3 PARIS                         1
         3 ORLY-VILLE                    1
         3 EPINAY SUR SEINE              1
         3 EPINAY-SUR-SEINE              1
         5                               2
         5 ROME                          1
         5 TUNIS                         1
         7                               2
         7 BAGDAD                        1
         7 CARTHAGE                      1

34 rows selected.
*/
PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete H07 : Nombre de clients par catégorie et par ville : fonction ROLLUP
PROMPT =========================================================
PROMPT

select catcli as categorie, vilcli as ville, count(*) as nbcv from Clients
group by ROLLUP(catcli, vilcli);
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*
CATEGORIE VILLE                      NBCV
---------- -------------------- ----------
         1 PARIS                         2
         1 PaRiS                         1
         1 CARTHAGE                      1
         1 EPINAY-SUR-ORGE               1
         1 EPINAY-SUR-SEINE              2
         1                               7
         2 PARIS                         1
         2 MARCHEILLE                    2
         2 VILLETANEUSE                  1
         2                               4
         3 PARIS                         1
         3 ORLY-VILLE                    1
         3 EPINAY SUR SEINE              1
         3 EPINAY-SUR-SEINE              1
         3                               4
         5 ROME                          1
         5 TUNIS                         1
         5                               2
         7 BAGDAD                        1
         7 CARTHAGE                      1
         7                               2
                                        19

22 rows selected.

*/
PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete H08 : Classez les clients par ordre décroissant du chiffre d’affaires CA
PROMPT =========================================================
PROMPT

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*


*/
PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete H09 : Classez les clients par ordre décroissant du CA, donnez le rang
PROMPT =========================================================
PROMPT
/*
select (select count(*)+1 from cli C2 where C1.cacli<C2.cacli) as rang,
cacli, codcli, nomcli, catcli, vilcli, paycli
from cli C1
order by rang;*/
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*


*/
PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete H10 : Classez les clients par ordre décroissant du CA, donnez le rang : RANK() OVER…
PROMPT =========================================================
PROMPT
/*
select rank() over(order by cacli desc) as rang,
cacli, codcli, nomcli, catcli, vilcli, paycli
from cli;*/
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*


*/
PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete H11 : Clients par ordre décroissant du CA et de la catégorie, donnez le rang
PROMPT =========================================================
PROMPT

/*select rank() over (order by cacli desc, catcli desc) as rang,
cacli, codcli, nomcli, catcli, vilcli, paycli
from cli;*/

-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*


*/
PROMPT
pause Tapez sur Enter...
PROMPT


PROMPT =========================================================
PROMPT >> Requete H12 : Clients par ordre décroissant du CA et de la catégorie, donnez le rang
PROMPT =========================================================
PROMPT
/*select count(C2.cacli) as rang,
C1.cacli, C1.codecli, C1.nomcli, C1.catcli, C1.vilcli, C1.paycli
from cli C1, cli C2
where C1.cacli <= C2.cacli or (C1.cacli=C2.cacli and C1.catcli=C2.catcli)
group by C1.catcli, C1.cacli, C1.codecli, C1.nomcli, C1.vilcli, C1.paycli
order by C1.cacli desc, C1.catcli desc;*/
-- >>>>>>>>>>>>>>>>>>>>>>>>>> -- Résultat généré:
/*


*/
