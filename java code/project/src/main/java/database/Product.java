package database;

import java.sql.*;

public class Product  implements SQLData{
    private int product_id;
    private String product_name;
    private double product_price;
    private String product_category;
    private String typeName;

    public  Product(int product_id, String product_name, double product_price, String product_category){
        this.product_id = product_id;
        this.product_name = product_name;
        this.product_price =product_price;
        this.product_category =product_category;
        this.typeName = "PRODUCT_TYP";
    }


    public void setProduct_category(String product_category) {
        this.product_category = product_category;
    }
    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }
    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }
    public void setProduct_price(double product_price) {
        this.product_price = product_price;
    }
    public String getProduct_category() {
        return product_category;
    }
    public int getProduct_id() {
        return product_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public double getProduct_price() {
        return product_price;
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
        setProduct_id(stream.readInt());
        setProduct_name(stream.readString());
        setProduct_price(stream.readDouble());
        setProduct_category(stream.readString());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getProduct_id());
        stream.writeString(getProduct_name());
        stream.writeDouble(getProduct_price());
        stream.writeString(getProduct_category());
    }

}
