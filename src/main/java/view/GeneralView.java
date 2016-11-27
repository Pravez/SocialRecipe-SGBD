package main.java.view;


import main.java.DBAccess.DBAccess;
import main.java.DBAccess.SQLRequest;
import main.java.control.Controller;
import main.java.util.Utility;
import sun.applet.Main;

import javax.rmi.CORBA.Util;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;

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
    private JButton reloadMenu;
    private JButton button2;

    public JTable menuTable;
    public JTable recipesTable;
    public JTable ingredientsTable;
    private JPanel menuDataSetPane;

    private Controller controller;

    public GeneralView(Controller controller){
        this.controller = controller;

        initButtons();
        initWindow();

    }

    private void initWindow(){
        this.setContentPane(mainPane);
        this.setSize(537, 468);

        this.setTitle("SocialRecipe");
        this.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

        MainRequestPane pane = new MainRequestPane();
        this.controller.createAndBind(new SQLRequest().select("*").from("menu"), pane.table, Utility.IntegerArray(1));
        pane.reloadButton.addActionListener(e -> controller.updateTable(pane.table));
        this.dataPane.addTab("other", pane);

        //Controller sets it visible
        //this.setVisible(true);
    }

    private void initButtons() {
        connectButton.addActionListener(e -> connectButton());
        reloadMenu.addActionListener(e -> controller.updateTable(menuTable));
    }

    private void connectButton(){
        Connection connection = new Connection();
        if(!connection.canceled) {
            DBAccess access = connection.access;

            if (access != null) {
                String status = "Connected to " + access.getDatabase() + " at " + access.getHost();
                if (access.getTunnel() != null) {
                    if (access.getTunnel().isOpen()) {
                        status += "@" + access.getTunnel().getHost();
                    }
                }

                this.connectionStatus.setText(status);
                this.controller.setSQLConnection(access);

            }
        }
    }

    public void updateTableWithData(JTable table, Object[][] data, String[] head){
        DefaultTableModel tableModel = (DefaultTableModel) table.getModel();

        if(head != null) {
            tableModel.setColumnIdentifiers(head);
        }
        tableModel.setDataVector(data, head);
        table.setTableHeader(null);

        tableModel.fireTableDataChanged();
    }
}
