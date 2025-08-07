SELECT TOP 3 
    CustomerID,
    SUM(TotalAmount) AS TotalSpent
FROM 
    Invoices
GROUP BY 
    CustomerID
ORDER BY 
    TotalSpent DESC;



district_id	district_name	2012	2013



SELECT 
    district_id,
    district_name,
    population,
    year
FROM 
    Population_Each_Year
UNPIVOT (
    population FOR year IN ([2012], [2013])
) AS Unpivoted;

SELECT 
    p.ProductName,
    COUNT(s.SaleID) AS TimesSold
FROM 
    Products p
JOIN 
    Sales s ON p.ProductID = s.ProductID
GROUP BY 
    p.ProductName
ORDER BY 
    TimesSold DESC;

year	Bektemir	Chilonzor	Yakkasaroy


SELECT 
    year,
    district_name,
    population
FROM 
    Population_Each_City
UNPIVOT (
    population FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS Unpivoted;
