------------------------------------------------+
------------- dropTable                      |
------------------------------------------------+
-- permet de supprimer une table sans générer d'erreur si elle n'existe pas
CREATE OR REPLACE PROCEDURE dropTable (LaTable in VARCHAR2) AS
  BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE '||LaTable;
  EXCEPTION
      WHEN OTHERS THEN NULL;
  END;
  /
