/*
=================================================================================
Kasi Fresh Grocers Database Solution
=================================================================================
Student Name: Dineo Sefatsa (EDUV4953322)
Date: 15 August 2026
Description: Complete T-SQL solution for Kasi Fresh Grocers database including 
            tables, data, queries, indexes, triggers, views, stored procedures,
            security and testing. 
==================================================================================
*/

-- ===============================================================================
-- 1.1 Create a database named "KasiFreshGrocersDB"
-- ===============================================================================

USE master;

GO

CREATE DATABASE KasiFreshGrocersDB;

GO

USE KasiFreshGrocersDB;

GO

-- 1.2 All six tables listed in the correct order with appropriate data types, primary keys, and foreign keys.

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(100) NOT NULL,
    ContactEmail NVARCHAR(100),
    Province NVARCHAR(15)
);

GO

CREATE TABLE Branches (
    BranchID INT PRIMARY KEY IDENTITY(1,1),
    BranchName NVARCHAR(100) NOT NULL,
    Township NVARCHAR(100),
    Province NVARCHAR(15),
    ManagerName NVARCHAR(100)
);

GO

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    UnitPrice DECIMAL(10, 2) NOT NULL,
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

GO

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    ContactEmail NVARCHAR(100),
    ContactPhone NVARCHAR(15),
    LoyaltyTier NVARCHAR(20),
    SignupDate DATE
);

GO

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    BranchID INT,
    OrderDate DATETIME NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

GO

CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

GO 

-- I would like to see the data in all six tables.

SELECT * FROM Suppliers;
SELECT * FROM Branches;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderItems;

GO

-- 1.3 Insert statements to populate each table with at least 8 realistic rows.

INSERT INTO Suppliers (SupplierName, ContactEmail, Province) VALUES
('Soweto Fresh Grocers', 'info@sowetofreshgrocers.com', 'Soweto'),
('Alex Fruit & Veg', 'info@alexfruit&veg.com', 'Alexandra'),
('Khayelitsha wholefoods', 'info@khayelitshawholefoods.com', 'Khayelitsha'),
('Umlazi Fresh', 'info@umlazifresh.com', 'Umlazi'),
('Kasi Fresh Mamelodi', 'info@kasifreshmamelodi.com', 'Mamelodi'),
('Mdantsane Foods', 'info@mdantsanefoods.com', 'Mdantsane'),
('Tembisa Grocers', 'info@tembisagrocers.com', 'Tembisa'),
('Gale Kasi Grocers', 'info@galekasigrocers.com', 'Galeshewe');

GO

INSERT INTO Branches (BranchName, Township, Province, ManagerName) VALUES
('Soweto Branch', 'Soweto', 'Gauteng', 'Mbali Gumede'),
('Alexandra Branch', 'Alexandra', 'Gauteng', 'Thabiso Sithole'),
('Khayelitsha Branch', 'Khayelitsha', 'Western Cape', 'Thandiwe Nkosi'),
('Umlazi Branch', 'Umlazi', 'KwaZulu-Natal', 'Thulisile Zulu'),
('Mamelodi Branch', 'Mamelodi', 'Gauteng', 'Kabelo Mokoena'),
('Mdantsane Branch', 'Mdantsane', 'Eastern Cape', 'Luwella Khosa'),
('Tembisa Branch', 'Tembisa', 'Gauteng', 'Tish Lovie'),
('Galeshewe Branch', 'Galeshewe', 'Northern Cape', 'Jacob Mabuza');

GO

INSERT INTO Products (ProductName, Category, UnitPrice, SupplierID) VALUES
('Fresh Apples', 'Fruits', 3.50, 1),
('Bread', 'Bakery', 2.00, 2),
('Go Solos', 'Snacks', 1.50, 3),
('Apple munch', 'Frozen Foods', 2.50, 4),
('Fresh Chicken Breast', 'Meat', 8.00, 5),
('Tin Fish', 'Seafood', 12.00, 6),
('Fresh Milk', 'Dairy', 4.00, 7),
('Fresh Eggs (Dozen)', 'Dairy', 3.00, 8);

