package database;

import java.sql.*;

public class Reviews implements SQLData {
    private int review_id;
    private int flag;
    private String description;
    private int customer_id;
    private int product_id;
    private String typeName;

    public Reviews(int review_id, int flag, String description, int customer_id, int product_id) {
        this.review_id = review_id;
        this.flag = flag;
        this.description = description;
        this.customer_id = customer_id;
        this.product_id = product_id;
        this.typeName = "REVIEWS_TYP";
    }

    public void setReview_id(int review_id) {
        this.review_id = review_id;
    }

    public void setFlag(int flag) {
        this.flag = flag;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getReview_id() {
        return review_id;
    }

    public int getFlag() {
        return flag;
    }

    public String getDescription() {
        return description;
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
        setReview_id(stream.readInt());
        setFlag(stream.readInt());
        setDescription(stream.readString());
        setCustomer_id(stream.readInt());
        setProduct_id(stream.readInt());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getReview_id());
        stream.writeInt(getFlag());
        stream.writeString(getDescription());
        stream.writeInt(getCustomer_id());
        stream.writeInt(getProduct_id());
    }
}
