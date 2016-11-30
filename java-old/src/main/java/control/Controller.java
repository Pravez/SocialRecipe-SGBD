package main.java.control;

import main.java.DBAccess.DBAccess;
import main.java.DBAccess.DataSet;
import main.java.DBAccess.SQLRequest;
import main.java.view.GeneralView;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.util.HashMap;
import java.util.Map;

/**
 * Started to implement a Controller for a MVC pattern, but for now it is not a real MVC ...
 */
public class Controller {

    private HashMap<JTable, DataSet> sets;
    private GeneralView view;

    private DBAccess access;

    public Controller(){
        this.sets = new HashMap<>();
        this.view = new GeneralView(this);
    }

    public void launch(){
        this.view.setVisible(true);
    }


    public void setSQLConnection(DBAccess access){
        this.access = access;
    }

    public void createAndBind(SQLRequest request, JTable table, int[] columns){
        DataSet set = new DataSet(request, columns);
        this.sets.put(table, set);
    }

    public void updateTable(JTable table){
        DataSet set = this.sets.get(table);
        set.analyze(this.access.sendQuery(set.request.toString()));

        Map.Entry<Object[][], String[]> data = set.exportToTable();
        updateTableWithData(table, data.getKey(), data.getValue());
    }

    private void updateTableWithData(JTable table, Object[][] data, String[] head){
        DefaultTableModel tableModel = (DefaultTableModel) table.getModel();

        if(head != null) {
            tableModel.setColumnIdentifiers(head);
        }
        tableModel.setDataVector(data, head);
        table.setTableHeader(null);

        tableModel.fireTableDataChanged();
    }

    public HashMap<String, Object> getRowFromValue(JTable table, Object value){
        DataSet set = sets.get(table);
        return set.getRowFromItem(value);
    }
}
