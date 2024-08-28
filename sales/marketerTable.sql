use customerdata;

CREATE TABLE CustomerDetailsByMarketer(
customerid INT,
customername VARCHAR(50),
referredBy VARCHAR(10),
mobileNum BIGINT,
email VARCHAR(30),
city VARCHAR(20),
state VARCHAR(20),
country VARCHAR(20),
pincode INT(10)
);

INSERT INTO CustomerDetailsByMarketer (customerid, customername, referredBy, mobileNum, email, city, state, country, pincode) VALUES
(1, 'Michael Johnson', 'marketer', 123456789012, 'michael.johnson@gmail.com', 'San Diego', 'California', 'USA', 92101),
(2, 'Lisa Brown', 'marketer', 234567890123, 'lisa.brown@gmail.com', 'Dallas', 'Texas', 'USA', 75201),
(3, 'Michael Johnson', 'marketer', 123456789012, 'michael.johnson@gmail.com', 'San Diego', 'California', 'USA', 92101),
(4, 'Emily Wilson', 'marketer', 345678901234, 'emily.wilson@gmail.com', 'Miami', 'Florida', 'USA', 33101),
(5, 'David Anderson', 'marketer', 456789012345, 'david.anderson@gmail.com', 'Boston', 'Massachusetts', 'USA', 02101),
(6, 'David Kim', 'marketer', 612345678901, 'david.kim@gmail.com', 'Miami', 'Florida', 'USA', 33101);

SELECT * FROM CustomerDetailsByMarketer;

SET SQL_SAFE_UPDATES = 1;

DELETE t1
  FROM customerdetailsbymarketer AS t1
    INNER JOIN customerdetailsbymarketer AS t2
WHERE t1.customerid < t2.customerid
  AND t1.customername = t2.customername;
  
  

