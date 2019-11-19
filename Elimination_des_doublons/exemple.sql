
DROP TABLE EtudiUTV;
CREATE TABLE EtudiUTV(  id VARCHAR2(30),nom VARCHAR2(30), prenom VARCHAR2(30), dateN DATE, ville VARCHAR2(30), pays VARCHAR2(30),  CONSTRAINT match_EtudiUTV_pk PRIMARY  KEY (id));

INSERT INTO EtudiUTV VALUES ('i1','Le Bon','Adam','19/6/2001','Epinay sur seine ','France');
INSERT INTO EtudiUTV VALUES ('i2','BELLE','Clemence','16/10/1996','Nice','France');
INSERT INTO EtudiUTV VALUES ('i3','BELLE','c.','16/10/1996','Nice','France');


DROP TABLE EtudiIG;
CREATE TABLE EtudiIG(  NumE VARCHAR2(30), NomE VARCHAR2(30), PrenE VARCHAR2(30), DN DATE, VIL VARCHAR2(30), Pay VARCHAR2(30),  CONSTRAINT match_EtudiIG_pk PRIMARY  KEY (NumE));
INSERT INTO EtudiIG VALUES ('g1','Le Bon','Adam','19/6/2001','Epinay-sur-seine France',null);
INSERT INTO EtudiIG VALUES ('g2','LeBon','Adams',null,'Epinay-sur-seine ','France');


DROP TABLE TE;
CREATE TABLE TE as (select * from EtudiUTV UNION select * from EtudiIG);

COMMIT;
