package es.upm.etsiinf.is2.grupo11.handlers;

import java.sql.*;
/*
 * Class To handle a Connection and Configuration to a Database
 */
public class Database {
    Connection connection;
    String driverName = "com.mysql.jdbc.Driver";
    String serverName = "localhost";
    String userName = "root";
    String password = "nitdgp";
    String url = "jdbc:mysql://localhost:3306/training";
    /*
     * Creates a connection and Stores it in Connection object
     */
    public boolean doConnection()
    {

        try{
            Class.forName(driverName);

            connection = DriverManager.getConnection(url,userName,password);
        }
        catch(ClassNotFoundException e)
        {
            System.out.println("aaaa"+e.getMessage());
            return false;
        }
        catch(SQLException e)
        {
            System.out.println("abc "+e.getMessage());
            return false;
        }
        return true;
    }
    /*
     * Closes The current Connection to the Databases
     */
    public boolean closeConnection()
    {
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public Connection getConnect()
    {
        return connection;
    }
}