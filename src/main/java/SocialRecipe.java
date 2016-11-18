package main.java;

import main.java.DBAccess.DBAccess;
import main.java.DBAccess.SSTunnel;

import java.sql.SQLException;

public class SocialRecipe {

    public static void main(String[] args){
        SSTunnel tunnel = new SSTunnel("enseirb", "pravez.ddns.net", "X#d6H*45J2", 22);
        DBAccess access = new DBAccess("localhost", 5432, "enseirb", tunnel);

        access.setCredentials("enseirb", "vatefairefoutre");

        try {
            access.connect();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
