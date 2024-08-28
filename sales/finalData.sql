/* 
step 1:
standardize address format includes city,state,country,zipcode
*/
use customerdata;

CREATE TABLE CustomerFinalDetails(
customerID INT(20) PRIMARY KEY NOT NULL,
customerName VARCHAR(30),
dataSource ENUM("marketer","store","online"),
phoneNumber BIGINT UNIQUE,
customerEmailID VARCHAR(50) UNIQUE,
customerAddress VARCHAR(100) 
);

SELECT * FROM CustomerFinalDetails;

-- STEP2 MAPPING

INSERT INTO CustomerFinalDetails(customerID, customerName, dataSource, phoneNumber,
customerEmailID, customerAddress)
SELECT customerid, customername, 'online' as dataSource, mobileNum, email, CONCAT(city,", ",state,", ",country,", ",pincode) as customerAddress
FROM onlinecustomerdetails;

ALTER TABLE CustomerFinalDetails
drop COLUMN customerID;

-- step 3 removing duplicates

INSERT IGNORE INTO CustomerFinalDetails(customerName, dataSource, phoneNumber,
customerEmailID, customerAddress)
SELECT  customername, 'store' as dataSource, mobileNum, email, CONCAT(city,", ",state,", ",country,", ",pincode) as customerAddress
FROM storecustomerdetails;



INSERT INTO CustomerFinalDetails(customerName, dataSource, phoneNumber,
customerEmailID, customerAddress)
SELECT c.customername, 'marketer' as dataSource, c.mobileNum, c.email, CONCAT(c.city,", ",c.state,", ",c.country,", ",c.pincode) as customerAddress
FROM customerdetailsbymarketer c
inner join customerdetailsbymarketer c1
on c.mobileNum=c1.mobileNum AND c.email=c1.email
GROUP BY c.mobileNum,c.email
having count(c.mobileNum)=1;

ALTER TABLE customerFinalDetails
DROP INDEX phoneNumber;

ALTER TABLE CustomerFinalDetails
ADD COLUMN customerID INT AUTO_INCREMENT PRIMARY KEY FIRST;

SELECT * FROM CustomerFinalDetails;

-- step 4 filling null as 'NA'

SET SQL_SAFE_UPDATES = 0;

UPDATE CustomerFinalDetails
SET phoneNumber = IFNULL(phoneNumber, 0);

SELECT * FROM CustomerFinalDetails;

SET SQL_SAFE_UPDATES = 1;

-- step 5 validate phone number

/*
validation check is not working
how to refill null values
how to delete duplicate rows which are in marketer tables and add them in final table
*/




