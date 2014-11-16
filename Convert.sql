1.
SELECT ScrapReasonID, Name, ModifiedDate AS Date_And_Time, CONVERT (date, ModifiedDate) AS Date 
FROM Production.ScrapReason;

2.
SELECT CONVERT (varchar,ScrapReasonID)+ '.  '+ Name AS Scrap_Reason, CONVERT (date, ModifiedDate) AS Date 
FROM Production.ScrapReason;

3.
SELECT AccountNumber, Name +'.  The credit rating is  '+ CONVERT (varchar, CreditRating) AS Company_And_Credit_Rating
FROM Purchasing.Vendor
WHERE Name Like 'A%'
ORDER BY AccountNumber DESC;

In row 5 the text seems to be cut off. How would I get the column to display the full text if it displays a little short?

4.
SELECT CONVERT (datetimeoffset, ModifiedDate) AccountNumber, Name +'.  The credit rating is  '+ CONVERT (varchar, CreditRating) AS Company_And_Credit_Rating
FROM Purchasing.Vendor
WHERE Name Like '_R%' AND CreditRating = 1
ORDER BY AccountNumber ASC;

The same issue occurs in row 6 as in example 3 above.

