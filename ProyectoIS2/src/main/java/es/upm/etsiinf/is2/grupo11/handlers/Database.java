package es.upm.etsiinf.is2.grupo11.handlers;

import enums.PCestados;

import java.sql.*;
import java.util.ArrayList;

/*
 * Class To handle a Connection and Configuration to a Database
 */
public final class Database {
    private static Connection connection;
    private static String userName = "IS2";
    private static String password = "IS2Prac";
    private static String url = "jdbc:mysql://localhost:3306/practica";

    private static Database instance;

    private Database() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            createDB();
            register("admin", "admin", "admin@admin.es", 123456789, "Administrador");
            modifyUser("admin", null, null, 0, null, 1);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

    }

    public static synchronized Database getInstance() {
        if (instance == null)
            instance = new Database();
        return instance;
    }

    public static void setInstance(Database instance) {
        Database.instance = instance;
    }

    private boolean createDB() {
        try {
            connection = DriverManager.getConnection(url, userName, password);
            Statement stmt = connection.createStatement();

            String schema = "CREATE DATABASE IF NOT EXISTS `practica` /*!40100 DEFAULT CHARACTER SET utf8 */;";
            stmt.executeUpdate(schema);

            String acta = "CREATE TABLE IF NOT EXISTS `acta` (" +
                    "  `Id` int(11) NOT NULL AUTO_INCREMENT," +
                    "  `Fecha` varchar(10) NOT NULL," +
                    "  `Hora` varchar(5) NOT NULL," +
                    "  `Lugar` varchar(200) NOT NULL," +
                    "  `Asistentes` varchar(2000) DEFAULT NULL," +
                    "  `Puntos` varchar(2000) DEFAULT NULL," +
                    "  `Tiempos` varchar(2000) NOT NULL," +
                    "  PRIMARY KEY (`Id`)," +
                    "  UNIQUE KEY `Id_UNIQUE` (`Id`)" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";

            String agenda = "CREATE TABLE IF NOT EXISTS `agenda` (" +
                    "  `Id` int(11) NOT NULL AUTO_INCREMENT," +
                    "  `Fecha` varchar(10) NOT NULL," +
                    "  `Hora` varchar(5) NOT NULL," +
                    "  `Lugar` varchar(200) NOT NULL," +
                    "  `Asistentes` varchar(2000) NOT NULL," +
                    "  `Puntos` varchar(2000) NOT NULL," +
                    "  `Roles` varchar(2000) NOT NULL," +
                    "  `Tiempos` varchar(2000) NOT NULL," +
                    "  PRIMARY KEY (`Id`)," +
                    "  UNIQUE KEY `Id_UNIQUE` (`Id`)" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";

            String ccc = "CREATE TABLE IF NOT EXISTS `ccc` (" +
                    "  `Nombre` varchar(200) NOT NULL," +
                    "  `Admin` varchar(45) NOT NULL," +
                    "  PRIMARY KEY (`Nombre`)," +
                    "  UNIQUE KEY `Nombre_UNIQUE` (`Nombre`)," +
                    "  KEY `Admin_idx` (`Admin`)," +
                    "  CONSTRAINT `Admin` FOREIGN KEY (`Admin`) REFERENCES `usuario` (`Usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";

            String documnetos = "CREATE TABLE IF NOT EXISTS `documentos` (" +
                    "  `id` int(11) NOT NULL AUTO_INCREMENT," +
                    "  `Documento` varchar(200) NOT NULL," +
                    "  PRIMARY KEY (`id`)," +
                    "  UNIQUE KEY `Documento_UNIQUE` (`Documento`)" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";

            String miembrosCCC = "CREATE TABLE IF NOT EXISTS `miembros_ccc` (" +
                    "  `CCC` varchar(200) NOT NULL," +
                    "  `Usuario` varchar(45) NOT NULL," +
                    "  PRIMARY KEY (`CCC`,`Usuario`)," +
                    "  KEY `Usuario_idx` (`Usuario`)," +
                    "  CONSTRAINT `CCC` FOREIGN KEY (`CCC`) REFERENCES `ccc` (`Nombre`) ON DELETE NO ACTION ON UPDATE NO ACTION," +
                    "  CONSTRAINT `Usuario` FOREIGN KEY (`Usuario`) REFERENCES `usuario` (`Usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";

            String pC = "CREATE TABLE IF NOT EXISTS `pc` (" +
                    "  `ID` int(11) NOT NULL AUTO_INCREMENT," +
                    "  `Fecha` varchar(10) NOT NULL," +
                    "  `Descripcion` varchar(500) NOT NULL," +
                    "  `Motivo` varchar(2000) NOT NULL," +
                    "  `CCC` varchar(200) NOT NULL," +
                    "  `Usuario` varchar(45) NOT NULL," +
                    "  `Reunion` varchar(10) DEFAULT NULL," +
                    "  `Estado` varchar(45) NOT NULL DEFAULT 'evaluacion'," +
                    "  `Historial` varchar(2000) NOT NULL DEFAULT 'evaluacion'," +
                    "  PRIMARY KEY (`ID`)," +
                    "  UNIQUE KEY `ID_UNIQUE` (`ID`)," +
                    "  KEY `ccc_idx` (`CCC`)," +
                    "  KEY `usuario_idx` (`Usuario`)," +
                    "  CONSTRAINT `CCC_eval` FOREIGN KEY (`CCC`) REFERENCES `ccc` (`Nombre`) ON DELETE NO ACTION ON UPDATE NO ACTION," +
                    "  CONSTRAINT `user` FOREIGN KEY (`Usuario`) REFERENCES `usuario` (`Usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";

            String usuario = "CREATE TABLE IF NOT EXISTS `usuario` (" +
                    "  `Usuario` varchar(45) NOT NULL," +
                    "  `Contraseña` varchar(45) NOT NULL," +
                    "  `Telefono` int(9) NOT NULL," +
                    "  `e-mail` varchar(45) NOT NULL," +
                    "  `Tipo` tinyint(1) NOT NULL DEFAULT '0'," +
                    "`Nombre` varchar(200) NOT NULL," +
                    "  PRIMARY KEY (`Usuario`)," +
                    "  UNIQUE KEY `Usuario_UNIQUE` (`Usuario`)" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";

            stmt.executeUpdate(usuario);
            stmt.executeUpdate(agenda);
            stmt.executeUpdate(acta);
            stmt.executeUpdate(ccc);
            stmt.executeUpdate(miembrosCCC);
            stmt.executeUpdate(pC);
            stmt.executeUpdate(documnetos);
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean login(String usr, String pass) {
        boolean ret = false;
        try {
            connection = DriverManager.getConnection(url, userName, password);
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM `usuario` WHERE Usuario LIKE '" + usr + "' AND Contraseña LIKE '" + pass + "';");
            if (rs.next()) {
                ret = true;
            }
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ret;
    }

    public boolean deleteUser(String usr) {
        boolean ret = false;
        try {
            connection = DriverManager.getConnection(url, userName, password);
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM `usuario` WHERE Usuario LIKE '" + usr + "';");
            if (rs.next()) {
                PreparedStatement pr = connection
                        .prepareStatement("DELETE FROM `usuario` WHERE Usuario LIKE '" + usr + "';");
                pr.execute();
                pr.close();
                ret = true;
            }
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ret;
    }

    public boolean register(String usr, String pass, String email, int telf, String nombre) {
        boolean ret = false;
        try {
            connection = DriverManager.getConnection(url, userName, password);

            Statement stmt = connection.createStatement();
            ResultSet rs = stmt
                    .executeQuery("SELECT * FROM `usuario` WHERE Usuario LIKE '" + usr + "';");
            if (!rs.next()) {
                PreparedStatement pr = connection
                        .prepareStatement("INSERT INTO `usuario` (`Usuario`, `Contraseña`, `Telefono`, `e-mail`, `Nombre`)" +
                                " VALUES('" + usr + "','" + pass + "','" + telf + "','" + email + "','" + nombre + "')");
                pr.execute();
                ret = true;
                pr.close();
            }
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            ret = false;
        }
        return ret;
    }

    public boolean modifyUser(String usr, String pass, String email, int telf, String nombre, int tipo) {
        boolean modif = false;
        String sql = "UPDATE `usuario`" +
                "SET ";
        if (pass != null && !pass.equals(""))
            sql += "`Contraseña`='" + pass + "',";
        if (email != null && !email.equals(""))
            sql += "`e-mail`='" + email + "',";
        if (telf > 0)
            sql += "`Telefono`='" + telf + "',";
        if (nombre != null && !nombre.equals(""))
            sql += "`Nombre`='" + nombre + "',";
        if (tipo == 1 || tipo == 0)
            sql += "`Tipo`='" + tipo + "'";
        if (sql.endsWith(","))
            sql = sql.substring(0, sql.lastIndexOf(","));
        sql += "WHERE Usuario LIKE '" + usr + "';";
        try {
            connection = DriverManager.getConnection(url, userName, password);

            Statement stmt = connection.createStatement();
            ResultSet rs = stmt
                    .executeQuery("SELECT * FROM `usuario` WHERE Usuario LIKE '" + usr + "';");
            if (rs.next()) {
                PreparedStatement pr = connection
                        .prepareStatement(sql);
                pr.execute();
                modif = true;
                pr.close();
            }
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }


        return modif;
    }

    public boolean createCCC(String nombre, String admin) {
        boolean crete = false;
        try {
            connection = DriverManager.getConnection(url, userName, password);

            Statement stmt = connection.createStatement();
            ResultSet rs = stmt
                    .executeQuery("SELECT * FROM `ccc` WHERE `Nombre` LIKE '" + nombre + "';");
            if (!rs.next()) {
                PreparedStatement pr = connection
                        .prepareStatement("INSERT INTO `ccc` (`Nombre`, `Admin`)" + " VALUES('" + nombre + "','" + admin + "')");
                pr.execute();
                pr.close();

                //TODO admin en lista de miembros?
                pr = connection
                        .prepareStatement("INSERT INTO `miembros_ccc` (`CCC`, `Usuario`)" + " VALUES('" + nombre + "','" + admin + "')");
                pr.execute();
                pr.close();
                crete = true;
            }
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            crete = false;
        }
        return crete;
    }

    public boolean deleteCCC(String nombre) {
        boolean crete = false;
        try {
            connection = DriverManager.getConnection(url, userName, password);

            Statement stmt = connection.createStatement();
            ResultSet rs = stmt
                    .executeQuery("SELECT * FROM `ccc` WHERE `Nombre` LIKE '" + nombre + "';");
            if (rs.next()) {
                PreparedStatement pr = connection
                        .prepareStatement("DELETE FROM `ccc` WHERE `Nombre` LIKE '" + nombre + "';");
                pr.execute();
                pr.close();
                pr = connection
                        .prepareStatement("DELETE FROM `miembros_ccc` WHERE `CCC` LIKE '" + nombre + "';");
                pr.execute();
                pr.close();
                crete = true;
            }
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            crete = false;
        }
        return crete;
    }

    public boolean addUserCCC(String ccc, String user) {
        boolean added = true;
        try {
            connection = DriverManager.getConnection(url, userName, password);

            Statement stmt = connection.createStatement();
            ResultSet rs = stmt
                    .executeQuery("SELECT * FROM `ccc` WHERE `CCC` LIKE '" + ccc + "' AND `Usuario` LIKE '" + user + "';");
            if (!rs.next()) {
                PreparedStatement pr = connection
                        .prepareStatement("INSERT INTO `miembros_ccc` (`CCC`, `Usuario`)" + " VALUES('" + ccc + "','" + user + "')");
                pr.execute();
                pr.close();
                added = true;
            }
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            added = false;
        }

        return added;
    }

    public boolean deleteUserCCC(String ccc, String user) {
        boolean added = true;
        try {
            connection = DriverManager.getConnection(url, userName, password);
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt
                    .executeQuery("SELECT * FROM `miembros_ccc` WHERE `CCC` LIKE '" + ccc + "' AND `Usuario` LIKE '" + user + "';");
            if (rs.next()) {
                PreparedStatement pr = connection
                        .prepareStatement("DELETE FROM `miembros_ccc` WHERE `CCC` LIKE '" + ccc + "' AND `Usuario` LIKE '" + user + "';");
                pr.execute();
                pr.close();
                added = true;
            }
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            added = false;
        }
        return added;
    }

    public ArrayList<String> getCCCs() {
        ArrayList<String> cccs = new ArrayList<String>();
        try {
            connection = DriverManager.getConnection(url, userName, password);

            Statement stmt = connection.createStatement();
            ResultSet rs = stmt
                    .executeQuery("SELECT * FROM `ccc`;");
            while (rs.next()) {
                String nombre = rs.getString("Nombre");
                cccs.add(nombre);
            }
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cccs;
    }

    public boolean createPC(String fecha, String desc, String motivo, String ccc, String usuario, String reunion) {
        boolean crete = false;
        String aux = "INSERT INTO `pc`(`Fecha`,`Descripcion`,`Motivo`,`CCC`,`Usuario`," +
                "`Reunion`)" + "VALUES('" + fecha + "','" + desc + "','" + motivo + "','" + ccc + "','" +
                usuario + "','" + reunion + "');";
        try {
            connection = DriverManager.getConnection(url, userName, password);

            PreparedStatement pr = connection
                    .prepareStatement(aux);
            pr.execute();
            pr.close();
            crete = true;
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            crete = false;
        }


        return crete;
    }

    public boolean modifyPC(int id, PCestados nombre) {
        boolean modif = false;
        String estados;
        try {
            connection = DriverManager.getConnection(url, userName, password);

            Statement stmt = connection.createStatement();
            ResultSet rs = stmt
                    .executeQuery("SELECT * FROM `pc` WHERE `ID` LIKE '" + id + "';");
            if (rs.next()) {
                estados = rs.getString("`Historial`");
                estados += "&&&" + estados;
                String sql = "UPDATE `pc` SET `Estado`='" + nombre + "', `Historial`='" + estados + "'     WHERE `ID`" +
                        " LIKE '" + id + "';";
                PreparedStatement pr = connection
                        .prepareStatement(sql);
                pr.execute();
                modif = true;
                pr.close();
            }
            stmt.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return modif;
    }
}