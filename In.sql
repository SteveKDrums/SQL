1.
SELECT ParentProductCategoryID, Name  FROM SalesLT.ProductCategory
WHERE Name IN ('Bikes', 'Mountain Bikes', 'Road Bikes', 'Touring Bikes')
ORDER BY ProductCategoryID;

2.
SELECT Name, ProductNumber, Color, ('Size'+ ',' + Size ) AS Size
FROM SalesLT.Product
WHERE Color IN ('Blue', 'Silver')
ORDER BY Color ASC;

3.
SELECT SalesOrderID, PurchaseOrderNumber, SalesOrderNumber FROM SalesLT.SalesOrderHeader
WHERE SalesOrderNumber IN ('SO71774', 'SO71776', 'SO71780')
ORDER BY SalesOrderNumber DESC; 