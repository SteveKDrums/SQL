/*Views & Stored Procedures Assignmnet 3*/

--1.

CREATE VIEW Salary_Per_Job_Title AS
SELECT  Employee_Title, Education_Level, Salary_Amount
FROM Employees JOIN Salary ON
Employees.Employee_ID = Salary.Employee_ID
WHERE Salary_Amount > 50000
ORDER BY Salary_Amount DESC
OFFSET 0 ROWS
FETCH FIRST 4 ROWS ONLY;
GO

/* To test Salary_Per_Job_Title view */
SELECT * FROM Salary_Per_Job_Title;
GO

/*The code above creates a VIEW named Salary_Per_Job_Title. Within this view I have joined the base tables Employees and Salary on 
their Employee_ID columns. I have used the ORDER BY clause to order the information by Salary_Amount descending. It's important to 
note the ORDER BY clause will not work if the OFFSET and FETCH functions are not used. The WHERE clause adds the condition to return
Salary_Amounts > 50000. In the Salary base table there are 5 rows that contain salaries > 50000 but the FETCH clause creates a condition 
to only return the First 4 rows. A simple real world scenario is a management meeting where job title information on salaries of 50,000 + 
are to be displayed. The question from management maybe 'Can you show me a couple of our employees earning over 50,000? We are looking
to confirm their job titles.'*/

--2.

