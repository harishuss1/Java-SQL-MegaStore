--DROP TABLE AREA 
DROP TABLE Reviews;
DROP TABLE Project_Orders;
DROP TABLE Warehouse_Products;
DROP TABLE Stores;
DROP TABLE Warehouse;
DROP TABLE Products;
DROP TABLE Project_Customers;
DROP TABLE Cities;
DROP TABLE OrderAuditLog;
DROP TABLE LoginAuditLog;
DROP TABLE StockUpdateAuditLog;


-- DROP PROCEDURE AREA
DROP PROCEDURE GetTotalStockForProduct;
DROP PROCEDURE IsProductAvailable;
DROP PROCEDURE UpdateStockQuantity;
DROP PROCEDURE CheckFlaggedReviews;

-- ALTER TRIGGER AREA
ALTER TRIGGER OrderPlacedTrigger DISABLE;
ALTER TRIGGER StockUpdateTrigger DISABLE;

