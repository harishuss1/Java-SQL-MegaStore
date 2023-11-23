package database;

import java.sql.*;
import java.util.Map;
import java.util.Scanner;

import oracle.jdbc.OracleTypes;

/**
 * The Warehouse class represents information about a warehouse.
 * @class
 */
public class Warehouse implements SQLData {
    private String warehouse_name;
    private String address;
    private String city;
    private String typeName;

    /**
     * Creates an instance of Warehouse with the specified information.
     * @constructor
     * @param {string} warehouse_name - The name of the warehouse.
     * @param {string} address - The address of the warehouse.
     * @param {string} city - The city where the warehouse is located.
     */
    public Warehouse(String warehouse_name, String address, String city) {
        this.warehouse_name = warehouse_name;
        this.address = address;
        this.city = city;
        this.typeName = "WAREHOUSE_TYP";
    }

    public void setWarehouse_name(String warehouse_name) {
        this.warehouse_name = warehouse_name;
    }

    public String getWarehouse_name() {
        return warehouse_name;
    }

    public String getAddress() {
        return address;
    }

    public String getCity() {
        return city;
    }

    public String getTypeName() {
        return typeName;
    }

    @Override
    public String getSQLTypeName() throws SQLException {
        return typeName;
    }

    /**
     * Reads the SQL data into the Warehouse object.
     * @function
     * @param {SQLInput} stream - The SQL input stream.
     * @param {string} typeName - The SQL type name.
     * @throws {SQLException}
     */
    @Override
    public void readSQL(SQLInput stream, String typeName) throws SQLException {
        this.warehouse_name = stream.readString();
        this.address = stream.readString();
        this.city = stream.readString();
    }

    /**
     * Writes the Warehouse object to the SQL output stream.
     * @function
     * @param {SQLOutput} stream - The SQL output stream.
     * @throws {SQLException}
     */
    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeString(getWarehouse_name());
        stream.writeString(getAddress());
        stream.writeString(getCity());
    }

    /**
     * Adds the warehouse information to the database.
     * @function
     * @param {Connection} conn - The database connection.
     * @throws {SQLException}
     * @throws {ClassNotFoundException}
     */
    public void AddToDatabase(Connection conn) throws SQLException, ClassNotFoundException {
        Map map = conn.getTypeMap();
        conn.setTypeMap(map);
        map.put(this.typeName, Class.forName("database.Warehouse"));
        Warehouse myWarehouse = new Warehouse(this.warehouse_name, this.address, this.city);
        String sql = "{call insert_data.add_warehouse(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setObject(1, myWarehouse);
            stmt.execute();
        }
    }

    /**
     * Collects warehouse information from the user.
     * @function
     * @param {Connection} conn - The database connection.
     * @returns {Warehouse} - The Warehouse object with user-provided information.
     * @throws {SQLException}
     */
    public static Warehouse collectWarehouseInformation(Connection conn) throws SQLException {
        displayAllAddresses(conn);
        Scanner scanner = new Scanner(System.in);
        System.out.println("\nAdding Warehouse:");
        System.out.println("Enter warehouse name (Ex: Warehouse A): ");
        String warehouseName = scanner.nextLine();
        System.out.println("Enter warehouse address: ");
        System.out.println("Use an existing Address from the list above.");
        String address = scanner.nextLine();
        System.out.println("Enter warehouse city: ");
        String city = scanner.nextLine();

        return new Warehouse(warehouseName, address, city);
    }

    /**
     * Displays all addresses from the Project_Address table.
     * @function
     * @param {Connection} conn - The database connection.
     * @throws {SQLException}
     */
    public static void displayAllAddresses(Connection conn) throws SQLException {
        String sql = "SELECT address FROM Project_Address";
        try (Statement stmt = conn.createStatement();
             ResultSet resultSet = stmt.executeQuery(sql)) {
            System.out.println("-----------------------------");
            System.out.println("Addresses from Project_Address table:");
            while (resultSet.next()) {
                String address = resultSet.getString("address");
                System.out.println(address);
            }
        }
    }

    /**
     * Displays warehouse names using a stored procedure.
     * @function
     * @param {Connection} connection - The database connection.
     * @throws {SQLException}
     */
    public static void displayWarehouseNames(Connection connection) {
        try (CallableStatement stmt = connection.prepareCall("{call delete_data.display_warehouse(?)}")) {
            // Register the OUT parameter for the cursor
            stmt.registerOutParameter(1, OracleTypes.CURSOR);
            // Execute the stored procedure
            stmt.execute();
            
            // Retrieve the result set from the OUT parameter
            ResultSet rs = (ResultSet) stmt.getObject(1);

            // Print warehouse names
            while (rs.next()) {
                String warehouseName = rs.getString("warehouse_name");
                System.out.println("Warehouse Name: " + warehouseName);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