GO

INSERT INTO Customers (FirstName, LastName, ContactEmail, ContactPhone, LoyaltyTier, SignupDate) VALUES
('Lerato', 'Mokoena', 'L.mokoena@email.com', '0821234567', 'Gold', '2023-01-15'),
('Dineo', 'Mofokeng', 'Dineomofokeng@email.com', '0631034067', 'Silver', '2023-01-20'),
('Thabo', 'Nkosi', 'Thabo.nkosi@email.com', '0741244561', 'Bronze', '2023-03-10'),
('Karabo', 'Dlamini', 'KB.dlamini@email.com', '0631934427', 'Platinum', '2023-04-05'),
('Bianca', 'Ndlovu', 'Bianca.ndlovu@email.com', '0821234869', 'Gold', '2023-05-15'),
('Lethabo', 'Lebese', 'Lethabo.lebese@email.com', '0831234566', 'Silver', '2023-05-15'),
('Matshepo', 'Sebola', 'Matshepo.sebola@email.com', '0731234567', 'Bronze', '2023-06-15'),
('Nothando', 'Khumalo', 'Nthando.khumalo@email.com', '0731234568', 'Platinum', '2023-06-15');

-- Update customer signup dates
UPDATE S
SET S.SignupDate = '2025-09-17'
--SELECT * 
FROM Customers S
WHERE S.CustomerID in (1,2)

GO

SELECT * FROM Customers

GO

INSERT INTO Orders (CustomerID, BranchID, OrderDate, PaymentMethod) VALUES
(1, 1, '2023-07-01 10:30:00', 'Credit Card'),
(2, 2, '2023-07-02 11:00:00', 'Cash'),
(3, 3, '2023-07-03 12:15:00', 'Debit Card'),
(4, 4, '2023-07-04 13:45:00', 'Credit Card'),
(5, 5, '2023-07-05 14:30:00', 'Cash'),
(6, 6, '2023-07-06 15:00:00', 'Debit Card'),
(7, 7, '2023-07-07 16:20:00', 'Credit Card'),
(8, 8, '2023-07-08 17:10:00', 'Cash');

GO

UPDATE Orders
SET OrderDate = GETDATE()
WHERE CustomerID in (1,2,7);

GO

INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 4, 5, 3.50),
(1, 3, 2, 2.00),
(2, 1, 10, 1.50),
(2, 6, 3, 2.50),
(3, 2, 4, 8.00),
(3, 5, 1, 12.00),
(4, 7, 6, 4.00),
(4, 8, 2, 3.00);

GO

SELECT * FROM Suppliers;
SELECT * FROM Branches;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderItems;

GO

-- 1.4a What is the total revenue per branch?

SELECT b.BranchName, SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
FROM Branches b
JOIN Orders o ON b.BranchID = o.BranchID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
WHERE b.BranchName IS NOT NULL
GROUP BY b.BranchName
ORDER BY b.BranchName DESC

GO

-- 1.4b Which customers have not ordered in the last 90 days

SELECT 
    c.FirstName, c.LastName, c.ContactEmail,
    MAX(o.OrderDate) AS LastOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.ContactEmail
HAVING MAX(o.OrderDate) IS NULL OR MAX(o.OrderDate) < DATEADD(DAY, -90, GETDATE())
ORDER BY LastOrderDate;

GO

-- 1.5 Create a non-clustered index on a frequently-queried foreign key

CREATE NONCLUSTERED INDEX IX_Orders_CustomerID
ON Orders (CustomerID)
INCLUDE (OrderDate, BranchID);

GO

--OrderAudit table 
CREATE TABLE OrderAudit (
    AuditID INT IDENTITY(1,1)  PRIMARY KEY,
    OrderItemID INT,
    OrderID INT,
    ProductID INT,
    Quantity INT, 
    UnitPrice DECIMAL(10,2),
    ActionType NVARCHAR(20),
    ActionDate DATETIME DEFAULT GETDATE()
);

