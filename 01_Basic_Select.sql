/*Query all columns for all American cities in CITY with populations larger than 100000. The CountryCode for America is USA.*/
SELECT * FROM CITY where COUNTRYCODE = "USA" AND POPULATION > 100000;


/* Query a list of CITY names from STATION with even ID numbers only.
You may print the results in any order, but must exclude duplicates from your answer.*/
select distinct city from station where id % 2 = 0;


/*
Let  be the number of CITY entries in STATION,
and let  be the number of distinct CITY names in STATION; query the value of  from STATION.
In other words,
find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
*/
select count(city) - count(distinct city) from station;

/*
Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
*/
select distinct city from station where city REGEXP "^[aeiou].*";

/*
Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
*/
select distinct city from station where city REGEXP ".*[aeiou]$";

/*
Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters.
Your result cannot contain duplicates.
*/
select distinct city from station where city REGEXP "^[aeiou].*[aeiou]$";

/*
Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
*/
select distinct city from station where city REGEXP "^[^aeiou].*";

/*
Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
*/
select distinct city from station where city REGEXP ".*[^aeiou]$";

/*
Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels.
Your result cannot contain duplicates.
*/
select distinct city from station where city REGEXP "^[^aeiou].*|.*[^aeiou]$";

/*
Query the list of CITY names from STATION that do not start with vowels and do not end with vowels.
 Your result cannot contain duplicates.
*/
select distinct city from station where city REGEXP "^[^aeiou].*[^aeiou]$";

/*
Query the Name of any student in STUDENTS who scored higher than  Marks.
Order your output by the last three characters of each name.
If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.),
secondary sort them by ascending ID.
*/
select name from students where marks > 75 ORDER BY RIGHT(NAME, 3), ID ASC;

/*
Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
*/
select name from employee order by name ASC;

/*
Write a query that prints a list of employee names (i.e.: the name attribute)
for employees in Employee having a salary greater than 2000 per month who have been employees for less than 10 months.
Sort your result by ascending employee_id.
*/
select name from employee where months < 10 and salary > 2000;

/*
Query the two cities in STATION with the shortest and longest CITY names,
as well as their respective lengths (i.e.: number of characters in the name).
If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
*/
select min(city),min(length(city)) from station where (select MIN(LENGTH(CITY)) from station order BY length(city)) = length(city);
select max(city),max(length(city)) from station where (select MAX(LENGTH(CITY)) from station order BY length(city)) = length(city);

/*
Query the following two values from the STATION table:
The sum of all values in LAT_N rounded to a scale of 2 decimal places.
The sum of all values in LONG_W rounded to a scale of 2 decimal places.
*/
select ROUND(sum(lat_n),2), ROUND(sum(long_w),2) from station;


/*
Query the average population of all cities in CITY where District is California.
*/
select sum(population)/count(population) from city where district='california';

/*
Query the average population for all cities in CITY, rounded down to the nearest integer.
*/
select ROUND(sum(population)/count(population)) from city;

/*
Query the difference between the maximum and minimum populations in CITY.
*/
select max(population)-min(population) from city;


/*
Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, 
but did not realize her keyboard's  key was broken until after completing the calculation. 
She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.

Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.
*/
select ROUND(sum(salary)/count(salary)) -
       ROUND(sum(TRIM(REPLACE(salary, "0", "")))/count(salary))
       from employees;
       
 /*
 We define an employee's total earnings to be their monthly salary*months worked, 
 and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
 Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. 
 Then print these values as 2 space-separated integers.
 */
 select months*salary, count(months) from employee where (select MAX(months*salary) from employee order BY months*salary desc)=months*salary group by months*salary;

/*
Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. Round your answer to 4 decimal places.
*/
select ROUND(long_w,4) from station where (select max(lat_n) from station where lat_n<137.2345)=lat_n;
