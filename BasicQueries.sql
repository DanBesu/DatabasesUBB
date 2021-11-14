drop table competes;
drop table meal_program;
drop table athlete;
drop table sponsorship
drop table sponsor;
drop table competition;
drop table coach;
drop table gym;
drop table nutritionist;
drop table delivery_boy;
drop table chef;
drop table food_supplier;


create table food_supplier(
	food_supplier_id integer primary key,
	name varchar(30),
	delivery_price integer,
	average_pricing integer
);

create table chef(
	chef_id integer primary key,
	nationality varchar(30),
	chef_name varchar(30),
	salary integer,
	food_supplier_id integer foreign key references food_supplier(food_supplier_id)
);

create table delivery_boy(
	delivery_boy_id integer primary key,
	name varchar(30),
	salary integer,
	vehicle varchar(30)
);

create table nutritionist(
	nutritionist_id integer primary key,
	name varchar(30),
	salary integer, 
	specialty varchar(60)
);

create table gym(
	gym_id integer primary key,
	name varchar(30),
	subscription_price integer
);

create table coach(
	coach_id integer primary key,
	name varchar(30),
	salary integer,
	experience integer,
	gym_id integer foreign key references gym(gym_id)
);


create table competition(
	competition_id integer primary key,
	name varchar(30),
	date date,
	level varchar(20),
);

create table sponsor(
    sponsor_id integer primary key,
    name varchar(30),
);

create table sponsorship(
    sponsor_id integer foreign key references sponsor(sponsor_id),
    competition_id integer foreign key references competition(competition_id),
    budget integer 
);

create table athlete (
	athlete_id integer primary key,
	name varchar(30),
	experience integer,
	phase varchar(30),
	nutritionist_id integer foreign key references nutritionist(nutritionist_id),
	delivery_boy_id integer foreign key references delivery_boy(delivery_boy_id),
	coach_id integer foreign key references coach(coach_id)
);

create table competes (
	athlete_id integer foreign key references athlete(athlete_id),
	competition_id integer foreign key references competition(competition_id),
	constraint pk_competes primary key (athlete_id, competition_id)
);

create table meal_program(
	meal_program_id integer primary key,
	category varchar(30),
	nr_protein integer,
	nr_carbs integer, 
	nr_fats integer, 
	nr_kcals integer, 
	chef_id integer foreign key references chef(chef_id),
	athlete_id integer unique foreign key references athlete(athlete_id)
);


-------     INSERT      --**--

insert into gym(gym_id, name, subscription_price)
	values(31, 'Bamboo Fitness', 170);

insert into gym(gym_id, name, subscription_price)
	values(32, 'Revo Gym', 150);

-------

insert into coach(coach_id, name, salary, experience, gym_id)
	values (21, 'Chris', 11000, 20, 31);

insert into coach(coach_id, name, salary, experience, gym_id)
	values (22, 'Jeff', 8900, 8, 32);

insert into coach(coach_id, name, salary, experience, gym_id)
	values (23, 'Mike', 8000, 7, 32);

insert into coach(coach_id, name, salary, experience, gym_id)
	values (24, 'Venus', 9500, 9, 31);

insert into coach(coach_id, name, salary, experience, gym_id)
	values (20, 'Miranda', 4100, 3, 31);

------

insert into nutritionist(nutritionist_id, name, salary, specialty)
	values (11, 'Friederich', 5000, 'Vegan');

insert into nutritionist(nutritionist_id, name, salary, specialty)
	values (12, 'Jake', 4800, 'Cut');

insert into nutritionist(nutritionist_id, name, salary, specialty)
	values (13, 'Boris', 3700, 'Bulk');

-----

insert into athlete(athlete_id, name, experience, phase, nutritionist_id, coach_id)
	values (1, 'Alex', 2, 'Bulk', 13, 22);

insert into athlete(athlete_id, name, experience, phase, nutritionist_id, coach_id)
	values (2, 'Paul', 1, 'Bulk', 13, 24);

insert into athlete(athlete_id, name, experience, phase, nutritionist_id, coach_id)
	values (3, 'Andrei', 7, 'Off Season', 13, 24);

insert into athlete(athlete_id, name, experience, phase, nutritionist_id, coach_id)
	values (4, 'Marcu', 1, 'Vegan', 11, 24);

insert into athlete(athlete_id, name, experience, phase, nutritionist_id, coach_id)
	values (5, 'Ionut', 10, 'Cut', 12, 21);

