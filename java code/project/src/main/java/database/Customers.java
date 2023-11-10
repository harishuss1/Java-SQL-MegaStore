package database;

import java.sql.*;

public class Customers implements SQLData {
    private int customer_id;
    private String firstname;
    private String lastname;
    private String email;
    private int address_id;
    private int city_id;
    private String typeName;

    public Customers(int customer_id, String firstname, String lastname, String email, int address_id, int city_id) {
        this.customer_id = customer_id;
        this.firstname = firstname;
        this.lastname = lastname;
        this.email = email;
        this.address_id = address_id;
        this.city_id = city_id;
        this.typeName = "PROJECT_CUSTOMERS_TYP";
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
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

    public int getCustomer_id() {
        return customer_id;
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
        setCustomer_id(stream.readInt());
        setFirstname(stream.readString());
        setLastname(stream.readString());
        setEmail(stream.readString());
        setAddress_id(stream.readInt());
        setCity_id(stream.readInt());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getCustomer_id());
        stream.writeString(getFirstname());
        stream.writeString(getLastname());
        stream.writeString(getEmail());
        stream.writeInt(getAddress_id());
        stream.writeInt(getCity_id());
    }
}
