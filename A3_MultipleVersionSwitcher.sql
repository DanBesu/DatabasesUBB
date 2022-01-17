USE new_lab3
GO

-- 1 For each of the scripts above, write another one that reverts the operation. 
-- Place each script in a stored procedure. Use a simple, intuitive naming convention.

-- a. modify the type of a column
CREATE OR ALTER PROC usp_change_meal_program_category_type
AS
BEGIN
    ALTER TABLE meal_program
    ALTER COLUMN category CHAR(30)
    PRINT 'CHANGE TYPE of meal_program.category to CHAR(30)'
END
GO 

-- undo
CREATE OR ALTER PROC UNDO_usp_change_meal_program_category_type
AS
BEGIN
    ALTER TABLE meal_program
    ALTER COLUMN category VARCHAR(30)
    PRINT 'CHANGE TYPE of meal_program.category to VARCHAR(30)'
END
GO

-- b. add / remove a column
CREATE OR ALTER PROC usp_remove_meal_program_nr_kcals
AS
BEGIN
    ALTER TABLE meal_program 
    DROP COLUMN nr_kcals
    PRINT 'REMOVE meal_program.nr_kcals'
END 
GO 

-- undo
CREATE OR ALTER PROC UNDO_usp_remove_meal_program_nr_kcals
AS
BEGIN
    ALTER TABLE meal_program
    ADD nr_kcals INT 
    PRINT 'ADD meal_program.nr_kcals'
END
GO

-- c. add / remove a DEFAULT constraint
CREATE OR ALTER PROC usp_add_default_constraint_meal_program_nr_protein
AS
BEGIN
    ALTER TABLE meal_program
    ADD CONSTRAINT default_nr_protein DEFAULT 150 FOR nr_protein
    PRINT 'ADD DEFAULT CONSTRAINT 0 for meal_program.nr_protein'
END
GO

-- undo 
CREATE OR ALTER PROC UNDO_usp_add_default_constraint_meal_program_nr_protein 
AS 
BEGIN
    ALTER TABLE meal_program
    DROP CONSTRAINT default_nr_protein 
    PRINT 'DROP CONSTRAINT DEFAULT for meal_program.nr_protein'
END
GO 

-- d. add / remove a primary key
CREATE OR ALTER PROC usp_add_primary_key_therapist_id
AS
BEGIN
    ALTER TABLE therapist
    ADD CONSTRAINT therapist_id PRIMARY KEY (therapist_id)
    PRINT 'ADD PRIMARY KEY theraphist_id'
END 
GO

-- undo
CREATE OR ALTER PROC UNDO_usp_add_primary_key_therapist_id
AS
BEGIN
    ALTER TABLE therapist
    DROP CONSTRAINT therapist_id
    PRINT 'REMOVE PRIMARY KEY therapist_id'
END
GO

-- e. add / remove a candidate key
CREATE OR ALTER PROC usp_add_candidate_key_macronutrients
AS
BEGIN
    ALTER TABLE meal_program 
    ADD CONSTRAINT macros UNIQUE(nr_protein, nr_carbs, nr_fats)
    PRINT 'ADD CANDIDATE KEY macros(protein, carbs, fats)'
END
GO

-- undo
CREATE OR ALTER PROC UNDO_usp_add_candidate_key_macronutrients
AS
BEGIN
    ALTER TABLE meal_program
    DROP CONSTRAINT macros
    PRINT 'REMOVE CANDIDATE KEY macros(protein, carbs, fats)'
END
GO

-- f. add/remove a foreign key
CREATE OR ALTER PROC usp_connect_therapist_to_athlete
AS
BEGIN
    ALTER TABLE therapist
    ADD CONSTRAINT athlete_id_fk FOREIGN KEY (athlete_id) REFERENCES athlete(athlete_id) ON DELETE CASCADE

    PRINT 'ADD FOREIGN KEY therapist.athlete_id'
END
GO

-- undo 
CREATE OR ALTER PROC UNDO_usp_connect_therapist_to_athlete
AS
BEGIN
    ALTER TABLE therapist
    DROP CONSTRAINT athlete_id_fk
    PRINT 'REMOVE FOREIGN KEY therapist.athlete_id'
