use ds_jobs;
select * from ds_jobs_uncleaned;

create table DS_Jobs(`S.No` int not null, Job_Title varchar(255) not null,
Salary_Around bigint, Job_Description text, Company_Rating double,
Company_Name text, Job_Location text, Company_Headquarters text,
Employee_Size_Around bigint, Company_Size text, Established_In int null,
Company_Type varchar(255), Industry varchar(255), Sector varchar(255),
Company_Revenue bigint, Competitors text null,
No_Of_Competitors int null
);

insert into DS_Jobs(`S.No`, Job_Title, Salary_Around, Job_Description, Company_Rating, Company_Name,
Job_Location, Company_Headquarters, Employee_Size_Around, Company_Size, Established_In,
Company_Type, Industry, Sector, Company_Revenue, Competitors, No_Of_Competitors)
select `index` as `S.No`, `Job Title` as Job_Title,
(SELECT salary from salaryTransform s where s.`index`=d.`index` limit 1) as Salary_Around,
`Job Description` as Job_Description, Rating as Company_Rating, 
(select Company_Name from companytransform t where t.`index`=d.`index` limit 1),
Location as Job_Location, Headquarters as Company_Headquarters,
(select Employee_Size from sizetransform st where st.`index`=d.`index` limit 1) as Employee_Size_Around,
(select case when Employee_Size>1 and Employee_Size<20 then 'Micro enterprise' 
when Employee_Size>21 and Employee_Size<100 then 'Small Business' 
when Employee_Size>101 and Employee_Size<250 then 'Medium Size Company' 
when Employee_Size>250 then 'Large Size Company' 
end as Company_Size from sizeTransform st where st.`index`=d.`index`  limit 1),
(select Established_In from foundedTransform f where f.`index`=d.`index` limit 1),
(select Company_Type from companyTypeTransform ct where ct.`index`=d.`index` limit 1),
case when Industry=-1 then 0
else Industry end as Industry, 
case when Sector=-1 then 0
else Sector end as Sector, 
(SELECT Company_Revenue FROM RevenueTransform r WHERE r.`index`=d.`index` LIMIT 1) AS Company_Revenue,
case when Competitors=-1 then 0
else Competitors end as Competitors,
(select No_Of_Competitors from No_Of_Competitors c where c.`index`=d.`index` limit 1)
FROM ds_jobs_uncleaned D;

select * from ds_jobs;