CREATE DATABASE SalesDataAggregation;

USE SalesDataAggregation;

# table 1 tarnakaBranch

CREATE TABLE TarnakaBranch(
storeID ENUM("TAR1"),
productID INT(10) PRIMARY KEY, 
productCategory VARCHAR(20), 
productSales_22 INT(100), 
productSales_23 INT(100)
);

INSERT INTO TarnakaBranch(productID, productCategory, productSales_22, productSales_23)
VALUES(1,"dairy",2169,2723),
(2,"bakery",4713,3239),
(3,"vegetables",1295,3533),
(4,"fruits",1312,2142),
(5,"beauty",1513,903),
(6,"misc",5651,7267);

SELECT * FROM TarnakaBranch;

SET SQL_SAFE_UPDATES = 0;

UPDATE TarnakaBranch
set storeID = "TAR1";


# table 2 uppal branch

CREATE TABLE UppalBranch(
storeID ENUM("UPP2"),
productID INT(10) PRIMARY KEY, 
productCategory VARCHAR(20), 
productSales_22 INT(100), 
productSales_23 INT(100)
);


INSERT INTO UppalBranch(storeID, productID, productCategory, productSales_22, productSales_23)
VALUES("UPP2",1,"dairy",3743,4762),
("UPP2",2,"bakery",517,1073),
("UPP2",3,"vegetables",1672,2312),
("UPP2",4,"fruits",1073,967),
("UPP2",5,"beauty",763,1009),
("UPP2",6,"misc",6303,5942);

SELECT * FROM UppalBranch;


# table 3 secunderabad branch

CREATE TABLE SecBranch(
storeID ENUM("SEC3"),
productID INT(10) PRIMARY KEY, 
productCategory VARCHAR(20), 
productSales_22 INT(100), 
productSales_23 INT(100)
);

INSERT INTO SecBranch(storeID, productID, productCategory, productSales_22, productSales_23)
VALUES("SEC3",1,"dairy",3942,6392),
("SEC3",2,"bakery",3251,4261),
("SEC3",3,"vegetables",5239,4923),
("SEC3",4,"fruits",3269,2927),
("SEC3",5,"beauty",4219,5679),
("SEC3",6,"misc",8135,10129);

SELECT * FROM SecBranch;


# combile all 3 tables into 1 table (data consolidation)alter

CREATE TABLE mergeSalesData(
storeID VARCHAR(10),
productID INT(10), 
productCategory VARCHAR(20), 
productSales_22 INT(100), 
productSales_23 INT(100));

INSERT INTO mergeSalesData(storeID, productID, productCategory, productSales_22, productSales_23)
SELECT storeID, productID, productCategory, productSales_22, productSales_23 
FROM TarnakaBranch;


INSERT INTO mergeSalesData(storeID, productID, productCategory, productSales_22, productSales_23)
SELECT storeID, productID, productCategory, productSales_22, productSales_23 
FROM UppalBranch;


INSERT INTO mergeSalesData(storeID, productID, productCategory, productSales_22, productSales_23)
SELECT storeID, productID, productCategory, productSales_22, productSales_23 
FROM SecBranch;

SELECT * FROM mergeSalesData;

/* 
final table for performance. this includes
store id
total sales for each store for 2 years
higher sales period which is 2022 or 2023 for each store
most saled product category in all 3 stores - sum of sales for both years
how much percent the store is increaced or decresed in compare to previous year for each store
*/

CREATE TEMPORARY TABLE finalSalesPerformance
SELECT distinct storeID,  
	SUM(productSales_22) AS totalSales_22, 
	SUM(productSales_23) AS totalSales_23, 
	(case 
		when SUM(productSales_22) > SUM(productSales_23) then '2022' 
		else '2023' 
    end) AS highSalesYear,
	(SELECT productCategory FROM mergeSalesData AS ms
    WHERE ms.storeID = ms.storeID
    GROUP BY storeID, productCategory
    ORDER BY SUM(productSales_22 + productSales_23) desc
    limit 1) AS mostPopularProdCat,
	((SUM(productSales_23-productSales_22)/SUM(productSales_22))*100) AS percentage
FROM mergeSalesData
GROUP BY storeID;

SELECT * FROM finalSalesPerformance;



-- doubts
-- subquery where 

