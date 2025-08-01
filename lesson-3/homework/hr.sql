CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);
INSERT INTO Categories (CategoryID, CategoryName) 
VALUES
(1, 'Electronics'),
(2, 'Accessories');

INSERT INTO Products (ProductID, ProductName, Price, CategoryID, Stock)
VALUES
(10, 'Webcam', 60.00, 1, 50),
(11, 'USB Cable', 5.99, 2, 200),
(12, 'Headphones', 79.90, 1, 120);
INSERT INTO Products (ProductID, ProductName, Price, CategoryID, Stock)
VALUES (13, 'Mouse Pad', 10.00, 2, 100);
-- This will fail because Price <= 0
INSERT INTO Products (ProductID, ProductName, Price, CategoryID, Stock)
VALUES (14, 'Broken Item', 0.00, 1, 10);
INSERT INTO Products (ProductID, ProductName, Price, CategoryID, Stock)
VALUES (15, 'Mystery Box', NULL, 1, 5);
  


-- Medium-Level Tasks
BULK INSERT Products
FROM 'C:\Data\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;
-- hard-level task 

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Age INT CHECK (Age >= 18)
);
CREATE TABLE Invoice (
    InvoiceID INT IDENTITY(100,10) PRIMARY KEY,
    InvoiceDate DATE
);
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Email VARCHAR(100) UNIQUE
);
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories_Cascade
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID)
ON DELETE CASCADE
ON UPDATE CASCADE;
