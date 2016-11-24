package main.java.view;

import com.jcraft.jsch.JSchException;
import main.java.DBAccess.DBAccess;
import main.java.DBAccess.SSTunnel;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.sql.SQLException;

public class Connection extends JDialog {
    //main pane
    private JPanel contentPane;
    private JButton buttonOK;
    private JButton buttonCancel;

    //Pane for form
    private JPanel mainPane;

    //Pane concerning database
    private JPanel databasePane;
    private JTextField serverName;
    private JTextField databaseName;
    private JTextField userName;
    private JPasswordField userPassword;
    private JSpinner serverPort;

    //Pane concerning ssh
    private JPanel sshPane;
    private JTextField sshServer;
    private JTextField sshUsername;
    private JPasswordField sshPassword;
    private JButton sshConnect;
    private JSpinner sshForwardPort;
    private JCheckBox connectUsingSSHTunnelCheckBox;
    private JLabel testResult;


    private boolean sshCheckedAndWorking = false;
    boolean canceled = false;
    private SSTunnel tunnel;
    DBAccess access;

    Connection() {
        setContentPane(contentPane);
        setModal(true);
        getRootPane().setDefaultButton(buttonOK);
        pack();

        buttonOK.addActionListener(e -> onOK());
        buttonCancel.addActionListener(e -> onCancel());
        connectUsingSSHTunnelCheckBox.addActionListener(e -> changeSshConnectionState(connectUsingSSHTunnelCheckBox.isSelected()));

        this.changeSshConnectionState(this.connectUsingSSHTunnelCheckBox.isSelected());




        // call onCancel() when cross is clicked
        setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
        addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                onCancel();
            }
        });

        // call onCancel() on ESCAPE
        contentPane.registerKeyboardAction(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                onCancel();
            }
        }, KeyStroke.getKeyStroke(KeyEvent.VK_ESCAPE, 0), JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT);

        setVisible(true);

    }

    private void onOK() {
        if(checkDatabase())
            dispose();
    }

    private boolean checkDatabase(){
        boolean result = true;
        if(this.connectUsingSSHTunnelCheckBox.isSelected()) result = checkSsh();
        if(result) {
            this.access = new DBAccess(this.serverName.getText(),
                    (int) this.serverPort.getValue(), this.databaseName.getText(), this.tunnel);
            this.access.setCredentials(this.userName.getText(), new String(this.userPassword.getPassword()));

            try {
                this.access.connect((int) this.sshForwardPort.getValue());
                this.testResult.setText("SQL : Connection succeeded");
                this.testResult.setForeground(new Color(0, 255, 0));
                return true;
            } catch (SQLException e) {
                e.printStackTrace();
                if ((this.sshCheckedAndWorking && this.connectUsingSSHTunnelCheckBox.isSelected()) || !this.connectUsingSSHTunnelCheckBox.isSelected()) {
                    this.testResult.setText(e.getMessage());
                    this.testResult.setForeground(new Color(255, 0, 0));
                    this.access.close();
                }
                return false;
            }
        }

        return false;
    }

    private boolean checkSsh(){
        this.tunnel = new SSTunnel(this.sshUsername.getText(), this.sshServer.getText(),
                new String(this.sshPassword.getPassword()), 22);

        try {
            this.tunnel.initSession();
            this.testResult.setText("SSH : Connection succeed");
            this.testResult.setForeground(new Color(0, 255, 0));
            this.sshCheckedAndWorking = true;
            return true;
        } catch (JSchException e) {
            e.printStackTrace();
            this.testResult.setText(e.getMessage());
            this.testResult.setForeground(new Color(255, 0, 0));
            try {
                this.tunnel.close();
            } catch (JSchException e1) {
                e1.printStackTrace();
            }
            return false;
        }
    }

    private void onCancel() {
        this.canceled = true;
        dispose();
    }

    private void changeSshConnectionState(boolean enabled){
        this.sshServer.setEnabled(enabled);
        this.sshPassword.setEnabled(enabled);
        this.sshUsername.setEnabled(enabled);
        this.sshForwardPort.setEnabled(enabled);
    }
}
