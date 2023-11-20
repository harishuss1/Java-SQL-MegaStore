package database;

import java.sql.*;
import java.util.Map;
import java.util.Scanner;

public class Warehouse implements SQLData {
    private String warehouse_name;
    private String address;
    private String city;
    private String typeName;

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

    @Override
    public void readSQL(SQLInput stream, String typeName) throws SQLException {
        this.warehouse_name = stream.readString();
        this.address = stream.readString();
        this.city = stream.readString();
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeString(getWarehouse_name());
        stream.writeString(getAddress());
        stream.writeString(getCity());
    }

    // ADD TO DATABASE METHOD
    public void AddToDatabase(Connection conn) throws SQLException, ClassNotFoundException {
        Map map = conn.getTypeMap();
        conn.setTypeMap(map);
        Warehouse myWarehouse = new Warehouse(this.warehouse_name, this.address, this.city);
        String sql = "{call insert_data.add_warehouse(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setObject(1, myWarehouse);
            stmt.execute();
        }
    }

    public static Warehouse collectWarehouseInformation(Connection conn) throws SQLException {
        displayAllAddresses(conn);
        Scanner scanner = new Scanner(System.in);
        System.out.println("\nAdding Warehouse:");
        System.out.println("Enter warehouse name: ");
        String warehouseName = scanner.nextLine();
        System.out.println("Enter warehouse address: ");
        String address = scanner.nextLine();
        System.out.println("Enter warehouse city: ");
        String city = scanner.nextLine();

        return new Warehouse(warehouseName, address, city);
    }

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

}
