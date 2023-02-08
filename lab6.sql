CREATE DATABASE lab6;
CREATE TABLE locations(
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

CREATE TABLE departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);

CREATE TABLE employees(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);

INSERT INTO locations(location_id, street_address, postal_code, city, state_province) VALUES(501, 'Avangard', '11', 'Boston', 'USA');
INSERT INTO locations(location_id, street_address, postal_code, city, state_province) VALUES(212, 'Momyshuly', '22', 'Moscow', 'RUS');
INSERT INTO locations(location_id, street_address, postal_code, city, state_province) VALUES(41, 'Sairan', '33', 'Almaty', 'KZ');
INSERT INTO locations(location_id, street_address, postal_code, city, state_province) VALUES(21, 'Abai', '44', 'Astana', 'KZ');
INSERT INTO locations(location_id, street_address, postal_code, city, state_province) VALUES (327, 'Gogol', '55', 'Piter', 'RUS');

INSERT INTO departments(department_id, department_name, budget, location_id) VALUES(30, 'HHM', 300000000, 501);
INSERT INTO departments(department_id, department_name, budget, location_id) VALUES(50, 'Yoha', 400000000, 212);
INSERT INTO departments(department_id, department_name, budget, location_id) VALUES(60, 'Yandex', 350000000, 41);
INSERT INTO departments(department_id, department_name, budget, location_id) VALUES(70, 'Google', 300303000, 21);
INSERT INTO departments(department_id, department_name, budget, location_id) VALUES (80, 'LEGO', 707070707, 327);

INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES(01, 'Riza', 'Nurmagambetkyzy', 'r_nurmagambetkyzy', '50-47-55', 500000, 30);
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES(02, 'Dias', 'Kistaubaev', 'd_kis', '60-87-83', 400000, 50);
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES(03, 'Dinara', 'Momyt', 'D_M', '45-54-55', 600000, 60);
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES(04, 'Karina', 'Zhykbayeva', 'k_zhyk', '02-94-21', 450000, 70);
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES(05, 'Pasha', 'Technik', 'P_TECHNIK', '77-77-77', 777777, 80);
INSERT INTO employees(employee_id, first_name, last_name,email, phone_number,salary) values (06,'AAA','BBB','D+N','1111',5555);
DROP TABLE employees, departments, locations;

-- 4 Select the first name, last name, department id, and department name for each employee
SELECT first_name, last_name, employees.department_id, department_name FROM employees
JOIN departments ON departments.department_id = employees.department_id;

-- 5 . Select the first name, last name, department id and department name, for all employees for departments 80 or 30
SELECT first_name, last_name, employees.department_id, d.department_name FROM employees
--WHERE employees.department_id = departments.department_id AND (employees.department_id = 80 OR employees.department_id = 30);
INNER JOIN departments d on employees.department_id = d.department_id WHERE (employees.department_id = 80 OR employees.department_id = 30);

-- 6 Select the first and last name, department, city, and state province for each employee.
SELECT first_name, last_name, department_name, city, state_province FROM employees
--WHERE employees.department_id = departments.department_id AND departments.location_id = locations.location_id;
INNER JOIN departments d on employees.department_id = d.department_id
INNER JOIN locations l on d.location_id = l.location_id;

-- 7 Select all departments including those where does not have any employee.
SELECT e.first_name, e.last_name, department_name FROM employees e
RIGHT JOIN departments d on e.department_id = d.department_id;

--8 Select the first name, last name, department id and name, for all employees who have or have not any department.
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e LEFT JOIN departments d ON e.department_id = d.department_id;

--9 Select the employee last name, first name, who works in Moscow.
SELECT last_name, first_name FROM employees
JOIN departments d on d.department_id = employees.department_id
JOIN locations l on l.location_id = d.location_id
WHERE city = 'Moscow';