GO

-- Create a triiger that fires after an INSERT on OrderItems
CREATE TRIGGER trg_OrderItems_AfterInsert
ON OrderItems
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Rule: block negative quantites 
    IF EXISTS (SELECT 1 FROM inserted WHERE Quantity < 0)
    BEGIN
        RAISERROR('Quantity cannot be negative,', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Log the insert change:
    INSERT INTO OrderAudit (OrderItemID, OrderID, ProductID, Quantity, UnitPrice, ActionType)
    SELECT OrderItemID, OrderID, ProductID, Quantity, UnitPrice, 'INSERT'
    FROM inserted;
END;

GO

-- 1.6 Create a view that joins Orders. Customers, OrderItems and Products to produce a combined sales report.

IF OBJECT_ID('vw_SalesSummary', 'V') IS NOT NULL
    DROP VIEW vw_SalesSummary;

GO

CREATE VIEW vw_SalesSummary AS
SELECT CONCAT(FirstName, ' ', LastName) AS CustomerName, Products.ProductName, OrderItems.Quantity, (OrderItems.Quantity * OrderItems.UnitPrice) AS LineTotal
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN OrderItems ON Orders.OrderID = OrderItems.OrderID
JOIN Products ON OrderItems.ProductID = Products.ProductID

GO

SELECT * FROM vw_SalesSummary

GO

-- Alter database to include loyaltypoints as a column in customers table

ALTER TABLE Customers
ADD LoyaltyPoints INT NOT NULL DEFAULT 0;

GO

-- check if data is clean:

SELECT * FROM Orders WHERE CustomerID IS NULL;
SELECT * FROM OrderItems WHERE OrderID IS NULL;

GO

-- 1.7 Create a stored procedure that uses iteration to calculate and update loyalty points

CREATE PROCEDURE sp_UpdateLoyaltyPoints
AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @CustomerID INT;
    DECLARE @TotalSpend DECIMAL(18,2);
    DECLARE @Points INT;
    DECLARE @Tier NVARCHAR(20);

    -- Cursor to iterate through customers
    DECLARE customer_cursor CURSOR FOR
        SELECT 
              c.CustomerID,
              ISNULL(SUM(oi.Quantity * oi.UnitPrice), 0) AS TotalSpend,
              c.LoyaltyTier
        FROM Customers c
        LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
        LEFT JOIN OrderItems oi ON o.OrderID = oi.OrderID 
        GROUP BY c.CustomerID, c.LoyaltyTier;

    OPEN customer_cursor;

FETCH NEXT FROM customer_cursor INTO @CustomerID, @TotalSpend, @Tier;

WHILE @@FETCH_STATUS = 0
BEGIN 
    -- Calculate loyalty points based on spend and tier, higher tiers rewarded with steeper multiplier to encourage tier progression.

    SET @Points =
       CASE @Tier
           WHEN 'Bronze' THEN CAST(FLOOR(@TotalSpend / 10) * 2 AS INT)
           WHEN 'Silver' THEN CAST(FLOOR(@TotalSpend / 10) * 3 AS INT)
           WHEN 'Gold' THEN CAST(FLOOR(@TotalSpend / 10) * 5 AS INT)
           WHEN 'Platinum' THEN CAST(FLOOR(@TotalSpend / 10) * 8 AS INT)
           ELSE 0
        END;

    -- Update the customer's loyalty points
    UPDATE Customers 
    SET LoyaltyPoints = @Points
    WHERE CustomerID = @CustomerID;

    FETCH NEXT  FROM customer_cursor INTO @CustomerID, @TotalSpend, @Tier;
   END;

   CLOSE customer_cursor;
   DEALLOCATE customer_cursor;

   PRINT 'Loyalty points updated successfully for all customers';
END;

GO

-- I would like to execute the procedure to confirm it was successful:

EXEC sp_UpdateLoyaltyPoints;

GO

-- Confirmation that the actual data changed

USE KasiFreshGrocersDB

GO

SELECT CustomerID, FirstName, LastName, LoyaltyTier, LoyaltyPoints
FROM Customers
ORDER BY LoyaltyPoints DESC; 

GO 

-- =============================================================================
-- 1.8 Create DATABASE SECURITY AND TRY-CATCH ERROR HANDLING 
-- =============================================================================

-- Create SQL Login 
CREATE LOGIN ReportUser WITH PASSWORD = 'HappyNewYear@2026';

GO

-- Create the database user mapped to the login
CREATE USER ReportUser FOR LOGIN ReportUser;

GO

-- Grant SELECT only permissions on all tables and views
GRANT SELECT ON Suppliers TO ReportUser;
GRANT SELECT ON Branches TO ReportUser;
GRANT SELECT ON Products TO ReportUser;
GRANT SELECT ON Customers TO ReportUser;
GRANT SELECT ON Orders TO ReportUser;
GRANT SELECT ON OrderItems TO ReportUser;
GRANT SELECT ON vw_SalesSummary TO ReportUser;

GO

-- Stored procedure with TRY-CATCH error handling 
CREATE PROCEDURE sp_UpdateLoyaltyPointsWithErrorHandling
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CustomerID INT;
        DECLARE @TotalSpend DECIMAL(18, 2);
        DECLARE @Points INT;
        DECLARE @Tier NVARCHAR(20);
        DECLARE @ErrorMsg NVARCHAR(500);

    BEGIN TRY
        BEGIN TRANSACTION;

    -- Check if Customers table exists
    IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Customers')
    BEGIN 
        RAISERROR('Customers table does not exist. ', 16, 1);
    END;

    -- Cursor through customers 
    DECLARE customer_cursor CURSOR FOR
        SELECT
            c.CustomerID,
            ISNULL(SUM(oi.Quantity * oi.UnitPrice), 0) AS TotalSpend,
            c.LoyaltyTier
            FROM Customers c  
            LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
            LEFT JOIN OrderItems oi ON o.OrderID = oi.OrderID
            GROUP BY c.CustomerID, c.LoyaltyTier;

        OPEN customer_cursor;
        FETCH NEXT FROM customer_cursor INTO @CustomerID, @TotalSpend, @Tier

        WHILE @@FETCH_STATUS = 0 
        BEGIN
            -- Calculate points with tier-based multiplier
            SET @Points = 
                CASE @Tier
                     WHEN 'Bronze' THEN CAST(FLOOR(@TotalSpend / 10) * 2 AS INT)
                     WHEN 'Silver' THEN CAST(FLOOR(@TotalSpend / 10) * 3 AS INT)
                     WHEN 'Gold' THEN CAST(FLOOR(@TotalSpend / 10) * 5 AS INT)
                     WHEN 'Platinum' THEN CAST(FLOOR(@TotalSpend / 10) * 8 AS INT)
                     ELSE 0
                END;

            UPDATE Customers
            SET LoyaltyPoints = @Points
            WHERE CustomerID = @CustomerID;

            FETCH NEXT FROM customer_cursor INTO @CustomerID, @TotalSpend, @Tier;
        END;

        CLOSE customer_cursor;
        DEALLOCATE customer_cursor;

        COMMIT TRANSACTION;

        PRINT 'Loyalty Points updated successfully for all customers. ';
    END TRY
    BEGIN CATCH 
          -- Rollback transaction if error occurred
          IF @@TRANCOUNT > 0
          ROLLBACK TRANSACTION;

          -- Get error details
          SET @ErrorMsg =
          'Error ' + CAST(ERROR_NUMBER() AS NVARCHAR) +
          ' occurred at line ' + CAST(ERROR_LINE() AS NVARCHAR) +
          ': ' + ERROR_MESSAGE();

          -- Print meaningful error message 
          PRINT 'ERROR ' + @ErrorMsg;
          PRINT 'Stored procedure execution failed gracefully. ';
    END CATCH;
END;

GO 

-- ==============================================================================
-- VERIFY TRIGGER FUNCTIONALITIY 
-- ==============================================================================

-- Show OrderAudit before trigger test
SELECT * FROM OrderAudit

GO

-- Insert a new order to test the triiger 
INSERT INTO Orders (CustomerID, BranchID, OrderDate, PaymentMethod)
VALUES (1, 1, GETDATE(), 'Card');

GO

-- Insert order items to fire the trigger
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice)
VALUES
    (SCOPE_IDENTITY(), 1, 3, 25.00),
    (SCOPE_IDENTITY(), 3, 2, 32.00);

