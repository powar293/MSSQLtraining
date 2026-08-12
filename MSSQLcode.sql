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

-- 3)
--3.1)
create table training.DataTypePractice (
practiceID int identity(1,1) primary key,
name NVARCHAR(100) not null,
salary decimal(18,2) not null,
practice_date date not null,
practice_time_date datetime2 not null,
isStatus bit not null,
note varchar(max) null
)

ALTER TABLE  training.DataTypePractice
ALTER COLUMN name NVARCHAR(100) not null

select * from training.DataTypePractice;



INSERT INTO training.DataTypePractice (Name, salary,practice_date,practice_time_date,isStatus, Note)
VALUES 
('Alpha', 1500.50, '2026-08-11', '2026-08-11 10:30:00.0000000', 1, 'First test row'),
('Beta', 24500.00, '2026-08-12', '2026-08-12 14:15:30.1234567', 1, NULL);

EXEC sp_help 'training.DataTypePractice'
 --using "INFORMATION_SCHEMA.COLUMNS" we can see table meta data
select COLUMN_NAME ,IS_NULLABLE, CHARACTER_MAXIMUM_LENGTH ,DATA_TYPE 
from INFORMATION_SCHEMA.COLUMNS 
where TABLE_SCHEMA = 'training'
and TABLE_NAME = 'DataTypePractice';


--error as per ASSIGNMENT when add this values on "practice_time_date"
INSERT INTO training.DataTypePractice(name,salary,practice_date,practice_time_date,isStatus,note)
VALUES ('alphaew@1',12000.3494,'2026-8-11','2026-8-1105:02:12.6372',1,'this is a note for practice only not for any other purpuse regarding it.')

 /* Error =>  INSERT INTO training.DataTypePractice(name,salary,practice_date,practice_time_date,isStatus,note)
VALUES ('alphaew@1',12000.3494,'2026-8-11','2026-8-1105:02:12.6372',1,'this is a note for practice only not for any other purpuse regarding it.') */


--3.2)
CREATE TABLE training.ProjectAssignments(
projectID INT IDENTITY(10001,1) primary key,
assign_code varchar(12) unique,
employee_ID varchar(12) not null,
IS_Status bit DEFAULT(1),
project_date datetime2 default(convert(date, GETDATE())) 
)

SELECT * FROM training.ProjectAssignments;

INSERT INTO training.ProjectAssignments (projectID,assign_code, employee_ID)
VALUES(10003,'137406','654321');
 
 --Error add value to identity,null
/* Msg 544, Level 16, State 1, Line 194
Cannot insert explicit value for identity column in table 'ProjectAssignments' when IDENTITY_INSERT is set to OFF.

Completion time: 2026-08-11T18:30:52.8716597+05:30 */

-- inset dublicat in unique column "assign_code"
INSERT INTO training.ProjectAssignments (assign_code, employee_ID)
VALUES('130006','654321');
/* Error => Msg 2627, Level 14, State 1, Line 204
Violation of UNIQUE KEY constraint 'UQ__ProjectA__DD5E050200F494B0'. Cannot insert duplicate key in object 'training.ProjectAssignments'. The duplicate key value is (130006).
The statement has been terminated.

Completion time: 2026-08-11T18:37:14.7582838+05:30 */

--4)
--4.1)
--SELECT * FROM hR.Employees;

SELECT EmployeeID, FirstName , Salary,EmploymentStatus,HireDate
from hr.Employees 
where EmploymentStatus = 'Active'
and Salary between 700000 and 1300000
order by Salary DESC, HireDate ASC;

--SELECT * FROM sales.Customers 

SELECT DISTINCT StateName  from sales.Customers 
order by StateName;
--
SELECT EmployeeID, FirstName, phone FROM hr.Employees
where Phone IS NULL;

-- Use ORDER BY to sort results and easily identify min/max trends and to genreate output result in formated way that human can easily identify and understand
-- Order by need for genreate proper output result in asscending or desscending oerder for understand max and min 

--4.2)
--product name
select ProductID, ProductName from sales.Products
where ProductName like '%License%';

--company name start with vowel [AEIOU]% used wildcard [squared brackets] to like multiple patterns characters at a time.
select CustomerID,CompanyName, ContactName from sales.Customers
where CompanyName like '[aeiou]%'


-- city end with 'e'

select CustomerID,CompanyName, ContactName, City from sales.Customers
where City like '%e';

--highest paid employees
SELECT top 5 EmployeeID,FirstName, Salary ,EmploymentStatus FROM hr.Employees
where EmploymentStatus = 'Active'
order by Salary DESC

-- top 20% expensive product used "percent with ties" if boundaries have same value we use' with ties'
SELECT top 20 percent with ties ProductID, ProductName, UnitPrice FROM sales.Products
order by UnitPrice DESC;


--4.3)
SELECT CustomerID,ContactName,StateName,CustomerTier FROM sales.Customers
where CustomerTier in('Silver' ,'gold')
and StateName in('maharashtra','gujarat','karnataka');

