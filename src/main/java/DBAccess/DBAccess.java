package main.java.DBAccess;
import java.sql.*;

public class DBAccess {

    private String host;
    private int port;


    public static void main(String[] args)
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
    }

}
