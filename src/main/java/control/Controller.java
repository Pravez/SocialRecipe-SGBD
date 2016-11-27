package main.java.control;

import main.java.DBAccess.DBAccess;
import main.java.DBAccess.DataSet;
import main.java.DBAccess.SQLRequest;
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

        this.createAndBind(new SQLRequest().select("*").from("menu"), view.menuTable, Utility.IntegerArray(1));
        this.createAndBind(new SQLRequest().select("*").from("recipe"), view.recipesTable, Utility.IntegerArray(1));
        this.createAndBind(new SQLRequest().select("*").from("ingredient"), view.ingredientsTable, Utility.IntegerArray(1));
    }

    public void launch(){
        this.view.setVisible(true);
    }


    public void setSQLConnection(DBAccess access){
        this.access = access;
    }

    public void createAndBind(SQLRequest request, JTable table, int[] columns){
        DataSet set = new DataSet();
        set.bindTo(table, request, columns);
        this.sets.put(table, set);
    }

    public void updateTable(JTable table){
        DataSet set = this.sets.get(table);
        set.analyze(this.access.sendQuery(set.request.toString()));

        Map.Entry<Object[][], String[]> data = set.exportToTable();
        this.view.updateTableWithData(table, data.getKey(), data.getValue());
    }

}
