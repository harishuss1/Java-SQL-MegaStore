package database;

import java.sql.*;
import java.util.Map;
import java.util.Scanner;

import oracle.jdbc.OracleTypes;

/**
 * The Orders class represents order information and provides methods for interacting with orders in the database.
 * @class
 * @implements {SQLData}
 */
public class Orders implements SQLData {
    private int order_quantity;
    private Date order_date;
    private int store_id;
    private int customer_id;
    private int product_id;
    private String typeName;

    /**
     * Creates an instance of the Orders class.
     * @constructor
     * @param {number} order_quantity - The quantity of the order.
     * @param {Date} order_date - The date of the order.
     * @param {number} store_id - The store ID associated with the order.
     * @param {number} customer_id - The customer ID associated with the order.
     * @param {number} product_id - The product ID associated with the order.
     */
    public Orders(int order_quantity, Date order_date, int store_id, int customer_id, int product_id) {
        this.order_quantity = order_quantity;
        this.order_date = order_date;
        this.store_id = store_id;
        this.customer_id = customer_id;
        this.product_id = product_id;
        this.typeName = "PROJECT_ORDERS_TYP";
    }


    public void setOrder_quantity(int order_quantity) {
        this.order_quantity = order_quantity;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public void setStore_id(int store_id) {
        this.store_id = store_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getOrder_quantity() {
        return order_quantity;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public int getStore_id() {
        return store_id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public String getTypeName() {
        return typeName;
    }

    @Override
    public String getSQLTypeName() throws SQLException {
        return typeName;
    }

    /**
     * Reads SQL data from a stream and sets the properties of the Orders instance.
     * @override
     * @param {SQLInput} stream - The SQL input stream.
     * @param {string} typeName - The SQL type name.
     * @throws {SQLException}
     */
    @Override
    public void readSQL(SQLInput stream, String typeName) throws SQLException {
        setOrder_quantity(stream.readInt());
        setOrder_date(stream.readDate());
        setStore_id(stream.readInt());
        setCustomer_id(stream.readInt());
        setProduct_id(stream.readInt());
    }

    /**
     * Writes SQL data to a stream based on the properties of the Orders instance.
     * @override
     * @param {SQLOutput} stream - The SQL output stream.
     * @throws {SQLException}
     */
    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getOrder_quantity());
        stream.writeDate(getOrder_date());
        stream.writeInt(getStore_id());
        stream.writeInt(getCustomer_id());
        stream.writeInt(getProduct_id());
    }

    /**
     * Adds order information to the database.
     * @param {Connection} conn - The database connection.
     * @throws {SQLException, ClassNotFoundException}
     */
    public void AddToDatabase(Connection conn) throws SQLException, ClassNotFoundException {
        Map map = conn.getTypeMap();
        conn.setTypeMap(map);
        map.put(this.typeName, Class.forName("database.Orders"));
        Orders myOrders = new Orders(this.order_quantity, this.order_date, this.store_id,
                this.customer_id, this.product_id);
        String sql = "{call insert_data.add_order(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setObject(1, myOrders);
            stmt.execute();
        }
    }

    /**
     * Collects order information from the user.
     * @param {Connection} conn - The database connection.
     * @returns {Orders} The Orders instance with user-provided information.
     */
    public static Orders collectOrderInformation(Connection conn) {
        Scanner scanner = new Scanner(System.in);

        int orderQuantity = Helpers.getUserInputInt("Enter order quantity: ");
        // You can add validation for date input as needed
        System.out.println("Enter order date (yyyy-mm-dd): ");
        String orderDateInput = scanner.nextLine();
        Date orderDate = Date.valueOf(orderDateInput);

        int storeId = Helpers.getUserInputInt("Enter store ID: ");
        int customerId = Helpers.getUserInputInt("Enter customer ID: ");
        int productId = Helpers.getUserInputInt("Enter product ID: ");

        return new Orders(orderQuantity, orderDate, storeId, customerId, productId);
    }

    /**
     * Displays order information from the database.
     * @param {Connection} connection - The database connection.
     */
    public static void displayOrder(Connection connection) {
        try (CallableStatement stmt = connection.prepareCall("{call delete_data.display_order(?)}")) {
            stmt.registerOutParameter(1, OracleTypes.CURSOR);
            stmt.execute();

            ResultSet rs = (ResultSet) stmt.getObject(1);

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                int orderQuantity = rs.getInt("order_quantity");
                Date orderDate = rs.getDate("order_date");
                int storeId = rs.getInt("store_id");
                int customerId = rs.getInt("customer_id");
                int productId = rs.getInt("product_id");

                System.out.println("Order ID: " + orderId);
                System.out.println("Order Quantity: " + orderQuantity);
                System.out.println("Order Date: " + orderDate);
                System.out.println("Store ID: " + storeId);
                System.out.println("Customer ID: " + customerId);
                System.out.println("Product ID: " + productId);
                System.out.println("------------------------");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
