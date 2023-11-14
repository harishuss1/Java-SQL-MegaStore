package database;

import java.sql.*;
import java.util.Map;

public class ProjectCity implements SQLData {
    private int city_id;
    private String city_name;
    private String province_name;
    private String country_name;
    private String typeName;

    public ProjectCity(int city_id, String city_name, String province_name, String country_name) {
        this.city_id = city_id;
        this.city_name = city_name;
        this.province_name = province_name;
        this.country_name = country_name;
        this.typeName = "PROJECT_CITY_TYP";
    }

    public void setCity_id(int city_id) {
        this.city_id = city_id;
    }

    public void setCity_name(String city_name) {
        this.city_name = city_name;
    }

    public void setProvince_name(String province_name) {
        this.province_name = province_name;
    }

    public void setCountry_name(String country_name) {
        this.country_name = country_name;
    }

    public int getCity_id() {
        return city_id;
    }

    public String getCity_name() {
        return city_name;
    }

    public String getProvince_name() {
        return province_name;
    }

    public String getCountry_name() {
        return country_name;
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
        setCity_id(stream.readInt());
        setCity_name(stream.readString());
        setProvince_name(stream.readString());
        setCountry_name(stream.readString());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getCity_id());
        stream.writeString(getCity_name());
        stream.writeString(getProvince_name());
        stream.writeString(getCountry_name());
    }

    // ADD TO DATABASE METHOD
    public void AddToDatabase(Connection conn) throws SQLException, ClassNotFoundException {
        Map map = conn.getTypeMap();
        conn.setTypeMap(map);
        map.put(this.typeName, Class.forName("database.ProjectCity"));
        ProjectCity myProjectCity = new ProjectCity(this.city_id, this.city_name, this.province_name,
                this.country_name);
        String sql = "{call add_project_city(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setObject(1, myProjectCity);
            stmt.execute();
        }
    }

}
