/*
- Calculate the average, median, and standard deviation for salaries.
- Summarize the number of jobs per location.
- Compare average salaries across different industries, sectors.
- Analyze how company ratings correlate with salaries.
- Identify the most common industries and sectors.
- Evaluate the distribution of job postings across different sectors.
- Determine which locations have the most job postings.
- Identify correlations between variables such as company rating, salary, and company size.
- Examine the relationship between the number of competitors and company 
  performance metrics like revenue and rating.
- Identify top-performing companies in each industry and sector.
*/

-- Calculate the average, median, and standard deviation for salaries.

select * from ds_jobs;

select avg(Salary_Around) as mean,
(select avg(Salary_Around) from
(select salary_Around, 
row_number()over(order by Salary_Around)as rn,count(salary_Around)over() as total_rows from ds_jobs) as a
where rn in (floor((total_rows+1)/2), floor((total_rows+2)/2))) as median,
stddev(salary_Around) as std_dev from ds_jobs;

-- Summarize the number of jobs per location.

/*
create view - take last two characters from job location 
count job title group by location
*/

select state, count(Job_Title) jobs_In_Each_State from
(select job_title, job_location, trim(substring_index(job_location,',',-1)) as state from ds_jobs) as a
group by state;

-- Compare average salaries across different industries, sectors.

select industry, sector, avg(Salary_Around) as average_salary from ds_jobs
group by sector, industry
order by average_salary desc;

-- Analyze how company ratings correlate with salaries.
create view avg_salary_by_rating as
(select company_size, company_rating, avg(Salary_Around) as avgSalary from ds_jobs
where company_size<>'null'
group by company_size, company_rating
order by company_size, company_rating desc);

-- max salary according to rating
SELECT company_size, company_rating, avgSalary
FROM avg_salary_by_rating
WHERE avgSalary = (SELECT MAX(avgSalary) FROM avg_salary_by_rating);

-- top 5 max salary according to rating
select company_size, company_rating, salary_around from
(SELECT company_size, company_rating, salary_around, dense_rank()over(order by salary_around desc) as `rank`
FROM ds_jobs) a where `rank`<=5
order by company_rating desc;

-- Identify the most common industries and sectors.
select industry, count(industry) as `count` from ds_jobs
where industry <> '0'
group by industry
order by `count` desc;


select distinct industry, sector, count(sector) over(partition by industry) as countSector from ds_jobs
where industry <> '0'
order by industry, countSector desc;


-- Evaluate the distribution of job postings across different sectors.

select sector, count(*) as countOfJobs, (count(*)/(select count(*) from ds_jobs ))*100 as percentage
 from ds_jobs
where sector <> '0'
group by sector
order by countOfJobs desc;

-- Determine which locations have the most job postings.

select job_location, count(*) as totaljobs from ds_jobs
group by job_location
order by totaljobs desc;


-- Identify correlations between variables such as company rating, salary, and company size.

select company_size, company_rating, avg(Salary_Around) as averageSalary from ds_jobs
where company_size<>'null'
group by company_size, company_rating
order by company_size, company_rating desc;

-- Examine the relationship between the number of competitors and company performance metrics like revenue and rating.

select company_Name,company_rating, company_revenue,company_type, No_Of_Competitors from ds_jobs
where company_revenue<>0
order by no_of_competitors desc;