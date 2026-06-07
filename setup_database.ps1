# database_setup.ps1
# Setup Script for Inventory Management System SQL Server Database

$connectionString = "Data Source=.\SQLEXPRESS;Integrated Security=True;TrustServerCertificate=True"

Write-Host "Connecting to SQL Server Express (.\SQLEXPRESS)..." -ForegroundColor Cyan

try {
    $connection = New-Object System.Data.SqlClient.SqlConnection($connectionString)
    $connection.Open()
    Write-Host "Connected successfully!" -ForegroundColor Green
} catch {
    Write-Error "Failed to connect to .\SQLEXPRESS. Please make sure SQL Server Express is installed and running."
    exit
}

# Create Database if it doesn't exist
Write-Host "Creating database 'inventorydb' if it doesn't exist..." -ForegroundColor Cyan
$sqlCreateDb = "IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'inventorydb') CREATE DATABASE inventorydb;"
$command = New-Object System.Data.SqlClient.SqlCommand($sqlCreateDb, $connection)
try {
    [void]$command.ExecuteNonQuery()
    Write-Host "Database created or verified." -ForegroundColor Green
} catch {
    Write-Error "Failed to create database: $_"
    $connection.Close()
    exit
}
$connection.Close()

# Connect to the newly created/existing inventorydb
$connectionStringDb = "Data Source=.\SQLEXPRESS;Initial Catalog=inventorydb;Integrated Security=True;TrustServerCertificate=True"
Write-Host "Connecting to 'inventorydb' to create tables and seed data..." -ForegroundColor Cyan

try {
    $connectionDb = New-Object System.Data.SqlClient.SqlConnection($connectionStringDb)
    $connectionDb.Open()
} catch {
    Write-Error "Failed to connect to database 'inventorydb': $_"
    exit
}

# Table creation and seed data SQL
$sqlCreateTables = @"
-- User Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserTbl]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[UserTbl] (
        [UPhone] VARCHAR(50) NOT NULL PRIMARY KEY,
        [UfullName] VARCHAR(100) NULL,
        [Uname] VARCHAR(50) NULL,
        [UPassword] VARCHAR(50) NULL
    );
    INSERT INTO [dbo].[UserTbl] ([UPhone], [UfullName], [Uname], [UPassword])
    VALUES ('1234567890', 'Administrator', 'admin', 'admin');
    PRINT 'UserTbl created and default admin user seeded.';
END

-- Category Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CategoryTbl]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[CategoryTbl] (
        [CatId] INT NOT NULL PRIMARY KEY,
        [CatName] VARCHAR(100) NOT NULL
    );
    INSERT INTO [dbo].[CategoryTbl] ([CatId], [CatName]) VALUES (1, 'Electronics');
    INSERT INTO [dbo].[CategoryTbl] ([CatId], [CatName]) VALUES (2, 'Furniture');
    INSERT INTO [dbo].[CategoryTbl] ([CatId], [CatName]) VALUES (3, 'Groceries');
    PRINT 'CategoryTbl created and default categories seeded.';
END

-- Customer Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerTbl]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[CustomerTbl] (
        [custId] INT NOT NULL PRIMARY KEY,
        [custName] VARCHAR(100) NOT NULL,
        [custPhone] VARCHAR(50) NULL
    );
    INSERT INTO [dbo].[CustomerTbl] ([custId], [custName], [custPhone]) VALUES (1, 'John Doe', '0771234567');
    INSERT INTO [dbo].[CustomerTbl] ([custId], [custName], [custPhone]) VALUES (2, 'Jane Smith', '0777654321');
    PRINT 'CustomerTbl created and default customers seeded.';
END

-- Product Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductTbl]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[ProductTbl] (
        [ProId] INT NOT NULL PRIMARY KEY,
        [ProName] VARCHAR(100) NOT NULL,
        [ProQty] INT NOT NULL,
        [ProPrice] INT NOT NULL,
        [ProDescription] VARCHAR(255) NULL,
        [ProCategory] VARCHAR(100) NOT NULL
    );
    INSERT INTO [dbo].[ProductTbl] ([ProId], [ProName], [ProQty], [ProPrice], [ProDescription], [ProCategory])
    VALUES (1, 'Laptop', 10, 150000, 'Core i5 Laptop', 'Electronics');
    INSERT INTO [dbo].[ProductTbl] ([ProId], [ProName], [ProQty], [ProPrice], [ProDescription], [ProCategory])
    VALUES (2, 'Office Chair', 25, 12000, 'Ergonomic office chair', 'Furniture');
    PRINT 'ProductTbl created and default products seeded.';
END

-- Order Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderTbl]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[OrderTbl] (
        [OrderId] INT NOT NULL PRIMARY KEY,
        [CustId] INT NOT NULL,
        [CustName] VARCHAR(100) NOT NULL,
        [OrderDate] DATETIME NOT NULL,
        [TotalAmount] INT NOT NULL
    );
    PRINT 'OrderTbl created.';
END
"@

$commandDb = New-Object System.Data.SqlClient.SqlCommand($sqlCreateTables, $connectionDb)
try {
    # Listen to SQL print events
    $handler = [System.Data.SqlClient.SqlInfoMessageEventHandler] {
        param($sender, $event)
        Write-Host "SQL: $($event.Message)" -ForegroundColor Gray
    }
    $connectionDb.add_InfoMessage($handler)
    
    [void]$commandDb.ExecuteNonQuery()
    Write-Host "Database tables and seed data setup completed successfully!" -ForegroundColor Green
} catch {
    Write-Error "Failed to execute database schema script: $_"
} finally {
    $connectionDb.Close()
}
