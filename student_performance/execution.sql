-- adding primary key to studentId
-- the studentID column is not null and it is unique

SELECT * FROM student_performance_data;
ALTER TABLE student_performance_data
ADD PRIMARY KEY(studentID);

--  add check constraint to age column where age should be 15 to 18
-- You cannot add check constraint to the table which is already created.
-- so after data cleaning we can do that in transformation stage with new table creation

-- update gender 0 - male and 1 - female
-- for changing the values 0 and 1 we need to change the datatype to enum M AND N

ALTER TABLE student_performance_data
MODIFY COLUMN gender enum('M','F');

UPDATE student_performance_data
SET gender = 'M' WHERE gender = '0';

UPDATE student_performance_data
SET gender = 'F' WHERE gender = 1;

-- i got an error after doing this. all the rows become F thats why i changed the datatype 
-- again and inserted data for gender by using other table

ALTER TABLE student_performance_data
MODIFY COLUMN gender int;

UPDATE student_performance_data AS sp
JOIN student AS s ON sp.studentid = s.studentid
SET sp.gender = s.gender;

-- by using enum data is not updated correctly, thats why changed to char and modified 
-- gender data

ALTER TABLE student_performance_data
MODIFY COLUMN gender char;

UPDATE student_performance_data
SET gender = 'M' WHERE gender = 0;

UPDATE student_performance_data
SET gender = 'F' WHERE gender = '1';

select * from student_performance_data;

ALTER TABLE student_performance_data
MODIFY COLUMN gender enum('M','F');

-- add foreign key for ethnicity and that ethnicity should be primary key in lookup table
ALTER TABLE student_performance_data
ADD CONSTRAINT fk_ethnicity
FOREIGN KEY (Ethnicity) REFERENCES ethnicity(EthnicityID);

select * from student_performance_data;
select * from ethnicity;

-- add foreign key for parental education and that parentaleducation should be primary key
ALTER TABLE student_performance_data
ADD CONSTRAINT fk_parentaleducation
FOREIGN KEY (ParentalEducation) REFERENCES parentaleducation(ParentalEducationID);

-- convert studytimeweekly from hours to minutes and round it
UPDATE student_performance_data
SET StudyTimeWeekly =  round(StudyTimeWeekly * 60,2);

-- remove the data from table if absences is above 30 
DELETE FROM student_performance_data
WHERE Absences>30;

-- change tutoring 0 to no and 1 to yes by changing datatype text and after setting the
-- data again change the datatype text to enum

select * from student_performance_data;

ALTER TABLE student_performance_data
MODIFY COLUMN Tutoring Text;

UPDATE student_performance_data
SET Tutoring = 'No' where Tutoring = '0';

UPDATE student_performance_data
SET Tutoring = 'Yes' where Tutoring = '1';

ALTER TABLE student_performance_data
MODIFY COLUMN Tutoring Enum('Yes','No');


-- add foreign key for parental support and that parentalsupport should be primary key 
--  in lookup table

ALTER TABLE student_performance_data
ADD CONSTRAINT fk_parentalsupport
foreign key(parentalsupport) references parentalsupport(parentalsupportID);

-- change extracurricular 0 to no and 1 to yes 
-- for changing int to enum change first int to text
-- then update the table and change again text to enum

ALTER TABLE student_performance_data
MODIFY COLUMN Extracurricular text;

UPDATE student_performance_data
SET extracurricular = 'No' WHERE extracurricular = '0';

UPDATE student_performance_data
SET extracurricular = 'Yes' WHERE extracurricular = '1';

ALTER TABLE student_performance_data
MODIFY COLUMN Extracurricular ENUM('Yes','No');

-- change sports, music, volunteering from 0 to no and 1 to yes
-- for changing int to enum change first int to text
-- then update the table and change again text to enum

ALTER TABLE student_performance_data
MODIFY COLUMN Sports text;

UPDATE student_performance_data
SET Sports = 'No' where sports = '0';

UPDATE student_performance_data
SET Sports = 'Yes' where sports = '1';

ALTER TABLE student_performance_data
MODIFY COLUMN Sports enum('Yes','No');

ALTER TABLE student_performance_data
MODIFY COLUMN Music text;

UPDATE student_performance_data
SET Music = 'No' where Music = '0';

UPDATE student_performance_data
SET Music = 'Yes' where Music = '1';

ALTER TABLE student_performance_data
MODIFY COLUMN Music enum('Yes','No');

ALTER TABLE student_performance_data
MODIFY COLUMN Volunteering text;

UPDATE student_performance_data
SET Volunteering = 'No' where Volunteering = '0';

UPDATE student_performance_data
SET Volunteering = 'Yes' where Volunteering = '1';

ALTER TABLE student_performance_data
MODIFY COLUMN Volunteering enum('Yes','No');

-- round to one integer for gpa

UPDATE student_performance_data
SET GPA = ROUND(GPA,1);

select * from student_performance_data;

-- change 0,1,2,3,4 to A,B,C,D,E in gradeclass 
ALTER TABLE student_performance_data
MODIFY GradeClass text;

UPDATE student_performance_data
SET GradeClass = 'A' WHERE GradeClass = '0';
UPDATE student_performance_data
SET GradeClass = 'B' WHERE GradeClass = '1';
UPDATE student_performance_data
SET GradeClass = 'C' WHERE GradeClass = '2';
UPDATE student_performance_data
SET GradeClass = 'D' WHERE GradeClass = '3';
UPDATE student_performance_data
SET GradeClass = 'E' WHERE GradeClass = '4';
UPDATE student_performance_data
SET GradeClass = 'F' WHERE GradeClass = 'E';

select * from student_performance_data;

ALTER TABLE student_performance_data
MODIFY GradeClass CHAR;

-- add foreign key constraint to gradeclass pointing to gradeclass table's primary key

ALTER TABLE student_performance_data
ADD CONSTRAINT fk_gradeclass
foreign key (GradeClass) references gradeclass(GradeClass);

