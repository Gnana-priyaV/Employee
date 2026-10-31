USE Emp;
GO
ALTER TABLE Employees ADD Address NVARCHAR(200) NULL;
GO
ALTER PROC sp_Emp_INSERT
    @FullName NVARCHAR(100), @Email NVARCHAR(100), @Department NVARCHAR(50),
    @Phone VARCHAR(15), @JoinDate DATE, @Salary DECIMAL(10,2),
    @Address NVARCHAR(200) = NULL
AS
    INSERT INTO Employees (FullName, Email, Department, Phone, JoinDate, Salary, Address)
    VALUES (@FullName, @Email, @Department, @Phone, @JoinDate, @Salary, @Address);
GO
ALTER PROC sp_Emp_UPDATE
    @EmpID INT, @FullName NVARCHAR(100), @Email NVARCHAR(100), @Department NVARCHAR(50),
    @Phone VARCHAR(15), @JoinDate DATE, @Salary DECIMAL(10,2),
    @Address NVARCHAR(200) = NULL
AS
    UPDATE Employees
    SET FullName=@FullName, Email=@Email, Department=@Department,
        Phone=@Phone, JoinDate=@JoinDate, Salary=@Salary, Address=@Address
    WHERE EmpID=@EmpID;
GO






USE Emp;
GO
IF COL_LENGTH('Employees','Address') IS NULL
    ALTER TABLE Employees ADD Address NVARCHAR(200) NULL;
GO
ALTER PROC sp_Emp_Insert
    @FullName NVARCHAR(100), @Email NVARCHAR(100), @Phone VARCHAR(15),
    @Address NVARCHAR(200) = NULL, @Salary DECIMAL(10,2),
    @Department NVARCHAR(50), @JoinDate DATE
AS
    INSERT INTO Employees (FullName, Email, Phone, Address, Salary, Department, JoinDate)
    VALUES (@FullName, @Email, @Phone, @Address, @Salary, @Department, @JoinDate);
GO
ALTER PROC sp_Emp_Update
    @EmpID INT, @FullName NVARCHAR(100), @Email NVARCHAR(100), @Phone VARCHAR(15),
    @Address NVARCHAR(200) = NULL, @Salary DECIMAL(10,2),
    @Department NVARCHAR(50), @JoinDate DATE
AS
    UPDATE Employees
    SET FullName=@FullName, Email=@Email, Phone=@Phone, Address=@Address,
        Salary=@Salary, Department=@Department, JoinDate=@JoinDate
    WHERE EmpID=@EmpID;
GO
