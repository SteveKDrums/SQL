-- Assignment 2 Stephen Kohlmann

--1.

SELECT COUNT(BusinessEntityID) AS [Number of Employees], JobTitle AS Career, 
SUM(SickLeaveHours) AS [Sick Leave Hours], 
SUM(VacationHours) AS [Vacation Hours], 
SUM(SickLeaveHours + VacationHours) AS [Total Hours Absent]
FROM HumanResources.Employee
GROUP BY JobTitle
HAVING JobTitle != 'Chief Financial Officer' AND JobTitle != 'Janitor'
ORDER BY [Total Hours Absent] DESC;


-- In the query above I use the COUNT aggregate function to give me the total number of employees(BusinessEntityID's). I 
-- renamed the column to 'Number of Employees'. I also display the (JobTitle) AS 'Career', (SickLeaveHours) AS 'SickLeaveHours'
-- and (VacationHours) AS 'Vacation Hours'. I used the aggregate function SUM to display the total number of (SickLeaveHours) and 
-- (Vacation Hours). I then added the numeric data in the (SickLeaveHours) and (VacationHours) with the SUM function and stored
-- this information in a new column named 'Total Hours Absent'. I used the GROUP BY clause to group my information by (JobTitle).
-- As I specified the (JobTitle) in the GROUP BY clause the COUNT function will display the number of employees per (JobTitle). 
-- Within the HAVING clause I have added a complex search condition to return records that do not contain the (JobTitle) 'Chief Financial Officer'
-- and 'Janitor. A real world scenario as follows: Client would like to know the number of employees per career and their total hours absent. 
-- They may use this information to determine job pressures and reduce absent hours.

--2.

SELECT COUNT(emp.BusinessEntityID) AS [Number of Employees], JobTitle AS Career, 
SUM(SickLeaveHours) AS [Sick Leave Hours], 
SUM(VacationHours) AS [Vacation Hours], 
SUM(SickLeaveHours + VacationHours) AS [Total Hours Absent], 
CONVERT(int,Pay.Rate) AS [Hourly Rate of Pay Per Employee]
FROM HumanResources.Employee AS Emp
JOIN HumanResources.EmployeePayHistory AS Pay
ON Emp.BusinessEntityID = Pay.BusinessEntityID
GROUP BY JobTitle, Rate
HAVING JobTitle != 'Chief Financial Officer' AND JobTitle != 'Janitor'
ORDER BY [Total Hours Absent] DESC;

-- In this query I used the CONVERT function to change the display of (Rate) to an integer. The converted column is displayed 
-- with the name 'Hourly Rate of Pay Per Employee'. The rate coulumn comes from another table so I used the JOIN clause here
-- to join the tables HumanResources.Employee and HumanResouces.EmployeePayHistory. Both tables are joined on their (BusinessEntityID)
-- columns. Correlation names are used to identify the (BusinessEntityID) columns in the ON clause. The (Rate) column is added to
-- the GROUP BY clause to display in the result set. As a follow on from the sceanrio in Q1 the client may want more information to
-- see if the 'Career' columns corresponding (Rate) has anything to do with 'Total Hours Absent'. 

--3.

SELECT COUNT(emp.BusinessEntityID) AS [Number of Employees], JobTitle AS [Career Title], 
SUM(SickLeaveHours) AS [Sick Leave Hours], 
SUM(VacationHours) AS [Vacation Hours], 
SUM(SickLeaveHours + VacationHours) AS [Total Hours Absent], 
CONVERT(int,Pay.Rate) AS [Hourly Rate of Pay Per Employee],
COUNT(emp.BusinessEntityID) * CAST(Rate AS int) AS [Total Hourly Cost Per Career Title],
COUNT(emp.BusinessEntityID) * CAST(Rate AS int) * 40 AS [Total Weekly Cost Per Career Title]
FROM HumanResources.Employee AS Emp
JOIN HumanResources.EmployeePayHistory AS Pay
ON Emp.BusinessEntityID = Pay.BusinessEntityID
GROUP BY JobTitle,Rate
HAVING JobTitle != 'Chief Financial Officer' AND JobTitle != 'Janitor'
ORDER BY [Total Hourly Cost Per Career Title] DESC;

-- I have extended the query from Q2 to correlate with a real world scenario. The 6th line of the query uses the COUNT function
-- on (emp.BusinessEntityID). The (emp.BusinessEntityID) is then multiplied by the (Rate) column to return the 'Total Hourly Cost Per Career Title'
-- The 7th line of the query is an extension of the 6th line whereby the hourly rate is multiplied by 40. The 40 figure represents the standard 40 hour 
-- working week. It is important to note that the figure 40 could be replaced with any other number e.g 48 = 40 hours standard, 8 hours overtime.
-- I applied the CAST function to the (Rate) coulmn in both the 6th and 7th line to return the information as an integer. The information returned
-- is extemely relevant and important as it simply shows how much the accumalated absent hours are costing the client per hour and per week.

--4.

SELECT (emp.BusinessEntityID) AS [Employee ID], PP.FirstName AS [First Name], PP.LastName AS [Last Name],
JobTitle AS [Career Title], 
SUM(SickLeaveHours) AS [Sick Leave Hours], 
SUM(VacationHours) AS [Vacation Hours], 
SUM(SickLeaveHours + VacationHours)AS [Total Hours Absent], 
CONVERT(int,Pay.Rate) AS [Hourly Rate of Pay Per Employee],
CAST(Rate AS int) * 40 AS [Total Weekly Cost Per Career Title],
CAST(Rate AS int) * SUM(SickLeaveHours + VacationHours) AS [Total Actual Cost of Absence]
FROM HumanResources.Employee AS emp
JOIN HumanResources.EmployeePayHistory AS Pay
ON emp.BusinessEntityID = Pay.BusinessEntityID
JOIN Person.Person AS PP
ON emp.BusinessEntityID = PP.BusinessEntityID
GROUP BY emp.BusinessEntityID, JobTitle, Rate, FirstName, LastName
HAVING JobTitle != 'Chief Financial Officer' AND JobTitle != 'Production Technician - WC30'
ORDER BY [Total Actual Cost of Absence] DESC;

-- The query above looks quite complex so I will break it down in plane English. The query returns information from
-- 3 tables. The 3 tables are joined on their (BusinessEntityID) primary key columns. The 3 tables are HumanResorces.Employee,
-- HumanResources.EmployeePayHistory and Person.Person. The information returned in this query displays each employees first name,
-- last name and job title with the corresponding actual cost of their absence to the company. The actual cost is found by * the (Rate)
-- coulmn by the SUM of (SickLeaveHours + VacationHours) and the result is stored in [Total Actual Cost of Absence] column. In the 
-- HAVING clause I have excluded the Chief Financial Officer from the result set as I am taking him/her to be my client. The query also 
-- excludes the lowest paying (JobTitle), Production Technician - WC30

--5.

SELECT ShipMethodID AS [Shipping ID], 
CAST(AVG(Subtotal)AS int) AS [AVG Sub Total], CAST(AVG(TaxAmt)  AS int) AS [AVG Tax], 
CAST(AVG(Freight) AS int) AS [AVG Freight],   CAST(AVG(TotalDue)AS int) AS [AVG Total Due],
CAST(MIN(Subtotal)AS int) AS [MIN Sub Total], CAST(MIN(TaxAmt)  AS int) AS [MIN Tax], 
CAST(MIN(Freight) AS int) AS [MIN Freight],   CAST(MIN(TotalDue)AS int) AS [MIN Total Due],
CAST(MAX(Subtotal)AS int) AS [MAX Sub Total], CAST(MAX(TaxAmt)  AS int) AS [MAX Tax], 
CAST(MAX(Freight) AS int) AS [MAX Freight],   CAST(MAX(TotalDue)AS int) AS [MAX Total Due]
FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipMethodID
ORDER BY ShipMethodID

-- The query above uses the aggregate functions AVG, MIN and MAX to return the corresponding values of the (Subtotal), (TaxAmt), (Freight)
-- and (Total Due) columns. The results are grouped by the Shipping ID and CAST is used to return the information as an integer value. This
-- removes the decimal places from the original money data value making the result set more ledgible. In a real world scenario a client may 
-- be looking to find out figues in relation to shipping costs. The results returned give the client the average, minimum and maximum 
-- cost for each shipping method.

--6.

SELECT ShipMethodID AS [Shipping Method], 
CONVERT(int,SUM(Subtotal)) AS [(Total) Sub Total], CONVERT(int,SUM(TaxAmt))   AS [(Total) Tax Charges], 
CONVERT(int,SUM(Freight))  AS [(Total) Freight Charges], CONVERT(int,SUM(TotalDue)) AS [(Total) Total Due Per Shipping Method],
CONVERT(int,SUM(Freight + TaxAmt)) AS [Outsourced Cost, Can we reduce this?],
GETDATE() AS [Date & Time of Query]
FROM Purchasing.PurchaseOrderHeader
GROUP BY ShipMethodID
ORDER BY ShipMethodID

-- The query above utilizes the aggregate function SUM to add up the totals of the (SubTotal), (TaxAmt), (Freight) and (TotalDue)
-- columns for each (ShippingMethodID). The CONVERT function is used to change the data type returned to int in the result set.
-- The (Freight) and (TaxAmt) columns are added together with the SUM function to display the total outsourced cost per shipping method.
-- This column name displays the question 'Can we reduce this?' The reason for this is to help the client compartmentalize the result set
-- quicker.

--7.

SELECT DISTINCT SSOH.ShipMethodID AS [Shipping Method], COUNT(SSOH.SalesOrderID) AS [Sales Orders Per Shipping Method], 
CONVERT(int,SUM(PPOH.Subtotal)) AS [PO Sub Total], CONVERT(int,SUM(PPOH.TaxAmt)) AS [PO Tax Charges], 
CONVERT(int,SUM(PPOH.Freight))  AS [PO Freight Charges], CONVERT(int,SUM(PPOH.TotalDue)) AS [PO Total Due Per Shipping Method],
CONVERT(int,SUM(PPOH.Freight + PPOH.TaxAmt)) AS [PO Outsourced Cost, Can we reduce this?],
CONVERT(smalldatetime, GETDATE()) AS [Date & Time of Query]
FROM Purchasing.PurchaseOrderHeader AS PPOH
JOIN Sales.SalesOrderHeader AS SSOH
ON SSOH.ShipMethodID = SSOH.ShipMethodID
GROUP BY SSOH.ShipMethodID,SalesOrderID
HAVING SSOH.ShipMethodID = 1 
ORDER BY SSOH.ShipMethodID

-- The query above joins the Purchasing.PurchaseOrderHeader table and the Sales.SalesOrderHeader tables on their shipping ID columns.
-- The idea behind the query is to display the amount of Sales Orders per Shipping Method and the corresponding monetary totals associated 
-- with each. Some key points in this query include the use of the SELECT DISTINCT and HAVING clauses. If the HAVING clause is commented out
-- records for ShipMethodID's 1 and 5 are displayed in the result set. The HAVING clause specifies that only (ShipMethodID) 1 is returned.
-- As in the previous query I am displaying the date and time the query takes place but this time I use the value 'smalldatetime' to leave out the
-- seconds and milliseconds from the display.

--8.

SELECT SSP.BusinessEntityID, PP.FirstName, PP.LastName,
CONVERT(decimal,SUM(SSP.CommissionPct * SalesYTD)) AS [Commission YTD (6 Months)],
CONVERT(decimal,SUM(SSP.CommissionPct * SalesYTD / 6))  AS [Monthly Commission Based on 2nd Quarter Figures],
CONVERT(decimal,SUM(SSP.CommissionPct * SalesYTD / 6 * 12))  AS [Projected Yearly Commission Based on 2nd Quarter Figures]
FROM Sales.SalesPerson AS SSP
JOIN Person.Person AS PP
ON SSP.BusinessEntityID = PP.BusinessEntityID
GROUP BY SSP.BusinessEntityID, PP.FirstName, PP.LastName, CommissionPct
HAVING CommissionPct != 0.00  
ORDER BY [Commission YTD (6 Months)] DESC
OFFSET 0 ROWS
FETCH FIRST 6 ROWS ONLY

-- The above query joins the Sales.SalesPerson table with the Person.Person table on common (BusinessEntityID) columns. This query returns
-- the (FirstName) and (LastName) from the Person.Person table with their corresponding commission. There are 3 colmns with commission calculations,
-- with all calcualtions taking place within the Sales.SalesPerson table. The 2nd line of the query multiplies the (CommisionPct by the SalesYTD) which 
-- returns each persons actual commision from the begininng of the year. For the sake of a real world scenario I have decided that this figure represents
-- 6 months of sales which is noted in the column heading (Commission YTD (6 Months)). In the 3rd line of the query I divide the (Commission YTD (6 Months))
-- column by 6 to give the actual monthly commison for each person based on the 2nd quarter figures. The column heading helps to make this clear to the 
-- ...client (Monthly Commission Based on 2nd Quarter Figures). The 4th line of the query divides by 6 and then multiplies this figure by 12 returning the 
-- (Projected Yearly Commission Based On 2nd Quarter Figures) column. The HAVING clause states the search condition to return any values != 0.00 and the 
-- OFFSET AND FETCH operations are used to return the first 6 rows only.



