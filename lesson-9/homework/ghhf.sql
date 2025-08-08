 SELECT P.ProductName, S.SupplierName
FROM Products P
CROSS JOIN Suppliers S;
2. Get all combinations of departments and employees.


SELECT D.DepartmentName, E.Name
FROM Departments D
CROSS JOIN Employees E;
3. List only combinations where the supplier actually supplies the product.

SELECT S.SupplierName, P.ProductName
FROM Products P
JOIN Suppliers S ON P.SupplierID = S.SupplierID;
4. List customer names and their order IDs.

SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, O.OrderID
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID;
5. Get all combinations of students and courses.


SELECT S.Name AS StudentName, C.CourseName
FROM Students S
CROSS JOIN Courses C;
6. Get product names and orders where product IDs match.


SELECT P.ProductName, O.OrderID
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID;
7. List employees whose DepartmentID matches the department.


SELECT E.Name, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID;
8. List student names and their enrolled course IDs.


SELECT S.Name, E.CourseID
FROM Enrollments E
JOIN Students S ON E.StudentID = S.StudentID;
9. List all orders that have matching payments.


SELECT O.OrderID, P.PaymentID, P.Amount
FROM Orders O
JOIN Payments P ON O.OrderID = P.OrderID;
10. Show orders where product price is more than 100.


SELECT O.OrderID, P.ProductName, P.Price
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID
WHERE P.Price > 100;
🟡 Medium puzzles



SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID != D.DepartmentID;
2. Show orders where ordered quantity > stock quantity.

SELECT O.OrderID, O.Quantity, P.StockQuantity
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID
WHERE O.Quantity > P.StockQuantity;
3. List customer names and product IDs where sale amount is 500 or more.

SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, S.ProductID, S.SaleAmount
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
WHERE S.SaleAmount >= 500;
4. List student names and course names they’re enrolled in.


SELECT S.Name AS StudentName, C.CourseName
FROM Enrollments E
JOIN Students S ON E.StudentID = S.StudentID
JOIN Courses C ON E.CourseID = C.CourseID;
5. List product and supplier names where supplier name contains “Tech”.

SELECT P.ProductName, S.SupplierName
FROM Products P
JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE S.SupplierName LIKE '%Tech%';
6. Show orders where payment amount is less than total amount.

SELECT O.OrderID, O.TotalAmount, P.Amount AS PaymentAmount
FROM Orders O
JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.Amount < O.TotalAmount;
7. Get department name for each employee.


SELECT E.Name AS EmployeeName, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID;
8. Show products where category is either 'Electronics' or 'Furniture'.


SELECT P.ProductName, C.CategoryName
FROM Products P
JOIN Categories C ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics', 'Furniture');
9. Show all sales from customers who are from 'USA'.


SELECT S.*
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
WHERE C.Country = 'USA';
10. List orders by customers from 'Germany' with total > 100.

SELECT O.OrderID, CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, O.TotalAmount
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.Country = 'Germany' AND O.TotalAmount > 100;
🔴 Hard (5 puzzles)
1. List all pairs of employees from different departments.


SELECT E1.Name AS Employee1, E2.Name AS Employee2
FROM Employees E1
JOIN Employees E2 ON E1.EmployeeID < E2.EmployeeID
WHERE E1.DepartmentID != E2.DepartmentID;
2. Payment details where amount ≠ quantity × product price.



SELECT P.PaymentID, O.OrderID, O.Quantity, Pr.Price, P.Amount
FROM Payments P
JOIN Orders O ON P.OrderID = O.OrderID
JOIN Products Pr ON O.ProductID = Pr.ProductID
WHERE P.Amount != (O.Quantity * Pr.Price);
3. Find students not enrolled in any course.


SELECT S.StudentID, S.Name
FROM Students S
LEFT JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE E.EnrollmentID IS NULL;
4. List managers earning ≤ the person they manage.


SELECT M.Name AS ManagerName, E.Name AS EmployeeName, M.Salary AS ManagerSalary, E.Salary AS EmployeeSalary
FROM Employees E
JOIN Employees M ON E.ManagerID = M.EmployeeID
WHERE M.Salary <= E.Salary;
5. List customers with orders but no payment.

SELECT DISTINCT C.CustomerID, CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.OrderID IS NULL;
