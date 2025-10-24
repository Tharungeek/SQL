-- SELECT STATEMENET

-- the SELECT statement is used to work with columns and specify what columns you want to work see in your output. There are a few other things as well that
-- we will discuss throughout this video

#We can also select a specefic number of column based on our requirement. 

#Now remember we can just select everything by saying:
SELECT * 
FROM parks_and_recreation.employee_demographics;


#Let's try selecting a specific column
SELECT first_name
FROM employee_demographics;

#As you can see from the output, we only have the one column here now and don't see the others

#Now let's add some more columns, we just need to separate the columns with columns
SELECT first_name, last_name
FROM employee_demographics;

#Now the order doesn't normall matter when selecting your columns.
#There are some use cases we will look at in later modules where the order of the column
#Names in the select statement will matter, but for this you can put them in any order

SELECT last_name, first_name, gender, age
FROM employee_demographics;

#You'll also often see SQL queries formatted like this.
SELECT last_name, 
first_name, 
gender, 
age
FROM employee_demographics;

#The query still runs the exact same, but it is easier to read and pick out the columns
#being selected and what you're doing with them.

#For example let's take a look at using a calculation in the select statement

#You can see here we have the total_money_spent - we can perform calculations on this
SELECT first_name,
 last_name,
 total_money_spent,
 total_money_spent + 100
FROM customers;

#See how it's pretty easy to read and to see which columns we are using.

#Math in SQL does follow PEMDAS which stands for Parenthesis, Exponent, Multiplication,
#Division, Addition, subtraction - it's the order of operation for math

#For example - What will the output be?:
SELECT first_name, 
last_name,
salary,
salary + 100
FROM employee_salary;
#This is going to do 10* 100 which is 1000 and then adds the original 540

#Now what will the output be when we do this?
SELECT first_name, 
last_name,
salary,
(salary + 100) * 10
FROM employee_salary;


# Pemdas

#One thing I wanted to show you about the select statement in this lesson is the DISTINCT Statement - this will return only unique values in
#The output - and you won't have any duplicates

SELECT department_id
FROM employee_salary;

SELECT DISTINCT department_id
FROM employee_salary;

#Now a lot happens in the select statement. We have an entire module dedicated to just the 
#select statement so this is kind of just an introduction to the select statement.


#WHERE Clause:
#-------------
#The WHERE clause is used to filter records (rows of data)

#It's going to extract only those records that fulfill a specified condition.

# So basically if we say "Where name is = 'Alex' - only rows were the name = 'Alex' will return
# So this is only effecting the rows, not the columns


#Let's take a look at how this looks
SELECT *
FROM employee_salary
WHERE salary > 50000;

SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM employee_demographics
WHERE gender = 'Female';


#We can also return rows that do have not "Scranton"
SELECT *
FROM employee_demographics
WHERE gender != 'Female';


#We can use WHERE clause with date value also
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01';

-- Here '1990-01-01' is the default data formate in MySQL.
-- There are other date formats as well that we will talk about in a later lesson.


# LIKE STATEMENT

-- two special characters a % and a _

-- % means anything
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%';

-- _ means a specific value
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__';


SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%';





-- LIMIT and ALIASING

-- Limit is just going to specify how many rows you want in the output


SELECT *
FROM employee_demographics
LIMIT 3;

-- if we change something like the order or use a group by it would change the output

SELECT *
FROM employee_demographics
ORDER BY first_name
LIMIT 3;

-- now there is an additional paramater in limit which we can access using a comma that specifies the starting place

SELECT *
FROM employee_demographics
ORDER BY first_name;

SELECT *
FROM employee_demographics
ORDER BY first_name
LIMIT 3,2;

-- this now says start at position 3 and take 2 rows after that
-- this is not used a lot in my opinion

-- you could us it if you wanted to select the third oldest person by doing this:
SELECT *
FROM employee_demographics
ORDER BY age desc;
-- we can see it's Donna - let's try to select her
SELECT *
FROM employee_demographics
ORDER BY age desc
LIMIT 2,1;


