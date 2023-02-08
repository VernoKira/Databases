create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    commission float
);

INSERT INTO dealer (id, name, location, commission) VALUES (101, 'Oleg', 'Astana', 0.15);
INSERT INTO dealer (id, name, location, commission) VALUES (102, 'Amirzhan', 'Almaty', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (105, 'Ademi', 'Taldykorgan', 0.11);
INSERT INTO dealer (id, name, location, commission) VALUES (106, 'Azamat', 'Kyzylorda', 0.14);
INSERT INTO dealer (id, name, location, commission) VALUES (107, 'Rahat', 'Satpayev', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (103, 'Damir', 'Aktobe', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Bekzat', 'Satpayev', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Aruzhan', 'Almaty', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Almaty', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Yerkhan', 'Taraz', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Aibek', 'Kyzylorda', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Arsen', 'Taldykorgan', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Alen', 'Shymkent', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Zhandos', 'Astana', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2021-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2021-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2021-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2021-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2021-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2021-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2021-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2021-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2021-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2021-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2021-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2021-04-25 00:00:00.000000', 802, 101);

-- 1.	Write a SQL query using Joins:
--     a.	find those clients with a priority less than 300
SELECT * FROM client
WHERE priority < 300;

-- b.	combine each row of dealer table with each row of client table
SELECT * FROM dealer
CROSS JOIN client;

-- c.	find all dealers along with client name, city, priority, sell number, date, and amount
SELECT d.id, d.name, c.name, c.city, c.priority, s.id, s.date, s.amount
FROM dealer d
INNER JOIN client c on d.id = c.dealer_id
INNER JOIN sell s on c.id = s.client_id;

-- d.	find the dealer and client who reside in the same city
SELECT * FROM client c
INNER JOIN dealer d on c.dealer_id = d.id
WHERE c.city = d.location;

-- e.	find sell id, amount, client name, city those sells where sell amount exists between 200 and 500
SELECT s.id, s.amount, c.name, c.city
FROM sell s
INNER JOIN client c on c.id = s.client_id
WHERE s.amount between 200 and 500;

-- f.	find dealers who works either for one or more client or not yet join under any of the clients
SELECT distinct d.name, d.id, c.number_of_clients
FROM dealer d
INNER JOIN (SELECT count(c.dealer_id) as number_of_clients, c.dealer_id as d_id
            FROM client c
            GROUP BY dealer_id) c
on d.id = c.d_id;

-- g.	find the dealers and the clients he service, return client name, city, dealer name, commission.
SELECT c.name, c.city, d.name, d.commission
FROM dealer d
INNER JOIN client c on d.id = c.dealer_id;

-- h.	find client name, client city, dealer, commission those dealers who received a commission from the sell more than 13%

SELECT c.name, c.city, d.name, d.commission
FROM client c
INNER JOIN dealer d on d.id = c.dealer_id
WHERE d.commission > 0.13;

-- i.	make a report with client name, city, sell id, sell date, sell amount, dealer name
    -- and commission to find that either any of the existing clients haven’t made a purchase(sell)
    -- or made one or more purchase(sell) by their dealer or by own.
SELECT c.name, c.city, s.id, s.date, s.amount, d.name, d.commission
FROM client c
RIGHT JOIN dealer d on d.id = c.dealer_id
RIGHT JOIN sell s on c.id = s.client_id
ORDER BY c.name;


-- 2.	Create following views:
-- a.	count the number of unique clients, compute average and total purchase amount of client orders by each date.
CREATE OR REPLACE VIEW view_a
AS
    SELECT count(*) as number_of_clients, AVG(s.amount) as average, SUM(s.amount) as total, s.date
    FROM client c
    INNER JOIN sell s on c.id = s.client_id
    GROUP BY s.date;

-- b.	find top 5 dates with the greatest total sell amount
CREATE OR REPLACE VIEW view_b
AS
    SELECT s.date
    FROM sell s
    GROUP BY s.date
    ORDER BY SUM(s.amount) DESC
    LIMIT 5;

-- c.	count the number of sales, compute average and total amount of all sales of each dealer
CREATE OR REPLACE VIEW view_c
AS
    SELECT d.id, COUNT(s.*), coalesce(AVG(s.amount), 0) as average, coalesce(SUM(s.amount), 0) as total
    FROM sell s
    RIGHT JOIN dealer d on d.id = s.dealer_id
    GROUP BY d.id;

-- d.	compute how much all dealers earned from commission (total sell amount * commission) in each location
CREATE OR REPLACE VIEW view_d
AS
    SELECT sum(s1 * d.commission), d.location as earned
        FROM (SELECT sum(s.amount) as s1, d.id as dealer_id
              FROM sell s
              INNER JOIN dealer d on d.id = s.dealer_id
              GROUP BY d.id) total_dealer
        INNER JOIN dealer d on total_dealer.dealer_id = d.id
        GROUP BY d.location;

-- e.	compute number of sales, average and total amount of all sales dealers made in each location
create or replace view view_e
as
    select count(*), avg(s.amount), sum(s.amount)
    from sell s
    inner join dealer d on d.id = s.dealer_id
    group by d.location;


-- f.	compute number of sales, average and total amount of expenses in each city clients made.
create or replace view view_f
as
    select c.city, count(*), avg(s.amount), sum(s.amount)
    from sell s
    inner join client c on c.id = s.client_id
    group by c.city;

-- g.	find cities where total expenses more than total amount of sales in locations
create or replace view view_g
as
    select t1.loc1, t1.total1 as total_sales, t2.total2 as total_expenses
    from (select d.location as loc1, sum(s.amount) as total1
          from sell s
          inner join dealer d on d.id = s.dealer_id
          group by d.location) t1
    inner join (select c.city as loc2, sum(s2.amount) as total2
                from sell s2
                inner join client c on s2.client_id = c.id
                group by c.city) t2
    on t1.loc1 = t2.loc2
    where t2.total2 > t1.total1;








-- drop table client;
-- drop table dealer;
-- drop table sell;
