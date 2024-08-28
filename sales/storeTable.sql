use customerdata;

CREATE TABLE StoreCustomerDetails(
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

SELECT * FROM StoreCustomerDetails;

INSERT INTO StoreCustomerDetails (customerid, customername, referredBy, mobileNum, email, city, state, country, pincode) VALUES
(1, 'Sarah Miller', 'store', 918273645012, 'sarah.miller@gmail.com', 'San Francisco', 'California', 'USA', 94102),
(2, 'Kevin Johnson', 'store', 819263748011, 'kevin.johnson@gmail.com', 'Austin', 'Texas', 'USA', 73301),
(3, 'Laura Lee', 'store', 712345678901, 'laura.lee@gmail.com', 'Seattle', 'Washington', 'USA', 98101),
(4, 'David Kim', 'store', 612345678901, 'david.kim@gmail.com', 'Miami', 'Florida', 'USA', 33101),
(5, 'Emma Harris', 'store', 512345678901, 'emma.harris@gmail.com', 'Boston', 'Massachusetts', 'USA', 02101),
(6, 'Matthew Clark', 'store', 412345678901, 'matthew.clark@gmail.com', 'Denver', 'Colorado', 'USA', 80201),
(7, 'Jane Smith', 'store', 123456789012, 'jane.smith@gmail.com', 'Los Angeles', 'California', 'USA', 90001);

SET SQL_SAFE_UPDATES = 1;

UPDATE StoreCustomerDetails
SET mobileNum = NULL
WHERE customerid = 4;

UPDATE StoreCustomerDetails
SET email = NULL
WHERE customerid = 7;
