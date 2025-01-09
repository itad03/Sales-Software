SELECT Product.ProductID ,ProductName,Price, Supplier,InStock,OnOrder,MinimumStockLevel,MaximumStockLevel
FROM Product
INNER JOIN Inventory
ON Product.ProductID = Inventory.ProductID
WHERE Product.ProductID = Inventory.ProductID

SELECT * FROM Employee
SELECT * FROM Product
SELECT * FROM Inventory
SELECT * FROM Supplier
SELECT * FROM Agent
SELECT * FROM OrderTable
SELECT * FROM OrderDetail
SELECT * FROM ImportTable
SELECT * FROM ImportDetailTable
SELECT * FROM Delivery

SELECT Delivery.deliveryID, Delivery.paymentStatus, Delivery.deliverStatus,
OrderTable.OrderID, OrderTable.DateOrdered, OrderTable.AgentID, OrderTable.Total 
FROM Delivery 
INNER JOIN OrderTable 
ON Delivery.OrderID = OrderTable.OrderID;


SELECT Product.ProductID ,ProductName,Price,Inventory.ImportPrice, Supplier,InStock,OnOrder,MinimumStockLevel,MaximumStockLevel FROM Product 
INNER JOIN Inventory ON Product.ProductID = Inventory.ProductID 
                WHERE Product.ProductID = 'P1'