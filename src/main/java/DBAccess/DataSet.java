package main.java.DBAccess;

import java.sql.*;
import java.util.*;

public class DataSet {
    public ArrayList<Map.Entry<String, Class>> head;
    public ArrayList<Row> data;

    public DataSet(ResultSet set) throws SQLException {
        head = new ArrayList<>();
        data = new ArrayList<>();

        ResultSetMetaData rsmd = set.getMetaData();
        int numOfCol = rsmd.getColumnCount();

        for(int i=1;i <= rsmd.getColumnCount();i++){
            head.add(new AbstractMap.SimpleImmutableEntry<>(rsmd.getColumnName(i), Row.TYPE.get(rsmd.getColumnTypeName(i).toUpperCase())));
        }

        while(set.next()){
            Row current_row = new Row();

            for (int i = 1; i <= numOfCol; i++) {
                current_row.add(set.getObject(i), rsmd.getColumnTypeName(i));
            }

            data.add(current_row);
        }
    }

    public Map.Entry<Object[][], String[]> exportToTable(){
        int size = this.head.size();
        String[] head = new String[size];
        Object[][] data = new Object[this.data.size()][size];
        int i = 0;
        int j = 0;

        for(Map.Entry<String, Class> entry : this.head){
            head[i++] = entry.getKey();
        }

        for(Row row : this.data){
            i = 0;
            Object[] rowData = new Object[size];

            for(Map.Entry<Object, Class> obj : row.row){
                rowData[i++] = obj.getValue().cast(obj.getKey());
            }

            data[j++] = rowData;
        }

        return new AbstractMap.SimpleImmutableEntry<>(data, head);
    }
}