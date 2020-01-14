------------------------------------------------------------------------+
---------           Groupe          :  13                ---------------|
---------           Nom             :  TEKAM LUDOVIK     ---------------|
---------           Numéro étudiant :  11706765          ---------------|
------------------------------------------------------------------------+

--- dans la première version que je vous ai envoyé le Jeudi 3/10/19 j'avais déja redige la procédure qui permet de filtrer une table quelque soit la colonne
--- dans cette version j'ai rajouter une fonctionalité qui permet de filtrer quelque soit la table et la colonne passer en paramètres

--- il y a deux PROCEDURES dans ce fichier
--- + RECHERCHEAVANCEE() : qui permet de faire les requête A20-A30
--- + RECHERCHEAVANCEE_GLOBAL() : qui permet de faire la requête A40 quelque soit les colonnes et quelques soit la table

--- j'ai mit quelque resultats à la finc de ce fichier
--- vous pouvez executer les procedures suivantes pour faire les teste
/*
EXEC RECHERCHEAVANCEE('clients','KeyWordsCli','FooTBALL/MAnGA',4,'myview');
EXEC RECHERCHEAVANCEE('clients','KeyWordsCli','FooTBALL',5,'myview');

EXEC RECHERCHEAVANCEE('clients','KeyWordsCli','FooTBALL*Voyages*BasketBall',4,'myview');
EXEC RECHERCHEAVANCEE('clients','KeyWordsCli','FooTBALL+Voyages+BasketBall',4,'myview');
EXEC RECHERCHEAVANCEE('clients','KeyWordsCli','FooTBALL/Voyages/BasketBall',4,'myview');

EXEC RECHERCHEAVANCEE('clients','KeyWordsCli','Paris',4,'myview');
EXEC RECHERCHEAVANCEE_GLOBAL('clients','Paris',4,'myview');
*/

set serveroutput on
SET TIMING ON;
SET LINES 1000
SET PAGES 1000
COLUMN CODCLI         FORMAT A6
COLUMN CIVCLI         FORMAT A8
COLUMN NOMCLI         FORMAT A8
COLUMN PRENCLI        FORMAT A8
COLUMN CATCLI         FORMAT 99
COLUMN ADNCLI         FORMAT A6
COLUMN ADRCLI         FORMAT A10
COLUMN CPCLI          FORMAT A5
COLUMN VilCli         FORMAT A10
COLUMN PAYSCLI        FORMAT A7
COLUMN MAILCLI        FORMAT A10
COLUMN TELCLI         FORMAT A12
COLUMN KEYWORDSCLI    FORMAT A20


---------------------------------------------------------------------------------------------------------------------+
---------------------------- getDelimiterType(MotsCles in VARCHAR2, operator OUT VARCHAR2, nbr_mot OUT NUMBER)       |
---------------------------------------------------------------------------------------------------------------------+
--- cette fonction prend en paramètre une chaîne de caractére et retourne
-- + le delimiter contenue dans la chaîne
-- + l'opérateur corespondant à la chaîne
-- + le nombre de delimiter (nbr_mot) contenue dans la chaîne
CREATE OR REPLACE FUNCTION getDelimiterType(MotsCles in VARCHAR2, operator OUT VARCHAR2, nbr_mot OUT NUMBER)
RETURN VARCHAR2
AS
delimiter VARCHAR2(5);
BEGIN
  delimiter := '\*';
  operator := 'AND';
  select REGEXP_COUNT(MotsCles, delimiter) into nbr_mot from dual;
  IF nbr_mot<=0 THEN
    delimiter := '\+';
    operator := 'OR';
    select REGEXP_COUNT(MotsCles, delimiter) into nbr_mot from dual;
    IF nbr_mot<=0 THEN
      delimiter := '/';
      operator := 'XOR';
      select REGEXP_COUNT(MotsCles, delimiter) into nbr_mot from dual;
      IF nbr_mot<=0 THEN
        nbr_mot:=0;
        operator := null;
        delimiter :=null;
      END IF;
    END IF;
  END IF;
  RETURN(delimiter);