-- insert into athlete(athlete_id, name, experience, phase, nutritionist_id, coach_id)
-- 	values (5, 'Ionut', 5, 'Cut', 12, 21);
-- error: duplicate athlete_id

-----

insert into competition(competition_id, name, [date], level)
	values(61, 'IPF WORDS', '2021-10-25', 'Junior');

insert into competition(competition_id, name, [date], level)
	values(62, 'IPF WORDS', '2021-10-26', 'Senior');

insert into competition(competition_id, name, [date], level)
	values(63, 'Romanian Nationals', '2021-08-25', 'Junior');

insert into competition(competition_id, name, [date], level)
	values(64, 'Romanian Nationals', '2021-08-26', 'Senior');

-----

insert into competes(athlete_id, competition_id)
	values(1, 63)

insert into competes(athlete_id, competition_id)
	values(1, 64)

insert into competes(athlete_id, competition_id)
	values(1, 61)

insert into competes(athlete_id, competition_id)
	values(5, 62)

insert into competes(athlete_id, competition_id)
	values(5, 64)

insert into competes(athlete_id, competition_id)
	values(2, 63)

-----

insert into food_supplier(food_supplier_id, name, delivery_price, average_pricing)
	values (41, 'Carrefour', 10, 2700);

insert into food_supplier(food_supplier_id, name, delivery_price, average_pricing)
	values (42, 'Kaufland', 8, 3500);

-----

insert into chef(chef_id, nationality, chef_name, salary, food_supplier_id)
	values (51, 'Spanish', 'Pedro', 4200, 41);

insert into chef(chef_id, nationality, chef_name, salary, food_supplier_id)
	values (52, 'Japanese', 'Asahi', 4600, 42);

insert into chef(chef_id, nationality, chef_name, salary, food_supplier_id)
	values (53, 'Spanish', 'Raphael', 4200, 42);

insert into chef(chef_id, nationality, chef_name, salary, food_supplier_id)
	values (54, 'Scandinavian', 'Bjorn', 4900, 41);

-----

insert into sponsor(sponsor_id, name)
	values (71, 'Rogue');

insert into sponsor(sponsor_id, name)
	values (72, 'SBD');

insert into sponsor(sponsor_id, name)
    values(73, 'Eleiko')

-----

insert into sponsorship(sponsor_id, competition_id, budget)
	values (71, 64, 3000)

insert into sponsorship(sponsor_id, competition_id, budget)
	values (72, 63, 4000)

insert into sponsorship(sponsor_id, competition_id, budget)
	values (73, 64, 3000)

insert into sponsorship(sponsor_id, competition_id, budget)
	values (71, 61, 3000)

insert into sponsorship(sponsor_id, competition_id, budget)
	values (72, 61, 3000)

insert into sponsorship(sponsor_id, competition_id, budget)
	values (73, 62, 3000)

insert into sponsorship(sponsor_id, competition_id, budget)
	values (71, 63, 3000)

-------     UPDATE / DELETE      --**--

--  or  =  arithmetic expr
insert into athlete(athlete_id, name, experience, phase, nutritionist_id, coach_id)
	values (6, 'Mihai', 10, 'Cut', 12, 21);

update athlete
set experience = experience + 2
where athlete_id = 6 or name = 'Mihai'

delete athlete
where athlete_id = 6 or name = 'Johny'

-- >=  <=  and  like  in  not null  arithmetic expr
insert into nutritionist(nutritionist_id, name, salary, specialty)
	values (14, 'Antonio', 300, 'Bulking');

update nutritionist
set salary = salary * 2
where nutritionist_id >=14 and salary <=1000 and specialty like 'Bulking%'

delete nutritionist
where name = 'Antonio' and specialty in ('Bulking') and specialty is not null 

insert into nutritionist(nutritionist_id, name, salary, specialty)
	values (14, 'Antonio', 3800, 'Bulking');

-- between  <  not  arithmetic expr
insert into coach(coach_id, name, salary, experience, gym_id)
	values (25, 'Carl', 998, 9, 31);

update coach
set experience = experience - 1
where salary between 997 and 999

delete 
from coach
where not (coach_id < 25 or coach_id >= 26)


