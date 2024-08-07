-- create lookup table for ethnicity

CREATE TABLE EthnicityLookup(EthnicityID int primary key , EthnicityValue text); 
INSERT INTO EthnicityLookup(EthnicityID,EthnicityValue)
VALUES(0, 'Caucasian'),
(1, 'African American'),
(2, 'Asian'),
(3, 'Other');

USE practice;
SELECT * FROM EthnicityLookup;

-- create lookup table for parental education

CREATE TABLE EducationLookup(EducationID int primary key , EducationStatus text); 
INSERT INTO EducationLookup(EducationID, EducationStatus)
VALUES(0, 'None'),
(1, 'High School'),
(2, 'Under Graduate'),
(3, 'Graduate'),
(4, 'Masters');
USE practice;
SELECT * FROM EducationLookup;

-- create lookup table for parental support

CREATE TABLE SupportLookup(SupportID int primary key , SupportValue text); 
INSERT INTO SupportLookup(SupportID, SupportValue)
VALUES(0, 'None'),
(1, 'Low'),
(2, 'Moderate'),
(3, 'High'),
(4, 'Very High');
USE practice;
SELECT * FROM SupportLookup;

-- create lookup table for Grade class

CREATE TABLE GradeLookup(ID INT, Grade char primary key ,GPAScale text); 
INSERT INTO GradeLookup(ID, Grade, GPAScale)
VALUES(0,'A', 'GPA >= 3.5'),
(1,'B', '3.0 <= GPA < 3.5'),
(2,'C', '2.5 <= GPA < 3.0'),
(3,'D', '2.0 <= GPA < 2.5'),
(4,'F', 'GPA < 2.0');
USE practice;
SELECT * FROM GradeLookup;