END;
/

-------------------------------------------------------------------------------------------------------------------------------------+
-- RECHERCHEAVANCEE(LaTable in VARCHAR2, LaColonne in VARCHAR2, MotsCles in VARCHAR2, Seuil in NUMBER, LaVueResultante in VARCHAR2)  |
-------------------------------------------------------------------------------------------------------------------------------------+
-- +LaTable : nom de la table sur laquel la recherche sera lancer
-- +LaColonne : nom de la colonnne qui devra verifier les conditions
-- +MotsCles : liste de mot cles recherché
-- +Seuil : nombre de caractére à prendre en compte lors de la recherche (ex : MotsCles = FooTBALL Seuil = 4 ==> MotsCles = FooT )
-- +LaVueResultante : nom de la vue qui contiendra le resultats de la recherche

--- methode de résolution :
--- je construi la requêtes adapter en fonction de l'opérateur (*,+,/) contenue dans le MotsCles
--- Affichage des résultats : vue que je ne connais pas les colonnes qui seront affichées,
--- je vais simplement créer une vue dans laquelle les résultats seront stocké
--- l'avantage est que le resultats pourras être reutiliser ou filtre a nouveau
--- donc pour afficher les resultats il suffit de faire un select sur la vue passer en parametre

CREATE OR REPLACE PROCEDURE RECHERCHEAVANCEE(LaTable in VARCHAR2, LaColonne in VARCHAR2, MotsCles in VARCHAR2, Seuil in NUMBER, LaVueResultante in VARCHAR2) AS
myQuery VARCHAR2(500);
where_conditions VARCHAR2(500);
where_conditions_or VARCHAR2(500);
where_conditions_and VARCHAR2(500);

nbr_mot NUMBER;
delimiter VARCHAR2(20);
operator VARCHAR2(20);

first_itration NUMBER;
BEGIN

--- ici je determine le délimiteur de mot, l'opérateur associer et le le nombre de mots
delimiter := getDelimiterType(MotsCles, operator, nbr_mot);
------------------
--- ici je découpe ma chaine en fonction du délimiteur
-- trim() : permet de supprimer les éventuelles espaces situent au début ou à la fin d'un mot
-- substr(): permet de découper la chaîne en fonction du Seuil fixer
-- upper(): pour s'assure que tout les mots auront le mme formart en sortie

--- cas particulier : un seul mot cles, donc il suffit de faire un like %xxx% tout en s'assurant que le mot est bien en majuscule
IF nbr_mot = 0 THEN
  where_conditions := ' UPPER ('||LaColonne||') like ''%'||UPPER(substr(trim(MotsCles),0,Seuil))||'%''';
  where_conditions := ' where (REGEXP_LIKE ('||LaColonne||', ''[A-Z]+'')) AND (' ||where_conditions|| ')';
END IF;

--- cas générale, on a plusieurs mots
IF nbr_mot > 0 THEN
  first_itration := 0;
  FOR i IN
  (SELECT upper(substr((trim(regexp_substr(MotsCles, '[^'||delimiter||']+', 1, LEVEL))) , 0,Seuil)) mot
  FROM dual
  CONNECT BY LEVEL <= nbr_mot +1)
  -- on peut remplacer nbr_mot par regexp_count(MotsCles, delimiter) +1
  LOOP
  --- je definie les conditions de ma requête en fonction des opérateurs
    IF first_itration = 0 THEN
      where_conditions := where_conditions || ' UPPER ('||LaColonne||') like ''%'||i.mot||'%''';
      where_conditions_or := where_conditions;
      where_conditions_and := where_conditions;
      first_itration := 1;
    ELSE
      where_conditions := where_conditions || operator || ' UPPER ('||LaColonne||') like ''%'||i.mot||'%''';
      where_conditions_or := where_conditions_or || ' OR UPPER ('||LaColonne||') like ''%'||i.mot||'%''';
      where_conditions_and := where_conditions_and || ' AND UPPER ('||LaColonne||') like ''%'||i.mot||'%''';

    END IF;

  END LOOP;
  IF operator = 'XOR' THEN
    where_conditions := ' where (REGEXP_LIKE ('||LaColonne||', ''[A-Z]+'')) AND (('|| where_conditions_or ||') AND NOT ('|| where_conditions_and ||'))';
  ELSE
    --- on pourais rajouté des if pour operator = 'OR' ou operator = 'AND'
    --- mais ce n'ai pas necessaire car where_conditions regoupe le AND et le OR
    --- l'idéale aurais été d'avoir un operateur XOR Mais d'aprés mes recherche cette opérateur n'existe pas
    where_conditions := ' where (REGEXP_LIKE ('||LaColonne||', ''[A-Z]+'')) AND (' ||where_conditions|| ')';
  END IF;

