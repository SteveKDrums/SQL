1.
SELECT NationalIDNumber, JobTitle, SUBSTRING (CAST (BirthDate AS varchar), 1,4) AS YearOfBirth 
FROM HumanResources.Employee;

2.
SELECT NationalIDNumber, JobTitle, SUBSTRING (CAST (BirthDate AS varchar), 1,4) AS Year_Of_Birth, 
SUBSTRING (CAST (BirthDate AS varchar), 6,10) AS Month_And_Day_Of_Birth
FROM HumanResources.Employee;

3.
SELECT ContactTypeID, Name, SUBSTRING (CAST (ModifiedDate AS varchar), 8,10) AS Modified_Year
FROM Person.ContactType
ORDER BY ContactTypeID DESC;

I'm not sure how to get the year to display without the time. It seems to appear automatically even though I selected the specific placement of the year.

4.
SELECT ContactTypeID, SUBSTRING ( Name, 1,5) AS Top_Skill, ModifiedDate
FROM Person.ContactType
WHERE ContactTypeID BETWEEN 17 AND 20
ORDER BY ContactTypeID DESC;