GO

-- Show OrderAudit after trigger test
SELECT * FROM OrderAudit;

GO

-- Show the new order items inserted 
SELECT * FROM OrderItems
WHERE OrderID = (SELECT MAX(OrderID) FROM Orders);

GO

-- Test trigger's negative quantity check (should fail gracefully)
BEGIN TRY
    INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice)
    VALUES ((SELECT MAX(OrderID) FROM Orders), 2, -5, 18.50);
    PRINT 'ERROR: Should not have inserted negative quantity!';
END TRY
BEGIN CATCH 
    PRINT 'SUCCESS: Trigger prevented negative quantity insert.';
    PRINT 'Error message: ' + ERROR_MESSAGE();
END CATCH;

GO

-- ============================================================================================
-- VERIFY INDEX CREATION
-- ============================================================================================

SELECT 
     i.name AS IndexName,
     OBJECT_NAME(i.object_id) AS TableName,
     i.type_desc AS IndexType,
     COL_NAME(ic.object_id, ic.column_id) AS ColumnName
FROM sys.indexes i 
INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
WHERE i.name = 'IX_Orders_CustomerID';

GO

-- ============================================================================================
-- VERIFY VIEW FUNCTIONALITY
-- ============================================================================================

SELECT TOP 10
    CustomerName,
    ProductName,
    Quantity,
    LineTotal
