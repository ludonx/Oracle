# Oracle ETL (Extract Transform and Load)
`Oracle PL/SQL`
iDQMS tool : An intelligent Data Quality Management System tool
<img src="img/idqms.png" title="iDQMS" alt="iDQMS">

## Code

1. [ETL](ETL)
2. [Data and Tables](Oracle/ETL/tables)
3. [Trasform CSV format to a table format ](Oracle/ETL/functions/CSV2TAB)
4. [Detect anomaly and generate statistics ](Oracle/ETL/functions/DetectAnomaly)
5. [Normalize data based on statistics ](Oracle/ETL/functions/NormalizeAndCleanData)

## Demo : csvFile1

### Before processing 
<img src="img/before.png" title="before processing" alt="before">

### during processing 
<img src="img/during1.png" title="Transforme CSV to Table" alt="during">
<img src="img/stat1.png" title="Statistic 1" alt="Statistic_1">
<img src="img/stat2.png" title="Statistic 2" alt="Statistic_2">
<img src="img/stat3.png" title="Statistic 3" alt="Statistic_3">

### After processing
    <img src="img/after.png" title="after processing" alt="after">

## Default Test 
Connect to your oracle database and run  `@MAIN.sql`

## Personal Test 
1. Add your own csvfile on `tables_data_csv_file1.sql` [here] ( Oracle/ETL/tables )
2. open oracle
3. run `@resouces` to load necessary tools
4. run `EXEC MyETL ('CSVfile1' ,';' ,'CSVfile1_new' );` or personalize this file : `MAIN.sql` [here](Oracle/ETL)



