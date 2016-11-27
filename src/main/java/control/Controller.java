package main.java.control;

import main.java.DBAccess.DBAccess;
import main.java.DBAccess.DataSet;
import main.java.util.Utility;
import main.java.view.GeneralView;

import javax.swing.*;
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

        this.createAndBind("SELECT * FROM menu", view.menuTable, Utility.IntegerArray(1));
        this.createAndBind("SELECT * FROM recipe", view.recipesTable, Utility.IntegerArray(1));
        this.createAndBind("SELECT * FROM ingredient", view.ingredientsTable, Utility.IntegerArray(1));
    }

    public void launch(){
        this.view.setVisible(true);
    }


    public void setSQLConnection(DBAccess access){
        this.access = access;
    }

    private void createAndBind(String request, JTable table, int[] columns){
        DataSet set = new DataSet();
        set.bindTo(table, request, columns);
        this.sets.put(table, set);
    }

    public void updateTable(JTable table){
        DataSet set = this.sets.get(table);
        set.analyze(this.access.sendQuery(set.request));

        Map.Entry<Object[][], String[]> data = set.exportToTable();
        this.view.updateTableWithData(table, data.getKey(), data.getValue());
    }

}
