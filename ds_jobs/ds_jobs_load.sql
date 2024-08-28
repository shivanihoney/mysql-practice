create database DS_jobs;
use DS_jobs;

create table DS_jobs_uncleaned(
`index` text null,
`Job Title` text null,
`Salary Estimate` text null,
`Job Description` text null,
Rating text null,
Company text null,
Location text null,
Headquarters text null,
Size text null,
Founded text null,
`Type of ownership` text null,
Industry text null,
Sector text null,
Revenue text null,
Competitors text null
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Uncleaned_DS_jobs.csv'
INTO TABLE DS_jobs_uncleaned
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- (`index`,`Job Title`,`Salary Estimate`,`Job Description`,Rating,Company,Location,
-- Headquarters,Size,Founded,`Type of ownership`,Industry,Sector,Revenue,Competitors)

select * from DS_jobs_uncleaned;
