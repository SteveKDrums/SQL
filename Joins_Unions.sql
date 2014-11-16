--1.

SELECT HumanResources.Employee.BusinessEntityID, HumanResources.Employee.JobTitle, HumanResources.Employee.BirthDate
FROM HumanResources.Employee
WHERE HumanResources.Employee.BusinessEntityID LIKE '1'  
UNION
SELECT HumanResources.Employee.BusinessEntityID, HumanResources.Employee.JobTitle, HumanResources.Employee.BirthDate
FROM HumanResources.Employee
WHERE HumanResources.Employee.BusinessEntityID LIKE '2'

-- The above Query uses a UNION on one table to return two records that contain the Business Entity ID, Job Tiltle and BirthDate. 
-- A UNION on one table does not make sense to me as it seems to be similar to a self join. I could get the same result the above query
-- returns by using the cod below

SELECT BusinessEntityID, JobTitle, BirthDate
FROM HumanResources.Employee
WHERE BusinessEntityID LIKE '1' OR BusinessEntityID LIKE '2' 

--2.

SELECT BusinessEntityID, JobTitle, BirthDate
INTO dbo.Records123
FROM HumanResources.Employee
WHERE BusinessEntityID IN (1, 2, 3);

SELECT BusinessEntityID AS [Business Entity ID], JobTitle As [Job Title], BirthDate As [Birth Date]
FROM HumanResources.Employee
WHERE BusinessEntityID NOT IN (1, 2, 3) AND BusinessEntityID IN (1,2,3,4,5)
UNION
SELECT BusinessEntityID, JobTitle, BirthDate
FROM dbo.Records123
ORDER BY BusinessEntityID;

-- In the above query I have taken the first 3 records of the Human HumanResources.Employee table. I have used the Business Entity ID, Job Title
-- and Birthdate column.
-- I have used the BusinessEntityID (1, 2, 3) and created a new table named dbo.Records123 to store the records. The column names are formatted using [ ]
-- and the WHERE clause specifies that BusinessEntityID (1, 2, 3) are not returned. The IN operator is used to return BusinessEntityID's
-- between 1 & 5 only. A good way to see the query working is to run the query before the UNION clause. This way you will that only records
-- 4 and 5 are returned. The UNION clause appends the first 3 records by accessing the dbo.Records 1, 2, 3 table.

--3.

SELECT BusinessEntityID, FirstName, LastName, CONVERT(date,ModifiedDate) AS DateTable
INTO dbo.Person123456
FROM Person.Person
WHERE BusinessEntityID IN (1, 2, 3, 4, 5);

SELECT BusinessEntityID AS [Business Entity ID], FirstName, LastName, CONVERT(date,ModifiedDate) AS Date
FROM Person.Person
WHERE BusinessEntityID NOT IN (1, 2, 3, 4, 5) AND BusinessEntityID < 11
UNION
SELECT BusinessEntityID, FirstName, LastName, DateTable
FROM dbo.Person123456
ORDER BY BusinessEntityID;

IF OBJECT_ID ('dbo.Person12345', 'U') IS NOT NULL
DROP TABLE dbo.Person12345;

-- The first section creates a new table dbo.Person123456. Records 1 - 5 from the Business Entity ID of the Person.Person table 
-- are placed in this new table along with the first, last name and modified date columns. The CONVERT operator is used to convert the date to
-- a smaller display.
-- 
---In the second section the WHERE clause is used to exclude Business Entity ID's 1-5 and return records 1 - 10. To use a UNION clause both
-- SELECT statements need to have the same Coulmns. When I created the dbo.Person123456 database I changed the name of the Modified date column 
-- to DateTable. In the UNION SELECT clause I then used the DateTable name to corespond to the Modified Date column from the Person.Person table.
-- 
-- In the Third section I dropped the database (dbo.12345) as I did not need it for the query.

--4.

SELECT PP.BusinessEntityID AS [Business Entity ID], FirstName, LastName, JobTitle, BirthDate, SickLeaveHours, 
CONVERT(date,PP.ModifiedDate) AS Date
FROM Person.Person AS PP
JOIN HumanResources.Employee AS HRE
ON PP.BusinessEntityID = HRE.BusinessEntityID
SELECT BusinessEntityID AS [Business Entity ID], FirstName, LastName, CONVERT(date,ModifiedDate) AS Date
FROM Person.Person
WHERE BusinessEntityID NOT IN (1, 2, 3, 4, 5) AND BusinessEntityID < 11
UNION
SELECT BusinessEntityID, FirstName, LastName, DateTable
FROM dbo.Person123456
ORDER BY BusinessEntityID;

