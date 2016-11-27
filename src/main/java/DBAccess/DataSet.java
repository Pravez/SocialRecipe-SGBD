package main.java.DBAccess;

import java.sql.*;
import java.util.*;
import java.util.stream.IntStream;

/**
 * Class supposed to take the representation of the result set.
 * It has a head made of a tuple (Column Name, Type of data), and a data made of {@link Row}s.
 */
public class DataSet {
    public ArrayList<Map.Entry<String, Class>> head;
    public ArrayList<Row> data;

    /**
     * Initializes and builds the head and data
     * @param set is the {@link ResultSet} from the SQL query
     * @throws SQLException if a database access error occurs or this method is called on a closed result set
     */
    public DataSet(ResultSet set) throws SQLException {
        head = new ArrayList<>();
        data = new ArrayList<>();

        //We take metadatas and number of columns
        ResultSetMetaData rsmd = set.getMetaData();
        int numOfCol = rsmd.getColumnCount();

        //We add a "map entry" meaning a tuple made of two values
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

    public Map.Entry<Object[][], String[]> exportToTable(int[] showedColumns){
        boolean selectColumns = showedColumns != null;

        //If we have to select columns then we take the array of selected ones,
        //else we fill an array with int values from 1 to the size of total columns
        int[] toTake = selectColumns ? showedColumns.clone() : new int[this.head.size()];
        if(!selectColumns) IntStream.range(0, this.head.size()).forEach(value -> toTake[value] = value);

        String[] head = new String[toTake.length];
        Object[][] data = new Object[this.data.size()][toTake.length];
        Map.Entry<Object, Class> temp;
        int add = 0;

        //Then for each selected column we take the head
        for (int aToTake : toTake) {
            head[add++] = this.head.get(aToTake).getKey();
        }

        //And for each row
        for(int i=0;i<this.data.size();i++){
            Object[] rowData = new Object[toTake.length];
            add = 0;

            //we take the selected columns (we get the value and cast it with the key)
            for (int aToTake : toTake) {
                temp = this.data.get(i).row.get(aToTake);
                rowData[add++] = temp.getValue().cast(temp.getKey());
            }

            data[i] = rowData;
        }

        //We return a tuple
        return new AbstractMap.SimpleImmutableEntry<>(data, head);
    }
}