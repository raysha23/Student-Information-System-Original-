USE [master]
GO
/****** Object:  Database [SIS]    Script Date: 7/24/2025 10:47:04 AM ******/
CREATE DATABASE [SIS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SIS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SIS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SIS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SIS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SIS] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SIS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SIS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SIS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SIS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SIS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SIS] SET ARITHABORT OFF 
GO
ALTER DATABASE [SIS] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SIS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SIS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SIS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SIS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SIS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SIS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SIS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SIS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SIS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SIS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SIS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SIS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SIS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SIS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SIS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SIS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SIS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SIS] SET  MULTI_USER 
GO
ALTER DATABASE [SIS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SIS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SIS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SIS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SIS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SIS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SIS] SET QUERY_STORE = ON
GO
ALTER DATABASE [SIS] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SIS]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 7/24/2025 10:47:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[admin_id] [int] NOT NULL,
	[email] [varchar](100) NULL,
	[full_name] [varchar](100) NULL,
	[role_id] [int] NULL,
	[created_at] [datetime] NULL,
	[user_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[admin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 7/24/2025 10:47:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[role_id] [int] NOT NULL,
	[role] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 7/24/2025 10:47:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[student_id] [int] NOT NULL,
	[first_name] [varchar](100) NULL,
	[last_name] [varchar](100) NULL,
	[date_of_birth] [date] NULL,
	[gender] [varchar](50) NULL,
	[email] [varchar](100) NULL,
	[phone] [varchar](100) NULL,
	[address] [varchar](100) NULL,
	[enrollment_date] [date] NULL,
	[status] [varchar](100) NULL,
	[role_id] [int] NULL,
	[user_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 7/24/2025 10:47:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher](
	[teacher_id] [int] NOT NULL,
	[first_name] [varchar](100) NULL,
	[last_name] [varchar](100) NULL,
	[email] [varchar](100) NULL,
	[phone] [varchar](100) NULL,
	[hire_date] [date] NULL,
	[department] [varchar](100) NULL,
	[specialization] [varchar](100) NULL,
	[status] [varchar](100) NULL,
	[role_id] [int] NULL,
	[user_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[teacher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Login]    Script Date: 7/24/2025 10:47:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Login](
	[user_id] [int] NOT NULL,
	[username] [varchar](100) NULL,
	[password_hash] [varchar](100) NULL,
	[role_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Admin] ([admin_id], [email], [full_name], [role_id], [created_at], [user_id]) VALUES (1, N'admin@gmail.com', N'Admin Gwapo', 1, CAST(N'2025-07-24T10:31:55.347' AS DateTime), 1)
GO
INSERT [dbo].[Role] ([role_id], [role]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([role_id], [role]) VALUES (2, N'Teacher')
INSERT [dbo].[Role] ([role_id], [role]) VALUES (3, N'Student')
GO
INSERT [dbo].[Student] ([student_id], [first_name], [last_name], [date_of_birth], [gender], [email], [phone], [address], [enrollment_date], [status], [role_id], [user_id]) VALUES (21, N'Student', N'Gwapo', CAST(N'2003-12-23' AS Date), N'Male', N'student@gmail.com', N'09517380165', N'San Roque, Talisay City, Cebu', CAST(N'2025-07-24' AS Date), N'Active', 3, 3)
GO
INSERT [dbo].[Teacher] ([teacher_id], [first_name], [last_name], [email], [phone], [hire_date], [department], [specialization], [status], [role_id], [user_id]) VALUES (11, N'Teacher', N'Gwapo', N'teacher@gmail.com', N'09517380165', CAST(N'2025-07-24' AS Date), N'Computer Studies', N'Programmer', N'Active', 2, 2)
GO
INSERT [dbo].[User_Login] ([user_id], [username], [password_hash], [role_id]) VALUES (1, N'Admin', N'admin', 1)
INSERT [dbo].[User_Login] ([user_id], [username], [password_hash], [role_id]) VALUES (2, N'Teacher', N'teacher', 2)
INSERT [dbo].[User_Login] ([user_id], [username], [password_hash], [role_id]) VALUES (3, N'Student', N'student', 3)
GO
ALTER TABLE [dbo].[Admin] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Admin]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([role_id])
GO
ALTER TABLE [dbo].[Admin]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[User_Login] ([user_id])
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([role_id])
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[User_Login] ([user_id])
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([role_id])
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[User_Login] ([user_id])
GO
ALTER TABLE [dbo].[User_Login]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([role_id])
GO
USE [master]
GO
ALTER DATABASE [SIS] SET  READ_WRITE 
GO
