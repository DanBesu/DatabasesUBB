use new_lab3
go

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_Tables
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tables]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tables
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunTables_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestRunTables] DROP CONSTRAINT FK_TestRunTables_TestRuns
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_TestRuns]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_TestRuns
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestTables_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestTables] DROP CONSTRAINT FK_TestTables_Tests
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Tests]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Tests
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestRunViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestRunViews] DROP CONSTRAINT FK_TestRunViews_Views
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[FK_TestViews_Views]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [TestViews] DROP CONSTRAINT FK_TestViews_Views
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[Tables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [Tables]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestRunTables]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestRunViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestRunViews]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestRuns]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestRuns]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestTables]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)

drop table [TestTables]

GO

if exists (select * from dbo.sysobjects where id = object_id(N'[TestViews]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [TestViews]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[Tests]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [Tests]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[Views]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [Views]
GO


CREATE TABLE [Tables] (
	[TableID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	)  ON [PRIMARY]
GO

CREATE TABLE [TestRunTables] (
	[TestRunID] [int] NOT NULL ,
	[TableID] [int] NOT NULL ,
	[StartAt] [datetime] NOT NULL ,
	[EndAt] [datetime] NOT NULL 
	)  ON [PRIMARY]
GO

CREATE TABLE [TestRunViews] (
	[TestRunID] [int] NOT NULL ,
	[ViewID] [int] NOT NULL ,
	[StartAt] [datetime] NOT NULL ,
	[EndAt] [datetime] NOT NULL 
	)  ON [PRIMARY]
GO

CREATE TABLE [TestRuns] (
	[TestRunID] [int] IDENTITY (1, 1) NOT NULL ,
	[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StartAt] [datetime] NULL ,
	[EndAt] [datetime] NULL 
	)  ON [PRIMARY]
GO

CREATE TABLE [TestTables] (
	[TestID] [int] NOT NULL ,
	[TableID] [int] NOT NULL ,
	[NoOfRows] [int] NOT NULL ,
	[Position] [int] NOT NULL 
	)  ON [PRIMARY]
GO

CREATE TABLE [TestViews] (
	[TestID] [int] NOT NULL ,
	[ViewID] [int] NOT NULL 
	)  ON [PRIMARY]
GO

CREATE TABLE [Tests] (
	[TestID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	)  ON [PRIMARY]
GO

CREATE TABLE [Views] (
	[ViewID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	)  ON [PRIMARY]
GO

ALTER TABLE [Tables] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tables] PRIMARY KEY  CLUSTERED 
	(
		[TableID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestRunTables] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestRunTables] PRIMARY KEY  CLUSTERED 
	(
		[TestRunID],
		[TableID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestRunViews] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestRunViews] PRIMARY KEY  CLUSTERED 
	(
		[TestRunID],
		[ViewID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestRuns] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestRuns] PRIMARY KEY  CLUSTERED 
	(
		[TestRunID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestTables] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestTables] PRIMARY KEY  CLUSTERED 
	(
		[TestID],
		[TableID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestViews] WITH NOCHECK ADD 
	CONSTRAINT [PK_TestViews] PRIMARY KEY  CLUSTERED 
	(
		[TestID],
		[ViewID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [Tests] WITH NOCHECK ADD 
	CONSTRAINT [PK_Tests] PRIMARY KEY  CLUSTERED 
	(
		[TestID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [Views] WITH NOCHECK ADD 
	CONSTRAINT [PK_Views] PRIMARY KEY  CLUSTERED 
	(
		[ViewID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [TestRunTables] ADD 
	CONSTRAINT [FK_TestRunTables_Tables] FOREIGN KEY 
	(
		[TableID]
	) REFERENCES [Tables] (
		[TableID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_TestRunTables_TestRuns] FOREIGN KEY 
	(
		[TestRunID]
	) REFERENCES [TestRuns] (
		[TestRunID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [TestRunViews] ADD 
	CONSTRAINT [FK_TestRunViews_TestRuns] FOREIGN KEY 
	(
		[TestRunID]
	) REFERENCES [TestRuns] (
		[TestRunID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_TestRunViews_Views] FOREIGN KEY 
	(
		[ViewID]
	) REFERENCES [Views] (
		[ViewID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [TestTables] ADD 
	CONSTRAINT [FK_TestTables_Tables] FOREIGN KEY 
	(
		[TableID]
	) REFERENCES [Tables] (
		[TableID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_TestTables_Tests] FOREIGN KEY 
	(
		[TestID]
	) REFERENCES [Tests] (
		[TestID]
	) ON DELETE CASCADE  ON UPDATE CASCADE 
GO

ALTER TABLE [TestViews] ADD 
	CONSTRAINT [FK_TestViews_Tests] FOREIGN KEY 
	(
		[TestID]
	) REFERENCES [Tests] (
		[TestID]
	),
	CONSTRAINT [FK_TestViews_Views] FOREIGN KEY 
	(
		[ViewID]
	) REFERENCES [Views] (
		[ViewID]
	)
GO

-- Table with a single-column primary key and no foreign keys: Sponsor
-- Table with a single-column primary key and at least one foreign key: Chef
-- Table with a multicolumn primary key: Sponsorship

-- view with a SELECT statement operating on one table: view on gym
CREATE OR ALTER VIEW ViewOnOneTable
AS
	SELECT G.name
	FROM gym G
	WHERE G.subscription_price = 170
GO

-- view with a SELECT statement operating on at least 2 tables: view on gym and coach
CREATE OR ALTER VIEW ViewOnMinTwoTables -- coaches and subscription prices of the gyms they work at
AS
	SELECT C.name, G.subscription_price
	FROM coach C
	INNER JOIN gym G
	ON C.gym_id = G.gym_id
GO

-- view with a SELECT statement that has GROUP BY clause and operates on at least 2 tables
CREATE OR ALTER VIEW ViewGroupBy -- coaches and gyms
AS
	SELECT TOP 3 C.name, C.salary, G.name, G.subscription_price
	FROM coach C
	INNER JOIN gym G
	ON C.gym_id = G.gym_id
	WHERE G.subscription_price BETWEEN 100 AND 200
	ORDER BY C.salary
GO


INSERT INTO Tables
VALUES ('Sponsor'),
	   ('Chef'),
	   ('Sponsorship')

INSERT INTO Views 
VALUES ('view_on_one_table'),
	   ('view_on_min_two_tables'),
	   ('view_group_by')

INSERT INTO TESTS
VALUES ('test1'),
	   ('test2'),	
	   ('test3'),	
	   ('test4'),	
	   ('test5')	

INSERT INTO TestTables -- (TestID, TableID, NoOfRows, Position)
VALUES (1, 1, 5, 1),		
	   (1, 2, 5, 2),		
	   (2, 1, 15, 2),
	   (2, 2, 15, 3),
	   (2, 3, 15, 1),
	   (3, 1, 150, 3),
	   (3, 2, 150, 1),
	   (3, 3, 150, 2),
	   (4, 1, 1500, 1),
	   (4, 2, 1500, 3),
	   (4, 3, 1500, 2),
	   (5, 1, 5000, 2),
	   (5, 2, 5000, 1),
	   (5, 3, 5000, 3)

INSERT INTO TestViews -- (IdTest, IdView)
VALUES (1, 1), 
	   (1, 2),
	   (1, 3),
	   (2, 1),
	   (2, 2),
	   (2, 3),
	   (3, 1),
	   (3, 2),
	   (3, 3),
	   (4, 1),
	   (4, 2),
	   (4, 3),
	   (5, 1),
	   (5, 2),
	   (5, 3)

GO
CREATE OR ALTER PROCEDURE deleteData (@table VARCHAR(30))
AS
BEGIN
	IF EXISTS (
        SELECT * 
        FROM PowerliftingCompDB.sys.tables 
        WHERE tables.name IN ('Sponsor', 'Chef', 'Sponsorship') AND tables.name = @table
    )
	BEGIN
		DECLARE @executeDelete NVARCHAR(100)
		SET @executeDelete = N'DELETE FROM ' + @table
		EXECUTE sp_executesql @executeDelete
	END
	ELSE
	BEGIN
		RAISERROR('invalid input: table', 17, 1)
		RETURN
	END
END

GO
CREATE OR ALTER PROCEDURE evaluateView (@view VARCHAR(30))
AS
BEGIN
	IF EXISTS (SELECT * FROM PowerliftingCompDB.sys.views WHERE views.name = @view)
	BEGIN
		DECLARE @executeView NVARCHAR(100)
		SET @executeView = N'SELECT * FROM ' + @view
		EXECUTE sp_executesql @executeView
	END
	ELSE
	BEGIN
		RAISERROR('invalid input: view', 17, 1)
		RETURN
	END
END


GO
CREATE OR ALTER PROCEDURE insertData (@tableName VARCHAR(30), @nrOfRows INTEGER)
AS
BEGIN
	DECLARE @initialNrOfRows INTEGER
	SET @initialNrOfRows = @nrOfRows
    -- sponsor
	IF @tableName = 'Sponsor'
	BEGIN
		DECLARE @sponsor_name VARCHAR(100)
		DECLARE @sponsor_id INTEGER

		WHILE @nrOfRows > 0
		BEGIN
			SET @sponsor_name = CONVERT(VARCHAR(100), NEWID())

			INSERT INTO Sponsor(name)
			VALUES (@sponsor_name)

			SET @nrOfRows = @nrOfRows - 1
		END
	END
    -- chef 
	ELSE IF @tableName = 'Chef'
	BEGIN
        -- chef props
		DECLARE @chef_id INTEGER
		DECLARE @food_supplier_id INTEGER
		DECLARE @salary INTEGER
        DECLARE @chef_name VARCHAR(100)
        DECLARE @nationality VARCHAR(100)

        -- food_supplier props
		DECLARE @FS_id INTEGER
		DECLARE @FS_name VARCHAR(100)
		DECLARE @delivery_price INTEGER
        DECLARE @average_pricing INTEGER

		WHILE @nrOfRows > 0
		BEGIN
			SET @FS_name = CONVERT(VARCHAR(100), NEWID())
			SET @delivery_price = ABS(CHECKSUM(NEWID())) % 35 + 20
            SET @average_pricing = ABS(CHECKSUM(NEWID())) % 35 + 20

			INSERT INTO food_supplier(name, delivery_price, average_pricing)
			VALUES (@FS_name, @delivery_price, @average_pricing)

			SET @food_supplier_id = (
                SELECT food_supplier_id 
                FROM food_supplier 
                WHERE food_supplier_id = @initialNrOfRows - @nrOfRows + 1
            )
			SET @salary = ABS(CHECKSUM(NEWID())) % 35 + 20
            SET @chef_name = CONVERT(VARCHAR(100), NEWID())
            SET @nationality = CONVERT(VARCHAR(100), NEWID())

			INSERT INTO chef(food_supplier_id, chef_name, nationality, salary)
			VALUES (@food_supplier_id, @chef_name, @nationality, @salary)
			
			SET @nrOfRows = @nrOfRows - 1 
		END
	END

	ELSE IF @tableName = 'Sponsorship'
	BEGIN
		DECLARE @sponsor_id INTEGER
		DECLARE @competition_id INTEGER
        DECLARE @budget INTEGER

		WHILE @nrOfRows > 0
		BEGIN
			SET @sponsor_id = (SELECT TOP 1 sponsor_id FROM sponsor)
			SET @competition_id = (SELECT TOP 1 competition_id FROM competition)
            SET @budget = ABS(CHECKSUM(NEWID())) % 35 + 20

			INSERT INTO sponsorship(sponsor_id, competition_id, budget)
			VALUES (@sponsor_id, @competition_id, @budget)

			SET @nrOfRows = @nrOfRows - 1
		END
	END
	ELSE
	BEGIN
		RAISERROR('Invalid input: insert', 17, 1)
		RETURN
	END
END

GO
CREATE OR ALTER PROCEDURE mainTest (@testID INT)
AS
BEGIN
	DECLARE @testRunID INT
	DECLARE @viewID INT
    DECLARE @tableID INT
    DECLARE @tableName VARCHAR(30)
	DECLARE @viewName VARCHAR(30)
    DECLARE @nrOfRows INT
	DECLARE @startTime DATETIME
	DECLARE @endTime DATETIME
	
	INSERT INTO TestRuns VALUES (
        (
            SELECT T.Name 
            FROM Tests T 
            WHERE T.TestID = @testID
        ),
            GETDATE(),
            GETDATE()
        )
	SET @testRunID = (SELECT MAX(T.TestRunID) FROM TestRuns T)
    
	PRINT 'TestRuns Success'

	DECLARE deleteCursor CURSOR FOR
		SELECT TableID
		FROM TestTables
		WHERE TestID = @testID
		ORDER BY Position ASC

	OPEN deleteCursor
        FETCH NEXT
            FROM deleteCursor
            INTO @tableID

        PRINT 'delete cursor'

        WHILE @@FETCH_STATUS = 0
        BEGIN	
            SET @tableName = (SELECT Name FROM Tables WHERE TableID = @tableID)
            EXEC deleteData @tableName
            FETCH NEXT
                FROM deleteCursor
                INTO @tableID
            PRINT 'fetch the next delete cursor'
        END
	CLOSE deleteCursor
	DEALLOCATE deleteCursor

	DECLARE insertCursor CURSOR FOR
		SELECT TableID, NoOfRows
		FROM TestTables
		WHERE TestID = @testID
		ORDER BY Position DESC

	OPEN insertCursor
        FETCH NEXT
            FROM insertCursor
            INTO @tableID, @nrOfRows

        PRINT 'insert cursor'

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @tableName = (SELECT Name from Tables WHERE TableID = @tableID)
            SET @startTime = GETDATE()
            EXEC insertData @tableName, @nrOfRows
            SET @endTime = GETDATE()
            INSERT INTO TestRunTables VALUES (@testRunID, @tableID, @startTime, @endTime)
            FETCH NEXT
                FROM insertCursor
                INTO @tableID, @nrOfRows
            PRINT 'fetch the next insert cursor'
        END
	CLOSE insertCursor
	DEALLOCATE insertCursor

	DECLARE viewsCursor CURSOR FOR
		SELECT ViewID
		FROM TestViews
		WHERE TestID = @testID

	OPEN viewsCursor
        FETCH NEXT
            FROM viewsCursor
            INTO @viewID

        PRINT 'views cursor'

        WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @viewName = (SELECT Name FROM Views WHERE ViewID = @viewID)
            SET @startTime = GETDATE()
            EXEC evaluateView @viewName
            SET @endTime = GETDATE()
            INSERT INTO TestRunViews VALUES (@testRunID, @viewID, @startTime, @endTime)
            FETCH NEXT
                FROM viewsCursor
                INTO @viewID
            PRINT 'fetch the next view cursor'
        END
	CLOSE viewsCursor
	DEALLOCATE viewsCursor

	UPDATE TestRuns
		SET EndAt = GETDATE()
		WHERE TestRunID = @testRunID

	PRINT 'TestRuns is now updated!'
END
