/*
- change column names to meaningful names index to S.No, Salary Estimate to Salary,
  Rating to Job_Rating, Location to Job_Location, headquarters to Company_Headquarters,
  size to Employee_Size, Founded to Established_In, Type of ownership to Company_Type,
  revenue to company_revenue_in_usd
- make salary values average and remove (glassdoor est.)
- make -1 value to 0 in rating 
- remove rating attached to comapany name in company column
- headquarters have -1 remove that and replace with 0
- take average values for size if it has 'to' in data, remove +, and replace -1 to 0
- replace -1 to 0 in founded
- remove company word in type of ownership, -1 to 0, self-employed to private
- replace -1 to 0 in industry, sector, revenue
- remove usd word from data, average value if it have to, remove less than word, remove + 
  symbol, convert million and billions to proper number.
- replace -1 to 0 

  Microenterprise: 1 to 9 employees. Small business: 10 to 49 employees. Medium-sized companies:
  50 to 249 employees. Large companies: 250 or more employees.
*/
select * from ds_jobs_uncleaned;

-- create view to remove (glassdoor est.) from salary estimation
create view salarytransform as 
(select `index`,`salary estimate`,
trim(((substring_index(substring_index(substring_index(`salary estimate`,'-',1),'$',-1),'K',1) +
substring_index(substring_index(substring_index(`salary estimate`,'-',-1),'$',-1),'K',1) )/2 )*1000 )
 as salary
 from ds_jobs_uncleaned);
 
 (select `index`,`salary estimate`,
-- substring_index(substring_index(`salary estimate`,'-',1),'$',-1) 
substring_index(substring_index(`salary estimate`,'-',-1),'$',-1)
 from ds_jobs_uncleaned);
 
 select distinct * from salarytransform;
 
 -- remove rating attached to company name in company column
 create view CompanyTransform as 
 (select `index`,company,
 substring(company,1,length(company)-3) as Company_Name
 from ds_jobs_uncleaned);
 
 select * from CompanyTransform;
 
 -- take average values for size if it has 'to' in data, remove +, and replace -1 to 0
 
 create view sizeTransform as
(select `index`,size,
case when size like '%+%'then substring_index(size,'+',1) 
when size like '-1' or size like 'Unknown' then 0
else round(((substring_index(size,'to',1)+substring_index(substring_index(size,'to',-1),'emp',1))/2),0)
end as Employee_Size
 from ds_jobs_uncleaned);
 
 select * from sizeTransform;
 select max(employee_size), min(employee_size) from sizeTransform;
 
 
 -- remove company word in type of ownership, -1 to 0
 
 create view companyTypeTransform as 
 (select `index`,`type of ownership`,
 case when `type of ownership`=-1 then 0
 when `type of ownership` like '%-%' then substring_index(`type of ownership`,'-',-1) 
 else `type of ownership`
 end as Company_Type
 from ds_jobs_uncleaned);
 
 select * from companyTypeTransform;
 
 -- remove usd word from data, average value if it have to, remove less than word, remove + 
 -- symbol, convert million and billions to proper number.
 
 CREATE VIEW RevenueTransform AS 
SELECT `index`,revenue,
    CASE 
        WHEN Revenue = -1 OR Revenue LIKE '%Unknown%' THEN 0
        WHEN Revenue LIKE '%+%' THEN 
            TRIM(substring_index(substring_index(Revenue, '$', -1), '+', 1)) * 1000000000
            WHEN Revenue LIKE '%to%' and Revenue like '%million%' and  Revenue like '%billion%'  then
       ( (substring_index(substring_index(revenue,'million',1),'$',-1)*1000000)+
        (substring_index(substring_index(substring_index(revenue,'to',-1),'$',-1),'billion',1)*1000000000))/2
        WHEN Revenue LIKE '%to%' and Revenue like '%billion%' THEN 
            trim((((substring_index(substring_index(Revenue, ' to ', 1), '$', -1)) +
            (substring_index(substring_index(substring_index(Revenue, ' to ', -1), '$', -1),'billion',1) ))* 1000000000 )/ 2)
        WHEN Revenue LIKE '%to%' and Revenue like '%million%' THEN 
        trim((((substring_index(substring_index(Revenue, ' to ', 1), '$', -1)) +
            (substring_index(substring_index(substring_index(Revenue, ' to ', -1), '$', -1),'million',1)) )* 1000000) / 2)
    WHEN Revenue LIKE '%Less%' and Revenue LIKE '%million%' THEN 
            TRIM(REPLACE(substring_index(substring_index(Revenue, '$', -1), ' million', 1), ',', '')) * 1000000
        WHEN Revenue LIKE '%Less%' and Revenue LIKE '%billion%' THEN 
            TRIM(REPLACE(substring_index(substring_index(Revenue, '$', -1), ' billion', 1), ',', '')) * 1000000000
    else 0
    END AS Company_Revenue
FROM ds_jobs_uncleaned;

 
 select * from RevenueTransform
 where company_revenue like '%billion%';
 
 create view No_Of_Competitors as 
 (select `index`,competitors, 
 case when competitors=-1 then 0
 when competitors like '%,%' then (length(competitors)-LENGTH(REPLACE(competitors, ',', '')))+1
 else 1
 end
 as No_Of_Competitors
 from ds_jobs_uncleaned);
 
 create view foundedTransform as
 (select `index`, founded, case when Founded=-1 then 0
else Founded end as Established_In from ds_jobs_uncleaned);

select * from foundedTransform;

 