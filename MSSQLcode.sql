-- 1.1)
use InternMSSQLTraining

select * from hr.Employees

-- hr.Employees table has PK named as PK_Employees created on EmployeeID column   .
   -- and two attributes is FirstNmae and Email

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


 --7)
 --7.1)
 ALTER table training.LearnerScratch
 add ReviewerName varchar(80) null;

 -- select * from training.learnerScratch;
 INSERT INTO training.learnerScratch (
    
    LearnerName, 
    TopicName, 
    Score, 
    AttemptDate, 
    Notes
    
)
VALUES 
( 'Smith', 'Data Analytics', 92, '2026-08-13', 'Excellent work.')




exec sp_help 'training.learnerScratch'

 update training.LearnerScratch
 set ReviewerName = 'pratham'
 where ReviewerName is null 

 ALTER table training.LearnerScratch
 alter column ReviewerName varchar(80) not null;

 alter table training.LearnerScratch
 add ReviewedAT datetime2(0) default getdate()

 update training.LearnerScratch
 set ReviewedAT = GETDATE()


 alter table training.LearnerScratch
 add temp_column varchar(99) null;


  EXEC sp_help 'training.LearnerScratch'


 alter table training.LearnerScratch
 drop column temp_column



 7.2)
 select * from training.LearnerScratch

  alter table  training.LearnerScratch
  alter column Score int null

  alter table  training.LearnerScratch
  ADD constraint CK_LearnersSratch_Score check(Score between 0 and 100)
  
  update training.LearnerScratch
  set Score = 99
  where ScratchID = 4

    update training.LearnerScratch
  set Score = 120
  where ScratchID = 4

  /* Msg 547, Level 16, State 0, Line 476
The UPDATE statement conflicted with the CHECK constraint "CK_LearnersSratch_Score". The conflict occurred in database "InternMSSQLTraining", table "training.LearnerScratch", column 'Score'.
The statement has been terminated.
*/

select OBJECT_NAME(parent_object_id), name as contraint from sys.check_constraints

alter table training.LearnerScratch
drop constraint CK_LearnersSratch_Score

alter table training.LearnerScratch
add constraint CK_LearnersSratch_Score check(Score between 0 and 100)

-- 8)
-- 8.1)  
create database training
-- one to many
create table department(
dep_id int primary key,
dep_name varchar(36)
)
select * from employees 

create table employees(
emp_id int primary key,
emp_name varchar(50) not null ,
dep_id int ,
foreign key (dep_id) references department(dep_id)
)

-- many to many
create table student(
student_id int primary key,
student_name varchar(36) not null
)
 
 create table course(
 course_id int primary key ,
 course_name varchar not null
 )

 create table student_course(
 course_id int ,
 student_id int,
 primary key (course_id,student_id),
 foreign key(course_id) references student(student_id)
 )

 -- self references
 create table staff(
 emp_id int primary key,
 hr_id int not null unique,
 constraint FK_staff_hr foreign key (hr_id) references staff(emp_id)
 );

 select * from sys.foreign_keys
 select *  from sys.foreign_key_columns
 select OBJECT_NAME(constraint_object_id), OBJECT_NAME(parent_object_id) from sys.foreign_key_columns 

 -- 

 select * from sales.OrderItems

 BEGIN try
   BEGIN transaction
     insert into sales.OrderItems(OrderID,Quantity)
     values(999,3);
     commit transaction;
 END try
  BEGIN catch
     if @@TRANCOUNT > 0 rollback transaction;
     select ERROR_NUMBER() , ERROR_MESSAGE() ;
     end catch;
-- Cannot insert the value NULL into column 'UnitPrice', table 'master.sales.OrderItems'; column does not allow nulls. INSERT fails.

select * from sales.OrderItems

exec sp_help 'Sales.OrderItems'
-- orderItems it is a junction of many to many relationship . which make relation between 'products' and 'Orders' tables.
-- orderItems table have two foreign keys contraints 1) for product = FK_OrderItems_Product and 2) for Orders = FK_Orderitems_Orders which creats relation between this .
select * from sales.Products
select * from sales.Orders


-- 
8.2)
 select OrderDate,OrderNumber,c.CompanyName from sales.Orders as o
 inner join sales.Customers as c
 on c.CustomerID = o.CustomerID;


 select *  from sales.Customers as c
 left join sales.Orders as o
 on c.CustomerID = o.CustomerID
 where o.OrderID is null;


 select* from hr.Employees
 
 SELECT 
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    ISNULL(m.FirstName + ' ' + m.LastName, 'Top Level (No Manager)') AS ManagerName
FROM hr.Employees e
LEFT JOIN hr.Employees m ON e.ManagerID = m.EmployeeID


