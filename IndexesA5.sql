use lab5

-- Ta
CREATE TABLE coach( 
	coachID INT PRIMARY KEY,
	personalCode INT UNIQUE,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	salary INT,
	workingHours INT
)

EXECUTE sp_helpindex coach

-- Tb
CREATE TABLE [gym]( 
	gymID INT PRIMARY KEY,
	addressCode INT, -- b2
	nrMembers INT,
	sessionDuration TINYINT
) 

-- Tc
CREATE TABLE member( 
	memberID INT PRIMARY KEY,
	coachID INT REFERENCES coach(coachID),
	gymID INT REFERENCES [gym](gymID),
	FirstName VARCHAR(50),
	LastName VARCHAR(50)
)

-- A.
-- CREATE NONCLUSTERED INDEX selectCoaches
-- 	ON coach(salary DESC, LastName ASC)

-- DROP INDEX selectCoaches on coach

-- clustered index scan
	-- default clustered index - coachID
	-- scan - searches in all data to find > 1000
	--      - on column salary, does not have index
SELECT salary FROM coach
	WHERE salary > 1000
	ORDER BY salary DESC

-- clustered index seek
	-- default clustered index - coachID
	-- seek - coachID is primary key and has index
SELECT coachID, FirstName FROM coach
	WHERE coachID BETWEEN 1000 AND 7000

-- nonclustered index seek
	-- noncluster - personalCode = UNIQUE
SELECT personalCode FROM coach
	WHERE personalCode > 10

-- nonclustered index scan
	-- nonclustered - personalCode = unique
	-- scan - must check all data
SELECT personalCode, coachID FROM coach
	WHERE coachID > 1000
	ORDER BY personalCode DESC

-- key lookup 
	-- unique => it is known that it will be just one result
SELECT * FROM coach
	WHERE personalCode = 148321


-- B.
-- 0.0104 estimated Operator Cost
SELECT gymID, addressCode FROM [gym]
	WHERE addressCode = 100

-- create index on addressCode
-- 0.0032 estimated Operator Cost
CREATE NONCLUSTERED INDEX getgyms
	ON [gym](addressCode)

DROP INDEX getgyms on [gym]

EXECUTE sp_helpindex [gym]

--c)
--0.047 estimated Operator Cost without index
--0.046 estimated Operator Cost with index
GO
CREATE OR ALTER VIEW gymsView 
AS
SELECT member.memberID, member.gymID 
	FROM member
INNER JOIN [gym] 
	ON [gym].gymID = member.gymID
	WHERE [gym].sessionDuration > 20
GO

SELECT * FROM gymsView

CREATE NONCLUSTERED INDEX getgymsView
	ON [gym](sessionDuration)

CREATE NONCLUSTERED INDEX getmemberView
	ON [member](gymID)

DROP INDEX getgymsView on [gym]

EXECUTE sp_helpindex member

------

GO
CREATE OR ALTER PROCEDURE addCoaches
	@nb_of_rows VARCHAR(30)
AS
	SET NOCOUNT ON;

	DECLARE @count INT;
	SET @count = 1;
	SET @nb_of_rows = cast(@nb_of_rows as INT)
	DECLARE @id INT
	SET @id = 0;
	
	DECLARE @firstName VARCHAR(50)
	DECLARE @lastName VARCHAR(50)
	DECLARE @money INT
	DECLARE @cnp INT
	
	WHILE @count <= @nb_of_rows
	BEGIN
		SET @money= RAND()*(6000)+2000;
		SET @firstName = (SELECT CONVERT(VARCHAR(50),LEFT(REPLACE(NEWID(),'-',''),30)))
		SET @lastName = (SELECT CONVERT(VARCHAR(50),LEFT(REPLACE(NEWID(),'-',''),20)))
		SET @id = @id + 1
		SET @cnp = RAND()*(100000000)+1000000;
		
		INSERT INTO coach(coachID, personalCode, salary, workingHours, FirstName, LastName) 
			VALUES (@id, @cnp, @money, 8, @firstName, @lastName)
		SET @count = @count + 1;
	END

GO
CREATE OR ALTER PROCEDURE addGyms
	@nb_of_rows VARCHAR(30)
AS
	SET NOCOUNT ON;
	
	DECLARE @count INT;
	SET @count = 1;

	SET @nb_of_rows = cast(@nb_of_rows as INT)
	DECLARE @id INT
	SET @id = 0;
	
	DECLARE @people INT
	DECLARE @code INT
	DECLARE @time TINYINT

	WHILE @count <= @nb_of_rows
	BEGIN
		SET @people= RAND()*(5)+1;
		SET @id = @id + 1
		SET @code = RAND()*(1000)+1;
		SET @time = RAND()*(30)+1;
		
		INSERT INTO [gym](gymID, addressCode, nrMembers, sessionDuration) 
			VALUES (@id, @code, @people, @time)
		SET @count = @count + 1;
	END

GO
CREATE OR ALTER PROCEDURE addMembers
	@nb_of_rows VARCHAR(30)
AS
	SET NOCOUNT ON;
	
	DECLARE @count INT;
	SET @count = 1;
	SET @nb_of_rows = cast(@nb_of_rows as INT)

	DECLARE @id INT
	set @id = 0;
	
	DECLARE @gymID INT
	DECLARE @coachID INT
	DECLARE @firstName VARCHAR(50)
	DECLARE @lastName VARCHAR(50)

	while @count <= @nb_of_rows
	BEGIN
		SET @id = @id + 1
		SET @gymID= RAND()*(600)+1;
		SET @coachID = RAND()*(600)+1;
		SET @firstName = (SELECT CONVERT(varchar(50),LEFT(REPLACE(NEWID(),'-',''),30)))
		SET @lastName = (SELECT CONVERT(varchar(50),LEFT(REPLACE(NEWID(),'-',''),20)))
		
		INSERT INTO member(memberID, gymID, coachID, FirstName, LastName) 
			VALUES (@id, @gymID, @coachID, @firstName, @lastName)
		SET @count = @count + 1;
	END

exec addCoaches '2500'
SELECT * FROM coach

exec addGyms '2500'
SELECT * FROM [gym]

exec addMembers '2500'
SELECT * FROM member
