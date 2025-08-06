SELECT MIN(col1) AS col1, MAX(col2) AS col2
FROM InputTbl
GROUP BY 
    CASE 
        WHEN col1 < col2 THEN col1 ELSE col2 
    END,
    CASE 
        WHEN col1 < col2 THEN col2 ELSE col1 
    END;


SELECT * FROM TestMultipleZero
WHERE COALESCE(A, 0) + COALESCE(B, 0) + COALESCE(C, 0) + COALESCE(D, 0) > 0;


SELECT * 
FROM section1
WHERE id % 2 = 1;

SELECT * 
FROM section1
WHERE id = (SELECT MIN(id) FROM section1);

SELECT * 
FROM section1
WHERE id = (SELECT MAX(id) FROM section1);

SELECT * 
FROM section1
WHERE name LIKE 'B%';


SELECT * 
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';
