-- 1.1)
use InternMSSQLTraining

select * from hr.Employees

-- hr.Employees table has PK named as PK_Employees created on EmployeeID column

EXEC sp_help 'hr.employees'

-- This database uses a Relational Database Management System (RDBMS) structure, where tables are connected to each other using Primary Key (PK) and Foreign Key (FK) constraints.
--SQL Server manages, stores, and provides security for data using its software engine.

--1.2)
select * from sales.Products;

select top 5*from sales.Products;

select getdate()

select DB_NAME()

-- SQL is a standard Structured Query Language used to manage databases. SQL Server is a database management system created by Microsoft that performs data tasks, provides security, and requires a server to run.
-- T-SQL is an advanced extension of SQL that adds programming features like while loops, if/else statements, and try/catch error handling.

--1.3)

SELECT @@VERSION

SELECT SUSER_SNAME();

SELECT SYSDATETIME();

--2)DATA BASE MANAGEMENT

-- all DB info
SELECT 
    NAME AS [DB_Name],
       state_desc AS [STATE],
       recovery_model_desc AS [Recovery Model],
       create_date AS [Creation Date]
FROM SYS.DATABASES;
 
-- backup 
backup database InternMSSQLTraining
to disk =N'C:\backup\InternMSSQLTraining.bak' with format, init;


select DB_NAME();
-- all schema and tables name in column
SELECT 
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables t
INNER JOIN sys.schemas s 
    ON t.schema_id = s.schema_id
ORDER BY s.name, t.name;

--  column and data types of sales.orders
SELECT 
    COLUMN_NAME AS ColumnName,
    DATA_TYPE AS DataType
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'sales'
  AND TABLE_NAME = 'orders'
ORDER BY ORDINAL_POSITION;

use InternMSSQLTraining

--2.2)
CREATE DATABASE Internsandbox;

use InternSandbox

select DB_NAME()

CREATE TABLE Intern(
InternID int identity(1,1) primary key,
FName varchar(30) not null,
LName varchar(30) not null,
department varchar(20) check( department IN('IT', 'account', 'intern')),  
MARK INT CHECK(MARK >= 0 AND MARK <= 10)
)

SELECT * FROM SYS.TABLES

USE master;
--set to sigle user 
ALTER DATABASE Internsandbox 
SET SINGLE_USER 
WITH ROLLBACK IMMEDIATE;

DROP database Internsandbox

select name from sys.databases
 -- 2.3)

 SELECT * FROM training.LearnerScratch;

 update training.LearnerScratch
 set AttemptDate = '2025-01-13'
 where ScratchID = 1

 INSERT INTO training.LearnerScratch(LearnerName,TopicName, Score,AttemptDate, Notes)
 VALUES ('pratik','Physics',99,'good performance of this candidate')

  INSERT INTO training.LearnerScratch(LearnerName,TopicName, Score, Notes)
 VALUES ('pratiksha','history',90,'good performance of this candidate'),
        ('ruturaj','politics',60,'good performance')

select * from training.LearnerScratch
where ScratchID =3
 
 update training.LearnerScratch
 set LearnerName = 'ram ji'
 where ScratchID =1

select @@ROWCOUNT; 

delete from training.LearnerScratch
where ScratchID = 2;

select * from training.LearnerScratch;

-- BEGIN TRAN to ROLLBACK TRAN it is used to keep safe queries in DB we can restor it from BEGIN what we have changed.
begin TRAN

select * from training.LearnerScratch

 update training.LearnerScratch
 set LearnerName = 'shamala ji'
 where ScratchID =3

  select @@rowcount;

delete from training.LearnerScratch
where ScratchID = 3

select @@ROWCOUNT;

-- restore oprations of DB from BEGIN TRAN we have done
ROLLBACK TRAN

