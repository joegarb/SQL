IF OBJECT_ID('tempdb..#table') IS NOT NULL DROP TABLE #table
CREATE TABLE #table (Name NVARCHAR(1) PRIMARY KEY, Flag INT)
INSERT INTO #table (Name, Flag)
VALUES
    ('A', 1),
    ('B', 2),
    ('C', 4)

SELECT
    Name,
    HasFlagOne = CASE WHEN [1] IS NOT NULL THEN 1 ELSE NULL END,
    HasFlagTwo = CASE WHEN [2] IS NOT NULL THEN 1 ELSE NULL END,
    HasFlagFour = CASE WHEN [4] IS NOT NULL THEN 1 ELSE NULL END
FROM #table WITH(NOLOCK)
PIVOT (AVG(Flag) FOR Flag IN ([1], [2], [4])) AS Pvt