package database;

import java.sql.*;

public class StockUpdateAuditLog implements SQLData {
    private int log_id;
    private Timestamp event_timestamp;
    private int product_id;
    private int previous_stock;
    private int new_stock;
    private String event_description;
    private String typeName;

    public StockUpdateAuditLog(int log_id, Timestamp event_timestamp, int product_id, int previous_stock, int new_stock, String event_description) {
        this.log_id = log_id;
        this.event_timestamp = event_timestamp;
        this.product_id = product_id;
        this.previous_stock = previous_stock;
        this.new_stock = new_stock;
        this.event_description = event_description;
        this.typeName = "STOCK_UPDATE_AUDIT_LOG_TYP";
    }

    public void setLog_id(int log_id) {
        this.log_id = log_id;
    }

    public void setEvent_timestamp(Timestamp event_timestamp) {
        this.event_timestamp = event_timestamp;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public void setPrevious_stock(int previous_stock) {
        this.previous_stock = previous_stock;
    }

    public void setNew_stock(int new_stock) {
        this.new_stock = new_stock;
    }

    public void setEvent_description(String event_description) {
        this.event_description = event_description;
    }

    public int getLog_id() {
        return log_id;
    }

    public Timestamp getEvent_timestamp() {
        return event_timestamp;
    }

    public int getProduct_id() {
        return product_id;
    }

    public int getPrevious_stock() {
        return previous_stock;
    }

    public int getNew_stock() {
        return new_stock;
    }

    public String getEvent_description() {
        return event_description;
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
        setLog_id(stream.readInt());
        setEvent_timestamp(stream.readTimestamp());
        setProduct_id(stream.readInt());
        setPrevious_stock(stream.readInt());
        setNew_stock(stream.readInt());
        setEvent_description(stream.readString());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getLog_id());
        stream.writeTimestamp(getEvent_timestamp());
        stream.writeInt(getProduct_id());
        stream.writeInt(getPrevious_stock());
        stream.writeInt(getNew_stock());
        stream.writeString(getEvent_description());
    }
}
