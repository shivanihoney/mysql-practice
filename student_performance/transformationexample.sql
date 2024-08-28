

use practice;

select count(distinct studentID) from student_performance_data; -- 2392 rows
select count(*) from student_performance_data;                  -- 2392 rows

-- from the above query we can state that each student id is unique, so it is considered as 
-- primary index/ primary key

select * from student_performance_data;
-- using where condition we can check for nulls

select distinct age from student_performance_data;  -- age --> 15 - 18
select distinct gender from student_performance_data; -- 0 male, 1 female
select distinct ethnicity from student_performance_data;  
/* 0: Caucasian
1: African American
2: Asian
3: Other */

select distinct parentaleducation from student_performance_data; 
/*
0: None
1: High School
2: Some College
3: Bachelor's
4: Higher
*/

select * from student_performance_data;
/*
transfer the hours to  minutes and round to 2 */

/*
absences limit 30, if student have above 30 then remove the student data from table
*/

select distinct tutoring from student_performance_data; 
-- 1 - yes, 0 - no

select distinct parentalsupport from student_performance_data; 
-- scale of 4 - so it should be less than 4 
/*
0: None
1: Low
2: Moderate
3: High
4: Very High
*/


select distinct extracurricular from student_performance_data; 
-- 0 - no, 1 - yes

select * from student_performance_data;

-- 0 -no 1-yes for all 3 columns sports, music, volunteering

select max(gpa) from student_performance_data;
/*
0: 'A' (GPA >= 3.5)
1: 'B' (3.0 <= GPA < 3.5)
2: 'C' (2.5 <= GPA < 3.0)
3: 'D' (2.0 <= GPA < 2.5)
4: 'F' (GPA < 2.0)
*/

/*
- lookups table create
- transform
analytics
create views for each analytics
group concat

*/


