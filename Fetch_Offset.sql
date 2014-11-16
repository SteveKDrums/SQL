1.
SELECT ProductID,  CONVERT (date,ModifiedDate) AS Date, DATEDIFF(DAY, ModifiedDate, GETDATE()) AS Days_Since_Last_Modified
FROM Sales.SpecialOfferProduct
WHERE ProductID BETWEEN 680 AND 710 OR ProductID BETWEEN 801 AND 803
ORDER BY Days_Since_Last_Modified
OFFSET 5 ROWS 
FETCH NEXT 6 ROWS ONLY;

2.
SELECT SpecialOfferID, ProductID
FROM Sales.SpecialOfferProduct
WHERE SpecialOfferID LIKE 4
ORDER BY ProductID DESC
OFFSET 0 ROWS
FETCH FIRST 5 ROWS ONLY;

3.
SELECT JobTitle, NationalIDNumber, HireDate 
FROM HumanResources.Employee
ORDER BY JobTitle
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;

4.
SELECT JobTitle, NationalIDNumber, CONVERT (varchar, HireDate) AS [Hire Date],
DATEDIFF(MONTH, HireDate, GETDATE()) AS [Months Since Hired] 
FROM HumanResources.Employee
ORDER BY NationalIDNumber
OFFSET 5 ROWS
FETCH NEXT 7 ROWS ONLY;

When I create a column e.g Months Since Hired, how do write text within this column. 
e.g The column "Months Since Hired" Row 1 returns "133". I would like to write "It has been 133 months since you were hired.