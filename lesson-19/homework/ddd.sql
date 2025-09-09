CREATE PROCEDURE GetEmployeeBonus
AS
BEGIN
    -- Create temp table
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    -- Insert data with bonus calculation
    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * db.BonusPercentage / 100 AS BonusAmount
    FROM Employees e
    INNER JOIN DepartmentBonus db ON e.Department = db.Department;

    -- Return result
    SELECT * FROM #EmployeeBonus;
END;
📄 Task 2: Update Salary by Department
sql
Копировать код
CREATE PROCEDURE UpdateDepartmentSalary
    @DeptName NVARCHAR(50),
    @IncreasePct DECIMAL(5,2)
AS
BEGIN
    -- Update salaries
    UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePct / 100)
    WHERE Department = @DeptName;

    -- Return updated employees
    SELECT * 
    FROM Employees
    WHERE Department = @DeptName;
END;
📄 Task 3: MERGE Products
sql
Копировать код
MERGE Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID

-- Update if exists
WHEN MATCHED THEN
    UPDATE SET 
        target.ProductName = source.ProductName,
        target.Price = source.Price

-- Insert if new
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)

-- Delete if missing
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Return final state
OUTPUT $action, inserted.*, deleted.*;
After running MERGE, check:


SELECT * FROM Products_Current;
 Task 4: Tree Node Types

SELECT 
    id,
    CASE
        WHEN p_id IS NULL THEN 'Root'
        WHEN id NOT IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM Tree
ORDER BY id;
 Task 5: Confirmation Rate

SELECT 
    s.user_id,
    CASE 
        WHEN COUNT(c.user_id) = 0 THEN 0
        ELSE ROUND(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) * 1.0 / COUNT(c.user_id), 2)
    END AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;
 Task 6: Employees with Lowest Salary

SELECT *
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);
📄 Task 7: Product Sales Summary Procedure

CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
✅ Now you can run each stored procedure like:


EXEC GetEmployeeBonus;
EXEC UpdateDepartmentSalary 'Sales', 5;
EXEC GetProductSalesSummary 1;
