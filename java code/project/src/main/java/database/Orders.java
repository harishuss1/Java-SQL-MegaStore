package database;

import java.sql.*;
import java.util.Map;

public class Orders implements SQLData {
    private int order_id;
    private int order_quantity;
    private Date order_date;
    private int store_id;
    private int customer_id;
    private int product_id;
    private String typeName;

    public Orders(int order_id, int order_quantity, Date order_date, int store_id, int customer_id, int product_id) {
        this.order_id = order_id;
        this.order_quantity = order_quantity;
        this.order_date = order_date;
        this.store_id = store_id;
        this.customer_id = customer_id;
        this.product_id = product_id;
        this.typeName = "PROJECT_ORDERS_TYP";
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public void setOrder_quantity(int order_quantity) {
        this.order_quantity = order_quantity;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

    public void setStore_id(int store_id) {
        this.store_id = store_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getOrder_id() {
        return order_id;
    }

    public int getOrder_quantity() {
        return order_quantity;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public int getStore_id() {
        return store_id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public int getProduct_id() {
        return product_id;
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
        setOrder_id(stream.readInt());
        setOrder_quantity(stream.readInt());
        setOrder_date(stream.readDate());
        setStore_id(stream.readInt());
        setCustomer_id(stream.readInt());
        setProduct_id(stream.readInt());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getOrder_id());
        stream.writeInt(getOrder_quantity());
        stream.writeDate(getOrder_date());
        stream.writeInt(getStore_id());
        stream.writeInt(getCustomer_id());
        stream.writeInt(getProduct_id());
    }

    // ADD TO DATABASE METHOD
    public void AddToDatabase(Connection conn) throws SQLException, ClassNotFoundException {
        Map map = conn.getTypeMap();
        conn.setTypeMap(map);
        map.put(this.typeName, Class.forName("database.Orders"));
        Orders myOrders = new Orders(this.order_id, this.order_quantity, this.order_date, this.store_id,
                this.customer_id, this.product_id);
        String sql = "{call add_order(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setObject(1, myOrders);
            stmt.execute();
        }
    }

}