-- This is my first attemt at using a union and join together. The result set is showing two seperate tables and I'm not
-- sure how to get around this. I've looked online and I'm struggling to find a reason why I would use a join and union
-- in the same query.

--5.
SELECT ProductID AS [ID of Products with no Transaction History]
FROM Production.Product
EXCEPT
SELECT ProductID 
FROM Production.TransactionHistory
ORDER BY
ProductID 

-- The above query uses the except operator to return Products from the Production.Product table that have no transaction
-- history. In terms of a real world scenario the client may ask the DBA for a quick list of Product ID's that have no
-- transaction recording. 


--6.
SELECT ProductID AS [ID of Products with no Transaction History],
ListPrice AS [List Price from Production.Product that does not match the Actual Cost in Production.TransactionHistory]
FROM Production.Product
WHERE ListPrice NOT IN (0.00)
EXCEPT
SELECT ProductID, ActualCost 
FROM Production.TransactionHistory
ORDER BY
ProductID 

-- This query is an extension of number 5 and returns two columns according to the EXCEPT operator. The information that is returned 
-- is the Product ID and List Price of each Product with no transaction history. When using the EXCEPT operator I need to return the same
-- number of columns and similar data types for the query to work. In this case both tables have a Product ID but both tables do not have a list price.
-- I wanted to return the List Price from Production.Product so I used the Actual Cost column from Production.Transaction History as both of these
-- columns share the money data type. I renamed the coulmns in a descripitive style to help make the query clear.

--7.
SELECT BusinessEntityID
FROM Sales.SalesPerson
INTERSECT
SELECT BusinessEntityID
FROM Sales.SalesPersonQuotaHistory

-- I've spent just under 2 hours trying to find a valid reason to use the INTERSECT operator. 
-- Maybe I'm missing something but apart from PK's and FK's I can't see the logic of two columns 
-- in different tables containing the exact same information. Even the example in the book chapter
-- seems to return pointless information. What I mean by this is would a client really ask the question..
-- What employees are also our customers? Again I hold my hands up if I'm wrong but I can't see the logic
-- behind this operator.
-- My query above uses the INTERSECT operator but returns no valid information.

--8.
SELECT HRE.BusinessEntityID, PP.FirstName, PP.LastName, HRE.OrganizationLevel, HRE.JobTitle 
FROM HumanResources.Employee AS HRE
JOIN Person.Person AS PP ON PP.BusinessEntityID = HRE.BusinessEntityID
ORDER BY HRE.BusinessEntityID

--This query retruns the first name, last name, orginisational level and job title columns. The Person.Person
--table is joined to the HumanRescources.Employee table on the Business Entity ID columns. In a real world example a
--client may ask for a list of employees with their corresponding job titles. 

--9.
SELECT HRE.BusinessEntityID, PP.FirstName, PP.LastName, HRE.OrganizationLevel, HRE.JobTitle, 
SSP.SalesQuota
FROM HumanResources.Employee AS HRE
JOIN Person.Person AS PP ON PP.BusinessEntityID = HRE.BusinessEntityID
JOIN Sales.SalesPerson AS SSP ON HRE.BusinessEntityID = SSP.BusinessEntityID
WHERE SalesQuota NOT LIKE 'NULL'
ORDER BY HRE.BusinessEntityID

--This query is an extension of the above query. The Sales.SalesPerson table is added to the query and the SalesQuota
--table is displayed in the result set. I have joined the Sales.SalesPerson and HumanResources.Employee
--table on their Business Entity ID columns but it is important to note that I could have joined the Sales.SalesPerson column
--on the BusinessEntity ID of the Person.Person column. A client may ask for the names their sales rep's with their current
--Sales Quota   

