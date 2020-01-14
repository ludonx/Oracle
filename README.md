# Oracle ETL (Extract Transform and Load)
ETL ( PL/SQL - Oracle )

`iDQMS tool : An intelligent Data Quality Management System tool`

The main objectif of this project is to clean you data (from a csv file) so if you have a csv file with a lot of data and you don't know what that data mean, you have no idea of the schema behin it , but you want to be able to explore it and be able to get insights, this program will help you.

<img src="img/idqms.png" title="iDQMS" alt="iDQMS">

## Code
1. [Pipeline](ETL/ETL.sql)
2. [test program](ETL/MAIN.sql)
3. [ETL](ETL)
4. [Data and Tables](ETL/tables)
5. [Trasform CSV format to a table format ](ETL/functions/CSV2TAB)
6. [Detect anomaly and generate statistics ](ETL/functions/DetectAnomaly)
7. [Normalize data based on statistics ](ETL/functions/NormalizeAndCleanData)

## Demo : csvFile1

### Before processing 
<img src="img/before.png" title="before processing" alt="before">

### During processing 
* ***Transforme CSV to Table***
<img src="img/during1.png" title="Transforme CSV to Table" alt="during">

* ***Statistic 1***
<img src="img/stat1.png" title="Statistic 1" alt="Statistic_1">

* ***Statistic 2***
<img src="img/stat2.png" title="Statistic 2" alt="Statistic_2">

* ***Statistic 3***
<img src="img/stat3.png" title="Statistic 3" alt="Statistic_3">

### After processing
<img src="img/after.png" title="after processing" alt="after">

## Default Test 
Connect to your oracle database and run  `@MAIN.sql`

## Personal Test 
1. Add your own csv file [here]( ETL/tables/tables_data_csv_file1.sql )

2. connect to oracle database
3. run `@resouces` to load necessary tools
4. run
```sql
EXEC MyETL('CSVfile1' ,';' ,'CSVfile1_new' );
```
or personalize this file : [MAIN.sql](ETL/MAIN.sql)