select * from sales.Customers

select c1.CompanyName,c1.CustomerTier from sales.Customers as c1
cross join sales.Customers as c2


select *  from sales.Customers as c
 right join sales.Orders as o
 on c.CustomerID = o.CustomerID

 select *  from sales.Customers as c
 full outer join sales.Orders as o
 on c.CustomerID = o.CustomerID

 -- 8.3)
 select Location from hr.Departments
  union
 select City from sales.Customers;

  select Location from hr.Departments
  union  all
 select City from sales.Customers;



 select City from sales.Customers
 except
  select ShippingCity from sales.Orders;


  SELECT 
    c.CustomerID,
    o.OrderID,
    o.OrderDate
FROM sales.Customers c
OUTER APPLY (
    SELECT TOP 1 OrderID, OrderDate 
    FROM sales.Orders 
    WHERE CustomerID = c.CustomerID
    ORDER BY OrderDate DESC
) AS o;

 

 --9)
 --9.1)
CREATE VIEW training.vw_CustomerSales AS
SELECT
    c.CustomerID,
    c.CompanyName,
    COUNT(DISTINCT o.OrderID) AS OrderCount,
    ISNULL(SUM(oi.UnitPrice * oi.Quantity), 0) AS GrossSales,    
    ISNULL(SUM((oi.UnitPrice * oi.Quantity) - o.DiscountPercent), 0) AS NetSales
FROM sales.Customers c
LEFT JOIN sales.Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN sales.OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY c.CustomerID, c.CompanyName;


select * from training.vw_CustomerSales

CREATE VIEW training.vw_Net_CustomerSales AS
SELECT top 5
    c.CustomerID,
    c.CompanyName,
    COUNT(DISTINCT o.OrderID) AS OrderCount,
    ISNULL(SUM(oi.UnitPrice * oi.Quantity), 0) AS GrossSales,    
    ISNULL(SUM((oi.UnitPrice * oi.Quantity) - o.DiscountPercent), 0) AS NetSales
FROM sales.Customers c
LEFT JOIN sales.Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN sales.OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY c.CustomerID, c.CompanyName
order by NetSales

select * from training.vw_Net_CustomerSales

SELECT EmployeeID,FirstName, LastName,DepartmentID, Salary,
    RANK() OVER (
        PARTITION BY DepartmentID ORDER BY Salary DESC
) AS SalaryRank,
DENSE_RANK() OVER (
        PARTITION BY DepartmentID
        ORDER BY Salary DESC
    ) AS DenseRank

FROM hr.Employees
ORDER BY DepartmentID, Salary DESC; 
   
    
   

   SELECT o.OrderID,o.OrderDate,oi.ProductID,oi.Quantity, oi.UnitPrice,
   SUM(oi.Quantity * oi.UnitPrice
        * (1 - o.DiscountPercent / 100.0))
    OVER (
        ORDER BY o.OrderDate, o.OrderID
        ROWS UNBOUNDED PRECEDING
    ) AS RunningNetSales

FROM sales.Orders o
JOIN sales.OrderItems oi
    ON o.OrderID = oi.OrderID
ORDER BY o.OrderDate, o.OrderID;


--9.2)
with order_totals as (
  SELECT OrderItemID,OrderID,Quantity*UnitPrice AS net_total FROM sales.OrderItems )
select * from order_total

SELECT c.CustomerTier,sum(o.Total) from order_total AS o
join sales.Customers as c on
c.CustomerID=c.CustomerID;



WITH order_totals AS (
    SELECT
        o.OrderID,
        o.CustomerID,
        SUM(oi.Quantity * oi.UnitPrice) AS net_total
    FROM Sales.Orders o
    JOIN Sales.OrderItems oi
        ON o.OrderID = oi.OrderID
    GROUP BY o.OrderID, o.CustomerID
)
SELECT
    c.CustomerTier,
    SUM(ot.net_total) AS total_net_sales
FROM order_totals ot
JOIN Sales.Customers c
    ON ot.CustomerID = c.CustomerID
GROUP BY c.CustomerTier;

--

WITH order_totals AS (
    SELECT
        o.OrderID,
        YEAR(o.OrderDate) AS OrderYear,
        SUM(oi.Quantity * oi.UnitPrice) AS order_total
    FROM Sales.Orders o
    JOIN Sales.OrderItems oi
        ON o.OrderID = oi.OrderID
    WHERE o.OrderStatus = 'Completed'
    GROUP BY o.OrderID, YEAR(o.OrderDate)
),
ranked_orders AS (
    SELECT
        OrderYear,
        OrderID,
        order_total,
        ROW_NUMBER() OVER (
            PARTITION BY OrderYear
            ORDER BY order_total DESC
        ) AS rn
    FROM order_totals
)
SELECT
    OrderYear,
    OrderID,
    order_total
