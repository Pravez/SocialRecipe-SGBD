package main.java.view;

import main.java.DBAccess.SQLRequest;
import main.java.view.description.DescriberPane;
import main.java.view.description.MenuDescriber;

import javax.swing.*;
import java.awt.*;

import static main.java.util.Utility.constraints;

public class MainRequestPane extends JPanel {

    public JPanel dataPane;
    public JScrollPane scrollPane;
    public JTable table;
    public JButton reloadButton;
    public JButton addButton;

    public DescriberPane describer;

    private GeneralView mainFrame;

    public SQLRequest request;

    public MainRequestPane(GeneralView mainFrame, SQLRequest request, int[] selected){
        this.mainFrame = mainFrame;
        this.request = request;

        createComponents();

        this.mainFrame.controller.createAndBind(this.request, this.table, selected);

        initEvents();
    }

    private void createComponents(){
        this.setLayout(new GridBagLayout());

        this.dataPane = new JPanel(new GridBagLayout());
        this.table = new JTable();
        this.scrollPane = new JScrollPane(table);
        this.reloadButton = new JButton("Reload");
        this.addButton = new JButton("Add an entry");

        this.dataPane.add(scrollPane, constraints(0, 1, 2, 4, 1., 1., GridBagConstraints.BOTH));
        this.dataPane.add(reloadButton, constraints(0, 0, 1, 1, 1., 0.01, GridBagConstraints.BOTH));
        this.dataPane.add(addButton, constraints(1, 0, 1, 1, 1., 0.01, GridBagConstraints.BOTH));

        this.describer = new MenuDescriber(new String[]{"du texte"});

        this.add(dataPane, constraints(0, 0, 1, 1,0.5, 0.5,  GridBagConstraints.BOTH));
        this.add(describer, constraints(1, 0, 2, 1,1., 1.,  GridBagConstraints.BOTH));
    }

    private void initEvents(){
        mainFrame.addButtonListener(this.reloadButton, () -> mainFrame.controller.updateTable(table));
    }


}
