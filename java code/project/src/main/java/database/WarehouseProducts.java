package database;

import java.sql.*;
import java.util.Map;
import java.util.Scanner;

public class WarehouseProducts implements SQLData {
    private int warehouse_id;
    private int product_id;
    private int total_quantity;
    private String typeName;

    public WarehouseProducts(int warehouse_id, int product_id, int total_quantity) {
        this.warehouse_id = warehouse_id;
        this.product_id = product_id;
        this.total_quantity = total_quantity;
        this.typeName = "WAREHOUSE_PRODUCTS_TYP";
    }

    public void setWarehouse_id(int warehouse_id) {
        this.warehouse_id = warehouse_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public void setTotal_quantity(int total_quantity) {
        this.total_quantity = total_quantity;
    }

    public int getWarehouse_id() {
        return warehouse_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public int getTotal_quantity() {
        return total_quantity;
    }

    public String getTypeName() {
        return typeName;
    }

    @Override
    public String getSQLTypeName() throws SQLException {
        return typeName;
    }

    @Override
    public void readSQL(SQLInput stream, String typeName) throws SQLException {
        setWarehouse_id(stream.readInt());
        setProduct_id(stream.readInt());
        setTotal_quantity(stream.readInt());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getWarehouse_id());
        stream.writeInt(getProduct_id());
        stream.writeInt(getTotal_quantity());
    }

    // ADD TO DATABASE METHOD
    public void AddToDatabase(Connection conn) throws SQLException, ClassNotFoundException {
        Map map = conn.getTypeMap();
        conn.setTypeMap(map);
        WarehouseProducts myWarehouseProducts = new WarehouseProducts(this.warehouse_id, this.product_id,
                this.total_quantity);
        String sql = "{call insert_data.add_warehouse_product(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setObject(1, myWarehouseProducts);
            stmt.execute();
        }
    }

    public static WarehouseProducts collectWarehouseProductInformation(Connection conn) {
        System.out.println("\nAdding Warehouse Product:");
        int warehouseID = Helpers.getUserInputInt("Enter warehouse ID: ");
        int productID = Helpers.getUserInputInt("Enter product ID: ");
        int totalQuantity = Helpers.getUserInputInt("Enter total quantity: ");

        return new WarehouseProducts(warehouseID, productID, totalQuantity);
    }

}
