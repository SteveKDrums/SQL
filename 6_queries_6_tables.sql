1.
SELECT COUNT(BusinessEntityID) AS [Number of Human Resource Employees]
FROM HumanResources.Employee;

2.
SELECT UPPER (AddressLine1 + ', ' + AddressLine2) AS [Full Address], CAST (ModifiedDate AS date)AS [Date Modified]
FROM Person.Address
WHERE AddressLine1 IS NOT NULL AND AddressLine2 IS NOT NULL
ORDER BY ModifiedDate
OFFSET 0 ROWS
FETCH FIRST 11 ROWS ONLY;

3.
SELECT ProductAssemblyID, CONVERT (date, StartDate) AS [Start Date], 
DATEDIFF(DAY,StartDate,GETDATE()) AS [Number of Days Since First Product Assembly]
FROM Production.BillOfMaterials
WHERE ProductAssemblyID IS NOT NULL AND ProductAssemblyID LIKE '9%'
ORDER BY ProductAssemblyID;

4.
SELECT  CreditCardID, CardType +',  '+ CardNumber +',  '+ CONVERT(varchar,ExpMonth) +',  '+ 
CONVERT (varchar,ExpYear) AS [All Credit Cards That Expired March 2005] 
FROM Sales.CreditCard
WHERE ExpMonth LIKE 3 AND ExpYear LIKE 2005
ORDER BY CreditCardID DESC;
 
5.
SELECT Description AS [Special Offer],CAST(StartDate AS date) AS [Start Date],CAST (EndDate AS date) AS [End Date], 
DATEDIFF(Day,StartDate,EndDate) AS [Difference in Days from Start Date to End Date]
FROM Sales.SpecialOffer
WHERE Description LIKE 'V%' OR DESCRIPTION LIKE 'T%'
ORDER BY [Difference in Days from Start Date to End Date]

6.
SELECT LocationID, Name AS [Production Location], CAST (CostRate AS varchar) AS [Cost Rate],
CONVERT(varchar, ModifiedDate) AS [Date],
SUBSTRING (Name,1,5) AS [Type]
ROM Production.Location
WHERE CostRate NOT LIKE 0.00
ORDER BY LocationID
OFFSET 0 ROWS
FETCH FIRST 5 ROWS ONLY;