-- a. 2 queries with the union operation; use UNION [ALL] and OR
-- a1. union between atheltes with fases cut or vegan and coaches with experience 3 or 4
select distinct A.name
from athlete A
where A.phase = 'cut' or A.phase = 'vegan'
union
select C.name
from coach C
where C.experience = 3 or C.experience = 4
ORDER BY A.name

-- a2. select all athletes that ar bulking or have less than 3 years experience
select distinct A.name
from athlete A
where A.phase = 'bulk' or ( A.experience < 3 and A.experience >= 1)

-- b. 2 queries with the intersection operation; use INTERSECT and IN;
-- b1. Select all athletes that are in phases Bulk and Off Season, that are training with Venus(id=24)
select A.name 
from athlete A
where A.phase IN ('Bulk', 'Off Season')
intersect 
select A.name 
from athlete A
where A.coach_id = 24
-- rewrite this only with in

-- b2. Select all chefs with salary 42 * 100
select * 
from chef C
where C.chef_id IN (
	select c2.chef_id
	from chef c2 

);

-- c. 2 queries with the difference operation; use EXCEPT and NOT IN;
-- c1. Get the difference between the 2 collections:
		-- 1. Get the name of athletes under the nutritionist Boris(id=13), Exept of those that are on Bulking
		-- 2. Get the name of the athletes that are not Vegans, are not Cutting, or Bulking 

-- NOT IN
SELECT DIFFERENCE(
	(
		SELECT A.name
		FROM athlete A
		WHERE A.nutritionist_id = 13
		EXCEPT 
		SELECT A.name
		FROM athlete A
		WHERE A.phase = 'Bulk'
	), 
	(
		SELECT A.name
		FROM athlete A 
		WHERE A.phase NOT IN ('Vegan', 'Bulk', 'Cut')
	)
) AS Difference1 -- difference = 4 (same result)

-- c2. Get the difference between the 2 collections:
		-- 1. Get the nationality of Chefs with salary that is not 4200 or 4900
		-- 2. Get the nationality of Chefs that are getting supplied from Carrefour exept Pedro

SELECT DIFFERENCE(
	(
		SELECT C.nationality
		FROM chef C
		WHERE C.salary not in (4200, 4900)
	), 
	(
		SELECT C.nationality
		FROM chef C
		WHERE C.food_supplier_id = 41
		EXCEPT 
		SELECT C.nationality
		FROM chef C
		WHERE C.chef_name = 'Pedro'
	)
) AS Difference2 -- difference = 1 (different result)

-- d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator); 
	-- one query will join at least 3 tables, while another one will join at least two many-to-many relationships;

-- 3 tables: athlete - coach - gym
	-- right join, left join
	-- all coaches with their athletes and the gyms that are working to
select c.name, a.name, g.name 
from athlete a
right outer join coach c on a.coach_id = c.coach_id
left outer join gym g on c.gym_id = g.gym_id

-- all chefs with their suppliers
	-- left join
select c.chef_name, f.name 
from chef c 
left outer join food_supplier f 
on c.food_supplier_id = f.food_supplier_id

-- all athletes with their phases and all nutritionists with their specialities
	-- full join
select a.name, a.phase, n.name, n.specialty
from athlete a 
full join nutritionist n on a.nutritionist_id = n.nutritionist_id

-- competition table - athletes - competitions - sponsors
-- inner join - 2 many-to-many relationships
select a.name as athlete, c.name as competition, s.name as sponsor 
from athlete a 
inner join competes cmp on a.athlete_id = cmp.athlete_id 
inner join competition c on cmp.competition_id = c.competition_id 
inner join sponsorship sp on c.competition_id = sp.competition_id
inner join sponsor s on sp.sponsor_id = s.sponsor_id


-- e. 2 queries with the IN operator and a subquery in the WHERE clause;
	-- in at least one case, the subquery should include a subquery in its own
	-- WHERE clause;
-- e1. Athletes with Experience >= 2
SELECT *
FROM athlete A
WHERE A.athlete_id IN (
	SELECT A2.athlete_id
	FROM athlete A2 
	WHERE A2.experience >= 2
)

-- e2. Athletes that have coaches at Bamboo Fitness
SELECT TOP 4 * 
FROM athlete A
WHERE A.coach_id IN (
	SELECT C.coach_id
	FROM coach C
	WHERE C.gym_id IN (
		SELECT G.gym_id
		FROM gym G
		WHERE G.name = 'Bamboo Fitness'
	)
)
ORDER BY A.experience

