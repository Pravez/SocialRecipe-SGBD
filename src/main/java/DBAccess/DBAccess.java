package main.java.DBAccess;
import com.jcraft.jsch.JSchException;

import java.sql.*;

public class DBAccess {

    private String host;
    private int port;

    private String username;
    private String password;
    private String database;

    private Connection connection;
    private Statement statement;

    private SSTunnel tunnel;

    public DBAccess(String host, int port, String database){
        this.host = host;
        this.port = port;
        this.database = database;
    }

    public DBAccess(String host, int port, String database, SSTunnel tunnel){
        this.host = host;
        this.port = port;
        this.database = database;
        this.tunnel = tunnel;

        try {
            this.tunnel.initSession();
        } catch (JSchException e) {
            e.printStackTrace();
        }
    }

    public void setCredentials(String username, String password){
        this.username = username;
        this.password = password;
    }

    public void connect() throws SQLException {
        this.tunnel.forwardPort(4321, this.host, this.port);
        this.connection = DriverManager.getConnection("jdbc:postgresql://" + this.host + ":4321/" + this.database);
    }

    /*public static void main(String[] args)
            throws SQLException, ClassNotFoundException, java.io.IOException {
        // Preparation de la connexion.
        Connection conn = null;
        conn = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/enseirb","root", "");

        Statement stmt = null;

        try {
            stmt = conn.createStatement();
            // Execution de la requete.
            ResultSet rset = stmt.executeQuery("select A.NOM_ACTEUR, count(*) "
                            + "from ACTEUR A, ROLE RO "
                            + "where A.NUMERO_ACTEUR = RO.NUMERO_ACTEUR "
                            + "group by A.NOM_ACTEUR");

            ResultSetMetaData data = rset.getMetaData();
            for (int j=1;j<=data.getColumnCount();j++){
                System.out.println("Colonne : " + j + " " +data.getColumnName(j) + " "
                        + data.getColumnTypeName(j));
            }
            while (rset.next()) {
                // Affichage du resultat.
                System.out.println(rset.getString(1) + " a "
                        + rset.getInt(2) + " roles");
            }
        }
        finally {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }*/

}