-- ALIASING

-- aliasing is just a way to change the name of the column (for the most part)
-- it can also be used in joins, but we will look at that in the intermediate series


SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
;
-- we can use the keyword AS to specify we are using an Alias
SELECT gender, AVG(age) AS Avg_age
FROM employee_demographics
GROUP BY gender
;

-- although we don't actually need it, but it's more explicit which I usually like
SELECT gender, AVG(age) Avg_age
FROM employee_demographics
GROUP BY gender
;





-- Having vs Where

-- Both were created to filter rows of data, but they filter 2 separate things
-- Where is going to filters rows based off columns of data
-- Having is going to filter rows based off aggregated columns when grouped

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
;


-- let's try to filter on the avg age using where

SELECT gender, AVG(age)
FROM employee_demographics
WHERE AVG(age) > 40
GROUP BY gender
;
-- this doesn't work because of order of operations. On the backend Where comes before the group by. So you can't filter on data that hasn't been grouped yet
-- this is why Having was created

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT gender, AVG(age) as AVG_age
FROM employee_demographics
GROUP BY gender
HAVING AVG_age > 40
;

-- Group By
-- When you use the GROUP BY clause in a MySQL query, it groups together rows that have the same values in the specified column or columns.
-- GROUP BY is going to allow us to group rows that have the same data and run aggregate functions on them

SELECT *
FROM employee_demographics;

-- when you use group by  you have to have the same columns you're grouping on in the group by statement
SELECT gender
FROM employee_demographics
GROUP BY gender
;


SELECT first_name
FROM employee_demographics
GROUP BY gender
;





SELECT occupation
FROM employee_salary
GROUP BY occupation
;

-- notice there is only one office manager row

-- when we group by 2 columns we now have a row for both occupation and salary because salary is different
SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary
;

-- now the most useful reason we use group by is so we can perform out aggregate functions on them
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
;

SELECT gender, MIN(age), MAX(age), COUNT(age),AVG(age)
FROM employee_demographics
GROUP BY gender
;



#10 - The ORDER BY clause:
-------------------------
#The ORDER BY keyword is used to sort the result-set in ascending or descending order.

#The ORDER BY keyword sorts the records in ascending order by default. To sort the records in descending order, use the DESC keyword.


#So let's try it out with our customer table
#First let's start simple with just ordering by one column
SELECT *
FROM customers
ORDER BY first_name;

#You can see that first name is ordered from a - z or Ascending.

#We can change that by specifying DESC after it
SELECT *
FROM employee_demographics;

-- if we use order by it goes a to z by default (ascending order)
SELECT *
FROM employee_demographics
ORDER BY first_name;

-- we can manually change the order by saying desc
SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

#Now we can also do multiple columns like this:

SELECT *
FROM employee_demographics
ORDER BY gender, age;

SELECT *
FROM employee_demographics
ORDER BY gender DESC, age DESC;



#now we don't actually have to spell out the column names. We can actually just use their column position

#State is in position 8 and money is in 9, we can use those as well.
SELECT *
FROM employee_demographics
ORDER BY 5 DESC, 4 DESC;

#Now best practice is to use the column names as it's more overt and if columns are added or replaced or something in this table it will still use the right columns to order on.

#So that's all there is to order by - fairly straight forward, but something I use for most queries I use in SQL








-- Case Statements

-- A Case Statement allows you to add logic to your Select Statement, sort of like an if else statement in other programming languages or even things like Excel



SELECT * 
FROM employee_demographics;


SELECT first_name, 
last_name, 
CASE
	WHEN age <= 30 THEN 'Young'
END
FROM employee_demographics;


--

SELECT first_name, 
last_name, 
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Old'
    WHEN age >= 50 THEN "On Death's Door"
END
FROM employee_demographics;

-- Poor Jerry

-- Now we don't just have to do simple labels like we did, we can also perform calculations

-- Let's look at giving bonuses to employees

SELECT * 
FROM employee_salary;

