package database;

import java.sql.*;

public class OrderAuditLog implements SQLData {
    private int log_id;
    private Timestamp event_timestamp;
    private int customer_id;
    private int product_id;
    private String event_description;
    private String typeName;

    public OrderAuditLog(int log_id, Timestamp event_timestamp, int customer_id, int product_id, String event_description) {
        this.log_id = log_id;
        this.event_timestamp = event_timestamp;
        this.customer_id = customer_id;
        this.product_id = product_id;
        this.event_description = event_description;
        this.typeName = "ORDER_AUDIT_LOG_TYP";
    }

    public void setLog_id(int log_id) {
        this.log_id = log_id;
    }

    public void setEvent_timestamp(Timestamp event_timestamp) {
        this.event_timestamp = event_timestamp;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
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

    public int getCustomer_id() {
        return customer_id;
    }

    public int getProduct_id() {
        return product_id;
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
        setCustomer_id(stream.readInt());
        setProduct_id(stream.readInt());
        setEvent_description(stream.readString());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getLog_id());
        stream.writeTimestamp(getEvent_timestamp());
        stream.writeInt(getCustomer_id());
        stream.writeInt(getProduct_id());
        stream.writeString(getEvent_description());
    }
}
