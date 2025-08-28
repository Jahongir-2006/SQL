SELECT CONCAT(EMPLOYEE_ID, '-', FIRST_NAME, ' ', LAST_NAME) AS EmpDetails
FROM Employees
WHERE EMPLOYEE_ID = 100;
2. Replace '124' with '999' in phone_number

UPDATE Employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999');
3. Employees with names starting with A, J, or M

SELECT FIRST_NAME AS FirstName,
       LENGTH(FIRST_NAME) AS NameLength
FROM Employees
WHERE FIRST_NAME LIKE 'A%'
   OR FIRST_NAME LIKE 'J%'
   OR FIRST_NAME LIKE 'M%'
ORDER BY FIRST_NAME;
4. Total salary by Manager

SELECT MANAGER_ID,
       SUM(SALARY) AS TotalSalary
FROM Employees
GROUP BY MANAGER_ID
ORDER BY MANAGER_ID;
5. Highest of (Max1, Max2, Max3) from TestMax

SELECT Year,
       GREATEST(Max1, Max2, Max3) AS HighestValue
FROM TestMax;
6. Odd-numbered movies, not boring (cinema)

SELECT *
FROM Cinema
WHERE MOD(id, 2) = 1
  AND description <> 'boring'
ORDER BY rating DESC;
7. Sort by Id but put 0 last (SingleOrder)
CASE WHEN Id=0 THEN 1 ELSE 0 END


SELECT *
FROM SingleOrder
ORDER BY (CASE WHEN Id = 0 THEN 1 ELSE 0 END), Id;
8. First non-null value (person table)

SELECT COALESCE(column1, column2, column3, column4) AS FirstNonNull
FROM Person;
✅ Medium Tasks
9. Split FullName into 3 parts (Students table)

SELECT StudentID,
       SPLIT_PART(FullName, ' ', 1) AS FirstName,
       SPLIT_PART(FullName, ' ', 2) AS MiddleName,
       SPLIT_PART(FullName, ' ', 3) AS LastName
FROM Students;
(If more than 3 parts exist, only first 3 are shown.)

10. Customers with CA deliveries, show TX deliveries (Orders)

SELECT DISTINCT o.CustomerID, o.OrderID, o.DeliveryState
FROM Orders o
WHERE o.CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE DeliveryState = 'California'
)
AND o.DeliveryState = 'Texas';
11. Group concatenate values (DMLTable)
(PostgreSQL → STRING_AGG, MySQL → GROUP_CONCAT)


SELECT GROUP_CONCAT(ValueColumn ORDER BY ValueColumn) AS ConcatenatedValues
FROM DMLTable;
12. Employees whose name (first+last) has ≥3 "a"

SELECT *
FROM Employees
WHERE (LENGTH(CONCAT(FIRST_NAME, LAST_NAME)) 
     - LENGTH(REPLACE(CONCAT(FIRST_NAME, LAST_NAME), 'a', ''))) >= 3;
13. Employees count + % > 3 years

SELECT DEPARTMENT_ID,
       COUNT(*) AS TotalEmployees,
       ROUND(100.0 * SUM(CASE WHEN DATEDIFF(CURDATE(), HIRE_DATE)/365 > 3 THEN 1 ELSE 0 END) / COUNT(*), 2) AS PctMoreThan3Years
FROM Employees
GROUP BY DEPARTMENT_ID;
14. Most and least experienced spaceman by job (Personal)

SELECT JobDescription,
       MAX(SpacemanID) KEEP (DENSE_RANK FIRST ORDER BY ExperienceYears DESC) AS MostExperiencedID,
       MAX(SpacemanID) KEEP (DENSE_RANK FIRST ORDER BY ExperienceYears ASC) AS LeastExperiencedID
FROM Personal
GROUP BY JobDescription;
(Oracle syntax; in MySQL/Postgres → use ROW_NUMBER().)

✅ Difficult Tasks
15. Separate string characters into categories

WITH chars AS (
  SELECT 'tf56sd#%OqH' AS str
)
SELECT 
  REGEXP_REPLACE(str, '[^A-Z]', '', 'g') AS UppercaseLetters,
  REGEXP_REPLACE(str, '[^a-z]', '', 'g') AS LowercaseLetters,
  REGEXP_REPLACE(str, '[^0-9]', '', 'g') AS Numbers,
  REGEXP_REPLACE(str, '[A-Za-z0-9]', '', 'g') AS OtherChars
FROM chars;
16. Running sum (Students table)

SELECT StudentID,
       Grade,
       SUM(Grade) OVER (ORDER BY StudentID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Students;
17. Evaluate math equations (Equations table)
In PostgreSQL you can use EXECUTE or pg_eval, in MySQL use dynamic SQL. Example (Postgres):


SELECT equation,
       (SELECT SUM(eval) 
        FROM (SELECT (equation)::NUMERIC AS eval) t) AS result
FROM Equations;
(Otherwise needs UDF to safely evaluate.)

18. Students with same birthday

SELECT s1.StudentID, s1.Name, s1.Birthday
FROM Student s1
JOIN Student s2
  ON s1.Birthday = s2.Birthday
 AND s1.StudentID <> s2.StudentID
ORDER BY s1.Birthday;
