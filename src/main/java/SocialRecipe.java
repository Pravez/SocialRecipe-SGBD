package main.java;

import main.java.DBAccess.DBAccess;
import main.java.DBAccess.SSTunnel;
import main.java.control.Controller;
import main.java.view.GeneralView;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class SocialRecipe {

    public static void main(String[] args){
        Controller controller = new Controller();
        controller.launch();
    }
}
