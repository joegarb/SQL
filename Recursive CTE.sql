IF OBJECT_ID('tempdb..#table') IS NOT NULL DROP TABLE #table
CREATE TABLE #table (ID INT PRIMARY KEY, Name NVARCHAR(10) NOT NULL, ParentID INT)
INSERT INTO #table (ID, Name, ParentID)
VALUES
    (1, 'One', NULL),
    (2, 'Two', NULL),
    (3, 'Three', 1),
    (4, 'Four', NULL),
    (5, 'Five', 1),
    (6, 'Six', 2),
    (7, 'Seven', 3),
    (8, 'Eight', 3),
    (9, 'Nine', 8),
    (10, 'Ten', 7)

;WITH CTE (ParentID, ID, Depth) AS (
    SELECT NULL, ID, 1
    FROM #table
    WHERE ParentID IS NULL
    UNION ALL
    SELECT parent.ID, child.ID, parent.Depth + 1
    FROM CTE parent
    JOIN #table child ON child.ParentID = parent.ID
)
SELECT Parent = parent.Name, Child = child.Name, Depth
FROM CTE
JOIN #table child ON child.ID = CTE.ID
LEFT JOIN #table parent ON parent.ID = child.ParentID
ORDER BY parent.ID, Depth, child.ID