package main.java.DBAccess;



import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DataSet {
    public ArrayList<Map.Entry<String, Class>> head;
    public ArrayList<Row> data;

    public DataSet(ResultSet set) throws SQLException {
        head = new ArrayList<>();
        data = new ArrayList<>();

        ResultSetMetaData rsmd = set.getMetaData();
        int numOfCol = rsmd.getColumnCount();

        for(int i=1;i<rsmd.getColumnCount();i++){
            head.add(new Map.Entry<>(rsmd.getColumnName(i), Row.TYPE.get(rsmd.getColumnTypeName(i).toUpperCase())));
        }

        while(set.next()){
            Row current_row = new Row();

            for (int i = 1; i <= numOfCol; i++) {
                current_row.add(set.getObject(i), rsmd.getColumnTypeName(i));
            }
        }
    }
}

    /*ResultSet rset = access.sendQuery("SELECT * FROM test");

        try {
                while (rset.next()) {
                // Affichage du resultat.
                System.out.println(rset.getInt(1));
                }

                }catch (Exception e){
                e.printStackTrace();
                }*/

class Row {
    public List<Map.Entry<Object, Class>> row;
    public static Map<String, Class> TYPE;

    static {
        TYPE = new HashMap<>();

        TYPE.put("INTEGER", Integer.class);
        TYPE.put("TINYINT", Byte.class);
        TYPE.put("SMALLINT", Short.class);
        TYPE.put("BIGINT", Long.class);
        TYPE.put("REAL", Float.class);
        TYPE.put("FLOAT", Double.class);
        TYPE.put("DOUBLE", Double.class);
        TYPE.put("DECIMAL", BigDecimal.class);
        TYPE.put("NUMERIC", BigDecimal.class);
        TYPE.put("BOOLEAN", Boolean.class);
        TYPE.put("CHAR", String.class);
        TYPE.put("VARCHAR", String.class);
        TYPE.put("INTERVAL", Timestamp.class);
        TYPE.put("DATE", Date.class);
        TYPE.put("TIME", Time.class);
        TYPE.put("TIMESTAMP", Timestamp.class);
        TYPE.put("SERIAL", Integer.class);
        // ...
    }

    public Row() {
        row = new ArrayList<>();
    }

    public <T> void add(T data) {
        row.add(new AbstractMap.SimpleImmutableEntry<>(data, data.getClass()));
    }

    public void add(Object data, String sqlType) {
        Class castType = Row.TYPE.get(sqlType.toUpperCase());
        try {
            this.add(castType.cast(data));
        } catch (NullPointerException e) {
            e.printStackTrace();
            Logger lgr = Logger.getLogger(Row.class.getName());
            lgr.log(Level.SEVERE, e.getMessage() + " Add the type " + sqlType + " to the TYPE hash map in the Row class.", e);
            throw e;
        }
    }
}