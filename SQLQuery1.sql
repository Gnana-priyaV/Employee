EXEC sp_Emp_GetById @EmpId = 1;




IF DB_ID('EMP') IS NULL CREATE DATABASE EMP;
GO
USE EMP;
DROP PROC IF EXISTS sp_Emp_GetAll, sp_Emp_GetByID, sp_Emp_INSERT, sp_Emp_DELETE, sp_Emp_UPDATE;
DROP TABLE IF EXISTS Employees;
GO

CREATE TABLE Employees (
	EmpID INT identity(1,1) PRIMARY KEY,
	FullName NVARCHAR(100) NOT NULL,
	Email NVARCHAR(100) NOT NULL,
	Department NVARCHAR(50) NOT NULL,
	Phone VARCHAR(15),
	JoinDate DATE,
	Salary DECIMAL(10, 2),
	IsActive BIT DEFAULT 1
);
GO
CREATE PROC sp_Emp_GetAll AS
SELECT * FROM Employees WHERE IsActive = 1 ORDER BY EmpID DESC;
GO
CREATE PROC sp_Emp_GetByID @EmpID INT AS
SELECT * FROM Employees WHERE EmpID = @EmpID;
GO
CREATE PROC sp_Emp_INSERT
	@FullName NVARCHAR(100),
	@Email NVARCHAR(100),
	@Department NVARCHAR(50),
	@Phone VARCHAR(15),
	@JoinDate DATE,
	@Salary DECIMAL(10, 2) AS
    INSERT INTO Employees (FullName, Email, Department, Phone, JoinDate, Salary)
    VALUES (@FullName, @Email, @Department, @Phone, @JoinDate, @Salary);
GO
CREATE PROC sp_Emp_UPDATE
	@EmpID INT,
	@FullName NVARCHAR(100),
	@Email NVARCHAR(100),
	@Department NVARCHAR(50),
	@Phone VARCHAR(15),
	@JoinDate DATE,
	@Salary DECIMAL(10, 2) AS
	UPDATE Employees
	SET FullName = @FullName,
		Email = @Email,
		Department = @Department,
		Phone = @Phone,
		JoinDate = @JoinDate,
		Salary = @Salary
	WHERE EmpID = @EmpID;
	GO
	CREATE PROC sp_Emp_DELETE @EmpID INT AS
	UPDATE Employees SET IsActive = 0 WHERE EmpID = @EmpID;
	GO
