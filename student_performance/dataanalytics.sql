select * from studentperformancetable;

-- mean/median/standard deviation for age, studytime, absences, gpa

select avg(age) as meanAge, avg(weekstudytimeinmin) as meanStudyTime,
avg(absences) as meanAbsences, avg(gpa) as meanGPA from studentperformancetable;

with agemedian as
(select age, row_number() over(order by age) as rn
from studentperformancetable ),
studytimemedian as
(select weekstudytimeinmin, row_number() over(order by weekstudytimeinmin) as rn
from studentperformancetable),
absencesmedian as 
(select absences, row_number() over(order by absences) as rn
from studentperformancetable),
gpamedian as
(select gpa, row_number() over(order by gpa) as rn
from studentperformancetable )
select 
(select age from agemedian where rn= (select count(age)/2 from studentperformancetable)) as agemedian,
(select weekstudytimeinmin from studytimemedian where rn= ( select count(weekstudytimeinmin)/2 from studentperformancetable)) as studytimemedian,
(select absences from absencesmedian where rn= (select count(absences)/2 from studentperformancetable)) as absencesmedian,
(select gpa from gpamedian where rn= (select count(gpa)/2 from studentperformancetable)) as gpamedian;


SELECT STDDEV(Age) AS stddev_of_age, STDDEV(weekStudyTimeinMin) AS stddev_study_time_weekly,
STDDEV(Absences) AS stddev_absences, STDDEV(GPA) AS stddev_gpa
FROM studentperformancetable;


-- Correlation Analysis: Analyze the correlation between GPA and other numerical variables like 
-- StudyTimeWeekly, Absences, and ParentalEducation. - with respect to one column how rest of 
-- the columns behaving

select grade, min(absences), max(absences), min(weekstudytimeinmin), max(weekstudytimeinmin)
from studentperformancetable
group by grade
order by grade;


SELECT STUDENTiD, GPA, grade FROM studentperformancetable
WHERE Absences=0 and parenteducationstatus="masters" and parentsupport="very high" and weekstudytimeinmin> 1000;

SELECT STUDENTiD, GPA, grade FROM studentperformancetable
WHERE Absences<10 and parenteducationstatus="graduate" and parentsupport="high" and weekstudytimeinmin> 800;

SELECT STUDENTiD, GPA, grade FROM studentperformancetable
WHERE Absences<20 and parenteducationstatus>"high school" and parentsupport>"low" and weekstudytimeinmin> 1100;


-- Categorical Analysis: Analyze the performance (GPA) by different categories such as Gender,
-- Ethnicity, ParentalEducation, and GradeClass.

-- analysing min gpa max gpa avg gpa by each gender
select gender, min(gpa), max(gpa), avg(gpa) from studentperformancetable
group by gender;
-- analysing min gpa max gpa avg gpa by each origin
select origin, min(gpa), max(gpa), avg(gpa) from studentperformancetable
group by origin; 
-- analysing min gpa max gpa avg gpa by parents education status
select parenteducationstatus, min(gpa), max(gpa), avg(gpa) from studentperformancetable
group by parenteducationstatus;


-- Trend Analysis: Look at the trend of GPA across different age groups or grade classes.

select age, grade, min(gpa), max(gpa), avg(gpa) from studentperformancetable
group by age, grade
order by age, grade;

/* To calculate the slope (b) and intercept (a) for the linear regression line 
𝑦=𝑎+𝑏𝑥
y=a+bx in SQL, you can follow these steps:
Calculate the necessary aggregates:
----------------------------------------
1. Sum of the ages (∑Age)
2. Sum of the GPAs (∑GPA)
3. Sum of the products of ages and GPAs (∑Age×GPA) 
4. Sum of the squares of ages (∑Age 2)
5. Count of records (n)

Use these aggregates to compute the slope and intercept:
------------------------------------------------------------

​slope = sum pf prod of ages and gpa - sumOfAges*sumOfGpa/
		sumOfAgesquares - sumOfSquaresOfAges

intercept = sumOfGpa-SumOfAge/ n
*/
-- Calculate the slope (b) and intercept (a) for the linear regression line y = a + bx
WITH Aggregates AS (
SELECT COUNT(*) AS n,
SUM(Age) AS SumAge,
SUM(GPA) AS SumGPA,
SUM(Age * GPA) AS SumAgeGPA,
SUM(Age * Age) AS SumAgeSq
FROM StudentPerformanceTable),
REGRESSION as 
(SELECT 
(n * SumAgeGPA - SumAge * SumGPA) / (n * SumAgeSq - SumAge * SumAge) AS Slope,
(SumGPA - ((n * SumAgeGPA - SumAge * SumGPA) / (n * SumAgeSq - SumAge * SumAge)) * SumAge) / n AS Intercept
FROM Aggregates)
SELECT Age, Slope * Age + Intercept AS PredictedGPA
FROM Regression, (SELECT Age FROM StudentPerformanceTable) AS Ages;

select age, avg(gpa) from studentperformancetable
group by age;


-- Impact of Extracurricular Activities: Examine the impact of extracurricular
 -- participation (Sports, Music, Volunteering) on GPA.
 
 select totalactivities, min(gpa), max(gpa), avg(gpa) from studentperformancetable
 group by totalactivities
 order by totalactivities;
 
 -- Effect of Tutoring and Parental Support: Analyze how tutoring and parental 
-- support levels affect student performance.

select tutoring,  min(gpa), max(gpa), avg(gpa) from studentperformancetable
group by tutoring;
select parentsupport,  min(gpa), max(gpa), avg(gpa) as gpa from studentperformancetable
group by parentsupport order by gpa;




