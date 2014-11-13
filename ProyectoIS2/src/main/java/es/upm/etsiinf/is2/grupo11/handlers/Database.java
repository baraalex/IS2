package es.upm.etsiinf.is2.grupo11.handlers;

import java.sql.*;

/*
 * Class To handle a Connection and Configuration to a Database
 */
public class Database {
    private static Connection connection;
    private static String driverName = "com.mysql.jdbc.Driver";
    private static String serverName = "localhost";
    private static String userName = "IS2";
    private static String password = "IS2Prac";
    private static String url = "jdbc:mysql://localhost:3306/general";
    private static Database instance;
    /*
     * Creates a connection and Stores it in Connection object
     */

    private Database() {
        try {
            Class.forName(driverName);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }

    public Database getInstance() {
        if (instance == null)
            instance = new Database();
        return instance;
    }

    public boolean createDB(){
        try {
            connection = DriverManager.getConnection(url, userName, password);

            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }

        return true;
    }

}