-- f. 2 queries with the EXISTS operator and a subquery in the WHERE clause
-- f1. athletes with nutritionits that have salaries >= 4000
SELECT * 
FROM athlete A
WHERE EXISTS (
	SELECT N.salary
	FROM nutritionist N
	WHERE A.nutritionist_id = N.nutritionist_id AND N.salary >= 4000
)

-- f2. athletes going to Junior competitions
SELECT * 
FROM athlete A
WHERE EXISTS (
	SELECT C.athlete_id
	FROM competes C 
	WHERE A.athlete_id = C.athlete_id AND C.competition_id IN (
		SELECT CMP.competition_id
		FROM competition CMP
		WHERE CMP.level = 'Junior'
	)
)

-- g. 2 queries with a subquery in the FROM clause;
-- g1 coaches with athletes in phases Bulk and Vegan
SELECT DISTINCT Coach.name
FROM(
	SELECT coach_id 
	FROM athlete
	WHERE phase IN ('Bulk', 'Vegan')
) as Athlete, Coach
WHERE Athlete.coach_id = Coach.coach_id
ORDER BY coach.name

-- g2 gyms with coaches with experience >= 6
SELECT DISTINCT gym.name
FROM(
	SELECT gym_id 
	FROM coach
	WHERE experience >= 6
) as coach, gym
WHERE coach.gym_id = gym.gym_id

-- h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 
	-- 2 of the latter will also have a subquery in the HAVING clause; 
	-- use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;

-- h1. The coaches with more athletes than 0
SELECT coach_id, COUNT(coach_id) AS NrOfAthletes
FROM athlete A
GROUP BY A.coach_id
HAVING COUNT(coach_id) > 0;

-- h2. The min of experience for each athlete phase
SELECT A.phase, MIN(A.experience) as min_exp
FROM athlete A
GROUP BY A.phase

-- h3. The athlete with experience more than  2 * average experience
SELECT A.name, AVG(A.experience)
FROM athlete A
GROUP BY A.name
HAVING AVG(A.experience) > 2 * (
   SELECT AVG( experience )
   FROM athlete 
 );

-- h4. The coaches with max experience greater than the sum of experiences of the athletes
SELECT C.name, MAX(C.experience)
FROM coach C
GROUP BY C.name
HAVING MAX(C.experience) >  (
   SELECT SUM( experience )
   FROM athlete 
);

-- i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator);
	-- rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN.

-- i1. coaches with salary > all salaries of nutritionists
-- Are there coaches with salary higher than any nutritionist?
SELECT TOP 85 PERCENT C.name, C.salary
FROM coach C
WHERE C.salary > ALL(
	SELECT N.salary 
	FROM nutritionist N
)

-- rerwritten with MAX
SELECT C.name, C.salary 
FROM coach c 
WHERE C.salary > (
	SELECT MAX(N.salary) 
	FROM nutritionist N
)

-- i2
-- Are there sponsorships with budgets less than any of coaches salary?
SELECT S.sponsor_id, S.competition_id, S.budget 
FROM sponsorship S 
WHERE s.budget < ANY(
	SELECT C.salary 
	FROM coach C
)

-- rerwritten with IN
SELECT S.sponsor_id, S.competition_id, S.budget
FROM sponsorship S 
WHERE s.budget < (
	SELECT MIN(C.salary) 
	FROM coach C
)

-- i3. nutritionists with salaries <  all the salaries of chefs
-- Are there nutritionists with salary less than all salaries of chefs
SELECT N.name, N.salary
FROM nutritionist N
WHERE N.salary != ALL(
	SELECT C.salary
	FROM chef C
)

-- rerwritten with MIN
SELECT N.name, N.salary 
FROM nutritionist N
WHERE N.salary NOT IN (
	SELECT MIN(c.salary)
	from chef C
)

-- i4. athlete with experience =  any of the coaches
-- Are there athletes with experience equal to the experience of any coach?
SELECT A.name, A.experience
FROM athlete  A
WHERE A.experience = ANY(
	SELECT C.experience
	FROM coach C
)

-- rerwritten with IN
SELECT A.name, A.experience
FROM athlete A 
WHERE A.experience IN (
	SELECT C.experience 
	FROM coach C
)

select * from food_supplier
select * from chef
select * from nutritionist
select * from gym
select * from competes
select * from competition
select * from sponsor
select * from sponsorship
select * from athlete
select * from coach
