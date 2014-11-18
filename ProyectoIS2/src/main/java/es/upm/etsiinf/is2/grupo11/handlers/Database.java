package es.upm.etsiinf.is2.grupo11.handlers;

import java.sql.*;

/*
 * Class To handle a Connection and Configuration to a Database
 */
public final class Database {
    private static Connection connection;
    private static String serverName = "localhost";
    private static String userName = "IS2";
    private static String password = "IS2Prac";
    private static String url = "jdbc:mysql://localhost:3306/practica";

    private static Database instance;

    private Database() {
//        String driverName = "com.mysql.jdbc.Driver";
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
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

    public boolean createDB() {
        try {
            connection = DriverManager.getConnection(url, userName, password);
            Statement stmt = connection.createStatement();

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
            ResultSet rs = stmt
                    .executeQuery("SELECT * FROM `usuario` WHERE Usuario LIKE '"
                            + usr + "' AND Contraseña LIKE '" + pass + "';");
            while (rs.next()) {
                String id = rs.getString("Usuario");
                String passw = rs.getString("Contraseña");
                ret = true;
            }
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return ret;
    }

    public boolean register(String usr, String pass, String email, int telf, String nombre) {
        boolean ret = false;
        try {
            connection = DriverManager.getConnection(url, userName, password);

            Statement stmt = connection.createStatement();
            ResultSet rs = stmt
                    .executeQuery("SELECT * FROM `usuario` WHERE Usuario LIKE '"
                            + usr + "';");
            if (!rs.next()) {
                PreparedStatement pr = connection
                        .prepareStatement("INSERT INTO `usuario` (`Usuario`, `Contraseña`, `Telefono`, `e-mail`, `Nombre`)" +
                                " VALUES('" + usr + "','" + pass + "','" + telf + "','" + email + "','" + nombre + "')");
                pr.execute();
                ret = true;
            }
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return ret;
    }
}