END
GO

-- g. create / drop a table
CREATE OR ALTER PROC usp_create_table
AS
BEGIN
    CREATE TABLE therapist(
        therapist_id INT NOT NULL,
        name VARCHAR(30),
        athlete_id INT
    )
    PRINT 'CREATE therapist new table'
END
GO

-- undo
CREATE OR ALTER PROC UNDO_usp_create_table
AS
BEGIN
    DROP TABLE IF EXISTS therapist
    PRINT 'REMOVE therapist new table'
END
GO

-- Create a new table that holds the current version of the database schema. 
-- Simplifying assumption: the version is an integer number.

-- DROP TABLE version_update;

CREATE TABLE version_update(
    current_procedure VARCHAR(100),
    undo_procedure VARCHAR(100),
    current_version INT
)

INSERT INTO version_update(current_procedure, undo_procedure, current_version)
VALUES 
    (NULL, NULL, 0),
    ('usp_create_table', 'UNDO_usp_create_table', 1),
    ('usp_connect_therapist_to_athlete', 'UNDO_usp_connect_therapist_to_athlete', 2),
    ('usp_change_meal_program_category_type', 'UNDO_usp_change_meal_program_category_type', 3),
    ('usp_add_default_constraint_meal_program_nr_protein', 'UNDO_usp_add_default_constraint_meal_program_nr_protein', 4),
    ('usp_add_candidate_key_macronutrients', 'UNDO_usp_add_candidate_key_macronutrients', 5),
    ('usp_remove_meal_program_nr_kcals', 'UNDO_usp_remove_meal_program_nr_kcals', 6),
    ('usp_add_primary_key_therapist_id', 'UNDO_usp_add_primary_key_therapist_id', 7)

-- SELECT * FROM version_update

-- drop table current_version;

CREATE TABLE current_version(
    version_index INT NOT NULL
)

INSERT INTO current_version VALUES(0)

-- SELECT * FROM current_version

-- 3. Write a stored procedure that receives as a parameter a version number 
-- and brings the database to that version.

GO
CREATE OR ALTER PROCEDURE usp_change_version @VersionInput INT
AS
BEGIN 
    DECLARE @CurrentVersion INT
    SET @CurrentVersion = (SELECT * FROM current_version)
    PRINT 'Current Version: ' + CAST(@CurrentVersion as VARCHAR(2)) -- 

    IF @CurrentVersion NOT BETWEEN 0 AND 7
        BEGIN 
            RAISERROR('Version number must be between 0 and 7', 11, 1)
            RETURN 
        END
    ELSE
    IF @CurrentVersion = @VersionInput
        BEGIN
            PRINT 'The current version is the same with the Version from Input'
            RETURN 
        END
    ELSE
    IF @CurrentVersion < @VersionInput
        BEGIN 
            PRINT 'Current Version < Input Version'
            WHILE @CurrentVersion < @VersionInput
                BEGIN 
                    DECLARE @FunctionName VARCHAR(100)
                    SET @FunctionName = (
                        SELECT V.current_procedure
                        FROM version_update V
                        WHERE V.current_version = @CurrentVersion + 1
                    )
                    EXEC(@FunctionName)
                    PRINT 'Execute ' + @FunctionName
                    SET @CurrentVersion = @CurrentVersion + 1
                END
        END
    ELSE 
    IF @CurrentVersion > @VersionInput
        BEGIN
            PRINT 'Current Version > Input Version'
            WHILE @CurrentVersion > @VersionInput
                BEGIN 
                    DECLARE @FunctionName2 VARCHAR(100)
                    SET @FunctionName2 = (
                        SELECT V.undo_procedure
                        FROM version_update V 
                        WHERE V.current_version = @CurrentVersion
                    )
                    EXEC(@FunctionName2)
                    PRINT 'Execute ' + @FunctionName
                    SET @CurrentVersion = @CurrentVersion - 1
                END
        END
    
    UPDATE current_version
        SET version_index = @VersionInput
    PRINT 'Current version is now updated'
END
GO

EXEC usp_change_version 0
drop table if EXISTS therapist
UPDATE current_version
        SET version_index = 0
select * from meal_program
select * from version_update
