package database;

import java.sql.*;
import java.util.Map;
import java.util.Scanner;

public class Customers implements SQLData {
    
    private String firstname;
    private String lastname;
    private String email;
    private int address_id;
    private int city_id;
    private String typeName;

    public Customers(String firstname, String lastname, String email, int address_id, int city_id) {
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.address_id = address_id;
        this.city_id = city_id;
        this.typeName = "PROJECT_CUSTOMERS_TYP";
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setAddress_id(int address_id) {
        this.address_id = address_id;
    }

    public void setCity_id(int city_id) {
        this.city_id = city_id;
    }

    public String getFirstname() {
        return firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public String getEmail() {
        return email;
    }

    public int getAddress_id() {
        return address_id;
    }

    public int getCity_id() {
        return city_id;
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
        setFirstname(stream.readString());
        setLastname(stream.readString());
        setEmail(stream.readString());
        setAddress_id(stream.readInt());
        setCity_id(stream.readInt());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeString(getFirstname());
        stream.writeString(getLastname());
        stream.writeString(getEmail());
        stream.writeInt(getAddress_id());
        stream.writeInt(getCity_id());
    }

    // ADD TO DATABASE METHOD
    public void AddToDatabase(Connection conn) throws SQLException, ClassNotFoundException {
        Map map = conn.getTypeMap();
        conn.setTypeMap(map);
        map.put(this.typeName, Class.forName("database.Customers"));
        Customers myCustomer = new Customers(this.firstname, this.lastname, this.email,
                this.address_id, this.city_id);
        String sql = "{call add_customer(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setObject(1, myCustomer);
            stmt.execute();
        }
    }

    public static Customers collectCustomerInformation() {
        Scanner scanner = new Scanner(System.in);
        
        String firstname = Helpers.getUserInputString("Enter first name: ");
        String lastname = Helpers.getUserInputString("Enter last name: ");
        String email = Helpers.getUserInputString("Enter email: ");
        int addressId = Helpers.getUserInputInt("Enter address ID: ");
        int cityId = Helpers.getUserInputInt("Enter city ID: ");

        return new Customers(firstname, lastname, email, addressId, cityId);
    }

}
