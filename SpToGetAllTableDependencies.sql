


ALTER PROCEDURE SpToGetAllTableDependencies
(
@TableName	VARCHAR(200)
)
AS
BEGIN

SET NOCOUNT ON
DECLARE @DBName VARCHAR(200)
DECLARE @Sql VARCHAR(MAX)
DECLARE @i  INT = 0
DECLARE @Max INT

SELECT @Max = MAX(dbid) FROM SYSDATABASES


DECLARE @Table TABLE
(
ID			INT IDENTITY(1,1),
ProcName	VARCHAR(200)
)

WHILE (@i <= @Max)
BEGIN

SELECT @DBName = name FROM SYSDATABASES
WHERE dbid = @i

SET @i = @i +1

SET @Sql= 'SELECT DISTINCT so.name,'''+@DBName+'''
FROM '+@DBName+'..syscomments sc
INNER JOIN '+@DBName+'..sysobjects so ON sc.id=so.id
WHERE sc.TEXT LIKE ''%'+@TableName+'%''
AND so.type = ''P'''


INSERT INTO @Table(ProcName)
EXEC (@Sql)

END

SELECT T.ProcName FROM @Table T

END


EXEC SpToGetAllTableDependencies 'Employe'
--SET @Sql= 'SELECT DISTINCT so.name
--FROM '+@DBName+'..syscomments sc
--INNER JOIN '+@DBName+'..sysobjects so ON sc.id=so.id
--WHERE sc.TEXT LIKE ''%'+@TaleName+'%'''

--PRINT(@Sql)

--EXEC (@Sql)


----Option 2
SELECT DISTINCT o.*,c.*
FROM syscomments c
INNER JOIN sysobjects o ON c.id=o.id
WHERE c.TEXT LIKE '%Client_Configuration_Log%'


SELECT DISTINCT so.name,so.*
FROM syscomments sc
INNER JOIN sysobjects so ON sc.id=so.id
WHERE sc.TEXT LIKE '%Client_Configuration_Log%'



select top 1 * from sysdatabases
select top 1* from syscomments
select top 1* from sysobjects


