CREATE VIEW Lectures_On AS
SELECT  Employee_First_Name, Employee_Last_Name,'currently teaches the' AS [Description], Course_Name,
CAST(GETDATE() AS DATE) AS [Today's_Date]
FROM Employees JOIN Course_Lecturer ON
Employees.Employee_ID = Course_Lecturer.Employee_ID
ORDER BY Employee_First_Name  
OFFSET 0 ROWS
FETCH FIRST 30 ROWS ONLY;
GO

/* To test Lectures_On view */
SELECT * FROM Lectures_On;
GO

/*The query above cretaes a view named Lectures_On. The purpose of the view is to display full names of the lecturers to the
 corresponding module they teach on. The query selects the Employee_First_Name and Employee_Last_Name columns from the Employees table
 and joins the Course_Name column from the Course_Lecturer table. A temporary column is created named [Description] and each field 
 contains the text'currently teaches on'. This column is created so the result set reads as a sentence from left to right. The CAST 
 function is used to cast the GETDATE function as DATE. This is used to return only year/month/day in the result set. The casted column 
 is named Today's Date. The ORDER BY clause is used to display the result set in alphabetical order ascending and the OFFSET and FETCH
 must be used for the view to function.*/

 --3.

CREATE VIEW [Scott_Kohlmann_25_Hours_Overtime] AS
SELECT  Employee_First_Name, Employee_Last_Name, Overtime_Hourly_Rate, 'Overtime sum is' AS [25_Hours_Overtime],
(Overtime_Hourly_Rate * 25) AS [Payment_Due], 'Payment due on' AS [Description],
CAST(DATEADD(DAY,45,GETDATE()) AS DATE) AS [Payment_Date]
FROM Employees JOIN Salary ON
Employees.Employee_ID = Salary.Employee_ID
GROUP BY Employee_First_Name, Employee_Last_Name, Overtime_Hourly_Rate
HAVING Employee_First_Name = 'Scott'
GO

CREATE VIEW [Rolf_Patterson_10_Hours_Overtime] AS
SELECT  Employee_First_Name, Employee_Last_Name, Overtime_Hourly_Rate, 'Overtime sum is' AS [25_Hours_Overtime],
(Overtime_Hourly_Rate * 10) AS [Payment_Due], 'Payment due on' AS [Description],
CAST(DATEADD(DAY,20,GETDATE()) AS DATE) AS [Payment_Date]
FROM Employees JOIN Salary ON
Employees.Employee_ID = Salary.Employee_ID
GROUP BY Employee_First_Name, Employee_Last_Name, Overtime_Hourly_Rate
HAVING Employee_First_Name = 'Rolf'
GO

/* To test Scott_Kohlmann_25_Hours_Overtime */
SELECT * FROM Scott_Kohlmann_25_Hours_Overtime
GO

/* To test Rolf_Patterson_10_Hours_Overtime */
SELECT * FROM Rolf_Patterson_10_Hours_Overtime
GO


/* Example number 3 has two queires that are almost identical. My reason for creating these views is for an easy way to get overtime
pay for a specific lecturer based on a particular number of hours. When the views are created and you select the test code above the
overtime for the specifc lecturer is displayed. I will describe the first of the two views. A view named [Scott_Kohlmann_25_Hours_Overtime]
is created, within the SELECT clause the Employee_First_Name and Employee_Last_Name columns from the base table Employees are used. The
Overtime_Hourly_Rate column is selected form the base table Salary. The primary key Empolyee_ID from the Employees table and the foreign
key Employee_ID from the Salary table are used to to JOIN both tables together. Another 4 columns are created 2 of which hold a text description...
[25_Hours_Overtime] column holds the text description 'Overtime sum is' and the [Description] column holds the text description 'Payment due on'.
The Payment_Due column holds the result of a calcualtion, the number of overtime hours worked by the the overtime hourly rate. The following
SQL CAST(DATEADD(DAY,45,GETDATE()) AS DATE) AS [Payment_Date] displays the Payment_Date that the overtime will be paid. DATEADD allows me to add
a specific number of days in this case '45' to todays's date. Today's date is retrieved using GETDATE().*/

--4.

CREATE VIEW [Days to debit from -- 2014/4/6] AS 
SELECT  Employee_First_Name, Employee_Last_Name, Employee_Title, CAST(Salary_Amount AS int) AS [Yearly_Salary], 
CAST(Holiday_Pay AS int) AS [Yearly_Holiday_Pay],
CAST(Salary_Amount + Holiday_Pay AS int) / 12  AS [Total_Monthly_Outgoings],
DATEDIFF(DAY, 2014-4-31, 2014-4-6) AS [Day's_Until_Next_Debit]
FROM Employees JOIN Salary 
ON Employees.Employee_ID = Salary.Employee_ID
GROUP BY Employee_First_Name, Employee_Last_Name, Employee_Title, Salary_Amount, Holiday_Pay
ORDER BY Yearly_Salary DESC
OFFSET 0 ROWS
FETCH FIRST 10 ROWS ONLY
GO

/* To test [Days to debit from -- 2014/4/6] */
SELECT * FROM [Days to debit from -- 2014/4/6];
GO

/*Above is an example of a query that could be updated daily by a database professional. A potential scenario could be management asking
for a simple query to show the amount of funds and number of days until all of these outgoing funds will be debited from their account. By selecting 
SELECT * FROM [Days to debit from -- 2014/4/6] the resut set shows there are 25 days left until all monthly outgoings are paid and the outgoings
are broken down by each employee. The new elements used within this query are as follows: Using CAST to convert Salary_Amount and Holiday_Pay to int.
These column names are changed to Yearly-Salary and Yearly_Holiday_Pay. The following sum CAST(Salary_Amount + Holiday_Pay AS int) / 12 calculates
the outgoings per month. The result is displayed in the column [Total_Monthly_Outgoings]. The [Day's_Until_Next_Debit] column displays the
number of days between 2014-4-31 and 2014-4-6. The DATEDIFF function calculates the result based on the 3 parameters (DAY, 2014-4-31, 2014-4-6).
The Employees and Salary table are joined on the Employee_ID columns and the ORDER BY clause is used to order the result set by the yearly salary
descending.
 */

 --5.

CREATE VIEW [Weekly_Outgoings_More_Than_AVG_Salary] AS 
SELECT  Employee_First_Name, Employee_Last_Name, Employee_Title, CAST(Salary_Amount AS int) AS [Yearly_Salary], 
CAST(Holiday_Pay AS int) AS [Yearly_Holiday_Pay], Payment_Frequency,
CAST(Salary_Amount + Holiday_Pay AS int) / 52  AS [Total_Weekly_Outgoings],
DATEDIFF(HOUR, 2014-4-9, 2014-4-6) AS [Hourss_Until_Next_Debit],
CAST(GETDATE() AS smalldatetime) AS [Date&Time_Of_Query]
FROM Employees JOIN Salary 
ON Employees.Employee_ID = Salary.Employee_ID
GROUP BY Employee_First_Name, Employee_Last_Name, Employee_Title, Salary_Amount, Holiday_Pay, Payment_Frequency
HAVING Payment_Frequency = 'Weekly' AND Salary_Amount >
(SELECT AVG(Salary_Amount) 
FROM Salary) 
ORDER BY Salary_Amount DESC
OFFSET 0 ROWS
FETCH FIRST 10 ROWS ONLY
GO

/* To test [Weekly_Outgoings_More_Than_AVG_Salary] */
SELECT * FROM Weekly_Outgoings_More_Than_AVG_Salary;
GO

/*The view created above returns the weekly outgoings for the college based on salaries more than the sum of the average salary. The query also returns
the amount of hours left until the debit will occur. In this case two records are returned. The Employee_First_Name, Employee_Last_Name and Employee_Title
columns from the Employees table are joined with the Salary_Amount column renamed [Yearly_Salary] and the Holiday_Pay column renamed [Yearly_Holiday_Pay].
The Payment_Frequency column is also selected and these 3 columns come from the base table Salary. The CAST function is used on the columns Salary_Amount
and Holiday_Pay to change the data type returned to an integer. The CAST function is then used to return the sum of Salary_Amount + Holiday_Pay as an integer.
This sum is then divided by 52 (weeks) and the result is stored in the column [Total_Weekly_Outgoings]. There are two date columns returned in this query, 
the first uses the DATEDIFF function to return the number of hours between two specified dates and the result is stroed in the column [Hours's_Until_Next_Debit].
The second date returned returns the date and time the query is run. The CAST function is used on the second date returned to change the data type returned to smalldatetime.
The result is stored in the column [Date&Time_Of_Query]. The JOIN clause is used to join the Employees and Salary table on their Employee_ID columns.
The GROUP_BY clause is used to list the column names and within the HAVING clause two conditions are set. The first, Payment_Frequency = 'Weekly' and the second
is a subquery; Salary_Amount > (SELECT AVG(Salary_Amount) FROM Salary). The subquery works out the average salary from the Salary_Amount column from the base table Salary. 
The two conditions in the HAVING clause are joined with the AND operator so the results returned are based on a weekly pay frequency and salaries > than the average salary. 
The ORDER_BY clause is used to display the results by Salary_Amount descending and the OFFSET and FETCH clauses are used to allow the view to function without an error. */

--6.

CREATE VIEW [Students_Invoices_Full_Time] AS
SELECT TOP 2 S.Student_First_Name, S.Student_Last_Name, 
CS.Jazz_History, CS.Arranging, CS.Ear_Training, CS.Rhythmic_Dictation, 
CS.Jazz_Ensemble, CS.Contemporary_Ensemble, CS.Business, CS.Music_Technology,
I.Invoice_Amount,(I.Invoice_Amount / 8) AS [Cost_Per_Module],
(CAST((I.Invoice_Amount * 10 ) / 100 + I.Invoice_Amount AS money) / 9) AS [Monthly_Repayments_ April-December_10%_Interest],
'Bank Draft' AS [Preferred_Payment_Method],
CONVERT(date,I.Invoice_Due_Date) AS [Payment_Due_On]
FROM Students AS S
JOIN Course_Student AS CS
ON S.Student_ID = CS.Student_ID
JOIN Invoices AS I
ON S.Student_ID = I.Student_ID
GROUP BY Student_First_Name, Student_Last_Name, 
CS.Jazz_History, CS.Arranging, CS.Ear_Training, CS.Rhythmic_Dictation, 
CS.Jazz_Ensemble, CS.Contemporary_Ensemble, CS.Business, CS.Music_Technology,
I.Invoice_Amount, I.Invoice_Due_Date
HAVING CS.Jazz_History = 'Y1' AND CS.Arranging = 'Y1'AND CS.Ear_Training = 'Y1'AND CS.Rhythmic_Dictation = 'Y1'AND 
CS.Jazz_Ensemble ='Y1'AND CS.Contemporary_Ensemble = 'Y1'AND CS.Business = 'Y1'AND CS.Music_Technology = 'Y1'
OR
CS.Jazz_History = 'Y2' AND CS.Arranging = 'Y2'AND CS.Ear_Training = 'Y2'AND CS.Rhythmic_Dictation = 'Y2'AND 
CS.Jazz_Ensemble ='Y2'AND CS.Contemporary_Ensemble = 'Y2'AND CS.Business = 'Y2'AND CS.Music_Technology = 'Y2'
OR
CS.Jazz_History = 'Y3' AND CS.Arranging = 'Y3'AND CS.Ear_Training = 'Y3'AND CS.Rhythmic_Dictation = 'Y3'AND 
CS.Jazz_Ensemble ='Y3'AND CS.Contemporary_Ensemble = 'Y3'AND CS.Business = 'Y3'AND CS.Music_Technology = 'Y3'
OR
CS.Jazz_History = 'Y4' AND CS.Arranging = 'Y4'AND CS.Ear_Training = 'Y4'AND CS.Rhythmic_Dictation = 'Y4'AND 
CS.Jazz_Ensemble ='Y4'AND CS.Contemporary_Ensemble = 'Y4'AND CS.Business = 'Y4'AND CS.Music_Technology = 'Y4'
ORDER BY Student_First_Name DESC
GO

/* To test [Students_Invoices_Year1_Full_Time] */
SELECT * FROM Students_Invoices_Full_Time;
GO

/* The above query creates the view [Students_Invoices_Full_Time]. The TOP clause is used with SELECT to allow the view to save and function
without error. In the previous queries I used OFFSET & FETCH for this purpose. The query joins 3 tables and each table is given a correlation name
to improve readability of the query. The tables are named as follows; Students AS S, Course_Student AS CS and Invoices AS I. The (primary key) Student_ID
from the Students table is joined to the (foreign keys) Student_ID's from Course_Student and Invoices. In the SELECT clause the columns selected from
each table are defined by their correponding correlation names. The column Invoice_Amount is divided by 8 to return the cost per module and the result 
set is saved in the column [Cost_Per_Module]. The next column in the result set calculates the monthly repayments from April to December with 10% interest
added. The result is calculated by multiplying the Invoice_Amount by 10, dividing this result by 100, then adding the Invoice_Amount onto this result. The
CAST function is used to return the data type money and the total result is then divided by 9 to return the figure for 9 monthly installments. The GROUP BY
clause is used to display the columns specified in the SELECT clause. The HAVING clause creates the conditions to return any student that takes all 8 modules
from Y1 to Y4(Year1 to Year4). The result of the query shows only two students take all 8 modules and they are in Y1(Year1). The AND/OR operators are used to
link the conditions in the HAVING clause appropriately. The code behind the view is quite dense but the view itself makes this easy for anyone to run.
In a real world scenario this is the kind of query the finance department could use in a presentation as it's quick to run and returns specific information.*/

/* To DROP all VIEWS above */

DROP VIEW Salary_Per_Job_Title;
DROP VIEW Lectures_On;
DROP VIEW Scott_Kohlmann_25_Hours_Overtime;
DROP VIEW Rolf_Patterson_10_Hours_Overtime;
DROP VIEW [Days to debit from -- 2014/4/6];
DROP VIEW Weekly_Outgoings_More_Than_AVG_Salary;
DROP VIEW Students_Invoices_Full_Time;

--1. 

USE College_of_Music;
IF OBJECT_ID('spSalaries_&_Payment_Frequency') IS NOT NULL
    DROP PROC [spSalaries_&_Payment_Frequency];
GO
--Creates the Stored Procedure
CREATE PROC [spSalaries_&_Payment_Frequency]
AS
    IF OBJECT_ID('[Salary_Table_For_User]') IS NOT NULL
        DROP TABLE [Salary_Table_For_User];
    SELECT TOP 10 Employee_ID, Salary_Amount, Payment_Frequency,
	CAST(GETDATE() AS date) AS [Date_Of_Query] 
    INTO [Salary_Table_For_User]
    FROM Salary
	ORDER BY Employee_ID ASC;

--Executes the Stored Procedure
EXEC [spSalaries_&_Payment_Frequency];

/* To test [Salary_Table_For_User] */
SELECT * FROM [Salary_Table_For_User];
GO
/* The query above creates a stored procedure that returns a result set based on columns from the base table Salary from the College_of_Music database.
The purpose of the stored procedure is to limit the amount of data a user can access. The portion of the code below creates the condition that IF the 
stored procedure is present in the College_of_Music database it will be deleted.
USE College_of_Music;
IF OBJECT_ID('spSalaries_&_Payment_Frequency') IS NOT NULL
    DROP PROC [spSalaries_&_Payment_Frequency];
GO

The stored procedure is created using the CREATE PROC function followed by the 'sp' name, in this case [spSalaries_&_Payment_Frequency]. Normal SQL code is used 
after the AS keyword. An IF condition is provided similar to the one described above which simply DROPS the [Salary_Table_For_User] if it is NOT NULL and is already 
in the database. The SELECT clause specifies the Employee_ID, Salary_Amount and Payment_Frequency columns and also gets the date the 'sp' is run. The TOP clause
is used to ensure the ORDER BY clause functions correctly. The GETDATE function is CAST to return the data type date to only return the Y/M/D. The EXEC function
executes the SQL code written above it and saves the stored procedure. */

--2.

USE College_of_Music;

IF OBJECT_ID('spInvoice_Calculations') IS NOT NULL
    DROP PROC spInvoice_Calculations;
GO

CREATE PROC spInvoice_Calculations
       @Inv_Average money OUTPUT,
       @Inv_Total money OUTPUT,
	   @Inv_Maximum money OUTPUT,
	   @Inv_Minimum money OUTPUT
AS
SELECT @Inv_Minimum = MIN(Invoice_Amount), @Inv_Maximum = MAX(Invoice_Amount), @Inv_Average = AVG(Invoice_Amount), @Inv_Total = SUM(Invoice_Amount)
FROM Invoices;
GO

/* To test [spInvoice_Calculations] The code below is what executes when the spInvoice_Calculations is executed from the Stored Procedures foler  */

USE [College_of_Music]
GO

DECLARE	@return_value int,
		@Inv_Average money,
		@Inv_Total money,
		@Inv_Maximum money,
		@Inv_Minimum money

EXEC	@return_value = [dbo].[spInvoice_Calculations]
		@Inv_Average = @Inv_Average OUTPUT,
		@Inv_Total = @Inv_Total OUTPUT,
		@Inv_Maximum = @Inv_Maximum OUTPUT,
		@Inv_Minimum = @Inv_Minimum OUTPUT

SELECT	@Inv_Average as N'@Inv_Average',
		@Inv_Total as N'@Inv_Total',
		@Inv_Maximum as N'@Inv_Maximum',
		@Inv_Minimum as N'@Inv_Minimum'

GO

/* The query creates the stored procedurenamed spInvoice_Calculations and uses input variables calculate the AVG, MAX, MIN and SUM amounts
from the Invoice_Amount column in the Invoices table. Aggregate functions are used within this procedure. */

--3. 

USE College_of_Music;

IF OBJECT_ID('spInvMaxwell') IS NOT NULL
    DROP PROC spMaxwell;
GO
--Creates spInvMaxwell with one OUTPUT Parameter, 3 variables declared in total.
CREATE PROC spInvMaxwell
       @InvTotal money OUTPUT,
       @DateInv  date = NULL,
       @StudentLNam varchar(40) = 'Maxwell'
AS

IF @DateInv IS NULL
   SELECT @DateInv = MIN(Date_Modified) FROM Invoices;

SELECT @InvTotal = 2900
FROM Invoices JOIN Students
    ON Invoices.Student_ID = Students.Student_ID
WHERE (Invoice_Due_Date >= @DateInv) AND
      (Student_Last_Name LIKE @StudentLNam);

--The above has created the conditions within the procedure.
--Calls the stored procedure passing values by name

DECLARE @InvForMaxwell money;
EXEC spInvMaxwell @InvForMaxwell OUTPUT, @DateInv = '2012-02-01', @StudentLNam = 'M%';

PRINT '!!' + CAST(@InvForMaxwell AS varchar) + '!!';
GO

/* The code above declares and executes the stored procedure and also prints the invoice value '2900' with
!! on either side. Having a stored procedure for each students invoice could be a quick way of gathering the
information in business meeeting. */

--4.

USE College_of_Music;

-- Deletes stored proceedure if present in database.
IF OBJECT_ID('spHighetPaidEmployee') IS NOT NULL
    DROP PROC spHighetPaidEmployee;
GO

-- Creates stored proceedure and declares 4 variables.
CREATE PROC spHighestPaidEmployee
       @EmpFNam varchar(40) OUTPUT,
	   @EmpLNam varchar(40) OUTPUT,	   
	   @HighestSalary money OUTPUT,
       @Date date = NULL
       
AS

-- IF condition stating thatif the @Date variable is NULL select the date from the Date_Modified column in the Salary table.
IF @Date IS NULL
   SELECT @Date = (Salary.Date_Modified) FROM Salary;

-- Variables given specific text values and aggregate function SUM usd to get the MAX salary.
SELECT @EmpFNam = 'Rolf', @EmpLNam = 'Patterson', @HighestSalary = MAX(Salary_Amount)
FROM Salary JOIN Employees
    ON Salary.Employee_ID = Employees.Employee_ID
GO

--Salary and Employee tables joined on corresponding Employee_ID's.
--The code below calls the stored procedure and also returns the row count.

DECLARE	@return_value int,
		@EmpFNam varchar(40),
		@EmpLNam varchar(40),
		@HighestSalary money

EXEC	@return_value = [dbo].[spHighestPaidEmployee]
		@EmpFNam = @EmpFNam OUTPUT,
		@EmpLNam = @EmpLNam OUTPUT,
		@HighestSalary = @HighestSalary OUTPUT

SELECT	@EmpFNam as N'EmpFNam',
		@EmpLNam as N'EmpLNam',
		@HighestSalary as N'HighestSalary'

SELECT	'Return Value' = @@ROWCOUNT
GO

/* The stored procedure simply returns the highest paid employee with the first and last name and corresponding salary amount. The
return value has many uses in business or finance meetings. */

--5.

-- Selects database to use.
USE College_of_Music;
GO
-- Drops the stored procedure if present in the database.
IF OBJECT_ID('spInsertInvoiceRecord') IS NOT NULL
    DROP PROC spInsertInvoiceRecord;
GO
-- Creates the stored procedure, variables declared here.
CREATE PROC spInsertInvoiceRecord
       @Invoice_Code     varchar(20) = NULL,
       @Invoice_Amount   money = NULL,
       @Invoice_Due_Date smalldatetime = NULL,
       @Student_ID       varchar(20) = NULL,
       @Date_Modified    smalldatetime = NULL
     
AS
-- IF ELSE statements to return specific error messages based on certain conditions.
IF @Student_ID IS NULL
    THROW 50001, 'Invalid StudentID.', 1;
IF @Invoice_Amount IS NULL
    THROW 50001, 'Invalid InvoiceAmount.', 1;
IF @Invoice_Due_Date IS NULL OR @Invoice_Due_Date > GETDATE() 
        OR DATEDIFF(dd, @Invoice_Due_Date, GETDATE()) > 30
    THROW 50001, 'Invalid InvoiceDate.', 1;
IF @Invoice_Code IS NULL 
    THROW 50001, 'Invalid InvoiceCode.', 1;
IF @Date_Modified IS NULL 
    THROW 50001, 'Invalid InvoiceDate.', 1;
IF @Invoice_Due_Date IS NULL
    SET @Invoice_Due_Date = @Date_Modified;
ELSE  -- @Invoice_Due_Date IS NOT NULL
    IF @Invoice_Due_Date < @Date_Modified OR
            DATEDIFF(dd, @Invoice_Due_Date, @Date_Modified) > 180
        THROW 50001, 'Invalid InvoiceDueDate.', 1;

-- Inserts the variables into the invoice table.
INSERT Invoices
VALUES (@Invoice_Code, @Invoice_Amount, @Invoice_Due_Date, @Student_ID,
        @Date_Modified);

-- Returns the last inserted identity value.
RETURN @@IDENTITY;
GO

-- Calls the above Stored Procedure with an ERROR message: Invalid InvoiceID. The Code below demonstartes TRY and CATCH functions

USE College_of_Music;
GO
-- Beginning of TRY Block
BEGIN TRY
-- Assigning values to variables    
	DECLARE @Invoice_ID int;
    EXEC @Invoice_ID = spInsertInvoiceRecord
         @Invoice_Code = 'IC0000012',
         @Invoice_Amount = 5000,
         @Invoice_Due_Date = '2014-12-23',
         @Student_ID = 1292.45,
		 @Date_Modified = '2014-04-12';
-- Messages to print if TRY is a success
    PRINT 'Row inserted.';
    PRINT 'New InvoiceID: ' + CONVERT(varchar, @Invoice_ID);
END TRY
-- Beginning of CATCH block
BEGIN CATCH
-- Messages to print from the CATCH block
    PRINT 'An error occurred on this occassion. The row was not inserted.';
    PRINT 'Error number: ' + CONVERT(varchar, ERROR_NUMBER());
    PRINT 'Error message: ' + CONVERT(varchar, ERROR_MESSAGE());
END CATCH;
GO
/* I have tried to get the stored procedure to function without an error but to no avail. To me this code is quite complicated and it's difficult to
find errors when they occur. The idea of the stored procedure is to simply insert a new record into the invoices table which could be done in easier 
ways than through a stored procedure. I understand the concept of stored procedures but introducing variables has caused some confusion for me.*/

--6.

USE College_of_Music;
IF OBJECT_ID('spEmployeeID_Total_Income') IS NOT NULL
    DROP PROC spEmployeeID_Total_Income;
GO

CREATE PROC spEmployeeID_Total_Income
AS
    
SELECT E.Employee_ID, Employee_Title, (Salary_Amount + Holiday_Pay) AS [Total_Income_Excluding_Over-Time]
FROM Employees AS E JOIN Salary AS S ON
E.Employee_ID = S.Employee_ID
WHERE Employee_Title = 'Lecturer'
ORDER BY Employee_ID;
GO

--Executes and returns the Stored Procedure
EXEC spEmployeeID_Total_Income;
GO

/* The above creates a stored procedure to return the total guaranteed income for each lecturer excluding possible overtime. The results are 
ordered by Employee_ID ascending. This query could be useful for HR managers to show a quick representation of the salaries obtained by lecturers...
Possible scenario could be a presentation at a career fair. The stored procedure contains standard SQL code so the main benefit is the speed
of the return. */

--7.

USE College_of_Music;
IF OBJECT_ID('spTotal_Due_Less_Student_Grant') IS NOT NULL
    DROP PROC spTotal_Due_Less_Student_Grant
GO

CREATE PROC spTotal_Due_Less_Student_Grant
AS

SELECT Students.Student_ID, Student_First_Name, Student_Last_Name, Invoice_Code, 
CAST((Invoice_Amount)/ 3 * 2 AS int) AS [Total_Due_After_Student_Grant],
CAST(DATEADD(DAY,11,GETDATE()) AS DATE) AS [Payment_Date_For_Next_Amount_Due], 
CAST((Invoice_Amount)/ 3 * 2 AS int) / 4 AS [Next_Amount_Due]
FROM Students JOIN Invoices ON
Students.Student_ID = Invoices.Student_ID
ORDER BY Student_ID
GO

--Executes and returns the Stored Procedure
EXEC spTotal_Due_Less_Student_Grant;
GO

/* The above code creates the stored procedure spTotal_Due_Less_Student_Grant. The Invoices and Students tables are joined on their Student_ID
columns. The Student_ID form the student table and the Student_First_Name and Student_Last_Name are called in the SELECT statement. From the Invoices table
the Invoice_Code and Invoice_Amount columns are also chosen. Two calculations take place on the Invoice_Amount column. The first gets the [Total_Due_After_Student_Grant]
which is the Invoice_Amount / 3 and * 2. The second calculation [Next_Amount_Due] is the previous sum / 4. Both these calculations use the CAST function to return
the data type int. The [Payment_Date_For_Next_Amount_Due] is calculated by using the DATEADD function. The DATEADD function takes 3 parameters in this case they are
DAY, 11 and GETDATE(). What happens here is 11 days are added to today's date and the return value is set to DATE using the CAST function. This type of stored procedure
would be very helpful for a student centre to have access to. As many students have fee concerns this type of stored procedure would help the college in resolving issues
in a streamlined manner. */

--8.

USE College_of_Music;
IF OBJECT_ID('spStudents_Over_20') IS NOT NULL
    DROP PROC spStudents_Over_20
GO

CREATE PROC spStudents_Over_20
AS

SELECT Student_ID, Student_First_Name, Student_Last_Name, Age,
CAST(GETDATE() AS date) AS [Todays_Date]
FROM Students
WHERE Age >= 20
ORDER BY Age;
GO

--Executes and returns the Stored Procedure
EXEC spStudents_Over_20;
GO

/* This stored procedure returns all students who are over the age of 20. The four columns Student_ID, Student_First_Name, Student_Last_Name and Age
are called in the SELECT table. A new column [Today's_Date] is created using the GETDATE() function and CAST to return the data type date. The WHERE
clause specifies to only return records where the age is more than 20. The ORDER BY clause is used to order the results by age ascending. Possible real world 
scenario for this stored procedure would be the student grant office looking to determine who is in the over 20's grant bracket. */

--9.

USE College_of_Music;
IF OBJECT_ID('spStudents_Taking_Jazz_History_AND_Arranging') IS NOT NULL
    DROP PROC spStudents_Taking_Jazz_History_AND_Arranging
GO

CREATE PROC spStudents_Taking_Jazz_History_AND_Arranging
AS

--Deletes table if it already exists in the database
IF OBJECT_ID('[Students_Taking_Jazz_History_AND_Arranging]') IS NOT NULL
        DROP TABLE [Students_Taking_Jazz_History_AND_Arranging]
		
SELECT S.Student_ID, Student_First_Name, Student_Last_Name, CS.Date_Modified
INTO [Students_Taking_Jazz_History_AND_Arranging] --<--Creates table
FROM Students AS S JOIN Course_Student AS CS
ON S.Student_ID = CS.Student_ID
WHERE Jazz_History != 'N/A' AND Arranging != 'N/A'
ORDER BY S.Student_ID;
GO

--Execute the Stored Procedure above and uses the TRY and CATCH functions to handle possible errors.

USE College_of_Music;
GO

BEGIN TRY
    EXEC spStudents_Taking_Jazz_History_AND_Arranging;
END TRY
BEGIN CATCH
    PRINT 'An error occurred. Query not returned.';
    PRINT 'Error number: ' + CONVERT(varchar, ERROR_NUMBER());
    PRINT 'Error message: ' + CONVERT(varchar, ERROR_MESSAGE());
END CATCH;
GO

-- Displays the table information from the stored procedure.

SELECT * FROM Students_Taking_Jazz_History_AND_Arranging;
GO

/* The code for number 9 above creates the stored procedure named spStudents_Taking_Jazz_History_AND_Arranging. This stored procedure
creates a new table named [Students_Taking_Jazz_History_AND_Arranging]. Both the stored procedure and table names have IF conditions 
to delete them from the database if they are already present. The 'sp' joins the Students and Course_Student tables on thier corresponding 
Student_ID columns. The S.Student_ID, Student_First_Name and Student_Last_Name come from the Students table and the CS.Date_Modified comes
from the Course_Student table. Notice the correlation names specified S for the Students table and CS for the Course_Student table. The
WHERE clause specifies the conditon to return records where Jazz_History != 'N/A' AND Arranging != 'N/A'. N/A simply stands for Not Applicable...
To see what this means just have a quick look at the Course_Student base table. The TRY and CATCH functions are usd to execute the code. 
Within the CATCH claue the PRINT function is used to display error messages if they occur. Again the student office could use this stored procedure 
in a real world scenario to gather quick information for the students who are taking the courses Jazz History and Arranging. */

--10.

USE College_of_Music;

IF OBJECT_ID('spMusic_Technology_Students_Invoice_Calculations_And_Projections') IS NOT NULL
    DROP PROC spMusic_Technology_Students_Invoice_Calculations_And_Projections
GO

CREATE PROC spMusic_Technology_Students_Invoice_Calculations_And_Projections
AS

IF OBJECT_ID('[Music_Technology_Students_Invoice_Calculations_And_Projections]') IS NOT NULL
        DROP TABLE [Music_Technology_Students_Invoice_Calculations_And_Projections]
		
SELECT S.Student_First_Name, S.Student_Last_Name, 
I.Invoice_Code, I.Invoice_Amount, CAST(I.Invoice_Due_Date AS Date) AS [Invoice_Due_Date],
((I.Invoice_Amount * 5) / 100 + I.Invoice_Amount) AS [5%_Increase_For_Next_Year],
CAST(DATEADD(YEAR,1,I.Invoice_Due_Date) AS DATE) AS [Payment_Date_For_Next_Year],
CAST(GETDATE() AS DATE) AS [Date_Of_Query]
INTO [Music_Technology_Students_Invoice_Calculations_And_Projections]
FROM Students AS S 
JOIN Course_Student AS CS
ON S.Student_ID = CS.Student_ID
JOIN Invoices AS I
ON S.Student_ID = I.Student_ID
GROUP BY S.Student_First_Name, S.Student_Last_Name, CS.Date_Modified, 
I.Invoice_Code , I.Invoice_Amount, CS.Music_Technology, I.Invoice_Due_Date
HAVING Music_Technology NOT LIKE 'N/A'
(SELECT AVG(Invoice_Amount) / 9 AS [Average_Fee_Payments_Per_Month_For_Students_Taking_Music_Technology] 
FROM Invoices)
GO

--Call the above Stored Procedure

USE College_of_Music;
GO

BEGIN TRY
    EXEC spMusic_Technology_Students_Invoice_Calculations_And_Projections;
	SELECT * FROM dbo.Music_Technology_Students_Invoice_Calculations_And_Projections
END TRY
BEGIN CATCH
    PRINT 'An error occurred. Query not returned.';
    PRINT 'Error number: ' + CONVERT(varchar, ERROR_NUMBER());
    PRINT 'Error message: ' + CONVERT(varchar, ERROR_MESSAGE());
END CATCH;
GO

/* The code for number 10 creates a stored procedure named spMusic_Technology_Students_Invoice_Calculations_And_Projections. A table
named [Music_Technology_Students_Invoice_Calculations_And_Projections] is created within the stored procedure. Both the stored procedure and 
table have IF conditons to delete the stored procedure/table if it is already present in the database. Three tables are joined in this stored 
procedure. The Students, Course_Student and Invoices tables are all joined on thier corresponding Student_ID columns. Each table is given
a correlation name and these are utilized within the SELECT clause. Students AS S, Course_Student AS CS and Invoices AS I. You can clearly
see the columns chosen in the SELECT clause so I will discuss the calculations instead. A column named [5%_Increase_For_Next_Year] is declared
and the calculation is the I.Invoice_Amount * 5 / 100 and then the Invoice_Amount is added to this result. The [Payment_Date_For_Next_Year] column
is calculated by using the DATEADD function. As discussed in previous dcumentation the DATEADD function takes 3 parameters. In this case they are
YEAR,1 and I.Invoice_Due_Date. What happens here is 1 year is added to the Invoice_Due_Date and the CAST function returns tha data type date.

The [Date_Of_Query] column displays the date the query is run by using the GETDATE() function. CAST is used again here to return the data type date.
The INTO clause specifies the new table to be created and the GROUP BY and HAVING clauses are used to return the columns under the condition that
the course Music_Technology is not like 'N/A'. A subquery is coded to return the average monthly repayments for those taking the Music_Technology
module. The average is obtained using the aggreagte function AVG and this result is divided by 9 to show the average figure for 9 monthly repayments.
9 months lines up with the school year. The TRY and CATCH clauses are used to run and return the stored procedure. Within the TRY block I have the
execute function EXEC spMusic_Technology_Students_Invoice_Calculations_And_Projections.

I also added the SELECT * FROM dbo.Music_Technology_Students_Invoice_Calculations_And_Projections which displays the table if no error occurs. If I left
this out only the subquery would display a result. I would have to code the SELECT * FROM dbo.Music_Technology_Students_Invoice_Calculations_And_Projections
manually and execute this if I wanted that table information to show. */

