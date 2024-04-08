create database Sales;

drop table SalesData;
CREATE TABLE SalesData (
    InvoiceNo NVARCHAR(10),
    StockCode NVARCHAR(255),
    Description NVARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10, 2),
    CustomerID INT,
    Country NVARCHAR(50)
);


BULK INSERT SalesData
FROM 'C:\Users\Devendra Rana\Documents\spring2024\buffalo_ds\buffalo_first_sem\EAS508\project\data.csv'
WITH
(
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2,
    KEEPNULLS,
    FORMAT = 'CSV'
)
;

select * from SalesData;

--541909
select count(*) from SalesData;

select TOP 10 * from SalesData ;

--4372
select count(distinct CustomerID) from  SalesData ;


--ALTER TABLE SalesData ADD Gender NVARCHAR(6);


IF OBJECT_ID('new_SalesData_1', 'U') IS NOT NULL
    DROP TABLE new_SalesData_1;


WITH RankedSales AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY CustomerID ORDER BY InvoiceNo,InvoiceDate)-1 AS Previous_Purchases_Rank
    FROM SalesData
)
SELECT *, 
        CASE WHEN ABS(CHECKSUM(HASHBYTES('SHA2_256', CAST(CustomerID AS NVARCHAR(50))))) % 2 = 0 
		          THEN 'Male' 
				  ELSE 'Female' 
			 END  AS Gender,

        ABS(CHECKSUM(HASHBYTES('SHA2_256', CAST(CustomerID AS NVARCHAR(50))))%90) AS Age ,

		CASE WHEN ABS(CHECKSUM(HASHBYTES('SHA2_256', CAST(InvoiceNo AS NVARCHAR(50))))) % 6 = 0 THEN 'Bank Tranfer' 
			 WHEN ABS(CHECKSUM(HASHBYTES('SHA2_256', CAST(InvoiceNo AS NVARCHAR(50))))) % 6 = 1 THEN 'Cash'
			 WHEN ABS(CHECKSUM(HASHBYTES('SHA2_256', CAST(InvoiceNo AS NVARCHAR(50))))) % 6 = 2 THEN 'Credit Card'
			 WHEN ABS(CHECKSUM(HASHBYTES('SHA2_256', CAST(InvoiceNo AS NVARCHAR(50))))) % 6 = 3 THEN 'Debit Card'
			 WHEN ABS(CHECKSUM(HASHBYTES('SHA2_256', CAST(InvoiceNo AS NVARCHAR(50))))) % 6 = 4 THEN 'PayPal'
			 else 'Venmo'
			 END  AS PaymentMethod,
       CASE WHEN CustomerID IS NULL THEN 0
            ELSE MIN(Previous_Purchases_Rank) OVER (PARTITION BY CustomerID, InvoiceNo)
            END AS Previous_Purchases
INTO new_SalesData_1
FROM RankedSales;

ALTER TABLE new_SalesData_1 DROP COLUMN Previous_Purchases_Rank;

select * from new_SalesData_1;

--testing
select * from new_SalesData_1 where CustomerID = 13988 order by InvoiceDate;

--248
select max(Previous_Purchases) from new_SalesData_1;

--we have 43 records ...need to remove later 
select InvoiceNo,count(distinct InvoiceDate) from new_SalesData_1 group by InvoiceNo having count(distinct InvoiceDate)>1;



select * from new_SalesData_1;
--testing to check for each CutomerID, there is unique Gender
--zero records
--select CustomerID,count(distinct Gender)  from new_SalesData_1 group by CustomerID having count(distinct Gender) >1;

