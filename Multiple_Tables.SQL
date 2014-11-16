/*MULTIPLE TABLES (4)


1.*/

SELECT DISTINCT BusinessEntityID AS [Business Entity ID], StartDate AS [Start Date], 
Name AS Department, hrd.DepartmentID AS [Department ID],
GroupName AS [Group Name], ShiftID AS [Shift ID], CONVERT (date,herd.ModifiedDate)  AS [Business Entity ID Last Modified Date] 
FROM HumanResources.Department AS hrd JOIN HumanResources.EmployeeDepartmentHistory AS herd
ON hrd.DepartmentID = herd.DepartmentID
WHERE BusinessEntityID BETWEEN 1 AND 20
ORDER BY StartDate ASC;

/*In the above query I am joining the HumanResources.Department and the HumanResources.EmployeeDepartmentHistory tables. 
I join the tables using the common DepartmentID column. I used some standard naming techniques to make the column names 
more readable such as BusinessEntityID AS [Business Entity ID] and StartDate AS [Start Date]. Within the FROM clause I gave both 
tables correlation names (hrd) and (herd). I needed to use these as I wanted to call on particular columns that had the same 
column name in both tables e.g CONVERT (date,herd.ModifiedDate)  AS [Modified Date]. Both tables had a ModifiedDate column but 
for my query I wanted to show the last time an individual employee had been modified not a department.


The query returns 25 rows and shows the Start Date, Department Name, Department ID, Group Name, Shift ID and the last time the 
Business Entity ID was modified. In a real world example managers may ask to see a condensed list of Business Entity ID's with ascending 
start dates per Department. They could use this information to decide what department needs to updated with training etc.*



2.*/

SELECT FirstName + ', ' + MiddleName +', ' + LastName AS Name, PhoneNumber AS Contact
FROM Person.Person AS Person JOIN Person.PersonPhone AS Phone
ON Person.BusinessEntityID = Phone.BusinessEntityID
WHERE MiddleName IS NOT NULL
ORDER BY Name;


/*This query concatanates the columns from the Person.Person table into one column containing the full name of an individual. 
I then joined the phone number from the Person.PersonPhone table. This query displays an alphabetical list of people with their 
corresponding numbers as long as the middle name column is not NULL. In the real world the query could be used by mangement looking 
for an alpahabetical list of employees or customers with corresponding phone numbers.



3.*/

SELECT PPD.ProductID AS [Product ID], DocumentNode AS [Document Node For Product], LocationID AS [Location ID], Quantity
FROM Production.ProductDocument AS PPD JOIN Production.ProductInventory AS PPI
ON PPD.ProductID = PPI.ProductID
WHERE Quantity < 200
ORDER BY DocumentNode


/*This query returns the relevant Document Node where the quantity of the product is < 200. 
The document node column is from the Production.Product table while the other 3 columns are from the Production.ProductIventory table.
In a real word scenario a client may ask for document node for each product where the quantity of the product is less than 200. 
The client may want to move the document node to the location of each product for quick access for an up and coming presentation etc.



4.*/

SELECT PP.ProductID [Product ID], Name, ProductNumber [Product Number], PP.ListPrice [Current List Price], 
CONVERT (date,PP.ModifiedDate) [Date Current List Price Last Modified], 
PPPH.ListPrice [Price History], CAST (PPPH.ModifiedDate AS date) [Price History Last Modified]
FROM Production.Product AS PP JOIN Production.ProductListPriceHistory AS PPPH
ON PP.ProductID = PPPH.ProductID
WHERE PP.ListPrice NOT LIKE '0.00' AND PP.ListPrice < 100
ORDER BY PP.ProductID
OFFSET 0 ROWS
FETCH FIRST 20 ROWS ONLY;


