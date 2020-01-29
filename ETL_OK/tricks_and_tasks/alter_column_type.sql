-- alter_column_type.sql
-- M2EID_23/M2EID_23
EXEC droptable('test');
create table test (col varchar(10),col2 VARCHAR2(10));
insert into test values ('123',null);
insert into test values ('bonjour',null);

ALTER TABLE test ADD col3 DATE ;
exec alterAddCol('test','col3','DATE');

--where_conditions := ' where table_name = '''||upper(laTable)||''' AND DATA_TYPE = ''VARCHAR2''';
--myQuery := 'SELECT '|| selected_values ||' FROM user_tab_columns'|| where_conditions;
-- select COLUMN_NAME, DATA_TYPE from user_tab_columns where table_name = 'TEST';

-- ALTER TABLE test MODIFY( col2 NUMBER );

-- select COLUMN_NAME, DATA_TYPE from user_tab_columns where table_name = 'TEST';


-- algo de netoyage des colonnes
je parcours les colonnes de ma table avec annomalies
pour chaque colonnes je recupere 
- son nouveau nom ( getnewname...) ( voir DR_CSVfile1_tabCOL )
- son typesemantique dominan, son type synthaxique dominan et maxlenth (voir DR_CSVfile1_tabCOL)
  -- > faire une fonct avec des in et out comme param
- le nom de sa table de stat  ( voir ETL_report) ou la definir moi meme avec format DR_..._coli

- j''ajoute une colonne avec le nouveau nom et le nouveau type dans la table d''origine
 si varchar --> varchar(maxlength)  
(s'assurer que l'ajout ne gégére pas d''erreur )

- je parcours la table DR_..._coli, pour chaque ligne de newvalues
je formaliser les données et fonction du typesemantique et synthaxique
    - si données n''exite pas ou ne peux etre formaliser, retourne null

- je sauvegarde la nouvelle données nettoyer dans la colonne créé dans la table d''origine

je parcours la table DR_CSVfile1_tabCOL, 
pour chaque OLDNAME, je parcours la table qui correspond dans 
