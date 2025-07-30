homework 1 
Basic Definitions 
Data
Raw facts and figures without context. Data can be numbers, text, images, etc., used for analysis or processing.

Database
A structured collection of data stored electronically, organized for easy access, management, and retrieval.

Relational Database
A type of database that stores data in tables (relations) with rows and columns. Tables can be linked using keys, allowing relationships between data entities.

Table
A collection of rows and columns in a database that stores data about a particular entity. Each row is a record; each column is an attribute or field.

Five Key Features of SQL Server
High Availability and Disaster Recovery – Features like Always On Availability Groups for failover and data redundancy.

Security – Supports authentication modes, encryption, row-level security, and auditing.

Scalability and Performance – Supports large databases, in-memory technologies, and advanced query optimizations.

Integration Services (SSIS) – Tools for data integration and workflow applications.

Support for T-SQL – Transact-SQL, an extension of SQL with procedural programming for complex queries and operations.

Authentication Modes in SQL Server
Windows Authentication Mode
Uses Windows user accounts to authenticate and authorize access. Secure and integrated with the OS.

SQL Server Authentication Mode
Uses SQL Server-specific usernames and passwords, managed within SQL Server.

Note: SQL Server can be set to use Windows Authentication only or Mixed Mode (both Windows and SQL Server Authentication).

Medium Level Tasks
1. Create a new database in SSMS named SchoolDB


CREATE DATABASE SchoolDB;
GO
2. Write and execute a query to create a table Students

USE SchoolDB;
GO

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);
GO
Differences Between SQL Server, SSMS, and SQL
SQL Server: The actual relational database management system (RDBMS) software by Microsoft that stores and manages data.

SSMS (SQL Server Management Studio): A graphical user interface tool to manage SQL Server instances, write queries, design databases, and administer the server.

SQL (Structured Query Language): The standard programming language used to communicate with relational databases, including SQL Server.

Hard Level Tasks
1. SQL Command Types
Command Type	Description	Examples
DQL (Data Query Language)	Used to query data from the database.	SELECT * FROM Students;
DML (Data Manipulation Language)	Used to modify data (insert, update, delete).	INSERT INTO Students VALUES (1, 'John', 20);
UPDATE Students SET Age=21 WHERE StudentID=1;
DELETE FROM Students WHERE StudentID=1;
DDL (Data Definition Language)	Used to define or modify database structure.	CREATE TABLE, ALTER TABLE, DROP TABLE
DCL (Data Control Language)	Used to control access to data.	GRANT SELECT ON Students TO user;
REVOKE INSERT ON Students FROM user;
TCL (Transaction Control Language)	Manages transactions.	BEGIN TRANSACTION;, COMMIT;, ROLLBACK;

2. Insert Three Records into the Students Table
USE SchoolDB;
GO

INSERT INTO Students (StudentID, Name, Age) VALUES (1, 'Alice', 22);
INSERT INTO Students (StudentID, Name, Age) VALUES (2, 'Bob', 24);
INSERT INTO Students (StudentID, Name, Age) VALUES (3, 'Charlie', 21);
GO


