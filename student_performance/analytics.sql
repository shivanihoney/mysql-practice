/*
analytics
---------------
create views for each analytics
1. compare who are participated in extra curricular and who did not 
   by doing avg of there gpa for 2 categories and compare
2. do same for parental support 
3. do same for tutoring
*/

select * from studentperformance;

create view studentsTutors as
(select avg(GPA) from studentPerformance
where tutoring = 'Yes'    -- 2.10 gpa
union 
select avg(GPA) from studentPerformance
where tutoring = 'No');      -- 1.80 gpa

select * from studentsTutors;

-- students who are taking tutoring score high than who did not take tutoring

select * from parentalsupport;

create view studentParentalsupport as 
(select avg(GPA), parentalsupport from studentPerformance
where parentalsupport = 4       -- 2.19 gpa
union
select avg(GPA), parentalsupport from studentPerformance
where parentalsupport = 0        -- 1.54
union
select avg(GPA), parentalsupport from studentPerformance
where parentalsupport = 1     -- 1.75
union
select avg(GPA), parentalsupport from studentPerformance
where parentalsupport = 2        -- 1.88
union
select avg(GPA), parentalsupport from studentPerformance
where parentalsupport = 3);       -- 2.04 

select * from studentparentalsupport;

-- student with high parental support scored high compared to students with less paental support

create view studentEC as
(select avg(GPA) from studentPerformance
where extracurricular = 'Yes'      -- 2.10
union
select avg(GPA) from studentPerformance
where extracurricular = 'No');       -- 1.83

select * from studentEC;

-- students with extracurricular activities scored high