--10.
SELECT HRE.BusinessEntityID, PP.FirstName, PP.LastName, HRE.OrganizationLevel, HRE.JobTitle, 
SSP.SalesQuota, (SSP.SalesYTD - SSP.SalesQuota) AS [Over Target]
FROM HumanResources.Employee AS HRE
JOIN Person.Person AS PP ON PP.BusinessEntityID = HRE.BusinessEntityID
JOIN Sales.SalesPerson AS SSP ON HRE.BusinessEntityID = SSP.BusinessEntityID
WHERE SalesQuota NOT LIKE 'NULL'
ORDER BY HRE.BusinessEntityID

--This query subtracts the Sales for the year to date column from the current sales quota of each sales representitive. This
--operation is then stored in a column named Over Target as all representitives have exceeded their targets. This information
--is very valuable for a client as they will see that the minimun Sales Quoata is very low according to the actual sales activity.

--11.
SELECT HRE.BusinessEntityID, PP.FirstName, PP.LastName, HRE.OrganizationLevel, HRE.JobTitle, 
SSP.SalesQuota, (SSP.SalesYTD - SSP.SalesQuota) AS [Over Target This Year], SSPQH.SalesQuota AS [History of Sales Quotas]
FROM HumanResources.Employee AS HRE
JOIN Person.Person AS PP ON PP.BusinessEntityID = HRE.BusinessEntityID
JOIN Sales.SalesPerson AS SSP ON HRE.BusinessEntityID = SSP.BusinessEntityID
JOIN Sales.SalesPersonQuotaHistory AS SSPQH ON HRE.BusinessEntityID = SSPQH.BusinessEntityID
WHERE SSP.SalesQuota NOT LIKE 'NULL'
ORDER BY HRE.BusinessEntityID

--When the client sees that the Sales Quota's are very low in comparrison to actual sales they may ask for the sales quota history of 
--each employee. The above query joins the Sales.SalesPersonQuotaHistory table to the result set making a total of 4 tables within
--this query. The result set returns multiple records for each employee because the result set is based on the varying sales quotas from low to high.
--
--12.
SELECT HRE.BusinessEntityID, PP.FirstName, PP.LastName, HRE.OrganizationLevel, HRE.JobTitle, 
SSP.SalesQuota, (SSP.SalesYTD - SSP.SalesQuota) AS [Over Target This Year], HREPH.Rate AS [Hourly Rate]
FROM HumanResources.Employee AS HRE
JOIN Person.Person AS PP ON PP.BusinessEntityID = HRE.BusinessEntityID
JOIN Sales.SalesPerson AS SSP ON HRE.BusinessEntityID = SSP.BusinessEntityID
JOIN HumanResources.EmployeePayHistory AS HREPH ON HRE.BusinessEntityID = HREPH.BusinessEntityID
WHERE SalesQuota NOT LIKE 'NULL'
ORDER BY HRE.BusinessEntityID

--At this stage the client may be wondering why such high sales are taking place. They may want to dig deeper and ask... What is the hourly rate we
--are paying each employee? The above query joins the HumanResources.EmployeePayHistory table to show the Hourly Rate column. The client can see from the
--result set that the hourly rate is actually quite high and that this rate is probably the driving force behind the high sales rather than the Sales Quotas.
--From a strategic management point of view it would be important to find a way to utilize the individual Sales Quotas more efficently.

--13.
SELECT HRE.BusinessEntityID, PP.FirstName, PP.LastName, HRE.OrganizationLevel, HRE.JobTitle, 
SSP.SalesQuota, (SSP.SalesYTD - SSP.SalesQuota) AS [Over Target This Year], HREPH.Rate AS [Hourly Rate], 
(HREPH.Rate * 40) AS [Sales Rep Weekly Wage Before Commission]
FROM HumanResources.Employee AS HRE
JOIN Person.Person AS PP ON PP.BusinessEntityID = HRE.BusinessEntityID
JOIN Sales.SalesPerson AS SSP ON HRE.BusinessEntityID = SSP.BusinessEntityID
JOIN HumanResources.EmployeePayHistory AS HREPH ON HRE.BusinessEntityID = HREPH.BusinessEntityID
WHERE SalesQuota NOT LIKE 'NULL'
ORDER BY HRE.BusinessEntityID

--The client may ask for the total weekly wage before commission to get a clear picture for management decisions. In this case
--I have simply multiplied the hourly rate of each employee by the standard working week. The result of this calculation is 
--returned in a column named Sales Rep Weekly Wage Before Commission.





