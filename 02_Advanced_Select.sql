/*
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths.
Output one of the following statements for each record in the table:

Equilateral: It's a triangle with 3 sides of equal length.
Isosceles: It's a triangle with 2 sides of equal length.
Scalene: It's a triangle with 3 sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle.
*/
select
    case
        when A+B>C and A+C>B and B+C>A then
            case
                when A=B and B=C and C=A then 'Equilateral'
                when A=B or B=C or A=C then 'Isosceles'
                else 'Scalene'
            end
        else 'Not A Triangle'
    end
from TRIANGLES;

/*
Generate the following two result sets:

1. Query an alphabetically ordered list of all names in OCCUPATIONS,
immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses).
For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
2. Query the number of ocurrences of each occupation in OCCUPATIONS.
Sort the occurrences in ascending order, and output them in the following format:

There are a total of [occupation_count] [occupation]s.

where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name.
If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
*/
select CONCAT(name,'(',SUBSTRING(occupation,1,1),')') from OCCUPATIONS order by name ASC;

select "There are a total of",count(occupation),concat(lower(occupation),'s.') from OCCUPATIONS 
group by occupation ORDER by count(occupation) ASC;

/*
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.

Column	Type
---------------
N	Integer
P	Integer

Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.
Sample Input:

N	P
----------
1	2
3	2
6	8
9	8
2	5
8	5
5	Null


Sample Output:

1 Leaf
2 Inner
3 Leaf
5 Root
6 Leaf
8 Inner
9 Leaf
*/
select
    case
        when P is NULL then CONCAT(N,' Root')
        when N in (select P from BST) then CONCAT(N,' Inner')
        else CONCAT(N,' Leaf')
    end
from BST order by N ASC;


/*
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.
*/
set @r1=0, @r2=0, @r3=0, @r4=0;
select min(Doctor), min(Professor), min(Singer), min(Actor)
from(
  select case when Occupation='Doctor' then (@r1:=@r1+1)
            when Occupation='Professor' then (@r2:=@r2+1)
            when Occupation='Singer' then (@r3:=@r3+1)
            when Occupation='Actor' then (@r4:=@r4+1) end as RowNumber,
    case when Occupation='Doctor' then Name end as Doctor,
    case when Occupation='Professor' then Name end as Professor,
    case when Occupation='Singer' then Name end as Singer,
    case when Occupation='Actor' then Name end as Actor
  from OCCUPATIONS
  order by Name
) Temp
group by RowNumber;

/*
Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.

Note:

The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.
*/
select E.company_code,C.founder, 
count(distinct LM.lead_manager_code),count(distinct SM.senior_manager_code), 
count(distinct M.manager_code),count(distinct E.employee_code) 
from Company C 
Join Lead_Manager LM on C.company_code=LM.company_code 
Left Join Senior_Manager SM on LM.lead_manager_code=SM.lead_manager_code 
Left Join Manager M on SM.senior_manager_code=M.senior_manager_code 
Left Join Employee E on M.manager_code=E.manager_code 
group by E.company_code,C.founder;
