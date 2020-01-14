-- algo de netoyage des colonnes
--------------------------------
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

- je supprime l''ancienne colonnes

