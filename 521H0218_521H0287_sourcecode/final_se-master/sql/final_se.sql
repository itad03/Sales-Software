-- Create Employee table
CREATE TABLE Employee (
    EmployeeID VARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Address NVARCHAR(200) NOT NULL,
    Contact VARCHAR(20) NOT NULL,
    Password VARCHAR(50) NOT NULL
);

-- Create Supplier table
CREATE TABLE Supplier (
    SupplierID VARCHAR(50) PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    Address NVARCHAR(200) NOT NULL,
    Contact VARCHAR(20) NOT NULL
);

-- Create Product table
CREATE TABLE Product (
    ProductID VARCHAR(50) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price INT NOT NULL,
    Supplier VARCHAR(50) NOT NULL,
);

-- Create Inventory table
CREATE TABLE Inventory (
    ProductID VARCHAR(50) PRIMARY KEY,
    InStock INT NOT NULL,
    OnOrder INT NOT NULL,
    MinimumStockLevel INT NOT NULL,
    MaximumStockLevel INT NOT NULL,
	ImportPrice int
);

CREATE TABLE Agent (
  AgentID VARCHAR(50) PRIMARY KEY,
  AgentName VARCHAR(50) NOT NULL,
  Address VARCHAR(100) NOT NULL,
  Contact VARCHAR(50) NOT NULL,
  Password VARCHAR(50) NOT NULL
);

CREATE TABLE OrderTable (
    OrderID varchar(50) PRIMARY KEY,
    DateOrdered datetime NOT NULL,
    AgentID varchar(50) NOT NULL,
	Total decimal(10,2) NULL
);

CREATE TABLE OrderDetail (
    ID int IDENTITY(1,1) PRIMARY KEY,
    OrderID varchar(50) NOT NULL REFERENCES OrderTable(OrderID),
    ProductID varchar(50) NOT NULL,
    Quan int NOT NULL,
    Price decimal(10, 2) NOT NULL
);

CREATE TABLE ImportTable (
    ImportID varchar(20) NOT NULL,
    DateImport datetime NOT NULL,
    SupplierID varchar(20) NOT NULL,
	Total decimal(10,2) NOT NULL,
    PRIMARY KEY (ImportID)
);

-- Create ImportDetailTable
CREATE TABLE ImportDetailTable (
    ImportID varchar(20) NOT NULL,
    ProductID varchar(20) NOT NULL,
    Quantity int NOT NULL,
    Price decimal(10,2) NOT NULL,
);

CREATE TABLE Delivery (
    deliveryID INT IDENTITY(1,1) PRIMARY KEY,
	AgentID varchar(50) NOT NULL,
    OrderID varchar(50) NOT NULL,
    paymentStatus VARCHAR(20),
    deliverStatus VARCHAR(20)
);
GO

-- tự động tạo đơn delivery
CREATE TRIGGER InsertDelivery
ON OrderTable
AFTER INSERT
AS
BEGIN
    INSERT INTO Delivery (AgentID, OrderID, paymentStatus, deliverStatus)
    SELECT i.AgentID, i.OrderID, 'unpaid', 'preparing'
    FROM inserted i
END

GO
-- cập nhật lại số lượng trong kho
CREATE TRIGGER UpdateInventory
ON OrderDetail
AFTER INSERT
AS
BEGIN
    UPDATE Inventory
    SET InStock = InStock - i.Quan, 
        OnOrder = OnOrder + i.Quan
    FROM Inventory
    INNER JOIN inserted i
        ON Inventory.ProductID = i.ProductID
END


GO
INSERT INTO Product(ProductID, ProductName, Price, Supplier)
VALUES
  ('P1', 'iPhone 13 Pro Max', 2299, 'Apple'),
  ('P2', 'Samsung Galaxy S21 Ultra', 1199, 'Samsung'),
  ('P3', 'Google Pixel 6 Pro', 1099, 'Google'),
  ('P4', 'OnePlus 10 Pro', 999, 'OnePlus'),
  ('P5', 'Xiaomi Mi 12', 899, 'Xiaomi'),
  ('P6', 'Oppo Find X3 Pro', 1299, 'Oppo'),
  ('P7', 'Sony Xperia 1 III', 1399, 'Sony'),
  ('P8', 'Asus ROG Phone 5', 999, 'Asus');

GO
INSERT INTO Supplier(SupplierID, SupplierName, Address, Contact)
VALUES
  ('S1', 'Apple', 'Cupertino, CA', '1-800-275-2273'),
  ('S2', 'Samsung', 'Seoul, South Korea', '82-2-2053-3000'),
  ('S3', 'Google', 'Mountain View, CA', '1-650-253-0000'),
  ('S4', 'OnePlus', 'Shenzhen, China', '+86 755-2533-8888'),
  ('S5', 'Xiaomi', 'Beijing, China', '+86 10-6060-6666'),
  ('S6', 'Oppo', 'Dongguan, China', '+86 769-8505-8888'),
  ('S7', 'Sony', 'Tokyo, Japan', '+81 3-6748-2111'),
  ('S8', 'Asus', 'Taipei, Taiwan', '+886 2-2894-3447');

GO
INSERT INTO Inventory(ProductID, InStock, OnOrder, MinimumStockLevel, MaximumStockLevel, ImportPrice)
VALUES
  ('P1', 100, 50, 20, 200, 1500),
  ('P2', 150, 20, 30, 300, 1000),
  ('P3', 75, 10, 15, 150, 900),
  ('P4', 200, 30, 25, 250, 800),
  ('P5', 120, 15, 20, 180, 700),
  ('P6', 80, 25, 10, 100, 1100),
  ('P7', 90, 5, 10, 120, 1200),
  ('P8', 50, 10, 5, 75, 950);
