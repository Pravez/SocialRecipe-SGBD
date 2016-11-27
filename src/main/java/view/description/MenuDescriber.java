package main.java.view.description;


import javax.swing.*;

import java.awt.*;

import static main.java.util.Utility.constraints;

public class MenuDescriber extends DescriberPane{

    private JLabel name;
    private JTextField name_entry;

    public MenuDescriber(String[] values){
        super();

        name = new JLabel("Menu name : ");
        name_entry = new JTextField(values[0]);

        this.add(name, constraints(0, 0, 1, 1, 0, 0, GridBagConstraints.BASELINE));
        this.add(name_entry, constraints(1, 0, 1, 1, 0, 0, GridBagConstraints.BASELINE));

        this.setVisibilityAll(true);
    }
}
