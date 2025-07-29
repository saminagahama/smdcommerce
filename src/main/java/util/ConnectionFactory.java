package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import config.Config;

public class ConnectionFactory {
    private static final String JDBC_URL = "jdbc:postgresql://localhost:5432/251web";
    private static final String JDBC_USUARIO = Config.JDBC_USUARIO;
    private static final String JDBC_SENHA = Config.JDBC_SENHA;

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver JDBC do PostgreSQL não encontrado.", e);
        }
    }

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(JDBC_URL, JDBC_USUARIO, JDBC_SENHA);
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao conectar ao banco de dados. Verifique a URL, usuário e senha.", e);
        }
    }
}