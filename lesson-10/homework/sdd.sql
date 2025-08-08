Employees with salary > 50000 and their department names


SELECT E.Name AS EmployeeName, E.Salary, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE E.Salary > 50000;
Customer names and order dates for orders placed in 2023


SELECT C.FirstName, C.LastName, O.OrderDate
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) = 2023;
All employees and their departments (include those without departments)


SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID;
All suppliers and products they supply (include suppliers without products)


SELECT S.SupplierName, P.ProductName
FROM Suppliers S
LEFT JOIN Products P ON S.SupplierID = P.SupplierID;
All orders and their corresponding payments (include unmatched on both sides)

SELECT O.OrderID, O.OrderDate, P.PaymentDate, P.Amount
FROM Orders O
FULL OUTER JOIN Payments P ON O.OrderID = P.OrderID;
Employees and their manager names


SELECT E.Name AS EmployeeName, M.Name AS ManagerName
FROM Employees E
LEFT JOIN Employees M ON E.ManagerID = M.EmployeeID;
Students enrolled in 'Math 101'


SELECT S.Name AS StudentName, C.CourseName
FROM Enrollments E
JOIN Students S ON E.StudentID = S.StudentID
JOIN Courses C ON E.CourseID = C.CourseID
WHERE C.CourseName = 'Math 101';
Customers who placed orders with more than 3 items


SELECT C.FirstName, C.LastName, O.Quantity
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE O.Quantity > 3;
Employees working in 'Human Resources'


SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Human Resources';
🟠 Medium-Level Tasks
Departments with more than 5 employees


SELECT D.DepartmentName, COUNT(E.EmployeeID) AS EmployeeCount
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName
HAVING COUNT(E.EmployeeID) > 5;
Products never sold


SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Orders O ON P.ProductID = O.ProductID
WHERE O.ProductID IS NULL;
Customers who placed at least one order


SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS TotalOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName;
Employee-department pairs where both exist (no NULLs)

SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;
Pairs of employees with the same manager


SELECT E1.Name AS Employee1, E2.Name AS Employee2, E1.ManagerID
FROM Employees E1
JOIN Employees E2 ON E1.ManagerID = E2.ManagerID AND E1.EmployeeID < E2.EmployeeID
WHERE E1.ManagerID IS NOT NULL;
Orders in 2022 with customer names

SELECT O.OrderID, O.OrderDate, C.FirstName, C.LastName
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) = 2022;
Employees in 'Sales' with salary > 60000


SELECT E.Name AS EmployeeName, E.Salary, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sales' AND E.Salary > 60000;
Orders with corresponding payments only


SELECT O.OrderID, O.OrderDate, P.PaymentDate, P.Amount
FROM Orders O
JOIN Payments P ON O.OrderID = P.OrderID;
Products never ordered


SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Orders O ON P.ProductID = O.ProductID
WHERE O.ProductID IS NULL;
🔴 Hard-Level Tasks
Employees earning more than avg salary of their department


SELECT E.Name AS EmployeeName, E.Salary
FROM Employees E
JOIN (
    SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
) DeptAvg ON E.DepartmentID = DeptAvg.DepartmentID
WHERE E.Salary > DeptAvg.AvgSalary;
Orders before 2020 with no payment


SELECT O.OrderID, O.OrderDate
FROM Orders O
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE O.OrderDate < '2020-01-01' AND P.OrderID IS NULL;
Products without matching category


SELECT P.ProductID, P.ProductName
FROM Products P
LEFT JOIN Categories C ON P.Category = C.CategoryID
WHERE C.CategoryID IS NULL;
Employees under same manager with salary > 60000


SELECT E1.Name AS Employee1, E2.Name AS Employee2, E1.ManagerID, E1.Salary
FROM Employees E1
JOIN Employees E2 ON E1.ManagerID = E2.ManagerID AND E1.EmployeeID < E2.EmployeeID
WHERE E1.Salary > 60000 AND E2.Salary > 60000;
Employees in departments starting with 'M'


SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName LIKE 'M%';
Sales > 500 with product names
(Assuming Sales table exists similar to Orders with ProductID and SaleAmount)


SELECT S.SaleID, P.ProductName, S.SaleAmount
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
WHERE S.SaleAmount > 500;
Students NOT enrolled in 'Math 101'


SELECT S.StudentID, S.Name AS StudentName
FROM Students S
WHERE S.StudentID NOT IN (
    SELECT E.StudentID
    FROM Enrollments E
    JOIN Courses C ON E.CourseID = C.CourseID
    WHERE C.CourseName = 'Math 101'
);
Orders missing payment details


SELECT O.OrderID, O.OrderDate, P.PaymentID
FROM Orders O
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL;
Products in 'Electronics' or 'Furniture' categories


SELECT P.ProductID, P.ProductName, C.CategoryName
FROM Products P
JOIN Categories C ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics', 'Furniture');