/*While the above statement looks complex it returns quite simple information. The real world sceanrio is management would like to see 
the current price of multiple products under a 100 euro and then be able to compare these prices to the previous prices of each product.
The Query returns multiples of the same product because the set of results is based on the Price History Last Modified column. e.g rows 1,2 and 3
of the result set return the same information bar the Price History and Price History Last Modified Column. This lines up with the clients
request to see a clear picture of the Current Price and Price History in one table.

In terms of SQL I have used some new elements that are not in my previous examples such as OFFSET, FETCH and CAST. 



COMPOUND JOIN CONDITIONS (4)



5.*/

SELECT HREPH.BusinessEntityID, DepartmentID, CONVERT(date,RateChangeDate) AS [Rate Change Date], Rate, StartDate, EndDate  
FROM HumanResources.EmployeeDepartmentHistory AS HREDH JOIN HumanResources.EmployeePayHistory AS HREPH
ON (HREDH.BusinessEntityID = HREPH.BusinessEntityID) AND (EndDate NOT LIKE 'NULL')
ORDER BY (DepartmentID), (RateChangeDate), Rate ASC;


/*This query returns the BusinessEntityID (Employee) and department they worked in along with the rate of pay increase and the date the increase 
was made. The query uses a compound condition "AND (EndDate NOT LIKE 'NULL')" to display BusinessEntityID's (Employees) that are no longer with the
company. A real world sceanrio could be the board of directors needing to see pay increases and corresponding increase dates per department and 
employees. This could be for tax reasons etc. The Order By part of this query has three parts. Firstly, to display the results by Department ID then within 
this I display the Rate Change date in order and then the actual monetary rate is displayed ascending.



6.*/

SELECT HREPH.BusinessEntityID [Business Entity ID], DepartmentID [Department ID], CONVERT(date,RateChangeDate) AS [Rate Change Date], 
Rate, StartDate[Start Date], EndDate [Year to End 2005] 
FROM HumanResources.EmployeeDepartmentHistory AS HREDH JOIN HumanResources.EmployeePayHistory AS HREPH
ON (HREDH.BusinessEntityID = HREPH.BusinessEntityID) AND ((EndDate LIKE '2005_____%') OR (EndDate NOT LIKE NULL))
ORDER BY (DepartmentID), (RateChangeDate), Rate ASC;


/*This Query is similar to number 5 but the results returned are more specific. I use two compund coditions here AND ((EndDate LIKE '2005_____%') OR (EndDate NOT LIKE NULL)) 
with the purpose of returning results with an end date of 2005 only. As an extension of the real world example in number 5, 
the board of directors may want to dig deeper into a particular year and ask me (the DBA) to bring up the results for 2005 only in a board meeting. 
Although the adjustment is simple it provides relevant information quickly to the client.



7.*/

SELECT BusinessEntityID [Business Entity ID], SST.TerritoryID, CountryRegionCode + ','+ Name AS Region, 
SSP.SalesLastYear AS [Sales Per Person], 
SST.SalesLastYear AS [Sales Per Territory]
FROM Sales.SalesPerson AS SSP JOIN Sales.SalesTerritory AS SST
ON SSP.TerritoryID = SST.TerritoryID AND CountryRegionCode LIKE 'US%'
ORDER BY Region ASC;


/*This query returns some very important information linking overall territory sales from the year previous with 
each individual BusinessEntityID's(Employees) total sales. The overall sales per territory is the sum of all employee sales within that territory. 
This displays a clear representation of the highest and lowest performing BusinessEntityID(Employee) per region in monetary terms. 
I used a compound condition here to display all regions within the US "AND CountryRegionCode LIKE 'US%'"



8.*/

SELECT BusinessEntityID [Business Entity ID], SST.TerritoryID, CountryRegionCode + ','+ Name AS Region, 
SSP.SalesLastYear AS [Sales Per Person], 
SST.SalesLastYear AS [Sales Per Territory]
FROM Sales.SalesPerson AS SSP JOIN Sales.SalesTerritory AS SST
ON (SSP.TerritoryID = SST.TerritoryID) AND (CountryRegionCode LIKE 'US%') AND (SST.SalesLastYear > 5000000.0000)
ORDER BY Region ASC;