FROM vw_SalesSummary
ORDER BY LineTotal DESC;

GO

-- Get summary statistics from the view 
SELECT 
    COUNT(*) AS TotalLineItems,
    AVG(LineTotal) AS AverageLineTotal
FROM vw_SalesSummary;

GO

-- ============================================================================================
-- VERIFY QUERY A - TOTAL REVENUE PER BRANCH
-- ============================================================================================

SELECT 
    b.BranchName,
    b.Township,
    b.Province,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
FROM Branches b 
INNER JOIN Orders o ON b.BranchID = o.BranchID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY b.BranchName, b.Township, b.Province
ORDER BY TotalRevenue DESC;

GO

-- ============================================================================================
-- VERIFY QUERY B - CUSTOMERS NOT ORDERED IN LAST 90 DAYS
-- ============================================================================================

INSERT INTO Customers (FirstName, LastName, ContactEmail, ContactPhone, LoyaltyTier, SignupDate) VALUES
('No', 'Orders', 'no.orders@email.com', '0999999999', 'Bronze', '2026-08-01'),
('Inactive', 'Shopper', 'inactive.shopper@email.com', '0888888888', 'Silver', '2023-01-01');

GO

INSERT INTO Orders (CustomerID, BranchID, OrderDate, PaymentMethod)
VALUES (
    (SELECT CustomerID FROM Customers WHERE ContactEmail = 'inactive.shopper@email.com'),
    1, 
    DATEADD(DAY, -120, GETDATE()),
    'cash'
);

GO

SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.ContactEmail,
    c.ContactPhone,
    c.LoyaltyTier,
    c.SignupDate,
    MAX(o.OrderDate) AS LastOrderDate,
    DATEDIFF(DAY, MAX(o.OrderDate), GETDATE()) AS DaysSinceLastOrder
FROM Customers c 
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.ContactEmail, c.ContactPhone, c.LoyaltyTier, c.SignupDate
HAVING MAX(o.OrderDate) IS NULL OR DATEDIFF(DAY, MAX(o.OrderDate), GETDATE()) > 90
ORDER BY DaysSinceLastOrder DESC;

GO 

-- ===========================================================================================================================
-- VERIFY STORED PROCEDURE - LOYALTY POINTS
-- ===========================================================================================================================