END IF;

--- je redige ma requête
myQuery := ' SELECT * FROM '|| LaTable || where_conditions;
-- je crée une vue et j'y met le resultats de ma requêtes
EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW  '||LaVueResultante||' AS '||myQuery;

END;
/


-------------------------------------------------------------------------------------------------+
---------- RECHERCHEAVANCEE_GLOBAL (LaTable in VARCHAR2, MotsCles in VARCHAR2, Seuil in NUMBER)  |
-------------------------------------------------------------------------------------------------+
--- methode de résolution :
--- je récupére les colonnes de la table passe en paramètres
--- puis je fais une boucle sur la liste de colonnes récupérée et j'appelle la fonction
--- RECHERCHEAVANCEE(), qui pour chaque colonne crée une vue de la table  qui contient les lignes qui verifier
--- les mots clés passer en paramètres

CREATE OR REPLACE PROCEDURE RECHERCHEAVANCEE_GLOBAL(LaTable in VARCHAR2, MotsCles in VARCHAR2, Seuil in NUMBER) AS
table_cursor SYS_REFCURSOR;
myQuery VARCHAR2(500);
selected_values VARCHAR2(500);
where_conditions VARCHAR2(500);

mycolname VARCHAR2(60);
myview VARCHAR2(60);
BEGIN
--- cette requête permet de récupérer les colonnes qu'une table passer en paramètres
selected_values := ' COLUMN_NAME ';
where_conditions := ' where table_name = '''||upper(LaTable)||''' AND DATA_TYPE = ''VARCHAR2''';
myQuery := 'SELECT '|| selected_values ||' FROM user_tab_columns'|| where_conditions;

--- pour chaque colonne récupérée, je lance la recherche
--- donc pour chaque colonne on auras une vue qui sera créeé
open table_cursor for myQuery;
  loop
    fetch table_cursor into mycolname ;
    EXIT when table_cursor%NOTFOUND;
    DBMS_OUTPUT.put_line ('------> COLUMN_NAME :   '||mycolname);
    myview := 'myview_'||LaTable||'_'||mycolname;
    RECHERCHEAVANCEE(LaTable,mycolname,MotsCles,4,myview);
    DBMS_OUTPUT.put_line ('----------------------------------------------------');
  end loop;
close table_cursor;
END;
/

-------------------------------------------------------------------------------------------------+
---------- EXEMPLE  ---------- EXEMPLE  ---------- EXEMPLE  ---------- EXEMPLE                   |
-------------------------------------------------------------------------------------------------+


