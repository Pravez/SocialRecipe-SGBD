package main.java.view;

import main.java.DBAccess.SQLRequest;
import main.java.view.description.DescriberPane;
import main.java.view.description.IngredientDescriber;
import main.java.view.description.MenuDescriber;
import main.java.view.description.RecipeDescriber;

import javax.swing.*;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import static main.java.util.Utility.constraints;

class MainRequestPane extends JPanel {

    private JPanel dataPane;
    private JScrollPane scrollPane;
    private JTable table;
    private JButton reloadButton;
    private JButton addButton;

    private DescriberPane describer;

    private GeneralView mainFrame;

    private SQLRequest request;

    MainRequestPane(GeneralView mainFrame, SQLRequest request, int[] selected, DescriberPane.DESCRIBER_TYPE desc_type){
        this.mainFrame = mainFrame;
        this.request = request;

        createComponents(desc_type);

        this.mainFrame.controller.createAndBind(this.request, this.table, selected);

        initEvents();
    }

    private void createComponents(DescriberPane.DESCRIBER_TYPE desc_type){
        this.setLayout(new GridBagLayout());

        this.dataPane = new JPanel(new GridBagLayout());
        this.table = new JTable();
        this.scrollPane = new JScrollPane(table);
        this.reloadButton = new JButton("Reload");
        this.addButton = new JButton("Add an entry");

        this.dataPane.add(scrollPane, constraints(0, 1, 2, 4, 1., 1., GridBagConstraints.BOTH));
        this.dataPane.add(reloadButton, constraints(0, 0, 1, 1, 1., 0.01, GridBagConstraints.BOTH));
        this.dataPane.add(addButton, constraints(1, 0, 1, 1, 1., 0.01, GridBagConstraints.BOTH));

        switch (desc_type){
            case MENU: this.describer = new MenuDescriber(); break;
            case INGREDIENT: this.describer = new IngredientDescriber(); break;
            case RECIPE: this.describer = new RecipeDescriber(); break;
        }

        this.add(dataPane, constraints(0, 0, 1, 1,0.5, 0.5,  GridBagConstraints.BOTH));
        this.add(describer, constraints(1, 0, 2, 1,1., 1.,  GridBagConstraints.BOTH));
    }

    private void initEvents(){
        mainFrame.addButtonListener(this.reloadButton, () -> mainFrame.controller.updateTable(table));

        table.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                int row = table.getSelectedRow();
                int column = table.getSelectedColumn();

                String selectedValue = (String)table.getModel().getValueAt(row, column);
                describer.updateDescriber(mainFrame.controller.getRowFromValue(table, selectedValue));
            }
        });
    }

}
