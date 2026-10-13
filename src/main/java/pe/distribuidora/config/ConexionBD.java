package pe.distribuidora.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    // 1. Instancia única del patrón Singleton
    private static ConexionBD instancia;
    private Connection conexion;

    // 2. Constructor privado
    private ConexionBD() {
        conectar();
    }

    // 3. Método para obtener la instancia única
    public static synchronized ConexionBD getInstancia() {
        if (instancia == null) {
            instancia = new ConexionBD();
        }
        return instancia;
    }

    // 4. Lógica de conexión con soporte para nube y local
    private void conectar() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Lee variables de entorno si estamos en Railway/Render, o usa valores locales
            String host = System.getenv("MYSQLHOST") != null ? System.getenv("MYSQLHOST") : "localhost";
            String port = System.getenv("MYSQLPORT") != null ? System.getenv("MYSQLPORT") : "3306";
            String dbName = System.getenv("MYSQLDATABASE") != null ? System.getenv("MYSQLDATABASE") : "sistema_cobranzas";
            String user = System.getenv("MYSQLUSER") != null ? System.getenv("MYSQLUSER") : "root";
            String pass = System.getenv("MYSQLPASSWORD") != null ? System.getenv("MYSQLPASSWORD") : "root";

            String url = "jdbc:mysql://" + host + ":" + port + "/" + dbName 
                    + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

            this.conexion = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error de conexión a la base de datos: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // 5. Método para entregar la conexión activa
    public Connection getConnection() {
        try {
            if (this.conexion == null || this.conexion.isClosed()) {
                conectar();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return this.conexion;
    }
}