FROM ranked_orders
WHERE rn = 1;



---- Start with CEO  -- Find employees under each manager
WITH EmployeeHierarchy AS (
   
    SELECT
        EmployeeID,
        FirstName,
        ManagerID,
        0 AS LevelNo
    FROM hr.Employees
    WHERE ManagerID IS NULL

    UNION ALL

   
    SELECT
        e.EmployeeID,
        e.FirstName,
        e.ManagerID,
        eh.LevelNo + 1
    FROM hr.Employees e
    JOIN EmployeeHierarchy eh
        ON e.ManagerID = eh.EmployeeID
)
SELECT
    EmployeeID,
    FirstName,
    ManagerID,
    LevelNo
FROM EmployeeHierarchy
ORDER BY LevelNo, EmployeeID;

--
/*SELECT
    EmployeeID,
    FirstName,
    ManagerID,
    LevelNo
FROM EmployeeHierarchy
ORDER BY LevelNo, EmployeeID
OPTION (MAXRECURSION 100);
*/


--9.3) 

CREATE OR ALTER PROCEDURE training.usp_GetCustomerOrders
    @CustomerID INT,
    @FromDate DATE,
    @Status VARCHAR(20) = NULL
AS
BEGIN
    SELECT
        OrderID,
        CustomerID,
        OrderDate,
        OrderStatus
    FROM Sales.Orders
    WHERE CustomerID = @CustomerID
      AND OrderDate >= @FromDate
      AND (@Status IS NULL OR OrderStatus = @Status);
END;


--
declare @CustomerID int = 2000

IF NOT EXISTS (
    SELECT 1
    FROM Sales.Customers
    WHERE CustomerID = @CustomerID
)
BEGIN
    THROW 50001, 'Invalid CustomerID. Customer does not exist.', 1;
END;


--
declare @CustomerID int 
   declare @FromDate DATE
    declare @Status VARCHAR(20) = NULL
SELECT
    o.OrderID,
    o.OrderDate,
    o.OrderStatus,
    oi.Quantity,
    oi.UnitPrice,
    oi.Quantity * oi.UnitPrice AS NetAmount
FROM Sales.Orders o
JOIN Sales.OrderItems oi
    ON o.OrderID = oi.OrderID
WHERE o.CustomerID = @CustomerID
  AND o.OrderDate >= @FromDate
  AND (@Status IS NULL OR o.OrderStatus = @Status);


  --

-- 
  BEGIN TRY
    EXEC training.usp_GetCustomerOrders 1, '2026-01-01', 'Completed';
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

--9.4)
CREATE OR ALTER FUNCTION training.fn_NetAmount
(
    @GrossAmount DECIMAL(14,2),
    @DiscountPercent DECIMAL(5,2)
)
RETURNS DECIMAL(14,2)
AS
BEGIN
    RETURN CAST(@GrossAmount * (1 - @DiscountPercent / 100) AS DECIMAL(14,2));
END;



--
SELECT
    o.OrderID,
    oi.Quantity,
    oi.UnitPrice,
    training.fn_NetAmount(
        oi.Quantity * oi.UnitPrice,
        o.DiscountPercent
    ) AS NetAmount
FROM Sales.Orders o
JOIN Sales.OrderItems oi
    ON o.OrderID = oi.OrderID;

    --
    CREATE OR ALTER FUNCTION training.fn_CustomerOrders
(
    @CustomerID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        o.OrderID,
        o.OrderDate,
        SUM(oi.Quantity * oi.UnitPrice) AS OrderTotal
    FROM Sales.Orders o
    JOIN Sales.OrderItems oi
        ON o.OrderID = oi.OrderID
    WHERE o.CustomerID = @CustomerID
    GROUP BY o.OrderID, o.OrderDate
);

SELECT * FROM training.fn_CustomerOrders(1);

SELECT * FROM training.fn_CustomerOrders(2);

--10)

--10.1)
SELECT CustomerID, SalesPersonID, ShippingCity
FROM Sales.Orders
WHERE OrderDate BETWEEN '2026-01-01' AND '2026-03-31'
  AND OrderStatus <> 'Cancelled';



  --
  SET STATISTICS IO ON;

SELECT CustomerID, SalesPersonID, ShippingCity
FROM Sales.Orders
WHERE OrderDate BETWEEN '2026-01-01' AND '2026-03-31'
  AND OrderStatus <> 'Cancelled';

SET STATISTICS IO OFF;

