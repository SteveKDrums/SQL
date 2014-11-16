1.

SELECT * FROM HumanResources.Employee;
SELECT TOP 20 PERCENT NationalIDNumber, VacationHours
FROM HumanResources.Employee
ORDER BY VacationHours DESC;

2.

SELECT TOP 30 PERCENT (Name + ',    '+ ProductNumber ) AS ProductInfo,StandardCost
FROM Production.Product
ORDER BY StandardCost DESC;

3.

SELECT TOP 50 (CardType + ',  ' + CardNumber) 
AS CreditCardDetails, 'The date the card was last modified is: ', ModifiedDate
FROM Sales.CreditCard
ORDER BY ModifiedDate ASC;

4.

SELECT TOP 5 WITH TIES BusinessEntityID, SalesYTD, SalesQuota
FROM Sales.SalesPerson
WHERE SalesQuota = 250000.00
ORDER BY SalesQuota;

5.

SELECT TOP 3 WITH TIES Description, DiscountPct, MaxQTY   
FROM Sales.SpecialOffer
WHERE DiscountPct > 0.06
ORDER BY DiscountPct;

6.

SELECT TOP 3 WITH TIES StateProvinceID, TaxRate
FROM Sales.SalesTaxRate
WHERE TaxRate <= 7.00
ORDER BY TaxRate ASC;