package database;

import java.sql.*;
import java.util.Map;

public class LoginAuditLog implements SQLData {
    private int log_id;
    private Timestamp event_timestamp;
    private int user_id;
    private String event_description;
    private String typeName;

    public LoginAuditLog(int log_id, Timestamp event_timestamp, int user_id, String event_description) {
        this.log_id = log_id;
        this.event_timestamp = event_timestamp;
        this.user_id = user_id;
        this.event_description = event_description;
        this.typeName = "LOGIN_AUDIT_LOG_TYP";
    }

    public void setLog_id(int log_id) {
        this.log_id = log_id;
    }

    public void setEvent_timestamp(Timestamp event_timestamp) {
        this.event_timestamp = event_timestamp;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
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

    public int getUser_id() {
        return user_id;
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
        setUser_id(stream.readInt());
        setEvent_description(stream.readString());
    }

    @Override
    public void writeSQL(SQLOutput stream) throws SQLException {
        stream.writeInt(getLog_id());
        stream.writeTimestamp(getEvent_timestamp());
        stream.writeInt(getUser_id());
        stream.writeString(getEvent_description());
    }

    // ADD TO DATABASE METHOD
    public void AddToDatabase(Connection conn) throws SQLException, ClassNotFoundException {
        Map map = conn.getTypeMap();
        conn.setTypeMap(map);
        map.put(this.typeName, Class.forName("database.LoginAuditLog"));
        LoginAuditLog myLoginAuditLog = new LoginAuditLog(this.log_id, this.event_timestamp, this.user_id,
                this.event_description);
        String sql = "{call add_login_audit_log(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setObject(1, myLoginAuditLog);
            stmt.execute();
        }
    }

}