--A22. Les client.e.s qui aiment soit le football soit les mangas mais pas les deux ensemble (le ou exclusif : football / mangas)
PROMPT
Pause Tapez sur Enter...
PROMPT
EXEC RECHERCHEAVANCEE('clients','KeyWordsCli','FooTBALL/MAnGA',4,'myview');
select * from myview;
/*
CODCLI CIVCLI   NOMCLI   PRENCLI  CATCLI ADNCLI ADRCLI     CPCLI VILCLI     PAYSCLI MAILCLI    TELCLI       KEYWORDSCLI
------ -------- -------- -------- ------ ------ ---------- ----- ---------- ------- ---------- ------------ --------------------
C001   Madame   CLEM@ENT EVE           1 18     BOULEVARD  91000 EPINAY-SUR FRANCE  eve.clemen +33777889911 Voyages, Mangas, Bas
                                                FOCH             -ORGE              t@gmail.co              ketBall, Musique
                                                                                    m

C007   Mademois TRAIFOR  ALICE         2 6      RUE DE LA  75015 PARIS      FRANCE  alice.trai +33777889966 Bandes Dessinees, fo

       elle                                     ROSIERE                             for@yahoo.              otball , Musique, Ha
                                                                                    fr                      ndball, Voyages

C008   Monsieur VIVANT   JEAN-BAP      1 13     RUE DE LA  93800 EPINAY-SUR FRANCE  jeanbaptis 0607         Handball, football,
                         TISTE                  PAIX             -SEINE             te@                     BasketBall

C010   Monsieur TRAIFOR  ALEXANDR      1 16     AVENUE FOC 75016 PARIS      FRA     alexandre. 06070809     Handball, Theatre, V
                         E                      H                                   traifor@up              oyages, FOOTBALL
                                                                                    13.fr

C011   Monsieur PREMIER  JOS//EPH      2 77     RUE DE LA  13001 MARCHEILLE FRANCE  josef@prem +33777889977 Voyages, Mangas
                                                LIBERTE                             ier

C017   Madame   RAHYM    KARYM         1 1      RUE DES GE 1000  CARTHAGE   TUNISIE karym.rahy +21624808444 Plongee sous marine,
                                                NTILS                               m@gmail.co               Voyages, Plongee so
                                                                                    m                       us marine, FOOTBALL,
                                                                                                             Cinema


6 lignes s�lectionn�es.
*/

-----------------------------------------------------------------------------------------------------------------------------------


--A21. Les client.e.s qui aiment le football ou les mangas (soit le football soit les mangas, un seul suffit : football + mangas)
PROMPT
Pause Tapez sur Enter...
PROMPT
EXEC RECHERCHEAVANCEE('clients','KeyWordsCli','FooTBALL+MAnGA',4,'myview');
select * from myview;