/*This query follows on from the previous example by adding another compound condition to display sales in the 
US > 5000000.0000 "AND (SST.SalesLastYear > 5000000.0000)". Again in terms of a real world example the board of directors may want to know
territorys with sales over a certain figure within the US and the corresponding BusinessEntityID's(Employees) for that territory.



SELF JOIN (1)



9.*/

SELECT DISTINCT HRE1.BusinessEntityID, HRE1.LoginID
FROM HumanResources.Employee AS HRE1, HumanResources.Employee AS HRE2
WHERE HRE1.BusinessEntityID < 10 OR HRE1.BusinessEntityID BETWEEN 20 AND 25


/*I performed a self join as above but to be honest I find this confusing. I have read up on the topic and
understand the concept that self joins are used to make multiple refrences to the same table and help 
make complicated queries easier but I'm finding it difficult to find a reason why I would use this. I think it's
because I understand the syntax we have done to date e.g The SQL below which returns the same results as above. 

//SELECT BusinessEntityID, LoginID 
FROM HumanResources.Employee
WHERE BusinessEntityID < 10
OR BusinessEntityID 
BETWEEN 20 AND 25;//



OUTER JOINS (3)



10.*/ 

SELECT PP.BusinessEntityID,  FirstName + ', ' + LastName AS Name, SalesQuota AS [Sales Quota], 
CAST (SSP.ModifiedDate AS date) AS [Sales Quota Most Recent Update], 
DATEDIFF(QUARTER, SSP.ModifiedDate,GETDATE()) AS [Quarters Since Last Update]
FROM Person.Person AS PP LEFT JOIN Sales.SalesPerson AS SSP
ON PP.BusinessEntityID = SSP.BusinessEntityID
ORDER BY SalesQuota DESC, PP.BusinessEntityID


/*In this query I am using a left join ensure all records within the PP.BusinessEntityID are returned. 
This left join overrides the "ON PP.BusinessEntityID = SSP.BusinessEntityID" code. The easiest way to 
explain this is that if the "LEFT" keyword is taken out of the code the query will only return matching 
BusinessEntityID's that are present in both tables Person.Person and Sales.SalesPerson. 
Within this query I have implemented the GETDATE function "DATEDIFF(QUARTER, SSP.ModifiedDate,GETDATE()) AS [Quarters Since Last Update]"
I have used this to display the amount of quarters since the last sales quota update.

In terms of a real world scenario the client may ask for the full name of each employee with a sales quota and how long it has been since 
it has been updated.(This excludes the LEFT keyword). When they get the information they may be suprised that so few employees have a sales 
quota and ask, how many people do we employ? A quick way of retrieving the information is to use the LEFT keyword as it returns all employees, 
even those with a NULL value.  



11.*/

SELECT PP.BusinessEntityID,  FirstName + ', ' + LastName AS Name, SalesQuota AS [Sales Quota], HireDate,
CAST (SSP.ModifiedDate AS date) AS [Sales Quota Most Recent Update], 
DATEDIFF(QUARTER, SSP.ModifiedDate,GETDATE()) AS [Quarters Since Last Update]
FROM Person.Person AS PP JOIN Sales.SalesPerson AS SSP  
ON PP.BusinessEntityID = SSP.BusinessEntityID
RIGHT JOIN HumanResources.Employee AS HRE 
ON HRE.BusinessEntityID = SSP.BusinessEntityID
ORDER BY SalesQuota DESC, HRE.BusinessEntityID


/*In the query above I have added a RIGHT join bringing a third table into the result set.



12.*/

SELECT Sales.SpecialOffer.ModifiedDate AS [Special Offer Last Modified] ,DiscountPct AS Discount, Description,Type,
ProductID AS [Product ID],SalesOrderID AS [Sales Order ID], Sales.SalesOrderDetail.ModifiedDate AS [Date of Last Sale]
FROM Sales.SalesOrderDetail
FULL OUTER JOIN Sales.SpecialOffer
ON Sales.SpecialOffer.ModifiedDate = Sales.SalesOrderDetail.ModifiedDate
ORDER BY Sales.SpecialOffer.ModifiedDate DESC

