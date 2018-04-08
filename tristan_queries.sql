SELECT DISTINCT u.unum, u.bnum, c.id, e.fname, e.lname
FROM Unit u, Building b, Complex c, Employee e
WHERE
u.bnum = b.bnum AND
b.complexid = 1 AND
b.managerssn = 234673456 AND
u.styleType = 'Studio' AND
c.location = '123 Division Ave';


SELECT *
FROM Employee e
WHERE e.salary > 55000
INTERSECT
SELECT *
FROM Employee e
WHERE e.job = 'maintenance';
    
    
SELECT AVG(Salary)
FROM Employee
WHERE Job != 'manager';
    
SELECT e.essn, e.fname, e.salary, e.job
FROM Employee e
WHERE 
e.salary > 54000 AND
NOT EXISTS 
(
SELECT *
FROM Building B
WHERE e.essn = b.managerSSN
); 

SELECT e.essn, e.lname, e.job, e.salary
FROM Employee e
WHERE e.salary > 120000 AND
e.essn IN 
(
SELECT b.managerSSN
FROM Building b
);

SELECT RANK() OVER (ORDER BY e.salary DESC) AS Rank, e.salary, e.lname, e.job
FROM Employee e
WHERE e.salary < 120000;

Select *
FROM 
(
SELECT *
FROM Employee e
ORDER BY Salary ASC
)
WHERE ROWNUM <= 4;

SELECT e.essn, e.lname
FROM Employee e
WHERE 
NOT EXISTS
(
(
SELECT b.managerSSN
FROM Building b
WHERE 
b.managerSSN = '234673456'
)
MINUS
(
SELECT b.managerSSN
FROM Unit u, Building b
WHERE 
b.managerSSN = '234673456' AND
u.price > 750
)
); ​
