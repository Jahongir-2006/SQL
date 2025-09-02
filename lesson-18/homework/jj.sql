-- Create temporary table
SELECT 
    s.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
INTO #MonthlySales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = YEAR(GETDATE()) 
  AND MONTH(s.SaleDate) = MONTH(GETDATE())
GROUP BY s.ProductID;

-- View results
SELECT * FROM #MonthlySales;
2️⃣ View: Product Sales Summary

CREATE OR ALTER VIEW vw_ProductSalesSummary
AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    ISNULL(SUM(s.Quantity),0) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;
3️⃣ Scalar Function: Get Total Revenue for Product

CREATE OR ALTER FUNCTION fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @Revenue DECIMAL(18,2);

    SELECT @Revenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;

    RETURN ISNULL(@Revenue, 0);
END;
4️⃣ Table-Valued Function: Sales by Category

CREATE OR ALTER FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);
5️⃣ Prime Number Function

CREATE OR ALTER FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    IF @Number < 2 RETURN 'No';

    DECLARE @i INT = 2;

    WHILE @i * @i <= @Number
    BEGIN
        IF @Number % @i = 0 RETURN 'No';
        SET @i += 1;
    END

    RETURN 'Yes';
END;
6️⃣ Numbers Between Function

CREATE OR ALTER FUNCTION fn_GetNumbersBetween(@Start INT, @End INT)
RETURNS @Numbers TABLE (Number INT)
AS
BEGIN
    DECLARE @i INT = @Start;
    WHILE @i <= @End
    BEGIN
        INSERT INTO @Numbers VALUES (@i);
        SET @i += 1;
    END
    RETURN;
END;
7️⃣ Nth Highest Distinct Salary
sql

CREATE OR ALTER FUNCTION getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
    RETURN (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        OFFSET (@N - 1) ROWS FETCH NEXT 1 ROWS ONLY
    );
END;
8️⃣ Person with Most Friends

SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id, accepter_id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id, requester_id FROM RequestAccepted
) f
GROUP BY id
ORDER BY num DESC;
9️⃣ View: Customer Order Summary

CREATE OR ALTER VIEW vw_CustomerOrderSummary
AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
🔟 Fill Gaps with Last Known Value

SELECT 
    g.RowNumber,
    LAST_VALUE(g.TestCase) 
        IGNORE NULLS 
        OVER (ORDER BY g.RowNumber ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
        AS Workflow
FROM Gaps g
ORDER BY g.RowNumber;
