select * from student;


drop view studentperformancetable;

create view StudentPerformanceTAble as
select studentID, 
age,
case when gender = 0 then 'M' else 'F' end as gender,
(select e.ethnicityvalue from ethnicitylookup E where E.ethnicityID=student.ethnicity limit 1) as origin,
 (select e.educationstatus from educationlookup E where E.educationid=student.parentaleducation limit 1) as parentEducationStatus,
studyTimeWeekly * 60 as weekStudyTimeInMin,
case when absences=0 then null else absences end as Absences,
case when Tutoring=0 then 'No' else 'Yes' end as tutoring,
(select su.supportvalue from supportlookup su where su.supportID=student.parentalsupport limit 1) as ParentSupport,
case when extracurricular=0 then 'No' else 'Yes' end as ExtraCurricular,
case when sports=0 then 'No' else 'Yes' end as sports,
case when music=0 then 'No' else 'Yes' end as music,
case when volunteering=0 then 'No' else 'Yes' end as volunteering,
(select extracurricular+sports+music+volunteering as totalactivities from student s2 
where s2.studentID=student.studentID limit 1) as totalactivities,
GPA,
(select g.grade from gradelookup g where g.id=student.gradeclass limit 1) as Grade
from student;


select * from studentperformancetable;

/*
Descriptive Statistics: Calculate mean, median, standard deviation for numerical columns like Age,
 StudyTimeWeekly, Absences, GPA. - data quality profile

Correlation Analysis: Analyze the correlation between GPA and other numerical variables like 
StudyTimeWeekly, Absences, and ParentalEducation. - with respect to one column how rest of the columns behaving
-

Distribution Analysis: Visualize the distribution of key variables such as GPA, 
StudyTimeWeekly, and Absences.
- how colmn having the most frequent data and how it s impactng

Categorical Analysis: Analyze the performance (GPA) by different categories such as Gender,
 Ethnicity, ParentalEducation, and GradeClass.

Trend Analysis: Look at the trend of GPA across different age groups or grade classes.

Impact of Extracurricular Activities: Examine the impact of extracurricular
 participation (Sports, Music, Volunteering) on GPA.

Effect of Tutoring and Parental Support: Analyze how tutoring and parental 
support levels affect student performance.
*/

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

-- by grade
select studentID, grade, absences, parenteducationstatus, parentsupport, weekstudytimeinmin from 
studentperformancetable where grade='A';

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

select age, avg(gpa) from studentperformancetable
group by age 
order by age;


-- Impact of Extracurricular Activities: Examine the impact of extracurricular
 -- participation (Sports, Music, Volunteering) on GPA.
 
 select totalactivities, avg(gpa) from studentperformancetable
 group by totalactivities;
 
 -- Effect of Tutoring and Parental Support: Analyze how tutoring and parental 
-- support levels affect student performance.

select tutoring, avg(gpa) from studentperformancetable
group by tutoring;
select parentsupport, avg(gpa) as gpa from studentperformancetable
group by parentsupport order by gpa;