--
CREATE NONCLUSTERED INDEX IX_Orders_OrderDate_Status
ON Sales.Orders (OrderDate, OrderStatus)
INCLUDE (CustomerID, SalesPersonID, ShippingCity);

--
SET STATISTICS IO ON;

SELECT CustomerID, SalesPersonID, ShippingCity
FROM Sales.Orders
WHERE OrderDate BETWEEN '2026-01-01' AND '2026-03-31'
  AND OrderStatus <> 'Cancelled';

SET STATISTICS IO OFF;

SELECT
    name,
    type_desc,
    is_unique,
    is_disabled
FROM sys.indexes
WHERE object_id = OBJECT_ID('Sales.Orders');

--
--10.2)
-- create trigger 
CREATE OR ALTER TRIGGER sales.trg_Products_PriceAudit
ON Sales.Products
AFTER UPDATE
AS
BEGIN
    INSERT INTO audit.ProductPriceAudit
        (ProductID, OldUnitPrice, NewUnitPrice)
    SELECT
        d.ProductID,
        d.UnitPrice,
        i.UnitPrice
    FROM inserted i
    JOIN deleted d
        ON i.ProductID = d.ProductID
    WHERE i.UnitPrice <> d.UnitPrice;
END;
select * from audit.ProductPriceAudit

-- Update 2 products in one statement + inspect audit

BEGIN TRANSACTION;

UPDATE Sales.Products
SET UnitPrice = UnitPrice + 10
WHERE ProductID IN (1, 2);

SELECT *
FROM audit.ProductPriceAudit
WHERE ProductID IN (1, 2);

--
ROLLBACK;

SELECT ProductID, UnitPrice
FROM Sales.Products
WHERE ProductID IN (1, 2);

SELECT *
FROM audit.ProductPriceAudit
WHERE ProductID IN (1, 2);


--
DISABLE TRIGGER sales.trg_Products_PriceAudit
ON Sales.Products;

--
DROP TRIGGER sales.trg_Products_PriceAudit;



--10.3
SELECT
    o.OrderID, o.OrderDate, o.CustomerID,
    c.ContactName,
    oi.ProductID, p.ProductName,
    oi.Quantity, oi.UnitPrice
INTO training.DenormalizedOrders
FROM Sales.Orders o
JOIN Sales.Customers c ON o.CustomerID = c.CustomerID
JOIN Sales.OrderItems oi ON o.OrderID = oi.OrderID
JOIN Sales.Products p ON oi.ProductID = p.ProductID;
/*

--Anomalies
Insert: Cannot add product without an order.
Update: Customer name must be changed in many rows.
Delete: Deleting an order may lose customer/product information.


--3NF design
Customer(CustomerID PK, CustomerName)


Order(OrderID PK, CustomerID FK, OrderDate, Status)


Product(ProductID PK, ProductName)


OrderItem(OrderItemID PK, OrderID FK, ProductID FK, Quantity, UnitPrice)

--Normalization
1NF: Atomic values, no repeating groups.
2NF: Non-key columns depend on the complete key.
3NF: Non-key columns depend only on the primary key.
*/


--10.4)   

--save the result as CSV from SSMS
SELECT
    ProductCode,
    ProductName,
    Category,
    UnitPrice,
    StockQty
FROM Sales.Products
WHERE IsActive = 1;



--

-- Row count
SELECT COUNT(*) AS RowCount
FROM training.ImportProducts;

-- NULL counts
SELECT
    SUM(CASE WHEN ProductCode IS NULL THEN 1 ELSE 0 END) AS NullCode,
    SUM(CASE WHEN ProductName IS NULL THEN 1 ELSE 0 END) AS NullName,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS NullCategory,
    SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS NullPrice,
    SUM(CASE WHEN StockQty IS NULL THEN 1 ELSE 0 END) AS NullStock
FROM training.ImportProducts;

-- Duplicate codes
SELECT ProductCode, COUNT(*) AS Cnt
FROM training.ImportProducts
GROUP BY ProductCode
HAVING COUNT(*) > 1;

-- Totals
SELECT
    SUM(UnitPrice) AS TotalPrice,
    SUM(StockQty) AS TotalStock
FROM training.ImportProducts;


--Compaire 
SELECT ProductCode, ProductName, Category, UnitPrice, StockQty
FROM Sales.Products
WHERE IsActive = 1
EXCEPT
SELECT ProductCode, ProductName, Category, UnitPrice, StockQty
FROM training.ImportProducts;

SELECT ProductCode, ProductName, Category, UnitPrice, StockQty
FROM training.ImportProducts
EXCEPT
SELECT ProductCode, ProductName, Category, UnitPrice, StockQty
FROM Sales.Products
WHERE IsActive = 1;
