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

    public GeneralView(){
        initButtons();
        initWindow();
    }

    private void initWindow(){
        this.setContentPane(mainPane);
        this.setSize(537, 468);

        this.setTitle("SocialRecipe");
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setVisible(true);
    }

    private void initButtons() {
        connectButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                connectButton();
            }
        });
    }

    private void connectButton(){
        DatabaseConnection connection = new DatabaseConnection();
    }
}
