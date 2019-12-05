DROP TABLE TABCLIDS ;

CREATE TABLE TABCLIDS (COL1 VARCHAR2(10), COL2 VARCHAR2(12), COL3 VARCHAR2(10), COL4 VARCHAR2(10), COL5 VARCHAR2(1));

INSERT INTO TABCLIDS VALUES ('2994570', 'Madame', 'RAHMA', 'CLEMENCE', '3');
INSERT INTO TABCLIDS VALUES ('2996100', 'Monsieur', 'CLEMENCE', 'ALEXANDRE', '1');
INSERT INTO TABCLIDS VALUES ('3000107', 'MO�NSIEUR', 'ONRI', 'PANDA', '2');
INSERT INTO TABCLIDS VALUES ('2997777', 'Mademoiselle', 'LE BON', 'CLEMENTINE', '1');
INSERT INTO TABCLIDS VALUES ('299PPPP', 'Mlle', 'BON', 'CLEMENTINE', '1');
INSERT INTO TABCLIDS VALUES ('2997007', 'Monsieur', 'TRAIFOR', 'ADAM', '2');
INSERT INTO TABCLIDS VALUES ('2998500', 'Monsieur', 'CHEVALIER', 'INES', '1');
INSERT INTO TABCLIDS VALUES ('3000106', 'Monsieur', 'HARISSA', 'FORD', '1');
INSERT INTO TABCLIDS VALUES ('3000108', 'Madame', 'EDITE', 'FIAT', '1');
INSERT INTO TABCLIDS VALUES ('3000109', 'Madame', 'TOYOTA', 'JACKSON', '3');
INSERT INTO TABCLIDS VALUES ('3000111', 'Madame', 'GENEREUX', 'EVE', '1');
INSERT INTO TABCLIDS VALUES ('3001778', 'Mr', 'COURTOIS', 'Bruno', '1');
INSERT INTO TABCLIDS VALUES ('3001779', 'Monsieur', 'VANDERHOTE', 'Ivan', '1');
INSERT INTO TABCLIDS VALUES ('3001780', 'Monsieur', 'Hollanda', 'Francis', '1');
INSERT INTO TABCLIDS VALUES ('3001781', 'Monsieur', 'Bernard', 'Hugues', '1');
INSERT INTO TABCLIDS VALUES ('3001782', 'Monsieur', 'LATIFOU', 'Ilyas', '1');
INSERT INTO TABCLIDS VALUES ('3001783', 'Madame', 'LALLEMAND', 'Ines', '1');
INSERT INTO TABCLIDS VALUES ('3001784', 'Monsieur', 'DEUTCH', 'Hans', '1');
INSERT INTO TABCLIDS VALUES ('3001785', 'Madame', 'ALMANI', 'Eve', '1');
INSERT INTO TABCLIDS VALUES ('3001786', 'Madame', 'MERQUELLE', 'Ange', '1');
INSERT INTO TABCLIDS VALUES ('3001', 'M.', 'LE BON', 'Adam', '1');
INSERT INTO TABCLIDS VALUES ('3001777', 'Mr', 'LE BON', 'Adem', '1');
INSERT INTO TABCLIDS VALUES ('3001777', 'Monsieur', 'LE BON', 'Adam', '1');
INSERT INTO TABCLIDS VALUES ('2998505', 'Mademoiselle', 'TRAIFOR', 'ALICE', '2');
INSERT INTO TABCLIDS VALUES ('3000110', 'MADAME', 'ONRI', 'HONDA', '2');
INSERT INTO TABCLIDS VALUES ('3001777', 'Monsieur', 'LE BON', 'Adam', '1');
INSERT INTO TABCLIDS VALUES ('3001777', 'Monsieur', 'LE BON', 'Adam', '1');
INSERT INTO TABCLIDS VALUES ('3001777', 'Monsieur', 'LE BON', 'Adam', '');
INSERT INTO TABCLIDS VALUES ('3001777', 'Monsieur', 'LE BON', 'Adam', '1');
INSERT INTO TABCLIDS VALUES ('3001777', 'Monsie�r', 'LE BON', 'Adam', '1');
INSERT INTO TABCLIDS VALUES ('2994570', 'Madame', 'RAHMA', 'CLEMENCE', '3');
INSERT INTO TABCLIDS VALUES ('2994570', 'Madame', 'RAHMA', 'CLEMENCE', '3');
INSERT INTO TABCLIDS VALUES ('2994570', 'Madame', 'RAHMA', 'CLEMENSE', '3');
INSERT INTO TABCLIDS VALUES ('2997007', '', 'TRAIFOR', 'ADAM', '2');
INSERT INTO TABCLIDS VALUES ('2997007', '', 'TRAIFOR', 'ADAM', '');
COMMIT;

--======================================================================================

REM VISUALISATION DES DONNEES
SELECT COUNT(*) AS NbrCli FROM TABCLIDS;
SELECT * FROM TABCLIDS;
