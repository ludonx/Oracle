# Oracle ETL (Extract Transform and Load)
`Oracle PL/SQL`
iDQMS tool : An intelligent Data Quality Management System tool
<img src="img/idqms.png" title="iDQMS" alt="iDQMS">

## Code
0. [Pipeline]( Oracle/ETL/ETL.sql )
1. [Test]( Oracle/ETL/MAIN.sql )

2. [ETL](ETL)
3. [Data and Tables](Oracle/ETL/tables)
4. [Trasform CSV format to a table format ](Oracle/ETL/functions/CSV2TAB)
5. [Detect anomaly and generate statistics ](Oracle/ETL/functions/DetectAnomaly)
6. [Normalize data based on statistics ](Oracle/ETL/functions/NormalizeAndCleanData)

## Demo : csvFile1
csvFile1
* Before processing 
    <img src="img/before.png" title="iDQMS" alt="iDQMS">

* during processing 
    <img src="img/before.png" title="iDQMS" alt="iDQMS">

* After processing
    <img src="img/after.png" title="iDQMS" alt="iDQMS">

## Default Test 
Connect to your oracle database and run  `@MAIN.sql`

## Personal Test 
1. Add your own csvfile [here] ( Oracle/ETL/tables/tables_data_csv_file1.sql )
2. open oracle
3. run `@resouces` to load necessary tools
4. run `EXEC MyETL ('CSVfile1' ,';' ,'CSVfile1_new' );` or personalize [this file](Oracle/ETL/MAIN.sql )



