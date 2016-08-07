IF OBJECT_ID('tempdb..#table') IS NOT NULL DROP TABLE #table
CREATE TABLE #table (Name NVARCHAR(1) PRIMARY KEY, Flag1 BIT, Flag2 BIT, Flag3 BIT)
INSERT INTO #table (Name, Flag1, Flag2, Flag3)
VALUES
    ('A', 1, NULL, NULL),
    ('B', NULL, 1, NULL),
    ('C', NULL, NULL, 1)

SELECT Name, FlagNumber
FROM #table WITH(NOLOCK)
UNPIVOT (Flag FOR FlagNumber IN (Flag1, Flag2, Flag3)) AS Unpvt