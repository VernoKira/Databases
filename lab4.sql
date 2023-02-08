create table classroom
	(building		varchar(15),
	 room_number		varchar(7),
	 capacity		numeric(4,0),
	 primary key (building, room_number)
	);

create table department
	(dept_name		varchar(20),
	 building		varchar(15),
	 budget		        numeric(12,2) check (budget > 0),
	 primary key (dept_name)
	);

create table course
	(course_id		varchar(8),
	 title			varchar(50),
	 dept_name		varchar(20),
	 credits		numeric(2,0) check (credits > 0),
	 primary key (course_id),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create table instructor
	(ID			varchar(5),
	 name			varchar(20) not null,
	 dept_name		varchar(20),
	 salary			numeric(8,2) check (salary > 29000),
	 primary key (ID),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create table section
	(course_id		varchar(8),
         sec_id			varchar(8),
	 semester		varchar(6)
		check (semester in ('Fall', 'Winter', 'Spring', 'Summer')),
	 year			numeric(4,0) check (year > 1701 and year < 2100),
	 building		varchar(15),
	 room_number		varchar(7),
	 time_slot_id		varchar(4),
	 primary key (course_id, sec_id, semester, year),
	 foreign key (course_id) references course (course_id)
		on delete cascade,
	 foreign key (building, room_number) references classroom (building, room_number)
		on delete set null
	);

create table teaches
	(ID			varchar(5),
	 course_id		varchar(8),
	 sec_id			varchar(8),
	 semester		varchar(6),
	 year			numeric(4,0),
	 primary key (ID, course_id, sec_id, semester, year),
	 foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
		on delete cascade,
	 foreign key (ID) references instructor (ID)
		on delete cascade
	);

create table student
	(ID			varchar(5),
	 name			varchar(20) not null,
	 dept_name		varchar(20),
	 tot_cred		numeric(3,0) check (tot_cred >= 0),
	 primary key (ID),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create table takes
	(ID			varchar(5),
	 course_id		varchar(8),
	 sec_id			varchar(8),
	 semester		varchar(6),
	 year			numeric(4,0),
	 grade		        varchar(2),
	 primary key (ID, course_id, sec_id, semester, year),
	 foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
		on delete cascade,
	 foreign key (ID) references student (ID)
		on delete cascade
	);

create table advisor
	(s_ID			varchar(5),
	 i_ID			varchar(5),
	 primary key (s_ID),
	 foreign key (i_ID) references instructor (ID)
		on delete set null,
	 foreign key (s_ID) references student (ID)
		on delete cascade
	);

create table time_slot
	(time_slot_id		varchar(4),
	 day			varchar(1),
	 start_hr		numeric(2) check (start_hr >= 0 and start_hr < 24),
	 start_min		numeric(2) check (start_min >= 0 and start_min < 60),
	 end_hr			numeric(2) check (end_hr >= 0 and end_hr < 24),
	 end_min		numeric(2) check (end_min >= 0 and end_min < 60),
	 primary key (time_slot_id, day, start_hr, start_min)
	);

create table prereq
	(course_id		varchar(8),
	 prereq_id		varchar(8),
	 primary key (course_id, prereq_id),
	 foreign key (course_id) references course (course_id)
		on delete cascade,
	 foreign key (prereq_id) references course (course_id)
	);


delete from prereq;
delete from time_slot;
delete from advisor;
delete from takes;
delete from student;
delete from teaches;
delete from section;
delete from instructor;
delete from course;
delete from department;
delete from classroom;
insert into classroom values ('Packard', '101', '500');
insert into classroom values ('Painter', '514', '10');
insert into classroom values ('Taylor', '3128', '70');
insert into classroom values ('Watson', '100', '30');
insert into classroom values ('Watson', '120', '50');
insert into department values ('Biology', 'Watson', '90000');
insert into department values ('Comp. Sci.', 'Taylor', '100000');
insert into department values ('Elec. Eng.', 'Taylor', '85000');
insert into department values ('Finance', 'Painter', '120000');
insert into department values ('History', 'Painter', '50000');
insert into department values ('Music', 'Packard', '80000');
insert into department values ('Physics', 'Watson', '70000');
insert into course values ('BIO-101', 'Intro. to Biology', 'Biology', '4');
insert into course values ('BIO-301', 'Genetics', 'Biology', '4');
insert into course values ('BIO-399', 'Computational Biology', 'Biology', '3');
insert into course values ('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', '4');
insert into course values ('CS-190', 'Game Design', 'Comp. Sci.', '4');
insert into course values ('CS-315', 'Robotics', 'Comp. Sci.', '3');
insert into course values ('CS-319', 'Image Processing', 'Comp. Sci.', '3');
insert into course values ('CS-347', 'Database System Concepts', 'Comp. Sci.', '3');
insert into course values ('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', '3');
insert into course values ('FIN-201', 'Investment Banking', 'Finance', '3');
insert into course values ('HIS-351', 'World History', 'History', '3');
insert into course values ('MU-199', 'Music Video Production', 'Music', '3');
insert into course values ('PHY-101', 'Physical Principles', 'Physics', '4');
insert into instructor values ('10101', 'Srinivasan', 'Comp. Sci.', '65000');
insert into instructor values ('12121', 'Wu', 'Finance', '90000');

-- 1a
select * from course WHERE (dept_name='Biology' and credits > 3);
-- 1b
select  * from classroom where (building='Watson' or building='Painter');
-- 1c
select * from course WHERE (dept_name = 'Comp. Sci.');
-- 1d
select title from course, section where course.course_id = section.course_id and section.semester='Spring';
-- 1e
select name from student where tot_cred > 45 intersect (select name from student where tot_cred < 85);
-- 1f
select title from course where title like  '%a' or title like '%e' or title  like '%i' or title like '%u' or title like'%o';
-- 1g
select title from course, prereq
where prereq.course_id = course.course_id AND prereq.course_id = 'EE-181';

-- 2a
SELECT  dept_name, AVG(salary) FROM instructor
GROUP BY dept_name
ORDER BY dept_name;

-- 2b
select building, count(*) from section
group by building
order by count(*) desc limit 1;

-- 2c
select dept_name, count(course_id) from course
group by dept_name
having count(course_id)=(SELECT min(cnt) FROM(
select count(course_id) as cnt from course
group by dept_name) as t);

-- 2d
SELECT  ID, name from student where ID in(select id from takes group by id
 having count(*)>3)
 and dept_name = 'Comp. Sci.';

-- 2e
select id, name from instructor
 where dept_name in(select dept_name from department
 where building =
'Taylor');

--2f
SELECT name from instructor where dept_name='Biology'
or dept_name = 'Philosophy' or dept_name = 'Music';

-- 2g
SELECT all * from instructor where id in(select id from teaches where year = '2018'
except select id from teaches where year='2017');

-- 3a
select name, id from student where id in(select id from takes where grade = 'A' or grade = '-A'  and course_id in
       (select course_id from course where course.dept_name='Comp. Sci.')) order by name;

-- 3b
select all* from advisor where s_ID in(select  id from takes where grade='A' or grade = '-A' or grade = 'B+');

-- 3c
SELECT DISTINCT student.dept_name FROM student
WHERE student.dept_name NOT IN(
SELECT student.dept_name FROM student
WHERE student.id IN
(SELECT DISTINCT takes.id FROM takes
WHERE takes.grade = 'F' OR takes.grade = 'C'));

-- 3d
SELECT * FROM instructor
WHERE id IN (
SELECT id FROM teaches)
EXCEPT
SELECT * FROM instructor
WHERE id IN (
SELECT id FROM teaches
WHERE course_id IN (
SELECT course_id FROM takes
WHERE grade IN ('A', 'A-')));

-- 3e
select *from course where course_id in(select  course_id from section
where time_slot_id in (select time_slot_id from time_slot where end_hr <13));