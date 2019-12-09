﻿set sqlblanklines on
/* tables_ETL_Report.sql */
exec dropTable('ETL_REPORT');
CREATE TABLE ETL_REPORT
(
CSVName VARCHAR2(100),
laTable VARCHAR2(100),
laColonne VARCHAR2(100),
dataReportTable VARCHAR2(100),
dataReportColonne VARCHAR2(100)

);

COLUMN CSVName FORMAT A15
COLUMN laTable FORMAT A15
COLUMN laColonne FORMAT A15
COLUMN dataReportTable FORMAT A20
COLUMN dataReportColonne FORMAT A20
