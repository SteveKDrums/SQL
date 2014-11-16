1.
SELECT (CAST(ListPrice AS nvarchar) ) AS ListPriceDetail
FROM Production.ProductListPriceHistory
WHERE ListPrice LIKE ('5%')
ORDER BY ListPrice ASC;

2.
SELECT ProductID, CAST(StartDate AS varchar) AS Start_Date , CAST (EndDate AS varchar) AS End_Date  
FROM Production.ProductListPriceHistory
ORDER BY ProductID;

3.
SELECT CreditCardID, (CAST (ExpMonth AS varchar) + ',' + CAST (ExpYear AS varchar) ) AS Credit_Card_Expiry 
FROM Sales.CreditCard;

4.
SELECT CreditCardID, (CAST (ExpMonth AS varchar) + ',' + CAST (ExpYear AS varchar) ) AS Credit_Card_Expiry,
CAST(ModifiedDate AS varchar) AS Last_Modified
FROM Sales.CreditCard
WHERE ModifiedDate LIKE 'Jun%'
ORDER BY ModifiedDate;