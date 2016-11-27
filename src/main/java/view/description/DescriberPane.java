package main.java.view.description;

import javax.swing.*;
import java.awt.*;

import static main.java.util.Utility.constraints;

public abstract class DescriberPane extends JPanel{

    public JLabel begin;


    public DescriberPane(){
        this.setLayout(new GridBagLayout());

        this.begin = new JLabel("To see details, select an entry ...");
        this.add(begin, constraints(0, 0, 1, 1,1., 1.,  GridBagConstraints.BASELINE));
    }

    public void setVisibilityAll(boolean visible){
        for(Component c : this.getComponents()){
            c.setVisible(visible);
        }

        this.begin.setVisible(!visible);
    }
}
