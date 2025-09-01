SELECT 
    SUBSTRING_INDEX(value, '.', 1) AS Part1,
    SUBSTRING_INDEX(SUBSTRING_INDEX(value, '.', 2), '.', -1) AS Part2,
    SUBSTRING_INDEX(value, '.', -1) AS Part3
FROM Splitter;
(For more than 3 parts, you can extend similarly.)

4. Replace all integers (digits) in a string with 'X'
Example string: 1234ABC123456XYZ1234567890ADS


SELECT REGEXP_REPLACE('1234ABC123456XYZ1234567890ADS', '[0-9]', 'X') AS Masked;
5. Return all rows where Vals column contains more than two dots (testDots)

SELECT *
FROM testDots
WHERE (LENGTH(Vals) - LENGTH(REPLACE(Vals, '.', ''))) > 2;
6. Count spaces in a string (CountSpaces)

SELECT 
    (LENGTH(str) - LENGTH(REPLACE(str, ' ', ''))) AS SpaceCount
FROM CountSpaces;
7. Find employees who earn more than their managers (Employee)
Assume table schema: Employee(EmpID, Name, Salary, ManagerID)


SELECT e.EmpID, e.Name, e.Salary, m.Name AS ManagerName, m.Salary AS ManagerSalary
FROM Employee e
JOIN Employee m ON e.ManagerID = m.EmpID
WHERE e.Salary > m.Salary;
8. Employees with 10–15 years of service (Employees)

SELECT 
    EmployeeID,
    FirstName,
    LastName,
    HireDate,
    TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) AS YearsOfService
FROM Employees
WHERE TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) BETWEEN 10 AND 14;
