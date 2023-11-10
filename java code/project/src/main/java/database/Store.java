package database;

import java.sql.*;

public class Store implements SQLData {
    private int store_id;
    private String store_name;
    private String typeName;

    public Store(int store_id, String store_name) {
        this.store_id = store_id;
        this.store_name = store_name;
        this.typeName = "STORE_TYP";
    }

    public void setStore_id(int store_id) {
        this.store_id = store_id;
    }

    public void setStore_name(String store_name) {
        this.store_name = store_name;
    }

    public int getStore_id() {
        return store_id;
    }

    public String getStore_name() {
        return store_name;
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
        setStore_id(stream.readInt());
        setStore_name(stream.readString());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getStore_id());
        stream.writeString(getStore_name());
    }
}
