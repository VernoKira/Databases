-- Create database called «assignment_5»
CREATE DATABASE assignment_5;
-- Create following tables «Warehouses» and «Packs»:
CREATE TABLE Warehouses
(
    code     integer,
    location varchar(255),
    capacity integer,
    primary key (code)

);

CREATE TABLE Packs
(
    code char(4),
    contents varchar(255),
    value real,
    warehouses int,
    foreign key (warehouses) references  Warehouses(code)

);
INSERT INTO Warehouses(code, location, capacity) VALUES(1, 'Chicago', 3);
INSERT INTO Warehouses(code, location, capacity) VALUES(2, 'Rocks', 4);
INSERT INTO Warehouses(code, location, capacity) VALUES(3, 'New York', 7);
INSERT INTO Warehouses(code, location, capacity) VALUES(4, 'Los Angeles', 2);
INSERT INTO Warehouses(code, location, capacity) VALUES(5, 'San Francisko', 8);

INSERT INTO Packs(code, contents, value, warehouses) VALUES ('0MN7', 'Rocks', 180, 3);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('4H8P', 'Rocks', 250, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('4RT3', 'Scissors', 190, 4);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('7G3H', 'Rocks', 200, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('8JN6', 'Papers', 75, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('8Y6U', 'Papers', 50, 3);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('9J6F', 'Papers', 175, 2);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('LL08', 'Rocks', 140, 4);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('P0H6', 'Scissors', 125, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('P2T6', 'Scissors', 150, 2);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('TUSS', 'Papers', 90, 5);

-- 5 Select all packs with a value larger than $190
SELECT  * from Packs where value > 190;
-- 6 Select all the packs distinct by contents
SELECT distinct contents from Packs ;

-- 7 Select the warehouse code and the number of the packs in each warehouse.
select warehouses, count(contents) from packs group by warehouses order by warehouses;

-- 8 Same as previous exercise,but select only those warehouses where the number of the packs is
-- greater than 2.
select warehouses, contents from (select warehouses, count(contents) as contents
from packs group by warehouses) as foo  where foo.contents > 2;

--9 Create a new warehouse in Texas with a capacity for 5 packs
INSERT INTO Warehouses(code, location, capacity) VALUES(6, 'Texas', 5);

--10 Create a new pack,with code "H5RT",containing "Papers" with a value
-- of $150,and located in warehouse 2.
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('H5RT', 'Papers', 150, 2);

--11 Reduce the value of the third largest pack by18%.
update packs set value = packs.value * 0.82 where value in (select value
from packs order by value desc offset 2 limit 1);

--12 Remove all packs with a value lower than $150.
delete from packs where value < 150;

--13 Remove all packs which is located in Chicago.Statement should return all deleted data.
delete from packs where warehouses in (select code from
warehouses where location = 'Chicago') RETURNING *;

