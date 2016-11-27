package main.java.view;


import main.java.view.description.DescriberPane;
import main.java.view.description.MenuDescriber;

import javax.swing.*;
import java.awt.*;

import static main.java.util.Utility.constraints;

public class MainRequestPane extends JPanel {

    public JPanel dataPane;
    public JTable table;
    public JButton reloadButton;
    public JButton addButton;

    public DescriberPane describer;

    public MainRequestPane(){
        this.setLayout(new GridBagLayout());

        this.dataPane = new JPanel(new GridBagLayout());
        this.table = new JTable();
        this.reloadButton = new JButton("Reload");
        this.addButton = new JButton("Add an entry");

        this.dataPane.add(table, constraints(0, 1, 2, 4, 1., 1., GridBagConstraints.BOTH));
        this.dataPane.add(reloadButton, constraints(0, 0, 1, 1, 1., 0.01, GridBagConstraints.BOTH));
        this.dataPane.add(addButton, constraints(1, 0, 1, 1, 1., 0.01, GridBagConstraints.BOTH));

        this.describer = new MenuDescriber(new String[]{"du texte"});

        this.add(dataPane, constraints(0, 0, 1, 1,0.5, 0.5,  GridBagConstraints.BOTH));
        this.add(describer, constraints(1, 0, 2, 1,1., 1.,  GridBagConstraints.BOTH));
    }


}
