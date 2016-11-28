package main.java.DBAccess;

import java.math.BigDecimal;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.*;

/**
 *
 */
class Row {
    List<Map.Entry<Object, Class>> row;
    static Map<String, Class> TYPE;

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
        TYPE.put("INTERVAL", org.postgresql.util.PGInterval.class);
        TYPE.put("DATE", Date.class);
        TYPE.put("TIME", Time.class);
        TYPE.put("TIMESTAMP", org.postgresql.util.PGInterval.class);
        TYPE.put("SERIAL", Integer.class);
        TYPE.put("INT4", Integer.class);
        TYPE.put("INT8", Integer.class);
        // ...
    }

    Row() {
        row = new ArrayList<>();
    }

    private <T> void add(T data) {
        row.add(new AbstractMap.SimpleImmutableEntry<>(data, data.getClass()));
    }

    void add(Object data, String sqlType) {
        Class castType = Row.TYPE.get(sqlType.toUpperCase());
        try {
            this.add(castType.cast(data));
        } catch (NullPointerException e) {
            e.printStackTrace();

            //Finally not necessary
            /*Logger lgr = Logger.getLogger(Row.class.getName());
            lgr.log(Level.SEVERE, e.getMessage() + " Add the type " + sqlType + " to the TYPE hash map in the Row class.", e);
            throw e;*/
            //Temporary
            this.add("null");
        }
    }
}