/*This query uses a FULL Join to show the date of [Special Offer Last Modified] and [Date of Last Sale]. The FULL Join clause displays the full set of results
for Sales.SalesOrderDetail.ModifiedDate AS [Date of Last Sale] regardless of whether there is a match in the Sales.SpecialOffer.ModifiedDate AS [Special Offer Last Modified]
column. There is information returned in the Special Offer Last Modified columnn up to row 10528. From 10528 this coulmn displays a NULL value because it no longer 
matches the Sales.SalesOrderDetail.ModifiedDate AS [Date of Last Sale] column. If the FULL Join is replaced with a standard JOIN clause 10522 records are returned
because the values in both modified date columns must match.



CONNECTING MULTIPLE DATABASES (1)



13.*/

SELECT DB1SalesOrder.OrderQty as DB1, DB2SalesOrder.OrderQty AS DB2
FROM [AdventureWorks2012].[Sales].[SalesOrderDetail] as DB1SalesOrder
Inner Join [AdventureWorksLT2012].[SalesLT].[SalesOrderDetail] as DB2SalesOrder 
ON DB1SalesOrder.SalesOrderDetailID = DB2SalesOrder.SalesOrderDetailID


/*The above query connects Adventure Networks 2012 and Adventure Networks LT 2012. I have linked the databases by thier common OrderQty column.



WHERE CLAUSE TO REPLACE COMPOUND CONDITION (3)



14.*/

SELECT HREPH.BusinessEntityID, DepartmentID, CONVERT(date,RateChangeDate) AS [Rate Change Date], Rate, StartDate, EndDate  
FROM HumanResources.EmployeeDepartmentHistory AS HREDH JOIN HumanResources.EmployeePayHistory AS HREPH
ON (HREDH.BusinessEntityID = HREPH.BusinessEntityID)
WHERE EndDate NOT LIKE 'NULL'
ORDER BY (DepartmentID), (RateChangeDate), Rate ASC;


/*The above example exchanges the compund condition "AND (EndDate NOT LIKE 'NULL')" from example 5 with an appropriate WHERE
clause "WHERE EndDate NOT LIKE 'NULL'". Both the above and example 5 return the same information.



15.*/

SELECT BusinessEntityID [Business Entity ID], SST.TerritoryID, CountryRegionCode + ','+ Name AS Region, 
SSP.SalesLastYear AS [Sales Per Person], 
SST.SalesLastYear AS [Sales Per Territory]
FROM Sales.SalesPerson AS SSP JOIN Sales.SalesTerritory AS SST
ON (SSP.TerritoryID = SST.TerritoryID) 
WHERE CountryRegionCode LIKE 'US%' AND SST.SalesLastYear > 5000000.0000
ORDER BY Region ASC;


/*The above example exchanges the compund condition "AND (CountryRegionCode LIKE 'US%') AND (SST.SalesLastYear > 5000000.0000)" from example 8 with an appropriate WHERE
clause "WHERE CountryRegionCode LIKE 'US%' AND SST.SalesLastYear > 5000000.0000". Both the above and example 8 return the same information.



16.*/

SELECT BusinessEntityID [Business Entity ID], SST.TerritoryID, CountryRegionCode + ','+ Name AS Region, 
SSP.SalesLastYear AS [Sales Per Person], 
SST.SalesLastYear AS [Sales Per Territory]
FROM Sales.SalesPerson AS SSP JOIN Sales.SalesTerritory AS SST
ON SSP.TerritoryID = SST.TerritoryID 
WHERE CountryRegionCode LIKE 'US%'
ORDER BY Region ASC;


/*The above example exchanges the compund condition "AND CountryRegionCode LIKE 'US%'" from example 7 with an appropriate WHERE
clause "WHERE CountryRegionCode LIKE 'US%'". Both the above and example 7 return the same information.*/