/*
CODCLI CIVCLI   NOMCLI   PRENCLI  CATCLI ADNCLI ADRCLI     CPCLI VILCLI     PAYSCLI MAILCLI    TELCLI       KEYWORDSCLI
------ -------- -------- -------- ------ ------ ---------- ----- ---------- ------- ---------- ------------ --------------------
C001   Madame   CLEM@ENT EVE           1 18     BOULEVARD  91000 EPINAY-SUR FRANCE  eve.clemen +33777889911 Voyages, Mangas, Bas
                                                FOCH             -ORGE              t@gmail.co              ketBall, Musique
                                                                                    m


C003   Madame   UNIQUE   MARINE        2 77     RUE DE LA  13001 MARCHEILLE FRANCE  munique@gm +33777889922 Cinema, football, Yo
                                                LIBERTE                             ail.com                 ga, Mangas

C004   Madame   CLEMENCE EVELYNE       3 8 BIS  BOULEVARD  93800 EPINAY-SUR FRANCE  clemence e +33777889933 Mangas, football , T
                                                FOCH             -SEINE             velyne@gma              heatre, Cinema, Musi
                                                                                    il.com                  que, Plongee sous ma
                                                                                                            rine

C005   Madame   FORT     JEANNE        3 55     RUE DU JAP 94310 ORLY-VILLE FRANCE  jfort\@hot +33777889944 Bandes Dessinees, Ha
                                                ON                                  mail.fr                 ndball, Musique, Man
                                                                                                            ga, foot, BasketBall

C006   Mademois LE BON   CLEMENCE      1 18     BOULEVARD  93800 EPINAY-SUR FRANCE  clemence.l 003377788995 Plongee sous marine,
       elle                                     FOCH             -SEINE             e bon@cfo. 5             Mangas, Cinema, FOO
                                                                                    fr                      TBALL

C007   Mademois TRAIFOR  ALICE         2 6      RUE DE LA  75015 PARIS      FRANCE  alice.trai +33777889966 Bandes Dessinees, fo
       elle                                     ROSIERE                             for@yahoo.              otball , Musique, Ha
                                                                                    fr                      ndball, Voyages
C008   Monsieur VIVANT   JEAN-BAP      1 13     RUE DE LA  93800 EPINAY-SUR FRANCE  jeanbaptis 0607         Handball, football,
                         TISTE                  PAIX             -SEINE             te@                     BasketBall

C010   Monsieur TRAIFOR  ALEXANDR      1 16     AVENUE FOC 75016 PARIS      FRA     alexandre. 06070809     Handball, Theatre, V
                         E                      H                                   traifor@up              oyages, FOOTBALL
                                                                                    13.fr

C011   Monsieur PREMIER  JOS//EPH      2 77     RUE DE LA  13001 MARCHEILLE FRANCE  josef@prem +33777889977 Voyages, Mangas

                                                LIBERTE                             ier

C012   Monsieur CLEMENT  ADAM          2 13     AVENUE JEA 9430  VILLETANEU FRANCE  adam.cleme +33149404072 Voyages, FOOTBALL, B
                                                N BAPTISTE       SE                 nt@gmail.c              asketBall, Mangas
                                                 CLEMENT                            om

C014   Monsieur ADAM     DAVID         5 1      AVENUE DE  99001 ROME       ITALIE  david.adam              Foot, Natation, Mang
                                                ROME                                é@gmail c               as, Cinema
                                                                                    om

C015   Monsieur Labsent  pala          7 1      rue des ab 000   BAGDAD     IRAQ    pala-labse              FootBALL, Natation,
                                                sents                               nt@paici                Mangas, Cinema

C017   Madame   RAHYM    KARYM         1 1      RUE DES GE 1000  CARTHAGE   TUNISIE karym.rahy +21624808444 Plongee sous marine,
                                                NTILS                               m@gmail.co               Voyages, Plongee so
                                                                                    m                       us marine, FOOTBALL,
                                                                                                             Cinema

C018   Madame   GENIE    ADAM          3 8      BOULEVARD  93800 EPINAY SUR FRANCE  adam.géni +33777889911 FootBALL, Natation,
                                                FOCH              SEINE             e@gmail.co              Mangas, Cinema
14 lignes s�lectionn�es.
*/
-----------------------------------------------------------------------------------------------------------------------------------


--A20. Les client.e.s qui aiment le football et les mangas (les deux obligatoirement : football * mangas)
PROMPT
Pause Tapez sur Enter...
PROMPT
EXEC RECHERCHEAVANCEE('clients','KeyWordsCli','FooTBALL*MAnGA',4,'myview');
select * from myview;

