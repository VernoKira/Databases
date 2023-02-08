CREATE TYPE  gender AS ENUM ('M', 'F');

CREATE TABLE employees(
    emp_no INT,
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR (16),
    gender gender,
    hire_date DATE,
    PRIMARY KEY (emp_no)
);
CREATE  TABLE  departments(
    dept_no CHAR(4),
    dept_name VARCHAR(40),
    PRIMARY KEY  (dept_no)

);
CREATE TABLE  dept_emp(
    emp_no INT,
    dept_no CHAR(4),
    from_date DATE,
    to_date DATE,
    FOREIGN KEY (dept_no) references  departments,
    FOREIGN KEY (emp_no) references  employees

);


CREATE TABLE  dept_manager
(
    dept_no   CHAR(4),
    emp_no    INT,
    from_date DATE,
    to_date   DATE,
    FOREIGN KEY (dept_no) references departments,
    FOREIGN KEY (emp_no) references employees
);
CREATE  TABLE salaries(
    emp_no INT,
    salary INT,
    from_date DATE,
    to_date DATE,
    PRIMARY KEY (from_date),
    FOREIGN KEY (emp_no) references  employees
);
CREATE  TABLE titles(
    emp_no INT,
    title VARCHAR(50),
    from_date DATE,
    to_date DATE,
    PRIMARY KEY (title),
    FOREIGN KEY (emp_no) references employees

);


CREATE TABLE students(
    ID VARCHAR(9),
    full_name VARCHAR(40),
    age INT,
    birth_date DATE,
    gender gender,
    av_grade FLOAT,
    nationally VARCHAR(20),
    phone_number VARCHAR(11),
    social_category VARCHAR(20),
    PRIMARY KEY (ID)
);
CREATE TABLE instructors(
    ID VARCHAR(9),
    full_name VARCHAR(40),
    speaking_language VARCHAR(20),
    work_exp INT,
    remote_lesson_possibility VARCHAR(20),
    PRIMARY KEY (full_name)
);

CREATE TABLE students_data(
    ID VARCHAR(9),
    full_name VARCHAR(40),
    address VARCHAR(20),
    phone_number VARCHAR(11),
    position VARCHAR(20),
    PRIMARY KEY (ID),
    FOREIGN KEY (full_name) references students
);
CREATE  TABLE student_soc_data(
    school VARCHAR(20),
    graduation_data DATE,
    address VARCHAR(20),
    region VARCHAR(20),
    country VARCHAR(15),
    gpa FLOAT,
    honors VARCHAR(30),
    PRIMARY KEY (address),
    FOREIGN KEY (address) references students_data
);

CREATE TABLE  student_exam(
    full_name VARCHAR(40),
    name_course VARCHAR(20),
    time_exam VARCHAR (10),
    FOREIGN KEY(full_name) references students

);





INSERT INTO employees(emp_no, birth_date, first_name, last_name, gender, hire_date)
    VALUES (199, to_date('20/01/2004', 'DD/MM/YYYY'), 'Riza', 'Nurmagambetkyzy','F', to_date('13/06/2047', 'DD/MM/YYYY'));

INSERT INTO departments(dept_no, dept_name)
    VALUES (1,'NAME1');

INSERT INTO departments(dept_no, dept_name)
    VALUES (2,'NAME2');

INSERT INTO departments(dept_no, dept_name)
    VALUES (3,'NAME3');

UPDATE employees
    set emp_no = emp_no-10;
UPDATE departments
    set dept_no = 3
    where dept_name= 'NAME3';

DELETE FROM departments
    where dept_no <'5';

UPDATE departments
    set dept_no = 78
    where dept_name= 'NAME1';

UPDATE  departments
    set dept_no = 7788
where dept_name = 'NAME1'







