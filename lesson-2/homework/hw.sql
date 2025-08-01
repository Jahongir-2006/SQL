
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);
-- Single-row insert
INSERT INTO Employees (EmpID, Name, Salary) VALUES (1, 'Alice', 6000.00);

-- Multiple-row insert
INSERT INTO Employees (EmpID, Name, Salary) VALUES 
(2, 'Bob', 4500.00),
(3, 'Charlie', 5500.00);
UPDATE Employees SET Salary = 7000.00 WHERE EmpID = 1;
DELETE FROM Employees WHERE EmpID = 2;
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);
ALTER TABLE Employees
ADD Department VARCHAR(50);
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;
    

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);
TRUNCATE TABLE Employees;
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR' UNION ALL
SELECT 2, 'IT' UNION ALL
SELECT 3, 'Finance' UNION ALL
SELECT 4, 'Sales' UNION ALL
SELECT 5, 'Logistics';
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;
DELETE FROM Employees;
ALTER TABLE Employees
DROP COLUMN Department;
DROP TABLE Departments;


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Description TEXT
);
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50; 

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Description)
VALUES 
(1, 'Laptop', 'Electronics', 1200.00, 'High-end gaming laptop'),
(2, 'Chair', 'Furniture', 150.00, 'Ergonomic office chair'),
(3, 'Smartphone', 'Electronics', 800.00, 'Flagship model'),
(4, 'Table', 'Furniture', 300.00, 'Wooden dining table'),
(5, 'Monitor', 'Electronics', 250.00, '27-inch 4K monitor');
SELECT * INTO Products_Backup FROM Products;
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000,5);


 