-- Pawnee Council sent out a memo of their bonus and pay increase structure so we need to follow it
-- Basically if they make less than 45k then they get a 5% raise - very generous
-- if they make more than 45k they get a 7% raise
-- they get a bonus of 10% if they work for the Finance Department

SELECT first_name, last_name, salary,
CASE
	WHEN salary > 45000 THEN salary + (salary * 0.05)
    WHEN salary < 45000 THEN salary + (salary * 0.07)
END AS new_salary
FROM employee_salary;

-- Unfortunately Pawnee Council was extremely specific in their wording and Jerry was not included in the pay increases. Maybe Next Year.

-- Now we need to also account for Bonuses, let's make a new column
SELECT first_name, last_name, salary,
CASE
	WHEN salary > 45000 THEN salary + (salary * 0.05)
    WHEN salary < 45000 THEN salary + (salary * 0.07)
END AS new_salary,
CASE
	WHEN dept_id = 6 THEN salary * .10
END AS Bonus
FROM employee_salary;

-- as you can see Ben is the only one who get's a bonus





  -- Joins

-- joins allow you to combine 2 tables together (or more) if they have a common column.
-- doesn't mean they need the same column name, but the data in it are the same and can be used to join the tables together
-- there are several joins we will look at today, inner joins, outer joins, and self joins


-- here are the first 2 tables - let's see what columns and data in the rows we have in common that we can join on
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

-- let's start with an inner join -- inner joins return rows that are the same in both columns

-- since we have the same columns we need to specify which table they're coming from
SELECT *
FROM employee_demographics
JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id;

-- notice Ron Swanson isn't in the results? This is because he doesn't have an employee id in the demographics table. He refused to give his birth date or age or gender

-- use aliasing!
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;


-- OUTER JOINS

-- for outer joins we have a left and a right join
-- a left join will take everything from the left table even if there is no match in the join, but will only return matches from the right table
-- the exact opposite is true for a right join

SELECT *
FROM employee_salary sal
LEFT JOIN employee_demographics dem
	ON dem.employee_id = sal.employee_id;

-- so you'll notice we have everything from the left table or the salary table. Even though there is no match to ron swanson. 
-- Since there is not match on the right table it's just all Nulls

-- if we just switch this to a right join it basically just looks like an inner join
-- that's because we are taking everything from the demographics table and only matches from the left or salary table. Since they have all the matches
-- it looks kind of like an inner join
SELECT *
FROM employee_salary sal
RIGHT JOIN employee_demographics dem
	ON dem.employee_id = sal.employee_id;



-- Self Join

-- a self join is where you tie a table to itself

SELECT *
FROM employee_salary;

-- what we could do is a secret santa so the person with the higher ID is the person's secret santa


SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id = emp2.employee_id
    ;

-- now let's change it to give them their secret santa
SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1  = emp2.employee_id
    ;



SELECT emp1.employee_id as emp_santa, emp1.first_name as santa_first_name, emp1.last_name as santa_last_name, emp2.employee_id, emp2.first_name, emp2.last_name
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1  = emp2.employee_id
    ;

-- So leslie is Ron's secret santa and so on -- Mark Brandanowitz didn't get a secret santa, but he doesn't deserve one because he broke Ann's heart so it's all good






-- Joining multiple tables

-- now we have on other table we can join - let's take a look at it
SELECT * 
FROM parks_and_recreation.parks_departments;


SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
JOIN parks_departments dept
	ON dept.department_id = sal.dept_id;

-- now notice when we did that, since it's an inner join it got rid of andy because he wasn't a part of any department

-- if we do a left join we would still include him because we are taking everything from the left table which is the salary table in this instance
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
LEFT JOIN parks_departments dept
	ON dept.department_id = sal.dept_id;



#Now let's look at string functions. These help us change and look at strings differently.

SELECT * 
FROM bakery.customers;


#Length will give us the length of each value
SELECT LENGTH('sky');

#Now we can see the length of each name
SELECT first_name, LENGTH(first_name) 
FROM employee_demographics;

