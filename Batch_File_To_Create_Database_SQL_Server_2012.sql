USE [master]
GO
--Drops a database named College_of_Music if it already exists 
IF DB_ID('College_of_Music') IS NOT NULL
	DROP DATABASE [College_of_Music]
GO
--Creates a database named College_of_Music
CREATE DATABASE [College_of_Music]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'College_of_Music_Data', FILENAME = N'C:\Stephen_Kohlmann\College_of_Music.mdf' , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'College_of_Music_Log', FILENAME = N'C:\Stephen_Kohlmann\College_of_Music_log.ldf' , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO

/****** Object 1:  Employee Table ******/ -- Creates Employee Table, column and data types specified. Primary key specified. 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employees](
	[Employee_ID] [varchar](20) NOT NULL,
	[Employee_First_Name] [nvarchar](30) NOT NULL,
	[Employee_Last_Name] [varchar](30) NOT NULL,
	[Employee_Title] [varchar](20) NOT NULL,
	[Education_Level] [varchar](20) NOT NULL,
	[Date_Modified] [date] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Employee_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


/****** Object 2:  Student Table ******/ -- Creates Student Table, column and data types specified. Primary key specified. 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Students](
	[Student_ID] [varchar](20) NOT NULL,
	[Student_First_Name] [nvarchar](30) NOT NULL,
	[Student_Last_Name] [varchar](30) NOT NULL,
	[Instrument] [varchar](20) NOT NULL,
	[Age] [tinyint] NOT NULL,
	[Date_Modified] [date] NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


/****** Object 3:  Course_Lecturer Table ******/ -- Creates Course_Lecturer Table, column and data types specified. Primary and Foreign key specified. 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Course_Lecturer](
	[Course_Code] [varchar](20) NOT NULL,
	[Course_Name] [nvarchar](30) NOT NULL,
	[Employee_ID] [varchar](20) NOT NULL CONSTRAINT [FK_Employee_ID] FOREIGN KEY REFERENCES Employees(Employee_ID),
	[Date_Modified] [date] NULL,
 CONSTRAINT [PK_Course_Lecturer] PRIMARY KEY CLUSTERED 
(
	[Course_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


/****** Object 4:  Course_Student Table ******/ -- Creates Course_Student Table, column and data types specified. Primary and Foreign key specified. 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Course_Student](
	[Student_ID] [varchar](20) NOT NULL,
	[Jazz_History] [varchar](3) NOT NULL,
	[Arranging] [varchar](3) NOT NULL,
	[Ear_Training] [varchar](3) NOT NULL,
	[Rhythmic_Dictation] [varchar](3) NOT NULL,
	[Jazz_Ensemble] [varchar](3) NOT NULL,
	[Contemporary_Ensemble] [varchar](3) NOT NULL,
	[Business] [varchar](3) NOT NULL,
	[Music_Technology] [varchar](3) NOT NULL,
	[Date_Modified] [date] NULL,
 CONSTRAINT [PK_Course_Student] PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO


/****** Object 5:  Invoice_Table ******/ -- Creates Invoice Table, column and data types specified. Primary and Foreign key specified. 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Invoices](
	[Invoice_Code] [varchar](20) NOT NULL,
	[Invoice_Amount] [money] NOT NULL,
	[Invoice_Due_Date] [smalldatetime] NOT NULL,
	[Student_ID] [varchar](20) NOT NULL CONSTRAINT [FK_Student_ID] FOREIGN KEY REFERENCES Students(Student_ID),
	[Date_Modified] [smalldatetime] NULL,
 CONSTRAINT [PK_Invoices] PRIMARY KEY CLUSTERED 
(
	[Invoice_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/****** Object 6:  Salary_Table ******/ -- -- Creates SalaryTable, column and data types specified. Primary and Foreign key specified. 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Salary](
	[Salary_ID] [varchar](20) NOT NULL,
	[Salary_Amount] [money] NOT NULL,
	[Payment_Frequency] [varchar](20) NOT NULL,
	[Overtime_Hourly_Rate] [money] NOT NULL,
	[Holiday_Pay] [money] NOT NULL,
	[Employee_ID] [varchar](20) NOT NULL CONSTRAINT [FK1_Employee_ID] FOREIGN KEY REFERENCES Employees(Employee_ID),
	[Date_Modified] [date] NULL,
 CONSTRAINT [PK_Salary] PRIMARY KEY CLUSTERED 

(
	[Salary_ID] ASC
)

WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

/****** Object 1:  Employee Table INSERT ******/ -- Records added for each column

INSERT [dbo].[Employees] ([Employee_ID], [Employee_First_Name], [Employee_Last_Name], [Employee_Title], [Education_Level], [Date_Modified]) VALUES ('E0000001', 'Stephen', 'Kohlmann', 'Lecturer ', 'Masters Level 9', '2008-4-11')
INSERT [dbo].[Employees] ([Employee_ID], [Employee_First_Name], [Employee_Last_Name], [Employee_Title], [Education_Level], [Date_Modified]) VALUES ('E0000002', 'Scott', 'Kohlmann', 'Lecturer ', 'Degree Level 8', '2006-12-12')
INSERT [dbo].[Employees] ([Employee_ID], [Employee_First_Name], [Employee_Last_Name], [Employee_Title], [Education_Level], [Date_Modified]) VALUES ('E0000003', 'Gillian', 'Kohlmann', 'Receptionist ', 'Degree Level 7', '2004-2-1')
INSERT [dbo].[Employees] ([Employee_ID], [Employee_First_Name], [Employee_Last_Name], [Employee_Title], [Education_Level], [Date_Modified]) VALUES ('E0000004', 'Rolf', 'Patterson', 'Lecturer ', 'PHD Level 10', '2003-2-8')
INSERT [dbo].[Employees] ([Employee_ID], [Employee_First_Name], [Employee_Last_Name], [Employee_Title], [Education_Level], [Date_Modified]) VALUES ('E0000005', 'Sinead', 'Conway', 'Lecturer ', 'Masters Level 9', '2007-2-11')
INSERT [dbo].[Employees] ([Employee_ID], [Employee_First_Name], [Employee_Last_Name], [Employee_Title], [Education_Level], [Date_Modified]) VALUES ('E0000006', 'John', 'Smith', 'IT Manager ', 'Masters Level 9', '2005-4-9')
INSERT [dbo].[Employees] ([Employee_ID], [Employee_First_Name], [Employee_Last_Name], [Employee_Title], [Education_Level], [Date_Modified]) VALUES ('E0000007', 'Keith', 'Curly', 'Marketing Manager ', 'Degree Level 8', '2002-6-10')
INSERT [dbo].[Employees] ([Employee_ID], [Employee_First_Name], [Employee_Last_Name], [Employee_Title], [Education_Level], [Date_Modified]) VALUES ('E0000008', 'Jim', 'Tate', 'Lecturer ', 'PHD Level 10', '2002-10-6')
INSERT [dbo].[Employees] ([Employee_ID], [Employee_First_Name], [Employee_Last_Name], [Employee_Title], [Education_Level], [Date_Modified]) VALUES ('E0000009', 'Matt', 'Halpin', 'Lecturer ', 'Masters Level 9', '2008-11-3')
INSERT [dbo].[Employees] ([Employee_ID], [Employee_First_Name], [Employee_Last_Name], [Employee_Title], [Education_Level], [Date_Modified]) VALUES ('E0000010', 'Robert', 'Gardener', 'Janitor ', 'N/A', '2008-8-25')


/****** Object 2:  Student Table INSERT ******/ -- Records added for each column

INSERT [dbo].[Students] ([Student_ID], [Student_First_Name], [Student_Last_Name], [Instrument], [Age], [Date_Modified]) VALUES ('S0000001', 'Thomas', 'Maxwell', 'Drums ', 21 , '2013-9-30')
INSERT [dbo].[Students] ([Student_ID], [Student_First_Name], [Student_Last_Name], [Instrument], [Age], [Date_Modified]) VALUES ('S0000002', 'Alex', 'Connell', 'Guitar ', 20 , '2012-9-30')
INSERT [dbo].[Students] ([Student_ID], [Student_First_Name], [Student_Last_Name], [Instrument], [Age], [Date_Modified]) VALUES ('S0000003', 'Fiona', 'McHugh', 'Violin ', 19 , '2011-9-29')
INSERT [dbo].[Students] ([Student_ID], [Student_First_Name], [Student_Last_Name], [Instrument], [Age], [Date_Modified]) VALUES ('S0000004', 'Giacamo', 'Mariscullio', 'Bass Guitar ', 18 , '2010-9-28')
INSERT [dbo].[Students] ([Student_ID], [Student_First_Name], [Student_Last_Name], [Instrument], [Age], [Date_Modified]) VALUES ('S0000005', 'Jack', 'Dean', 'Vocals ', 23 , '2013-9-30')
INSERT [dbo].[Students] ([Student_ID], [Student_First_Name], [Student_Last_Name], [Instrument], [Age], [Date_Modified]) VALUES ('S0000006', 'Marie', 'Daley', 'Vocals ', 24 , '2012-9-30')
INSERT [dbo].[Students] ([Student_ID], [Student_First_Name], [Student_Last_Name], [Instrument], [Age], [Date_Modified]) VALUES ('S0000007', 'Laura', 'Bridgeman', 'Piano ', 27 , '2011-9-29')
INSERT [dbo].[Students] ([Student_ID], [Student_First_Name], [Student_Last_Name], [Instrument], [Age], [Date_Modified]) VALUES ('S0000008', 'Ben', 'Cage', 'Piano ', 26 , '2010-9-28')
INSERT [dbo].[Students] ([Student_ID], [Student_First_Name], [Student_Last_Name], [Instrument], [Age], [Date_Modified]) VALUES ('S0000009', 'Shane', 'Jackson', 'Keyboards ', 25 , '2013-9-30')
INSERT [dbo].[Students] ([Student_ID], [Student_First_Name], [Student_Last_Name], [Instrument], [Age], [Date_Modified]) VALUES ('S0000010', 'Sam', 'Willis', 'Drums ', 24 , '2012-9-30')
INSERT [dbo].[Students] ([Student_ID], [Student_First_Name], [Student_Last_Name], [Instrument], [Age], [Date_Modified]) VALUES ('S0000011', 'Niamh', 'Smith', 'Guitar ', 23 , '2011-9-29')
INSERT [dbo].[Students] ([Student_ID], [Student_First_Name], [Student_Last_Name], [Instrument], [Age], [Date_Modified]) VALUES ('S0000012', 'Mary', 'Diaz', 'Guitar ', 29 , '2010-9-28')

/****** Object 3:  Course_Lecturer Table INSERT ******/ -- Records added for each column

INSERT [dbo].[Course_Lecturer] ([Course_Code], [Course_Name], [Employee_ID], [Date_Modified]) VALUES ('CC0000001', 'Jazz History', 'E0000004', '2009-8-28')
INSERT [dbo].[Course_Lecturer] ([Course_Code], [Course_Name], [Employee_ID], [Date_Modified]) VALUES ('CC0000002', 'Arranging', 'E0000009', '2009-8-28')
INSERT [dbo].[Course_Lecturer] ([Course_Code], [Course_Name], [Employee_ID], [Date_Modified]) VALUES ('CC0000003', 'Ear Training', 'E0000002', '2008-8-27')
INSERT [dbo].[Course_Lecturer] ([Course_Code], [Course_Name], [Employee_ID], [Date_Modified]) VALUES ('CC0000004', 'Rhythmic Dictation', 'E0000001', '2008-8-27')
INSERT [dbo].[Course_Lecturer] ([Course_Code], [Course_Name], [Employee_ID], [Date_Modified]) VALUES ('CC0000005', 'Jazz Ensemble', 'E0000002', '2007-8-24')
INSERT [dbo].[Course_Lecturer] ([Course_Code], [Course_Name], [Employee_ID], [Date_Modified]) VALUES ('CC0000006', 'Pop Ensemble', 'E0000008', '2007-8-24')
INSERT [dbo].[Course_Lecturer] ([Course_Code], [Course_Name], [Employee_ID], [Date_Modified]) VALUES ('CC0000007', 'Business', 'E0000005', '2006-7-23')
INSERT [dbo].[Course_Lecturer] ([Course_Code], [Course_Name], [Employee_ID], [Date_Modified]) VALUES ('CC0000008', 'Music Technology', 'E0000001', '2006-7-23')

/****** Object 4:  Course_Student Table INSERT ******/ -- Records added for each column

INSERT [dbo].[Course_Student] ([Student_ID], [Jazz_History], [Arranging], [Ear_Training], [Rhythmic_Dictation], [Jazz_Ensemble], [Contemporary_Ensemble], [Business], [Music_Technology], [Date_Modified]) VALUES ('S0000001', 'Y1', 'Y1', 'Y1', 'Y1', 'Y1', 'Y1 ', 'Y1', 'Y1', '2013-9-15')
INSERT [dbo].[Course_Student] ([Student_ID], [Jazz_History], [Arranging], [Ear_Training], [Rhythmic_Dictation], [Jazz_Ensemble], [Contemporary_Ensemble], [Business], [Music_Technology], [Date_Modified]) VALUES ('S0000002', 'Y2', 'Y2', 'N/A', 'N/A ', 'Y2', 'Y2', 'N/A ', 'N/A', '2012-9-15')
INSERT [dbo].[Course_Student] ([Student_ID], [Jazz_History], [Arranging], [Ear_Training], [Rhythmic_Dictation], [Jazz_Ensemble], [Contemporary_Ensemble], [Business], [Music_Technology], [Date_Modified]) VALUES ('S0000003', 'Y3', 'Y3', 'Y3', 'N/A ', 'N/A', 'Y3', 'Y3', 'Y3', '2011-9-13')
INSERT [dbo].[Course_Student] ([Student_ID], [Jazz_History], [Arranging], [Ear_Training], [Rhythmic_Dictation], [Jazz_Ensemble], [Contemporary_Ensemble], [Business], [Music_Technology], [Date_Modified]) VALUES ('S0000004', 'Y4', 'N/A', 'Y4', 'N/A ', 'Y4', 'Y4', 'Y4', 'Y4', '2010-9-13')
INSERT [dbo].[Course_Student] ([Student_ID], [Jazz_History], [Arranging], [Ear_Training], [Rhythmic_Dictation], [Jazz_Ensemble], [Contemporary_Ensemble], [Business], [Music_Technology], [Date_Modified]) VALUES ('S0000005', 'Y1', 'Y1', 'Y1', 'Y1', 'Y1 ', 'Y1', 'Y1', 'Y1', '2013-9-15')
INSERT [dbo].[Course_Student] ([Student_ID], [Jazz_History], [Arranging], [Ear_Training], [Rhythmic_Dictation], [Jazz_Ensemble], [Contemporary_Ensemble], [Business], [Music_Technology], [Date_Modified]) VALUES ('S0000006', 'Y2', 'Y2', 'Y2', 'Y2', 'Y2 ', 'Y2', 'Y2', 'N/A', '2012-9-15')
INSERT [dbo].[Course_Student] ([Student_ID], [Jazz_History], [Arranging], [Ear_Training], [Rhythmic_Dictation], [Jazz_Ensemble], [Contemporary_Ensemble], [Business], [Music_Technology], [Date_Modified]) VALUES ('S0000007', 'Y3', 'Y3', 'Y3', 'Y3', 'Y3 ', 'Y3', 'Y3', 'N/A', '2011-9-13')
INSERT [dbo].[Course_Student] ([Student_ID], [Jazz_History], [Arranging], [Ear_Training], [Rhythmic_Dictation], [Jazz_Ensemble], [Contemporary_Ensemble], [Business], [Music_Technology], [Date_Modified]) VALUES ('S0000008', 'Y4', 'Y4', 'Y4', 'Y4', 'Y4 ', 'Y4', 'Y4', 'N/A', '2010-9-13')
INSERT [dbo].[Course_Student] ([Student_ID], [Jazz_History], [Arranging], [Ear_Training], [Rhythmic_Dictation], [Jazz_Ensemble], [Contemporary_Ensemble], [Business], [Music_Technology], [Date_Modified]) VALUES ('S0000009', 'N/A', 'Y1', 'Y1', 'Y1', 'Y1 ', 'Y1', 'Y1', 'N/A', '2013-9-15')
INSERT [dbo].[Course_Student] ([Student_ID], [Jazz_History], [Arranging], [Ear_Training], [Rhythmic_Dictation], [Jazz_Ensemble], [Contemporary_Ensemble], [Business], [Music_Technology], [Date_Modified]) VALUES ('S0000010', 'Y2', 'N/A', 'Y2', 'Y2', 'Y2 ', 'Y2', 'N/A', 'Y2', '2012-9-15')
INSERT [dbo].[Course_Student] ([Student_ID], [Jazz_History], [Arranging], [Ear_Training], [Rhythmic_Dictation], [Jazz_Ensemble], [Contemporary_Ensemble], [Business], [Music_Technology], [Date_Modified]) VALUES ('S0000011', 'Y3', 'Y3', 'N/A', 'Y3', 'Y3 ', 'N/A', 'Y3', 'Y3', '2011-9-13')
INSERT [dbo].[Course_Student] ([Student_ID], [Jazz_History], [Arranging], [Ear_Training], [Rhythmic_Dictation], [Jazz_Ensemble], [Contemporary_Ensemble], [Business], [Music_Technology], [Date_Modified]) VALUES ('S0000012', 'Y4', 'Y4', 'Y4', 'N/A', 'N/A', 'Y4', '4', 'Y4', '2010-9-13')

/****** Object 5:  Invoice_Table INSERT ******/ -- Records added for each column

INSERT [dbo].[Invoices] ([Invoice_Code], [Invoice_Amount], [Invoice_Due_Date], [Student_ID], [Date_Modified]) VALUES ('IC0000001', '$2500', '2014-9-30', 'S0000009', '2014-1-7' )
INSERT [dbo].[Invoices] ([Invoice_Code], [Invoice_Amount], [Invoice_Due_Date], [Student_ID], [Date_Modified]) VALUES ('IC0000002', '$3500', '2014-9-30', 'S0000003', '2014-1-7' )
INSERT [dbo].[Invoices] ([Invoice_Code], [Invoice_Amount], [Invoice_Due_Date], [Student_ID], [Date_Modified]) VALUES ('IC0000003', '$3500', '2014-10-31', 'S0000006', '2014-2-7' )
INSERT [dbo].[Invoices] ([Invoice_Code], [Invoice_Amount], [Invoice_Due_Date], [Student_ID], [Date_Modified]) VALUES ('IC0000004', '$4650', '2014-8-28', 'S0000011', '2013-12-1' )
INSERT [dbo].[Invoices] ([Invoice_Code], [Invoice_Amount], [Invoice_Due_Date], [Student_ID], [Date_Modified]) VALUES ('IC0000005', '$350', '2014-8-28', 'S0000012', '2013-12-1' )
INSERT [dbo].[Invoices] ([Invoice_Code], [Invoice_Amount], [Invoice_Due_Date], [Student_ID], [Date_Modified]) VALUES ('IC0000006', '$350', '2014-8-27', 'S0000002', '2013-12-1' )
INSERT [dbo].[Invoices] ([Invoice_Code], [Invoice_Amount], [Invoice_Due_Date], [Student_ID], [Date_Modified]) VALUES ('IC0000007', '$1570', '2014-10-28', 'S0000004', '2014-2-25' )
INSERT [dbo].[Invoices] ([Invoice_Code], [Invoice_Amount], [Invoice_Due_Date], [Student_ID], [Date_Modified]) VALUES ('IC0000008', '$1670', '2014-9-28', 'S0000008', '2014-1-25' )
INSERT [dbo].[Invoices] ([Invoice_Code], [Invoice_Amount], [Invoice_Due_Date], [Student_ID], [Date_Modified]) VALUES ('IC0000009', '$1800', '2014-10-11', 'S0000007', '2014-3-15' )
INSERT [dbo].[Invoices] ([Invoice_Code], [Invoice_Amount], [Invoice_Due_Date], [Student_ID], [Date_Modified]) VALUES ('IC0000010', '$2900', '2014-12-18', 'S0000001', '2014-4-17' )
INSERT [dbo].[Invoices] ([Invoice_Code], [Invoice_Amount], [Invoice_Due_Date], [Student_ID], [Date_Modified]) VALUES ('IC0000011', '$2900', '2014-12-18', 'S0000005', '2014-4-17' )
INSERT [dbo].[Invoices] ([Invoice_Code], [Invoice_Amount], [Invoice_Due_Date], [Student_ID], [Date_Modified]) VALUES ('IC0000012', '$2900', '2014-12-15', 'S0000010', '2014-4-17' )

/****** Object 6:  Salary_Table INSERT ******/ -- Records added for each column


INSERT [dbo].[Salary] ([Salary_ID], [Salary_Amount], [Payment_Frequency], [Overtime_Hourly_Rate], [Holiday_Pay], [Employee_ID], [Date_Modified]) VALUES ('SID0000001', '$75000', 'Monthly','$75','$6500', 'E0000004', '2012-8-15')
INSERT [dbo].[Salary] ([Salary_ID], [Salary_Amount], [Payment_Frequency], [Overtime_Hourly_Rate], [Holiday_Pay], [Employee_ID], [Date_Modified]) VALUES ('SID0000002', '$65000', 'Monthly','$65','$6500', 'E0000008', '2012-8-15')
INSERT [dbo].[Salary] ([Salary_ID], [Salary_Amount], [Payment_Frequency], [Overtime_Hourly_Rate], [Holiday_Pay], [Employee_ID], [Date_Modified]) VALUES ('SID0000003', '$60000', 'Weekly','$60','$6500', 'E0000001', '2012-7-17')
INSERT [dbo].[Salary] ([Salary_ID], [Salary_Amount], [Payment_Frequency], [Overtime_Hourly_Rate], [Holiday_Pay], [Employee_ID], [Date_Modified]) VALUES ('SID0000004', '$55000', 'Weekly','$55','$6500', 'E0000005', '2012-7-17')
INSERT [dbo].[Salary] ([Salary_ID], [Salary_Amount], [Payment_Frequency], [Overtime_Hourly_Rate], [Holiday_Pay], [Employee_ID], [Date_Modified]) VALUES ('SID0000005', '$55000', 'Bi-Weekly','$55','$6500', 'E0000006', '2012-6-22')
INSERT [dbo].[Salary] ([Salary_ID], [Salary_Amount], [Payment_Frequency], [Overtime_Hourly_Rate], [Holiday_Pay], [Employee_ID], [Date_Modified]) VALUES ('SID0000006', '$50000', 'Weekly','$50','$6500', 'E0000009', '2012-4-19')
INSERT [dbo].[Salary] ([Salary_ID], [Salary_Amount], [Payment_Frequency], [Overtime_Hourly_Rate], [Holiday_Pay], [Employee_ID], [Date_Modified]) VALUES ('SID0000007', '$45000', 'Monthly','$45','$6500', 'E0000002', '2013-7-30')
INSERT [dbo].[Salary] ([Salary_ID], [Salary_Amount], [Payment_Frequency], [Overtime_Hourly_Rate], [Holiday_Pay], [Employee_ID], [Date_Modified]) VALUES ('SID0000008', '$45000', 'Monthly','$45','$6500', 'E0000007', '2013-7-30')
INSERT [dbo].[Salary] ([Salary_ID], [Salary_Amount], [Payment_Frequency], [Overtime_Hourly_Rate], [Holiday_Pay], [Employee_ID], [Date_Modified]) VALUES ('SID0000009', '$30000', 'Monthly','$30','$6500', 'E0000003', '2013-8-29')
INSERT [dbo].[Salary] ([Salary_ID], [Salary_Amount], [Payment_Frequency], [Overtime_Hourly_Rate], [Holiday_Pay], [Employee_ID], [Date_Modified]) VALUES ('SID0000010', '$30000', 'Weekly','$30','$6500', 'E0000010', '2011-8-27')


/****** The below is for quick testing purposes to ensure the tables and columns are populated correctly *****/

SELECT * FROM dbo.Course_Lecturer
SELECT * FROM dbo.Course_Student
SELECT * FROM dbo.Employees
SELECT * FROM dbo.Students
SELECT * FROM dbo.Invoices
SELECT * FROM dbo.Salary


