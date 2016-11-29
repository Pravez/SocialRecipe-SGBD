package main.java.view;


import main.java.DBAccess.DBAccess;
import main.java.DBAccess.Requests;
import main.java.DBAccess.SQLRequest;
import main.java.control.Controller;
import main.java.util.Utility;
import main.java.view.description.DescriberPane;
import sun.applet.Main;

import javax.swing.*;

public class GeneralView extends JFrame{


    private JPanel mainPane;
    private JToolBar menuBar;
    private JPanel contentPane;
    private JButton connectButton;
    private JLabel connectionStatus;
    private JTabbedPane dataPane;
    private JToolBar statusBar;

    Controller controller;

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

        MainRequestPane menus = new MainRequestPane(this, Requests.menus_all.callWithArgs(""), Utility.IntegerArray(1), DescriberPane.DESCRIBER_TYPE.MENU);
        MainRequestPane ingredients = new MainRequestPane(this, Requests.ingredients_all.callWithArgs(""), Utility.IntegerArray(1), DescriberPane.DESCRIBER_TYPE.INGREDIENT);
        MainRequestPane recipes = new MainRequestPane(this, Requests.recipes_all.callWithArgs(""), Utility.IntegerArray(1), DescriberPane.DESCRIBER_TYPE.RECIPE);

        this.dataPane.addTab("Menus", menus);
        this.dataPane.addTab("Ingredients", ingredients);
        this.dataPane.addTab("Recipes", recipes);

        //Controller sets it visible
        //this.setVisible(true);
    }

    void addButtonListener(AbstractButton button, Runnable function){
        button.addActionListener(l -> function.run());
    }

    private void initButtons() {
        addButtonListener(this.connectButton, this::connectButton);
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
}
