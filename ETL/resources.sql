-- drop all tables
@initialization/drop_tables.sql 

-- create tables
@tables/tables_data_csv_file1.sql
@tables/tables_RegexMFB.sql
@tables/tables_liste_villes.sql
@tables/tables_liste_mois.sql
@tables/tables_Data_Reporte.sql
@tables/tables_ETL_Report1.sql
@tables/tables_DR_SemanticDependencies.sql


-- call functions
@functions/Basics/functions_basics.sql
@functions/CSV2TAB/functions_transforme_csv2table.sql
@functions/CSV2TAB/functions_transforme_csv2table_version2.sql

@functions/DetectAnomaly/functions_profil_columns.sql
@functions/DetectAnomaly/functions_Detection_Anomalies.sql

@functions/NormalizeAndCleanData/functions_CleanData.sql
@functions/NormalizeAndCleanData/functions_CorrectData.sql
@functions/NormalizeAndCleanData/functions_NormalizeAndCleanData.sql

@functions/SemanticDependencies/functions_SemanticDependencies.sql
-- main function
@ETL.sql

-- some initialisations
SET serveroutput ON
SET TIMING ON;
SET LINES 1000
SET PAGES 1000

-- spécification du format d'affichage des colonnes
@initialization/format_colonnes.sql
-- M2EID_23/M2EID_23