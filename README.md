# Oracle ETL (Extract Transform and Load)
`Oracle PL/SQL`
iDQMS tool : An intelligent Data Quality Management System tool
<img src="img/idqms.png" title="iDQMS" alt="iDQMS">

## Code

1. [ETL](ETL)
2. [Data and Tables](ETL/tables)
3. [Trasform CSV format to a table format ](ETL/functions/CSV2TAB)
4. [Detect anomaly and generate statistics ](ETL/functions/DetectAnomaly)
5. [Normalize data based on statistics ](ETL/functions/NormalizeAndCleanData)

## Demo : csvFile1

### Before processing 
<img src="img/before.png" title="before processing" alt="before">

### during processing 
* Transforme CSV to Table
<img src="img/during1.png" title="Transforme CSV to Table" alt="during">

* Statistic 1
<img src="img/stat1.png" title="Statistic 1" alt="Statistic_1">

* Statistic 2
<img src="img/stat2.png" title="Statistic 2" alt="Statistic_2">

* Statistic 3
<img src="img/stat3.png" title="Statistic 3" alt="Statistic_3">

### After processing
<img src="img/after.png" title="after processing" alt="after">

## Default Test 
Connect to your oracle database and run  `@MAIN.sql`

## Personal Test 
1. Add your own csvfile in `tables_data_csv_file1.sql` [here] ( Oracle/ETL/tables )
2. open oracle
3. run `@resouces` to load necessary tools
4. run `EXEC MyETL ('CSVfile1' ,';' ,'CSVfile1_new' );` or personalize this file : `MAIN.sql` [here](ETL)



