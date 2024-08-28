/* 
- create lookup tables for ethnicity, parental education, parental support, grade class (DONE)
- add primary key to studentid (DONE)
- add check key to age column where age should be 15 to 18
- update gender 0 - male and 1 - female (DONE)
- change datatype to enum for gender (DONE)
- add foreign key for ethnicity and that ethnicity should be primary key in lookup table (DONE)
- add foreign key for parental education and that parentaleducation should be primary key 
  in lookup table (DONE)
- convert studytimeweekly from hours to minutes and round it (DONE)
- remove the data from table if absences is above 30 (DONE)
- add check vaildation for absences, it should be 0 to 30
- change tutoring 0 to no and 1 to yes (DONE)
- change datatype to enum for tutoring yes,no (DONE)
- add foreign key for parental support and that parentalsupport should be primary key 
  in lookup table (DONE)
- change extracurricular 0 to no and 1 to yes (DONE)
- change datatype to enum for extracurricular yes,no (DONE)
- change sports, music, volunteering from 0 to no and 1 to yes (DONE)
- change sports, music, volunteering to enum (DONE)
- round to one integer for gpa (DONE)
- change 0,1,2,3,4 to A,B,C,D,F in gradeclass (DONE)
- add foreign key constraint to gradeclass pointing to gradeclass table's primary key (DONE)
- add check constraint to gradeclass if
0: 'A' (GPA >= 3.5)
1: 'B' (3.0 <= GPA < 3.5)
2: 'C' (2.5 <= GPA < 3.0)
3: 'D' (2.0 <= GPA < 2.5)
4: 'F' (GPA < 2.0)                 (doubt)
- after transforming all the column data now need to optimize it by unpivoting the
  sports, volunteeing, music to one single activity column by creating new table overall
   using select into (done)
   
analytics
---------------
create views for each analytics
1. compare who are participated in extra curricular and who did not 
   by doing avg of there gpa for 2 categories and compare
2. do same for parental support 
3. do same for tutoring
*/
select * from student_performance_data;

