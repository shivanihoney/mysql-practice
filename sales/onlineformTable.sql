CREATE DATABASE customerData;

use customerData;

CREATE TABLE OnlineCustomerDetails(
customerid INT,
customername VARCHAR(50),
referredBy VARCHAR(10),
mobileNum INT(12),
email VARCHAR(30),
city VARCHAR(20),
state VARCHAR(20),
country VARCHAR(20),
pincode INT(10)
);

SELECT * FROM OnlineCustomerDetails;

ALTER TABLE OnlineCustomerDetails MODIFY COLUMN mobileNum BIGINT;

INSERT INTO OnlineCustomerDetails
VALUES(1,"shivani peddi","onlineform",3148274635,"shivani@gmail.com","tarnaka","telangana","india",583366),
(2,"sahaja bonagiri","onlineform",3145363377,"sahaja@gmail.com","secunderabad","telangana","india",573536),
(3,"ajay chintapalli","onlineform",5238274635,"ajay12@gmail.com","bhimavaram","andhra pradesh","india",723456),
(4, 'John Doe', 'onlineform', 987654321012, 'john.doe@gmail.com', 'New York', 'New York', 'USA', 10001),
(5, 'Jane Smith', 'onlineform', 123456789012, 'jane.smith@gmail.com', 'Los Angeles', 'California', 'USA', 90001),
(6, 'Emily Davis', 'onlineform', 789012345678, 'emily.davis@gmail.com', 'Chicago', 'Illinois', 'USA', 60007),
(7, 'Michael Brown', 'onlineform', 456789012345, 'michael.brown@gmail.com', 'Houston', 'Texas', 'USA', 77001),
(8, 'Jessica Wilson', 'onlineform', 234567890123, 'jessica.wilson@gmail.com', 'Phoenix', 'sydney', 'Australia', 85001),
(9, 'Daniel Taylor', 'onlineform', 345678901234, 'daniel.taylor@gmail.com', 'Philadelphia', 'Pennsylvania', 'USA', 19019),
(10, 'Olivia Thomas', 'onlineform', 567890123456, 'olivia.thomas@gmail.com', 'San Antonio', 'Texas', 'USA', 78201),
(11, 'James Martinez', 'onlineform', 678901234567, 'james.martinez@gmail.com', 'San Diego', 'California', 'USA', 92101);