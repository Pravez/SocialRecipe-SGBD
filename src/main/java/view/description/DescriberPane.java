package main.java.view.description;

import main.java.DBAccess.DataSet;
import main.java.DBAccess.SQLRequest;

import javax.swing.*;
import java.awt.*;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import static main.java.util.Utility.constraints;

public abstract class DescriberPane extends JPanel{

    public enum DESCRIBER_TYPE{
        MENU,
        INGREDIENT,
        RECIPE
    }

    private JLabel begin;

    private SQLRequest request;
    private DataSet set;

    protected ArrayList<Map.Entry<String, Map.Entry<JLabel, JTextArea>>> describers;

    protected int gridxcurrent;
    protected int gridycurrent;


    DescriberPane(){
        this.setLayout(new GridBagLayout());

        this.begin = new JLabel("To see details, select an entry ...");
        this.add(begin, constraints(0, 0, 1, 1,1., 1.,  GridBagConstraints.BASELINE));
    }

    void setVisibilityAll(boolean visible){
        for(Component c : this.getComponents()){
            c.setVisible(visible);
        }

        this.begin.setVisible(!visible);
    }

    protected void addDescriber(String name, String text){
        JLabel label = new JLabel(text);
        JTextArea textArea = new JTextArea();
        this.describers.add(new AbstractMap.SimpleImmutableEntry<>(
                name, new AbstractMap.SimpleImmutableEntry<>(
                label, textArea
        )
        ));

        this.add(label, constraints(gridxcurrent++, gridycurrent, 1, 1, 1., 1., GridBagConstraints.BASELINE));
        this.add(textArea, constraints(gridxcurrent, gridycurrent++, 1, 1, 1., 1., GridBagConstraints.BASELINE));
        gridxcurrent = 0;
    }

    public void updateDescriber(HashMap<String, Object> values){
        if(begin.isVisible()){
            this.setVisibilityAll(true);
        }
    }
    abstract void update(String[] set);

}