#Upper will change all the string characters to upper case
SELECT UPPER('sky');

SELECT first_name, UPPER(first_name) 
FROM employee_demographics;

#lower will change all the string characters to lower case
SELECT LOWER('sky');

SELECT first_name, LOWER(first_name) 
FROM employee_demographics;

#Now if you have values that have white space on the front or end, we can get rid of that white space using TRIM
SELECT TRIM('sky'   );

#Now if we have white space in the middle it doesn't work
SELECT LTRIM('     I           love          SQL');

#There's also L trim for trimming just the left side
SELECT LTRIM('     I love SQL');


#There's also R trim for trimming just the Right side
SELECT RTRIM('I love SQL    ');


#Now we have Left. Left is going to allow us to take a certain amount of strings from the left hand side.
SELECT LEFT('Alexander', 4);

SELECT first_name, LEFT(first_name,4) 
FROM employee_demographics;

#Right is basically the opposite - taking it starting from the right side
SELECT RIGHT('Alexander', 6);

SELECT first_name, RIGHT(first_name,4) 
FROM employee_demographics;

#Now let's look at substring, this one I personally love and use a lot.
#Substring allows you to specify a starting point and how many characters you want so you can take characters from anywhere in the string. 
SELECT SUBSTRING('Alexander', 2, 3);

#We could use this on phones to get the area code at the beginning.
SELECT birth_date, SUBSTRING(birth_date,1,4) as birth_year
FROM employee_demographics;

#We can also use replace
SELECT REPLACE(first_name,'a','z')
FROM employee_demographics;

#Next we have locate - we have 2 arguments we can use here: we can specify what we are searching for and where to search
#It will return the position of that character in the string.
SELECT LOCATE('x', 'Alexander');

#Now Alexander has 2 e's - what will happen if we try to locate it
SELECT LOCATE('e', 'Alexander');
#It will return the location of just the first position.

#Let's try it on our first name
SELECT first_name, LOCATE('a',first_name) 
FROM employee_demographics;

#You can also locate longer strings
SELECT first_name, LOCATE('Mic',first_name) 
FROM employee_demographics;

#Now let's look at concatenate - it will combine the strings together
SELECT CONCAT('Alex', 'Freberg');

#Here we can combine the first and the last name columns together
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;








  # Subqueries

#So subqueries are queries within queries. Let's see how this looks.

SELECT *
FROM employee_demographics;


#Now let's say we wanted to look at employees who actually work in the Parks and Rec Department, we could join tables together or we could use a subquery
#We can do that like this:

SELECT *
FROM employee_demographics
WHERE employee_id IN 
			(SELECT employee_id
				FROM employee_salary
                WHERE dept_id = 1);
                
#So we are using that subquery in the where statement and if we just highlight the subwuery and run it it's basically a list we are selecting from in the outer query

SELECT *
FROM employee_demographics
WHERE employee_id IN 
			(SELECT employee_id, salary
				FROM employee_salary
                WHERE dept_id = 1);

# now if we try to have more than 1 column in the subquery we get an error saying the operand should contain 1 column only 

#We can also use subqueries in the select and the from statements - let's see how we can do this

-- Let's say we want to look at the salaries and compare them to the average salary

SELECT first_name, salary, AVG(salary)
FROM employee_salary;
-- if we run this it's not going to work, we are using columns with an aggregate function so we need to use group by
-- if we do that though we don't exactly get what we want
SELECT first_name, salary, AVG(salary)
FROM employee_salary
GROUP BY first_name, salary;

-- it's giving us the average PER GROUP which we don't want
-- here's a good use for a subquery

SELECT first_name, 
salary, 
(SELECT AVG(salary) 
	FROM employee_salary)
FROM employee_salary;


-- We can also use it in the FROM Statement
-- when we use it here it's almost like we are creating a small table we are querying off of
SELECT *
FROM (SELECT gender, MIN(age), MAX(age), COUNT(age),AVG(age)
FROM employee_demographics
GROUP BY gender) 
;
-- now this doesn't work because we get an error saying we have to name it

