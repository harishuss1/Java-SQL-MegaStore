package database;

import java.sql.*;
import java.util.Map;
import java.util.Scanner;

public class Reviews implements SQLData {
    private int flag;
    private String description;
    private int review_score;
    private int customer_id;
    private int product_id;
    private String typeName;

    public Reviews(int flag, String description, int review_score, int customer_id, int product_id) {
        this.flag = flag;
        this.description = description;
        this.review_score = review_score;
        this.customer_id = customer_id;
        this.product_id = product_id;
        this.typeName = "REVIEWS_TYP";
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

    public void setReviewScore(int review_score) {
        this.review_score = review_score;
    }

    public int getFlag() {
        return flag;
    }

    public int getReviewScore() {
        return review_score;
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
        setFlag(stream.readInt());
        setDescription(stream.readString());
        setReviewScore(stream.readInt());
        setCustomer_id(stream.readInt());
        setProduct_id(stream.readInt());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getFlag());
        stream.writeString(getDescription());
        stream.writeInt(getReviewScore());
        stream.writeInt(getCustomer_id());
        stream.writeInt(getProduct_id());
    }

    // ADD TO DATABASE METHOD
    public void AddToDatabase(Connection conn) throws SQLException, ClassNotFoundException {
        Map map = conn.getTypeMap();
        conn.setTypeMap(map);
        map.put(this.typeName, Class.forName("database.Reviews"));
        Reviews myReviews = new Reviews(this.flag, this.description, this.review_score, this.customer_id, this.product_id);
        String sql = "{call insert_data.add_review(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setObject(1, myReviews);
            stmt.execute();
        }
    }

    public static Reviews collectReviewInformation(Connection conn) {
        Scanner scanner = new Scanner(System.in);
        
        // Collect review information from the user with input validation
        int flag = Helpers.getUserInputInt("Enter flag: ");
        System.out.println("Enter your description: ");
        String description = scanner.nextLine();
        
        int score = Helpers.getUserInputInt("Enter Review Score: ");
        int customerId = Helpers.getUserInputInt("Enter customer ID: ");
        int productId = Helpers.getUserInputInt("Enter product ID: ");

        return new Reviews(flag, description, score, customerId, productId);
    }

}
