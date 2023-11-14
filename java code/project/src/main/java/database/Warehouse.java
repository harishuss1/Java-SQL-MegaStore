package database;

import java.sql.*;
import java.util.Map;

public class Warehouse implements SQLData {
    private int warehouse_id;
    private String warehouse_name;
    private int address_id;
    private int city_id;
    private String typeName;

    public Warehouse(int warehouse_id, String warehouse_name, int address_id, int city_id) {
        this.warehouse_id = warehouse_id;
        this.warehouse_name = warehouse_name;
        this.address_id = address_id;
        this.city_id = city_id;
        this.typeName = "WAREHOUSE_TYP";
    }

    public void setWarehouse_id(int warehouse_id) {
        this.warehouse_id = warehouse_id;
    }

    public void setWarehouse_name(String warehouse_name) {
        this.warehouse_name = warehouse_name;
    }

    public void setAddress_id(int address_id) {
        this.address_id = address_id;
    }

    public void setCity_id(int city_id) {
        this.city_id = city_id;
    }

    public int getWarehouse_id() {
        return warehouse_id;
    }

    public String getWarehouse_name() {
        return warehouse_name;
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
        setWarehouse_id(stream.readInt());
        setWarehouse_name(stream.readString());
        setAddress_id(stream.readInt());
        setCity_id(stream.readInt());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getWarehouse_id());
        stream.writeString(getWarehouse_name());
        stream.writeInt(getAddress_id());
        stream.writeInt(getCity_id());
    }

    // ADD TO DATABASE METHOD
    public void AddToDatabase(Connection conn) throws SQLException, ClassNotFoundException {
        Map map = conn.getTypeMap();
        conn.setTypeMap(map);
        map.put(this.typeName, Class.forName("database.Warehouse"));
        Warehouse myWarehouse = new Warehouse(this.warehouse_id, this.warehouse_name, this.address_id, this.city_id);
        String sql = "{call add_warehouse(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setObject(1, myWarehouse);
            stmt.execute();
        }
    }

}