SELECT gender, AVG(Min_age)
FROM (SELECT gender, MIN(age) Min_age, MAX(age) Max_age, COUNT(age) Count_age ,AVG(age) Avg_age
FROM employee_demographics
GROUP BY gender) AS Agg_Table
GROUP BY gender
;








  #UNIONS


#A union is how you can combine rows together- not columns like we have been doing with joins where one column is put next to another
#Joins allow you to combine the rows of data

#Now you should keep it the same kind of data otherwise if you start mixing tips with first_names it would be really confusing, but you can do it.
#Let's try it out and use Union to bring together some random data, then we will look at an actual use case

SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT occupation, salary
FROM employee_salary;

#So you can see we basically combined the data together, but not side by side in different columns, but one on top of the other in the same columns
#This obviously is not good since you're mixing data, but it can be done if you want.

SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary;

-- notice it gets rid of duplicates? Union is actually shorthand for Union Distinct

SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary;

-- we can use UNION ALL to show all values

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;



#Now Let's actually try to use UNION
# The Parks department is trying to cut their budget and wants to identify older employees they can push out or high paid employees who they can reduce pay or push out
-- let's create some queries to help with this

SELECT first_name, last_name, 'Old'
FROM employee_demographics
WHERE age > 50;



SELECT first_name, last_name, 'Old Lady' as Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Old Man'
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Highly Paid Employee'
FROM employee_salary
WHERE salary >= 70000
ORDER BY first_name
;






  -- Window Functions

-- windows functions are really powerful and are somewhat like a group by - except they don't roll everything up into 1 row when grouping. 
-- windows functions allow us to look at a partition or a group, but they each keep their own unique rows in the output
-- we will also look at things like Row Numbers, rank, and dense rank

SELECT * 
FROM employee_demographics;

-- first let's look at group by
SELECT gender, ROUND(AVG(salary),1)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
;

-- now let's try doing something similar with a window function

SELECT dem.employee_id, dem.first_name, gender, salary,
AVG(salary) OVER()
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- now we can add any columns and it works. We could get this exact same output with a subquery in the select statement, 
-- but window functions have a lot more functionality, let's take a look


-- if we use partition it's kind of like the group by except it doesn't roll up - it just partitions or breaks based on a column when doing the calculation

SELECT dem.employee_id, dem.first_name, gender, salary,
AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


-- now if we wanted to see what the salaries were for genders we could do that by using sum, but also we could use order by to get a rolling total

SELECT dem.employee_id, dem.first_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY employee_id)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


-- Let's look at row_number rank and dense rank now


SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- let's  try ordering by salary so we can see the order of highest paid employees by gender
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- let's compare this to rank
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc) row_num,
Rank() OVER(PARTITION BY gender ORDER BY salary desc) rank_1 
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- notice rank repeats on tom ad jerry at 5, but then skips 6 to go to 7 -- this goes based off positional rank


-- let's compare this to dense rank
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc) row_num,
Rank() OVER(PARTITION BY gender ORDER BY salary desc) rank_1,
dense_rank() OVER(PARTITION BY gender ORDER BY salary desc) dense_rank_2 -- this is numerically ordered instead of positional like rank
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;






  -- Using Common Table Expressions (CTE)
-- A CTE allows you to define a subquery block that can be referenced within the main query. 
-- It is particularly useful for recursive queries or queries that require referencing a higher level
-- this is something we will look at in the next lesson/

-- Let's take a look at the basics of writing a CTE:


