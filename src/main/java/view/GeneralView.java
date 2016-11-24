package main.java.view;


import main.java.DBAccess.Row;
import main.java.DBAccess.DBAccess;
import main.java.DBAccess.DataSet;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumn;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.Map;

public class GeneralView extends JFrame{


    private JPanel mainPane;
    private JToolBar menuBar;
    private JPanel contentPane;
    private JButton connectButton;
    private JLabel connectionStatus;
    private JButton reloadQueries;
    private JTabbedPane dataPane;
    private JPanel menusPane;
    private JPanel recipesPane;
    private JPanel ingredientsPane;
    private JToolBar statusBar;
    private JTable menuData;
    private JTable recipesData;
    private JTable ingredientsData;

    private DBAccess access;

    public GeneralView(){
        initButtons();
        initWindow();
    }

    private void initWindow(){
        this.setContentPane(mainPane);
        this.setSize(537, 468);

        this.setTitle("SocialRecipe");
        this.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        this.setVisible(true);
    }

    private void initButtons() {
        connectButton.addActionListener(e -> connectButton());
    }

    private void connectButton(){
        Connection connection = new Connection();
        if(!connection.canceled) {
            this.access = connection.access;

            if (access != null) {
                String status = "Connected to " + access.getDatabase() + " at " + access.getHost();
                if (access.getTunnel() != null) {
                    if (access.getTunnel().isOpen()) {
                        status += "@" + access.getTunnel().getHost();
                    }
                }

                this.connectionStatus.setText(status);
                try {
                    updateTableWithData(this.menuData, new DataSet(this.access.sendQuery("SELECT * FROM menu")));
                    updateTableWithData(this.recipesData, new DataSet(this.access.sendQuery("SELECT * FROM recipe")));
                    updateTableWithData(this.ingredientsData, new DataSet(this.access.sendQuery("SELECT * FROM ingredient")));
                } catch (SQLException e) {
                    e.printStackTrace();
                }

            }
        }
    }

    private void updateTableWithData(JTable table, DataSet set){
        Map.Entry<Object[][], String[]> tableData = set.exportToTable();
        DefaultTableModel tableModel = (DefaultTableModel) table.getModel();

        tableModel.setColumnIdentifiers(tableData.getValue());
        tableModel.setDataVector(tableData.getKey(), tableData.getValue());
        tableModel.fireTableDataChanged();
    }
}
