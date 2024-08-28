-- create new table as student_performance_data

drop table studentPerformance;

CREATE TABLE studentPerformance(
studentID bigint primary key,
age int check(age>=15 and age<=18),
gender enum('M','F'),
ethnicity int check(ethnicity>=0 and ethnicity<=3),
parentalEducation int check(parentalEducation>=0 and parentalEducation<=4),
studyTimeWeekly double,
absences int check(absences>=0 and absences<=30),
tutoring enum('Yes','No'),
parentalSupport int check(parentalSupport>=0 and parentalSupport<=4),
extraCurricular enum('Yes','No'),
activities text,
GPA double,
gradeClass char(1),
FOREIGN KEY (ethnicity) REFERENCES ethnicity(EthnicityID),
FOREIGN KEY (parentalEducation) REFERENCES parentaleducation(ParentalEducationID),
FOREIGN KEY (parentalSupport) REFERENCES parentalsupport(ParentalSupportID),
FOREIGN KEY (gradeClass) REFERENCES gradeclass(GradeClass)
);


select * from studentperformance;

-- insert every data from old table to new table and do changes like group concat

INSERT INTO studentPerformance(studentID, age, gender, ethnicity, parentalEducation, studyTimeWeekly, 
absences, tutoring, parentalSupport, extraCurricular, GPA, gradeClass)
SELECT studentID, Age, gender, Ethnicity, ParentalEducation, StudyTimeWeekly, Absences, 
Tutoring, ParentalSupport, ExtraCurricular, GPA, GradeClass
FROM student_performance_data;

-- getting all three columns sports, music and volunteering to one column activities 

update studentPerformance s
left join
 (SELECT studentID,
           GROUP_CONCAT(activity SEPARATOR ', ') as grp from
 (SELECT studentID, 'sports' AS activity FROM student_performance_data WHERE sports = 'yes'
 UNION ALL
 SELECT studentID, 'music' AS activity FROM student_performance_data WHERE music = 'yes'
 UNION ALL
 SELECT studentID, 'volunteering' AS activity FROM student_performance_data WHERE volunteering = 'yes')
as a
group by studentID
order by studentID) GC on s.studentID=gc.studentID
set s.activities=gc.grp;

-- add data which violates check constraint
insert into studentPerformance
values(3394,19,'M',4,4,567.33,32,'yes',3,'no','sports',1.4,'f');
-- studentperformance_chk_1 violated

