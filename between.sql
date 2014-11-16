1.
SELECT * FROM Production.Product
WHERE StandardCost BETWEEN 343 AND 461
ORDER BY StandardCost DESC;

2.
SELECT BusinessEntityID, (SalesQuota + ', ' + Bonus + ', ' + CommissionPct) AS SalesInfo, ModifiedDate
FROM Sales.SalesPerson
WHERE ModifiedDate
BETWEEN '2006' AND '2007'
ORDER BY ModifiedDate ASC;

3.
SELECT AddressID, (AddressLine1 + ',' + City + ',' + PostalCode) AS FullAddress, StateProvinceID
FROM Person.Address
WHERE StateProvinceID NOT BETWEEN 1 AND 175
ORDER BY StateProvinceID  ASC;