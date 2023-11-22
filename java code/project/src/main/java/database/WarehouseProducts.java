package database;

import java.sql.*;
import java.util.Map;
import java.util.Scanner;

/**
 * The WarehouseProducts class represents information about products stored in a warehouse.
 * @class
 */
public class WarehouseProducts implements SQLData {
    private int warehouse_id;
    private int product_id;
    private int total_quantity;
    private String typeName;

    /**
     * Creates an instance of WarehouseProducts with the specified information.
     * @constructor
     * @param {int} warehouse_id - The ID of the warehouse.
     * @param {int} product_id - The ID of the product.
     * @param {int} total_quantity - The total quantity of the product in the warehouse.
     */
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

    /**
     * Reads the SQL data into the WarehouseProducts object.
     * @function
     * @param {SQLInput} stream - The SQL input stream.
     * @param {string} typeName - The SQL type name.
     * @throws {SQLException}
     */
    @Override
    public void readSQL(SQLInput stream, String typeName) throws SQLException {
        setWarehouse_id(stream.readInt());
        setProduct_id(stream.readInt());
        setTotal_quantity(stream.readInt());
    }

    /**
     * Writes the WarehouseProducts object to the SQL output stream.
     * @function
     * @param {SQLOutput} stream - The SQL output stream.
     * @throws {SQLException}
     */
    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getWarehouse_id());
        stream.writeInt(getProduct_id());
        stream.writeInt(getTotal_quantity());
    }

    /**
     * Adds the warehouse product information to the database.
     * @function
     * @param {Connection} conn - The database connection.
     * @throws {SQLException}
     * @throws {ClassNotFoundException}
     */
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

    /**
     * Collects warehouse product information from the user.
     * @function
     * @param {Connection} conn - The database connection.
     * @returns {WarehouseProducts} - The WarehouseProducts object with user-provided information.
     */
    public static WarehouseProducts collectWarehouseProductInformation(Connection conn) {
        System.out.println("\nAdding Warehouse Product:");
        int warehouseID = Helpers.getUserInputInt("Enter warehouse ID: ");
        int productID = Helpers.getUserInputInt("Enter product ID: ");
        int totalQuantity = Helpers.getUserInputInt("Enter total quantity: ");

        return new WarehouseProducts(warehouseID, productID, totalQuantity);
    }

}
