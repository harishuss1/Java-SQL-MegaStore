package database;

import java.sql.*;
import java.util.Map;
import java.util.Scanner;

/**
 * The Product class represents product information and provides methods for interacting with products in the database.
 * @class
 * @implements {SQLData}
 */
public class Product implements SQLData {
    private String product_name;
    private double product_price;
    private String product_category;
    private String typeName;

    /**
     * Creates an instance of the Product class.
     * @constructor
     * @param {string} product_name - The name of the product.
     * @param {number} product_price - The price of the product.
     * @param {string} product_category - The category of the product.
     */
    public Product(String product_name, double product_price, String product_category) {
        this.product_name = product_name;
        this.product_price = product_price;
        this.product_category = product_category;
        this.typeName = "PRODUCT_TYP";
    }

    public void setProduct_category(String product_category) {
        this.product_category = product_category;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public void setProduct_price(double product_price) {
        this.product_price = product_price;
    }

    public String getProduct_category() {
        return product_category;
    }

    public String getProduct_name() {
        return product_name;
    }

    public double getProduct_price() {
        return product_price;
    }

    public String getTypeName() {
        return typeName;
    }

    @Override
    public String getSQLTypeName() throws SQLException {
        return typeName;
    }

   /**
     * Reads SQL data from a stream and sets the properties of the Product instance.
     * @override
     * @param {SQLInput} stream - The SQL input stream.
     * @param {string} typeName - The SQL type name.
     * @throws {SQLException}
     */
    @Override
    public void readSQL(SQLInput stream, String typeName) throws SQLException {
        this.product_name = stream.readString();
        this.product_price = stream.readDouble();
        this.product_category = stream.readString();
    }

    /**
     * Writes SQL data to a stream based on the properties of the Product instance.
     * @override
     * @param {SQLOutput} stream - The SQL output stream.
     * @throws {SQLException}
     */
    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeString(product_name);
        stream.writeDouble(product_price);
        stream.writeString(product_category);
    }

    // ProductSQLData class
    public class ProductSQLData implements SQLData {
        private final String SQL_TYPE_NAME = "PRODUCT_TYP";
        private String product_name;
        private double product_price;
        private String product_category;

        // Constructor, getters, setters

        @Override
        public String getSQLTypeName() throws SQLException {
            return SQL_TYPE_NAME;
        }

        @Override
        public void readSQL(SQLInput stream, String typeName) throws SQLException {
            this.product_name = stream.readString();
            this.product_price = stream.readDouble();
            this.product_category = stream.readString();
        }

        @Override
        public void writeSQL(SQLOutput stream) throws SQLException {
            stream.writeString(product_name);
            stream.writeDouble(product_price);
            stream.writeString(product_category);
        }

        public void setProduct_name(String product_name) {
            this.product_name = product_name;
        }

        public void setProduct_price(double product_price) {
            this.product_price = product_price;
        }

        public void setProduct_category(String product_category) {
            this.product_category = product_category;
        }
    }

    /**
     * Adds product information to the database.
     * @param {Connection} conn - The database connection.
     * @throws {SQLException, ClassNotFoundException}
     */
    public void AddToDatabase(Connection conn) throws SQLException, ClassNotFoundException {
        Map map = conn.getTypeMap();
        conn.setTypeMap(map);

        ProductSQLData sqlData = new ProductSQLData();
        sqlData.setProduct_name(this.product_name);
        sqlData.setProduct_price(this.product_price);
        sqlData.setProduct_category(this.product_category);

        map.put(this.typeName, Class.forName("database.Product$ProductSQLData"));

        String sql = "{call insert_data.add_product(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setObject(1, sqlData);
            stmt.execute();
        }
    }

    /**
     * Collects product information from the user.
     * @returns {Product} The Product instance with user-provided information.
     */
    public static Product collectProductInformation() {
        Scanner scanner = new Scanner(System.in);
        System.out.println("\nAdding Product:");

        // Collect product information from the user with input validation
        String productName = Helpers.getUserInputString("Enter product name: ");
        double productPrice = Helpers.getUserInputDouble("Enter product price: ");
        String productCategory = Helpers.getUserInputString("Enter product category: ");

        return new Product(productName, productPrice, productCategory);
    }
}
