package main.java.view;

import javax.swing.*;
import javax.xml.crypto.Data;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class DatabaseConnection extends JFrame{

    private JPanel mainPane;
    private JPanel databasePane;
    private JPanel sshPane;
    private JTextField serverName;
    private JTextField databaseName;
    private JTextField userName;
    private JPasswordField userPassword;
    private JSpinner serverPort;
    private JButton dataConnect;
    private JTextField sshServer;
    private JTextField sshUsername;
    private JPasswordField sshPassword;
    private JButton sshConnect;
    private JTextField sshForwardPort;
    private JCheckBox connectUsingSSHTunnelCheckBox;

    DatabaseConnection(){
        initWindow();
        this.changeSshConnectionState(this.connectUsingSSHTunnelCheckBox.isSelected());


        connectUsingSSHTunnelCheckBox.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                changeSshConnectionState(connectUsingSSHTunnelCheckBox.isSelected());
            }
        });
    }

    private void initWindow(){
        this.setContentPane(mainPane);
        this.setSize(537, 468);
        this.setTitle("Connect to a database");
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.pack();
        this.setVisible(true);
    }

    private void changeSshConnectionState(boolean enabled){
        this.sshServer.setEnabled(enabled);
        this.sshPassword.setEnabled(enabled);
        this.sshUsername.setEnabled(enabled);
        this.sshForwardPort.setEnabled(enabled);
    }
}
