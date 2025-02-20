package database;

import java.sql.*;
import java.util.Map;

public class ProjectAddress implements SQLData {
    private int address_id;
    private String address;
    private int city_id;
    private String typeName;

    public ProjectAddress(int address_id, String address, int city_id) {
        this.address_id = address_id;
        this.address = address;
        this.city_id = city_id;
        this.typeName = "PROJECT_ADDRESS_TYP";
    }

    public void setAddress_id(int address_id) {
        this.address_id = address_id;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setCity_id(int city_id) {
        this.city_id = city_id;
    }

    public int getAddress_id() {
        return address_id;
    }

    public String getAddress() {
        return address;
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
        setAddress_id(stream.readInt());
        setAddress(stream.readString());
        setCity_id(stream.readInt());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getAddress_id());
        stream.writeString(getAddress());
        stream.writeInt(getCity_id());
    }

    // ADD TO DATABASE METHOD
    public void AddToDatabase(Connection conn) throws SQLException, ClassNotFoundException {
        Map map = conn.getTypeMap();
        conn.setTypeMap(map);
        map.put(this.typeName, Class.forName("database.ProjectAddress"));
        ProjectAddress myProjectAddress = new ProjectAddress(this.address_id, this.address, this.city_id);
        String sql = "{call add_project_address(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setObject(1, myProjectAddress);
            stmt.execute();
        }
    }

}
