package main.java.view;


import main.java.DBAccess.DBAccess;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GeneralView extends JFrame{


    private JPanel mainPane;
    private JToolBar menuBar;
    private JPanel contentPane;
    private JButton connectButton;
    private JLabel connectionStatus;
    private JButton button1;
    private JTabbedPane dataPane;
    private JPanel menusPane;
    private JPanel recipesPane;
    private JPanel ingredientsPane;
    private JToolBar statusBar;
    private JTable menuData;
    private JTable recipesData;
    private JTable ingredientsData;

    public GeneralView(){
        initButtons();
        initWindow();

        loadData();
    }

    private void initWindow(){
        this.setContentPane(mainPane);
        this.setSize(537, 468);

        this.setTitle("SocialRecipe");
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setVisible(true);
    }

    private void initButtons() {
        connectButton.addActionListener(e -> connectButton());
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


            }
        }
    }


    private void loadData(JTable table, ){
        this.menuData.removeAll();


    }
}