select OrderID,OrderDate,OrderStatus from sales.Orders
       where OrderStatus not in('cancelled')
       and OrderDate between '2025-01-01' and '2025-12-31';
      
--select * from sales.Products


SELECT ProductID, ProductName, UnitPrice,
case
     when UnitPrice > 50000 then 'Premium'
     when UnitPrice < 10000  then 'budget'
     else  'Standard'
end
FROM sales.Products
order by UnitPrice;


--
--select * from hr.Employees;

SELECT EmployeeID,FirstName , HireDate,
DATEDIFF(year, HireDate, getdate()) AS ExperienceInYears,
case 
     when DATEDIFF(year, HireDate, getdate())<=2 then 'New'
     when DATEDIFF(year, HireDate, getdate()) >=2 and DATEDIFF(year, HireDate, getdate())<=4 then 'Experience'
     else 'Senior'
end as Level
from hr.Employees
ORDER BY ExperienceInYears desc;

--
-- SELECT *FROM hr.Employees    --- department

SELECT d.DepartmentName,avg(e.Salary) as AVG_Salary, count(e.EmployeeID) Total_Employees_Counts
FROM hr.Employees as e 
inner join hr.Departments as d
on e.DepartmentID = d.DepartmentID
group by d.DepartmentName;

--
SELECT d.DepartmentName,avg(e.Salary) as AVG_Salary
FROM hr.Employees as e 
inner join hr.Departments as d
on e.DepartmentID = d.DepartmentID
group by d.DepartmentName
having avg(e.Salary)>900000;


-- select * from sales.Orders;
-- select * from sales.OrderItems;

select year(o.OrderDate) AS Order_year, o.OrderStatus , sum(oi.UnitPrice*oi.Quantity) AS Gross
from sales.Orders AS o
inner join sales.OrderItems AS oi
on o.OrderID=oi.OrderID
where o.OrderStatus <> 'Cancelled'
GROUP BY ROLLUP( year(o.OrderDate) , o.OrderStatus) 
ORDER BY Order_year DESC , Gross 



--5.2)
--SELECT Salary FROM hr.Employees;
-- scalar
SELECT FirstName,Salary FROM hr.Employees
where Salary>(select avg(Salary) from hr.Employees);


--select * from sales.Customers -- Orders tales.
--  Exists and Correlated
select c.CustomerID,c.ContactName from sales.Customers as c
 where EXISTS(
              select o.OrderStatus
              from sales.Orders as o
              where o.CustomerID=c.CustomerID
              AND o.OrderStatus = 'Completed'
) 


-- 
-- SELECT * FROM hr.Departments;
-- Correlated
SELECT * FROM hr.Employees AS e1
where Salary>(
      select avg(e2.Salary) from hr.Employees AS e2 where e2.DepartmentID = e1.DepartmentID

-- select * from sales.Customers
-- select* from sales.OrderItems;
-- select * from sales.Orders


SELECT TOP 5
    c.CustomerID,
    c.ContactName,
    v.NetSales
FROM sales.Customers AS c
INNER JOIN
(
    SELECT
        o.CustomerID,
        SUM(oi.Quantity * oi.UnitPrice) 
        AS NetSales
    FROM sales.Orders AS o
    INNER JOIN sales.OrderItems AS oi
        ON o.OrderID = oi.OrderID
    WHERE o.OrderStatus <> 'Cancelled'
    GROUP BY o.CustomerID
) AS v
    ON c.CustomerID = v.CustomerID
ORDER BY v.NetSales DESC;

--6)

select concat(FirstName, ' ' , LastName) AS EMP_NAME,lower(Email) AS Email from hr.Employees;

select SUBSTRING(ProductName,1,8), ProductName,len(ProductName) AS ProductName_LengthCount  from sales.Products;

 SELECT ProductName,REPLACE(ProductName,'LICENSE','Subscription') AS ProductName_Subcription FROM sales.Products;

 select Email from hr.Employees
 where email is null

 select SUBSTRING(Email, CHARINDEX('@',Email)+1, Len(Email)) from hr.Employees



--6.2)
select FirstName,datediff(year, HireDate, GETDATE()) ,dateadd(year ,datediff(year, HireDate, GETDATE()   ) , HireDate) as anniversary,HireDate from hr.Employees;

select OrderDate  ,
datename(month,OrderDate),
DATEPART(QUARTER , OrderDate),
EOMONTH(OrderDate)
from sales.Orders;

-- Last 12 Months Order Place

DECLARE @ASofDate date = '2026-10-08'; 
 select OrderID,OrderDate from sales.Orders
 where OrderDate >DATEADD(month,-12, dateadd(day , 1,EOMONTH(@ASofDate,-1)))
 and OrderDate< EOMONTH(@ASofDate, -1);

 -- Late and No_late
 SELECT OrderDate, RequiredDate , datediff(day,OrderDate,RequiredDate) AS late ,
 case
 when datediff(day,OrderDate,RequiredDate)>12 then 'late'
 else 'no_late'
 end AS Late_Flag
 FROM sales.Orders
