use shop;

-- Table "Clients"
CREATE TABLE Clients (
    ClientID INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber NVARCHAR(15),
    Password NVARCHAR(255) NOT NULL,
    Address NVARCHAR(200)
);


-- Table "Categories"
CREATE TABLE Categories (
    CategoryID INTEGER PRIMARY KEY AUTOINCREMENT,
    CategoryName NVARCHAR(100) NOT NULL
);

-- Table "Products"
CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY AUTOINCREMENT,
    CategoryID INTEGER,
    ProductName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(1000),
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);


-- Table "Orders"
-- Table "Orders"
CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY AUTOINCREMENT,
    ClientID INTEGER,
    OrderDate DATETIME NOT NULL,
    OrderAmount DECIMAL(10, 2), -- denormalized attribute
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

-- Table "OrderedProducts"
CREATE TABLE OrderedProducts (
    OrderID INTEGER,
    ProductID INTEGER,
    Quantity INT NOT NULL,
    TotalCost DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Table "Reviews"
CREATE TABLE Reviews (
    ReviewID INTEGER PRIMARY KEY AUTOINCREMENT,
    ProductID INTEGER,
    ClientID INTEGER,
    ReviewText NVARCHAR(1000) NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

-- Table "Suppliers"
CREATE TABLE Suppliers (
    SupplierID INTEGER PRIMARY KEY AUTOINCREMENT,
    SupplierName NVARCHAR(100) NOT NULL,
    ContactPerson NVARCHAR(50),
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber NVARCHAR(15),
    Address NVARCHAR(200)
);

-- Table "PurchaseOrders" Заказы на закупку
CREATE TABLE PurchaseOrders (
    PurchaseOrderID INTEGER PRIMARY KEY AUTOINCREMENT,
    SupplierID INTEGER,
    OrderDate DATETIME NOT NULL,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Table "OrderedProducts_Purchase" Заказанные продукты для закупки
CREATE TABLE OrderedProducts_Purchase (
    PurchaseOrderID INTEGER,
    ProductID INTEGER,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (PurchaseOrderID, ProductID),
    FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrders(PurchaseOrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


SELECT name AS table_name
FROM sys.tables
ORDER BY name;

select * from Clients;

-- общую стоимость всех заказанных продуктов клиента:
CREATE FUNCTION TotalSpentByClient (@ClientID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN (
        SELECT SUM(TotalCost)
        FROM OrderedProducts
        JOIN Orders ON OrderedProducts.OrderID = Orders.OrderID
        WHERE Orders.ClientID = @ClientID
    )
END;


SELECT dbo.TotalSpentByClient(1);

-- Процедура добавления нового заказа:
CREATE PROCEDURE AddNewOrder @ClientID INT, @OrderDate DATETIME, @OrderAmount DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Orders (ClientID, OrderDate, OrderAmount)
    VALUES (@ClientID, @OrderDate, @OrderAmount)
END;

EXEC AddNewOrder @ClientID = 1, @OrderDate = '2022-01-05', @OrderAmount = 5000.00;
select * from Orders;


-- Представление, отображающее всех клиентов и количество их заказов:
CREATE VIEW ClientsWithOrderCounts AS
SELECT 
    Clients.ClientID, 
    Clients.FirstName, 
    Clients.LastName, 
    COUNT(Orders.OrderID) AS OrderCount
FROM Clients
LEFT JOIN Orders ON Clients.ClientID = Orders.ClientID
GROUP BY Clients.ClientID, Clients.FirstName, Clients.LastName;

SELECT * FROM ClientsWithOrderCounts;


CREATE INDEX idx_Clients_Email ON Clients (Email);
CREATE INDEX idx_Categories_CategoryName ON Categories (CategoryName);
CREATE INDEX idx_Products_CategoryID ON Products (CategoryID);
CREATE INDEX idx_Orders_ClientID ON Orders (ClientID);
CREATE INDEX idx_OrderedProducts_OrderID ON OrderedProducts (OrderID);
CREATE INDEX idx_OrderedProducts_ProductID ON OrderedProducts (ProductID);
CREATE INDEX idx_Reviews_ProductID ON Reviews (ProductID);
CREATE INDEX idx_Reviews_ClientID ON Reviews (ClientID);


CREATE INDEX idx_low_stock_products 
ON Products(ProductID) 
WHERE StockQuantity < 10;

CREATE INDEX idx_product_reviews_rating 
ON Reviews(ProductID, Rating);



drop table OrderedProducts;
drop table Reviews;
drop table Orders;
drop table Clients;
drop table Products;
drop table Categories;

-- Заполнение таблицы "Clients"
INSERT INTO Clients (FirstName, LastName, Email, PhoneNumber, Password, Address)
VALUES 
('Ivan', 'Ivanov', 'ivan@example.com', '+79991112233', 'encryptedpass1', '123 Main St.'),
('Anna', 'Petrova', 'anna@example.com', '+79994445566', 'encryptedpass2', '456 Elm St.'),
('Elena', 'Sidorova', 'elena@example.com', '+79997778899', 'encryptedpass3', '789 Pine St.');
truncate table Clients;

-- Заполнение таблицы "Categories"
INSERT INTO Categories (CategoryName)
VALUES 
('Sedans'),
('SUVs'),
('Convertibles');
truncate table Categories;

-- Заполнение таблицы "Products"
INSERT INTO Products (CategoryID, ProductName, Description, Price, StockQuantity)
VALUES 
(1, 'Sedan A', 'Comfortable 4-door car', 20000.00, 10),
(2, 'SUV B', 'Off-road capable vehicle', 30000.00, 5),
(3, 'Convertible C', 'Stylish 2-door car', 25000.00, 3);
truncate table Products;

-- Заполнение таблицы "Orders"
INSERT INTO Orders (ClientID, OrderDate, OrderAmount)
VALUES 
(1, '2022-01-01', 20000.00),
(2, '2022-01-05', 55000.00),
(3, '2022-01-10', 75000.00)
truncate table Orders;
select * from Clients

INSERT INTO Orders (ClientID, OrderDate, OrderAmount)
VALUES 
(1, '2021-02-12', 62000.00),
(2, '2021-05-02', 83000.00),
(3, '2021-08-05', 91000.00),
(3, '2023-11-12', 47000.00),
(2, '2023-03-05', 81000.00),
(1, '2023-06-08', 64000.00),
(1, '2023-09-07', 70000.00);

-- Заполнение таблицы "OrderedProducts"
INSERT INTO OrderedProducts (OrderID, ProductID, Quantity, TotalCost)
VALUES 
(1, 1, 1, 20000.00),
(2, 2, 1, 30000.00),
(2, 3, 1, 25000.00),
(3, 3, 3, 75000.00);
truncate table OrderedProducts;

-- Заполнение таблицы "Reviews"
INSERT INTO Reviews (ProductID, ClientID, ReviewText, Rating)
VALUES 
(1, 1, 'Great car!', 5),
(2, 2, 'Could be better in off-road situations', 3),
(3, 3, 'Stylish but not very practical', 4);
truncate table Reviews;

-- Заполнение таблицы "Suppliers"
INSERT INTO Suppliers (SupplierName, ContactPerson, Email, PhoneNumber, Address)
VALUES 
('Supplier 1', 'Contact Person 1', 'supplier1@example.com', '+79998887766', '123 Supplier St.'),
('Supplier 2', 'Contact Person 2', 'supplier2@example.com', '+79997776655', '456 Supplier St.'),
('Supplier 3', 'Contact Person 3', 'supplier3@example.com', '+79996665544', '789 Supplier St.');
truncate table Suppliers;

-- Заполнение таблицы "PurchaseOrders"
INSERT INTO PurchaseOrders (SupplierID, OrderDate, TotalAmount)
VALUES 
(1, '2022-01-15', 45000.00),
(2, '2022-02-01', 60000.00),
(3, '2022-02-15', 75000.00);
truncate table PurchaseOrders;

-- Заполнение таблицы "OrderedProducts_Purchase"
INSERT INTO OrderedProducts_Purchase (PurchaseOrderID, ProductID, Quantity, UnitPrice)
VALUES 
(1, 1, 5, 200.00),
(2, 2, 3, 300.00),
(2, 3, 2, 250.00),
(3, 3, 4, 200.00);
truncate table OrderedProducts_Purchase;

select * from OrderedProducts_Purchase;
-- 6-4
-- Обновление данных в подчиненной таблице
-- Update existing data
BEGIN TRANSACTION;

UPDATE OrderedProducts_Purchase SET Quantity = 4 WHERE PurchaseOrderID = 1 AND ProductID = 1;

-- запускать отдельно с commit
COMMIT;

-- Добавление данных в подчиненную таблицу
BEGIN TRANSACTION;

INSERT INTO OrderedProducts_Purchase (PurchaseOrderID, ProductID, Quantity, UnitPrice)
VALUES (2, 1, 4, 180.00);

COMMIT;

-- Удаление данных из подчиненной таблицы
BEGIN TRANSACTION;

DELETE FROM OrderedProducts_Purchase WHERE PurchaseOrderID = 2;

COMMIT;


-- 6-6
-- Создание представления
CREATE VIEW OrderDetails AS
SELECT 
    OP.PurchaseOrderID,
    OP.ProductID,
    OP.Quantity,
    OP.UnitPrice,
    P.ProductName,
    S.SupplierName
FROM OrderedProducts_Purchase OP
JOIN Products P ON OP.ProductID = P.ProductID
JOIN PurchaseOrders PO ON OP.PurchaseOrderID = PO.PurchaseOrderID
JOIN Suppliers S ON PO.SupplierID = S.SupplierID;
select * from OrderDetails;


-- 6-7
-- Пример создания индексов
CREATE INDEX idx_OrderedProducts_Purchase_PurchaseOrderID ON OrderedProducts_Purchase(PurchaseOrderID);
CREATE INDEX idx_OrderedProducts_Purchase_ProductID ON OrderedProducts_Purchase(ProductID);



-- 6-8
-- Пример создания триггера
CREATE TRIGGER trg_AfterOrderUpdate
AFTER UPDATE ON Orders
BEGIN
    UPDATE OrderedProducts_Purchase
    SET UnitPrice = UnitPrice * 1.1 -- увеличение цены на 10%
    WHERE PurchaseOrderID = NEW.OrderID; -- исправлено на OrderID
END;

drop trigger trg_AfterOrderUpdate;

-- 6-9
-- Пример использования представления в запросе
SELECT * FROM OrderDetails;

UPDATE Orders SET OrderAmount = OrderAmount + 200 WHERE OrderID = 1;


select * from OrderedProducts_Purchase;







SELECT
    t.name AS TableName,
    c.name AS ColumnName,
    tp.name AS DataType,
    c.max_length AS MaxLength,
    c.precision,
    c.scale,
    c.is_nullable,
    ISNULL(ep.value, '') AS Description
FROM 
    sys.columns c
INNER JOIN 
    sys.types tp ON c.system_type_id = tp.system_type_id
LEFT JOIN 
    sys.extended_properties ep ON ep.major_id = c.object_id AND ep.minor_id = c.column_id AND ep.name = 'MS_Description'
INNER JOIN
    sys.tables t ON c.object_id = t.object_id
ORDER BY 
    t.name, c.column_id;


SELECT 
    t.name AS TableName,
    c.name AS ColumnName,
    con.name AS ConstraintName,
    con.type_desc AS ConstraintType
FROM 
    sys.tables t
INNER JOIN 
    sys.all_columns c ON c.object_id = t.object_id
LEFT JOIN 
    sys.check_constraints con ON con.parent_object_id = t.object_id AND con.parent_column_id = c.column_id
WHERE 
    con.name IS NOT NULL
ORDER BY 
    t.name, c.column_id;


SELECT 
    o.type_desc AS ObjectType,
    o.name AS ObjectName,
    ISNULL(ep.value, '') AS Description,
    OBJECT_DEFINITION(o.object_id) AS ObjectDefinition
FROM 
    sys.objects o
LEFT JOIN 
    sys.extended_properties ep ON ep.major_id = o.object_id AND ep.minor_id = 0 AND ep.name = 'MS_Description'
WHERE 
    o.type IN ('P', 'FN', 'TF', 'IF') -- P=Procedure, FN=SQL scalar function, TF=SQL table-valued-function, IF=SQL inline table-valued function

SELECT 
    'INDEX' AS ObjectType,
    i.name AS IndexName,
    t.name AS TableName,
    COLUMNS = STRING_AGG(c.name, ', ')
FROM 
    sys.indexes i
JOIN 
    sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN 
    sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
JOIN 
    sys.tables t ON i.object_id = t.object_id
WHERE 
    i.type > 0 -- 0 = Heap, which is not an index
GROUP BY 
    i.name, t.name

SELECT 
    'VIEW' AS ObjectType,
    v.name AS ViewName,
    ISNULL(ep.value, '') AS Description,
    OBJECT_DEFINITION(v.object_id) AS ViewDefinition
FROM 
    sys.views v
LEFT JOIN 
    sys.extended_properties ep ON ep.major_id = v.object_id AND ep.minor_id = 0 AND ep.name = 'MS_Description'




-- 3.1 
-- Adding a hierarchical type column 
ALTER TABLE Categories
add nodee hierarchyid,
LEVELL as nodee.GetLevel() persisted;
-- Adding data in Categories
INSERT INTO Categories VALUES
	('SUVs', hierarchyid::GetRoot()),
	('Convertibles', hierarchyid::GetRoot());
go

-- Define parent node
DECLARE @ParentNodePath hierarchyid;
SET @ParentNodePath = hierarchyid::Parse('/');

DECLARE @NewNodePath hierarchyid;
-- Beginning and ending scopes (диапазоны) (NULL means to use next available) 
SET @NewNodePath = @ParentNodePath.GetDescendant (NULL, NULL);

INSERT INTO Categories VALUES ('Universal', @NewNodePath); 
go
select * from Categories;

-- 3.2
CREATE PROCEDURE DisplayNodes
    @NodePath hierarchyid
AS
BEGIN
    SELECT
        CategoryID,
        CategoryName,
        nodee.ToString() AS NodePath,
        nodee.GetLevel() AS NodeLevel
    FROM
        Categories 
    WHERE
        nodee.IsDescendantOf(@NodePath) = 1
    ORDER BY nodee;
END;


drop procedure DisplayNodes
go


DECLARE @NodePath hierarchyid;
SET @NodePath = hierarchyid::Parse('/');

EXEC DisplayNodes @NodePath;
go

-- 3.3
CREATE PROCEDURE AddNode
    @ParentNodePath hierarchyid, 
    @NewNodeName NVARCHAR(100)
AS
BEGIN

    DECLARE @LastChild hierarchyid;
    
    -- Get the last child node under the parent
    SELECT TOP 1 @LastChild = nodee
    FROM Categories
    WHERE nodee.GetAncestor(1) = @ParentNodePath
    ORDER BY nodee DESC;

    DECLARE @NewNodePath hierarchyid;
    -- Use the last child as the first parameter to GetDescendant
    SET @NewNodePath = @ParentNodePath.GetDescendant(@LastChild, NULL);

    INSERT INTO Categories (CategoryName, nodee)
    VALUES (@NewNodeName, @NewNodePath);
END;


drop procedure AddNode
go

DECLARE @ParentNodePath hierarchyid;
SET @ParentNodePath = hierarchyid::Parse('/'); 

EXEC AddNode @ParentNodePath, 'Hatchback6';
go

-- 3.4
CREATE PROCEDURE TransportNode
    @SourceNodePath hierarchyid,
    @DestinationNodePath hierarchyid
AS
BEGIN
    
    UPDATE Categories
    SET nodee = nodee.GetReparentedValue(@SourceNodePath, @DestinationNodePath)
    WHERE nodee.IsDescendantOf(@SourceNodePath) = 1;
END;
go

DECLARE @SourceNodePath hierarchyid;
SET @SourceNodePath = hierarchyid::Parse('/2/1/'); 

DECLARE @DestinationNodePath hierarchyid;
SET @DestinationNodePath = hierarchyid::Parse('/3/1/'); 

EXEC TransportNode @SourceNodePath, @DestinationNodePath;








select * from Orders; 
-- 4.1
-- quarter = 12/4=3 month, if jan-may - 1, apr-june - 2, july-sept - 3, oct-dec - 4 
-- Common Table Expression (CTE) DateMetrics - breaks down order dates into year, month, quarter, and half-year components
WITH DateMetrics AS (
    SELECT
        OrderID,
        OrderAmount,
        DATEPART(YEAR, OrderDate) AS SaleYear,
        DATEPART(MONTH, OrderDate) AS SaleMonth,
        DATEPART(QUARTER, OrderDate) AS SaleQuarter,
		-- to define wich first or second half a year
        CASE 
            WHEN DATEPART(MONTH, OrderDate) <= 6 THEN 1
            ELSE 2
        END AS SaleHalfYear
    FROM Orders
)

-- The main SELECT then aggregates sales data for each month and provides the results for monthly, quarterly, half-yearly, and yearly metrics.
SELECT
    SaleYear,
    SaleMonth,
    SUM(OrderAmount) AS MonthlySales,
    SUM(CASE WHEN SaleQuarter = 1 THEN OrderAmount ELSE 0 END) AS Q1Sales,
    SUM(CASE WHEN SaleQuarter = 2 THEN OrderAmount ELSE 0 END) AS Q2Sales,
    SUM(CASE WHEN SaleQuarter = 3 THEN OrderAmount ELSE 0 END) AS Q3Sales,
    SUM(CASE WHEN SaleQuarter = 4 THEN OrderAmount ELSE 0 END) AS Q4Sales,
    SUM(CASE WHEN SaleHalfYear = 1 THEN OrderAmount ELSE 0 END) AS H1Sales,
    SUM(CASE WHEN SaleHalfYear = 2 THEN OrderAmount ELSE 0 END) AS H2Sales,
    SUM(OrderAmount) AS YearlySales
FROM DateMetrics
GROUP BY SaleYear, SaleMonth
ORDER BY SaleYear, SaleMonth;



-- 4.2
select * from OrderedProducts;
WITH SalesSummary AS (
    SELECT
        o.ClientID,
        SUM(op.TotalCost) AS TotalSales
    FROM Orders o
    JOIN OrderedProducts op ON o.OrderID = op.OrderID
    GROUP BY o.ClientID
),

TotalSales AS (
    SELECT SUM(TotalSales) AS GrandTotalSales FROM SalesSummary
),

MaxSales AS (
    SELECT MAX(TotalSales) AS BestSales FROM SalesSummary
)

SELECT
    c.ClientID,
    c.FirstName + ' ' + c.LastName AS SalesmanName,
    ss.TotalSales,	
    (ss.TotalSales / ts.GrandTotalSales * 100) AS SalesPercentageOfTotal, -- every client sales / total sales
    (ss.TotalSales / ms.BestSales * 100) AS SalesPercentageOfBest -- every client sales / only the client with max sales
FROM SalesSummary ss
JOIN Clients c ON ss.ClientID = c.ClientID
CROSS JOIN TotalSales ts
CROSS JOIN MaxSales ms
ORDER BY ss.TotalSales DESC;