-- Rest LoyaltyPoints to 0 so "before" Select is a genuine baseline to ensure the "after" SELECT demonstrates the procedure

UPDATE Customers
Set LoyaltyPoints = 0;

GO 

-- Show customers before loyalty points update
SELECT 
    CustomerID,
    FirstName + ' ' + LastName AS CustomerName,
    LoyaltyTier,
    LoyaltyPoints
FROM Customers
ORDER BY CustomerID;

GO

-- Execute the stored procedure 
EXEC sp_UpdateLoyaltyPoints;

GO

-- Show customers after loyalty points update
SELECT
    CustomerID,
    FirstName + ' ' + LastName AS CustomerName,
    LoyaltyTier,
    LoyaltyPoints
FROM Customers
ORDER BY CustomerID;

GO

-- ==============================================================================================
-- NEGATIVE TEST - TRIGGER THE CATCH BLOCK ON PURPOSE &
-- VERIFY STORED PROCEDURE WITH ERROR HANDLING 
-- ==============================================================================================

-- Step 1: Temporarily rename Customers to the procedure's own
-- existence check fails

EXECUTE sp_rename 'Customers', 'Customers_temp';

GO

-- Step 2: Run the procedure - this should hit RAISEROR, then CATCH, 
-- and print your custom error message instead of crashing
EXEC sp_UpdateLoyaltyPointsWithErrorHandling;

GO

-- Step 3: Rename it back immediately
EXEC sp_rename 'Customers_temp', 'Customers';

GO

-- Step 4: Confirm the table back and untouched

SELECT COUNT(*) AS CustomerCount FROM Customers;

GO

-- Execute the error-handling version 
EXEC sp_UpdateLoyaltyPointsWithErrorHandling;

GO

-- Verify results are consistent 
SELECT 
    CustomerID,
    FirstName + ' ' + LastName AS CustomerName,
    LoyaltyTier,
    LoyaltyPoints
FROM Customers
ORDER BY CustomerID;

GO  

-- =============================================================================================
-- VERIFY SECURITY PERMISSIONS
-- =============================================================================================

-- Show users and their permissions 
SELECT
    name AS UserName,
    type_desc AS UserType
FROM sys.database_principals
WHERE type IN ('S', 'U')
  AND name NOT IN ('dbo', 'guest', 'INFORMATION_SCHEMA', 'sys');

GO 

-- Show granted permission
SELECT 
    OBJECT_NAME(major_id) AS ObjectName,
    class_desc AS ObjectType,
    permission_name AS Permission 
FROM sys.database_permissions
WHERE grantee_principal_id = USER_ID('ReportUser')
ORDER BY ObjectName 

GO

-- Test SELECT access (should work)
EXECUTE AS USER = 'ReportUser';
SELECT TOP 5 * FROM vw_SalesSummary;
REVERT;
PRINT 'SELECT permisson working correctly';

GO

-- Test INSERT access (shoul fail)
BEGIN TRY 
    EXECUTE AS USER = 'ReportUser';
    INSERT INTO Customers (FirstName, LastName, ContactEmail, ContactPhone)
    VALUES ('Test', 'User', 'test@email.com', '0999999999');
    REVERT;
    PRINT 'ERROR: INSERT should have been denied!';
END TRY
BEGIN CATCH 
    REVERT;
    PRINT 'SUCCESS: INSERT permission denied as expected.';
    PRINT 'Error: ' + ERROR_MESSAGE();
END CATCH;

GO

-- Test EXECUTE permission on procedure (should fail)
BEGIN TRY
    EXECUTE AS USER = 'ReportUser';
    EXEC sp_UpdateLoyaltyPoints;
    REVERT;
    PRINT 'ERROR: execute should have been denied!';
END TRY
BEGIN CATCH
    REVERT;
    PRINT 'SUCCESS: EXECUTE permission denied as expected.';
    PRINT 'ERROR: ' + ERROR_MESSAGE();
END CATCH;

GO





































