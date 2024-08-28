use audiobook;
SELECT * FROM AUDIBLE_UNCLEANED
where price = 'Free';

/*
SPLIT and REMOVE writtenby: and narratedby: from author and narrator columns
TIME - SPLIT into 2 columns hours and minutes 
CONVERT DATE into yyyy-mm-dd and timeoffset to date 
stars - NOT YET RATED - 0
and split into 2 columns starts and rating
*/

create table audible_cleaned(`name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci null,
author text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci null,
narrator text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci null,
hours int null,
minutes int null,
releaseDate date null,
`language` text null,
starRating int null,
countOfRating int null,
price double);

insert into audible_cleaned(
select `name`, 
substring_index(author,':',-1) as author,
substring_index(narrator,':',-1) as narrator,
case when time LIKE '%hr%'  then trim(substring_index(time,'hr',1))
else null end as hour,
case when time LIKE '%min%' and time LIKE '%and%' then  
trim(substring_index(substring_index(time,'and',-1),'min',1))
when time LIKE '%hr%' and time not LIKE '%and%' then null
when time like '%Less than 1%' then 1
when time like '%min%' and time not like '%and%' then trim(substring_index(time,'min',1))
else null  end as minutes,
case when releasedate LIKE '%-%' THEN CAST(CONCAT(
        SUBSTRING_INDEX(SUBSTRING_INDEX(releasedate, '-', 3), '-', -1), '-', 
        SUBSTRING_INDEX(SUBSTRING_INDEX(releasedate, '-', 2), '-', -1), '-',
        SUBSTRING_INDEX(releasedate, '-', 1)
    ) AS DATE)
ELSE DATE_ADD('1899-12-30',INTERVAL releasedate DAY)
END as releasedate,
UPPER(`language`),
case when stars like '%out%' then trim(substring_index(stars,'out',1))
else 0 end as starRating ,
case when stars like '%star%' and stars like '%rating%' 
then replace(trim(substring_index(substring_index(stars,'stars',-1),'rating',1)),',','')
else 0 end as countOfRating,
case when price like '%free%' then 0
else price end as price from audible_uncleaned);

select * from audible_cleaned;

/*
rating for longest duration
*/