-- First, CTEs start using a "With" Keyword. Now we get to name this CTE anything we want
-- Then we say as and within the parenthesis we build our subquery/table we want
WITH CTE_Example AS 
(
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary), AVG(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- directly after using it we can query the CTE
SELECT *
FROM CTE_Example;


-- Now if I come down here, it won't work because it's not using the same syntax
SELECT *
FROM CTE_Example;



-- Now we can use the columns within this CTE to do calculations on this data that
-- we couldn't have done without it.

WITH CTE_Example AS 
(
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- notice here I have to use back ticks to specify the table names  - without them it doesn't work
SELECT gender, ROUND(AVG(`SUM(salary)`/`COUNT(salary)`),2)
FROM CTE_Example
GROUP BY gender;



-- we also have the ability to create multiple CTEs with just one With Expression

WITH CTE_Example AS 
(
SELECT employee_id, gender, birth_date
FROM employee_demographics dem
WHERE birth_date > '1985-01-01'
), -- just have to separate by using a comma
CTE_Example2 AS 
(
SELECT employee_id, salary
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000
)
-- Now if we change this a bit, we can join these two CTEs together
SELECT *
FROM CTE_Example cte1
LEFT JOIN CTE_Example2 cte2
	ON cte1. employee_id = cte2. employee_id;


-- the last thing I wanted to show you is that we can actually make our life easier by renaming the columns in the CTE
-- let's take our very first CTE we made. We had to use tick marks because of the column names

-- we can rename them like this
WITH CTE_Example (gender, sum_salary, min_salary, max_salary, count_salary) AS 
(
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- notice here I have to use back ticks to specify the table names  - without them it doesn't work
SELECT gender, ROUND(AVG(sum_salary/count_salary),2)
FROM CTE_Example
GROUP BY gender;






  -- So let's look at how we can create a stored procedure

-- First let's just write a super simple query
SELECT *
FROM employee_salary
WHERE salary >= 60000;

-- Now let's put this into a stored procedure.
CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 60000;

-- Now if we run this it will work and create the stored procedure
-- we can click refresh and see that it is there

-- notice it did not give us an output, that's because we 

-- If we want to call it and use it we can call it by saying:
CALL large_salaries();

-- as you can see it ran the query inside the stored procedure we created


-- Now how we have written is not actually best practice.alter
-- Usually when writing a stored procedure you don't have a simple query like that. It's usually more complex

-- if we tried to add another query to this stored procedure it wouldn't work. It's a separate query:
CREATE PROCEDURE large_salaries2()
SELECT *
FROM employee_salary
WHERE salary >= 60000;
SELECT *
FROM employee_salary
WHERE salary >= 50000;


-- Best practice is to use a delimiter and a Begin and End to really control what's in the stored procedure
-- let's see how we can do this.
-- the delimiter is what separates the queries by default, we can change this to something like two $$
-- in my career this is what I've seen a lot of people who work in SQL use so I've picked it up as well

-- When we change this delimiter it now reads in everything as one whole unit or query instead of stopping
-- after the first semi colon
DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
END $$

-- now we change the delimiter back after we use it to make it default again
DELIMITER ;

-- let's refresh to see the SP
-- now we can run this stored procedure
CALL large_salaries2();

-- as you can see we have 2 outputs which are the 2 queries we had in our stored procedure



-- we can also create a stored procedure by right clicking on Stored Procedures and creating one:

-- it's going to drop the procedure if it already exists.
USE `parks_and_recreation`;
DROP procedure IF EXISTS `large_salaries3`;
-- it automatically adds the dilimiter for us
DELIMITER $$
CREATE PROCEDURE large_salaries3()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
END $$

DELIMITER ;

-- and changes it back at the end

-- this can be a genuinely good option to help you write your Stored Procedures faster, although either way
-- works

-- if we click finish you can see it is created the same and if we run it

CALL large_order_totals3();

-- we get our results



-- -------------------------------------------------------------------------

-- we can also add parameters
USE `parks_and_recreation`;
DROP procedure IF EXISTS `large_salaries3`;
-- it automatically adds the dilimiter for us
DELIMITER $$
CREATE PROCEDURE large_salaries3(employee_id_param INT)
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000
    AND employee_id_param = employee_id;
END $$

DELIMITER ;



CALL large_salaries3(1);








  -- Using Temporary Tables
-- Temporary tables are tables that are only visible to the session that created them. 
-- They can be used to store intermediate results for complex queries or to manipulate data before inserting it into a permanent table.

-- There's 2 ways to create temp tables:
-- 1. This is the less commonly used way - which is to build it exactly like a real table and insert data into it

CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

-- if we execute this it gets created and we can actualyl query it.

SELECT *
FROM temp_table;
-- notice that if we refresh out tables it isn't there. It isn't an actual table. It's just a table in memory.

-- now obviously it's balnk so we would need to insert data into it like this:

INSERT INTO temp_table
VALUES ('Alex','Freberg','Lord of the Rings: The Twin Towers');

-- now when we run it and execute it again we have our data
SELECT *
FROM temp_table;

-- the second way is much faster and my preferred method
-- 2. Build it by inserting data into it - easier and faster

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary > 50000;

-- if we run this query we get our output
SELECT *
FROM temp_table_2;

-- this is the primary way I've used temp tables especially if I'm just querying data and have some complex data I want to put into boxes or these temp tables to use later
-- it helps me kind of categorize and separate it out

-- In the next lesson we will look at the Temp Tables vs CTEs













  -- Triggers

-- a Trigger is a block of code that executes automatically executes when an event takes place in a table.

-- for example we have these 2 tables, invoice and payments - when a client makes a payment we want it to update the invoice field "total paid"
-- to reflect that the client has indeed paid their invoice


SELECT * FROM employee_salary;

SELECT * FROM employee_demographics;

-- so really when we get a new row or data is inserted into the payments table we want a trigger to update the correct invoice 
-- with the amount that was paid
-- so let's write this out
USE parks_and_recreation;
DELIMITER $$

CREATE TRIGGER employee_insert2
    -- we can also do BEFORE, but for this lesson we have to do after
	AFTER INSERT ON employee_salary
    -- now this means this trigger gets activated for each row that is inserted. Some sql databses like MSSQL have batch triggers or table level triggers that
    -- only trigger once, but MySQL doesn't have this functionality unfortunately
    FOR EACH ROW
    
    -- now we can write our block of code that we want to run when this is triggered
BEGIN
-- we want to update our client invoices table
-- and set the total paid = total_paid (if they had already made some payments) + NEW.amount_paid
-- NEW says only from the new rows that were inserted. There is also OLD which is rows that were deleted or updated, but for us we want NEW
    INSERT INTO employee_demographics (employee_id, first_name, last_name) VALUES (NEW.employee_id,NEW.first_name,NEW.last_name);
END $$

DELIMITER ; 

-- Now let's run it and create it


-- Now that it's created let's test it out.

-- Let's insert a payment into the payments table and see if it updates in the Invoice table.

-- so let's put the values that we want to insert - let's pay off this invoice 3 in full
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);
-- now it was updated in the payments table and the trigger was triggered and update the corresponding values in the invoice table

DELETE FROM employee_salary
WHERE employee_id = 13;



-- -------------------------------------------------------------------------

-- now let's look at Events

-- Now I usually call these "Jobs" because I called them that for years in MSSQL, but in MySQL they're called Events

-- Events are task or block of code that gets executed according to a schedule. These are fantastic for so many reasons. Importing data on a schedule. 
-- Scheduling reports to be exported to files and so many other things
-- you can schedule all of this to happen every day, every monday, every first of the month at 10am. Really whenever you want

-- This really helps with automation in MySQL

-- let's say Parks and Rec has a policy that anyone over the age of 60 is immediately retired with lifetime pay
-- All we have to do is delete them from the demographics table

SELECT * 
FROM parks_and_recreation.employee_demographics;

SHOW EVENTS;

-- we can drop or alter these events like this:
DROP EVENT IF EXISTS delete_retirees;
DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO BEGIN
	DELETE
	FROM parks_and_recreation.employee_demographics
    WHERE age >= 60;
END $$


-- if we run it again you can see Jerry is now fired -- or I mean retired
SELECT * 
FROM parks_and_recreation.employee_demographics;