/*
CODCLI CIVCLI   NOMCLI   PRENCLI  CATCLI ADNCLI ADRCLI     CPCLI VILCLI     PAYSCLI MAILCLI    TELCLI       KEYWORDSCLI
------ -------- -------- -------- ------ ------ ---------- ----- ---------- ------- ---------- ------------ --------------------
C003   Madame   UNIQUE   MARINE        2 77     RUE DE LA  13001 MARCHEILLE FRANCE  munique@gm +33777889922 Cinema, football, Yo
                                                LIBERTE                             ail.com                 ga, Mangas

C004   Madame   CLEMENCE EVELYNE       3 8 BIS  BOULEVARD  93800 EPINAY-SUR FRANCE  clemence e +33777889933 Mangas, football , T
                                                FOCH             -SEINE             velyne@gma              heatre, Cinema, Musi
                                                                                    il.com                  que, Plongee sous ma

                                                                                                            rine

C005   Madame   FORT     JEANNE        3 55     RUE DU JAP 94310 ORLY-VILLE FRANCE  jfort\@hot +33777889944 Bandes Dessinees, Ha
                                                ON                                  mail.fr                 ndball, Musique, Man
                                                                                                            ga, foot, BasketBall

C006   Mademois LE BON   CLEMENCE      1 18     BOULEVARD  93800 EPINAY-SUR FRANCE  clemence.l 003377788995 Plongee sous marine,
       elle                                     FOCH             -SEINE             e bon@cfo. 5             Mangas, Cinema, FOO
                                                                                    fr                      TBALL

C012   Monsieur CLEMENT  ADAM          2 13     AVENUE JEA 9430  VILLETANEU FRANCE  adam.cleme +33149404072 Voyages, FOOTBALL, B
                                                N BAPTISTE       SE                 nt@gmail.c              asketBall, Mangas
                                                 CLEMENT                            om

C014   Monsieur ADAM     DAVID         5 1      AVENUE DE  99001 ROME       ITALIE  david.adam              Foot, Natation, Mang
                                                ROME                                é@gmail c               as, Cinema
                                                                                    om

C015   Monsieur Labsent  pala          7 1      rue des ab 000   BAGDAD     IRAQ    pala-labse              FootBALL, Natation,
                                                sents                               nt@paici                Mangas, Cinema
  C018   Madame   GENIE    ADAM          3 8      BOULEVARD  93800 EPINAY SUR FRANCE  adam.géni +33777889911 FootBALL, Natation,
                                                  FOCH              SEINE             e@gmail.co              Mangas, Cinema
                                                                                      m



  8 lignes s�lectionn�es.
*/

-----------------------------------------------------------------------------------------------------------------------------------


---A30. Les client.e.s qui aiment (*) :  Voyages, FOOTBALL, BasketBall (-->>>  Voyages * FOOTBALL * BasketBall)
PROMPT
Pause Tapez sur Enter...
PROMPT
EXEC RECHERCHEAVANCEE('clients','KeyWordsCli','FooTBALL*Voyages*BasketBall',4,'myview');
select * from myview;


-----------------------------------------------------------------------------------------------------------------------------------

--A30. Les client.e.s qui aiment (+) :  Voyages, FOOTBALL, BasketBall (-->>>  Voyages + FOOTBALL + BasketBall)
PROMPT
Pause Tapez sur Enter...
PROMPT
EXEC RECHERCHEAVANCEE('clients','KeyWordsCli','FooTBALL+Voyages+BasketBall',4,'myview');
select * from myview;


-----------------------------------------------------------------------------------------------------------------------------------

--- A30. Les client.e.s qui aiment (/) :  Voyages, FOOTBALL, BasketBall (-->>>  Voyages / FOOTBALL / BasketBall)
PROMPT
Pause Tapez sur Enter...
PROMPT
EXEC RECHERCHEAVANCEE('clients','KeyWordsCli','FooTBALL/Voyages/BasketBall',4,'myview');
select * from myview;


-----------------------------------------------------------------------------------------------------------------------------------

--EXEC RECHERCHEAVANCEE('clients','KeyWordsCli','Paris',4,'myview')
--select * from myview;


-----------------------------------------------------------------------------------------------------------------------------------

--- A40. Les client.e.s pour lesquels le mots Paris est cité (cela peut être le nom ou le Prénom ou la ville ou encore les mots clés; on ne sait pas!)
PROMPT
Pause Tapez sur Enter...
PROMPT
EXEC RECHERCHEAVANCEE_GLOBAL('clients','Paris',4)
select * from myview_clients_CODCLI;
select * from myview_clients_CIVCLI;
select * from myview_clients_NOMCLI;
select * from myview_clients_PRENCLI;
select * from myview_clients_CATCLI;
select * from myview_clients_ADNCLI;
select * from myview_clients_ADRCLI;
select * from myview_clients_CPCLI;
select * from myview_clients_VILCLI;
select * from myview_clients_PAYSCLI;
select * from myview_clients_MAILCLI;
select * from myview_clients_TELCLI;
select * from myview_clients_KEYWORDSCLI;
