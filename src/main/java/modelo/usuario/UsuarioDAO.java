package modelo.usuario;

import java.sql.*;
import static config.Config.*;

/**
 *
 * @author Leonardo Oliveira Moreira
 * 
 * Classe que implementa o padrão DAO para a entidade usuário
 */
public class UsuarioDAO {

    /**
     * Método para inserir um novo cliente
     * 
     * @param nome
     * @param endereco
     * @param email
     * @param login
     * @param senha
     * @return 
     */
    public boolean inserirCliente(String nome, String endereco, String email, String login, String senha) {
        boolean sucesso = false;
        try {
            Class.forName(JDBC_DRIVER);
            Connection c = DriverManager.getConnection(JDBC_URL, JDBC_USUARIO, JDBC_SENHA);
            PreparedStatement s = c.prepareStatement("INSERT INTO usuario (nome, endereco, email, login, senha, administrador) VALUES (?, ?, ?, ?, ?, FALSE)");
            s.setString(1, nome);
            s.setString(2, endereco);
            s.setString(3, email);
            s.setString(4, login);
            s.setString(5, senha);
            sucesso = (s.executeUpdate() == 1);
            s.close();
            c.close();
        } catch (Exception ex) {
            sucesso = false;
        }
        return sucesso;
    }

    /**
     * Método para inserir um novo administrador
     * 
     * @param nome
     * @param endereco
     * @param email
     * @param login
     * @param senha
     * @return 
     */
    public boolean inserirAdministrador(String nome, String endereco, String email, String login, String senha) {
        boolean sucesso = false;
        try {
            Class.forName(JDBC_DRIVER);
            Connection c = DriverManager.getConnection(JDBC_URL, JDBC_USUARIO, JDBC_SENHA);
            PreparedStatement s = c.prepareStatement("INSERT INTO usuario (nome, endereco, email, login, senha, administrador) VALUES (?, ?, ?, ?, ?, TRUE)");
            s.setString(1, nome);
            s.setString(2, endereco);
            s.setString(3, email);
            s.setString(4, login);
            s.setString(5, senha);
            sucesso = (s.executeUpdate() == 1);
            s.close();
            c.close();
        } catch (Exception ex) {
            sucesso = false;
        }
        return sucesso;
    }

    public Usuario obter(String login, String senha) {
        Usuario usuario = null;
        try {
            Class.forName(JDBC_DRIVER);
            Connection c = DriverManager.getConnection(JDBC_URL, JDBC_USUARIO, JDBC_SENHA);
            PreparedStatement s = c.prepareStatement("SELECT id, nome, endereco, email, login, senha, administrador FROM usuario WHERE login = ? AND senha = ?");
            s.setString(1, login);
            s.setString(2, senha);
            ResultSet rs = s.executeQuery();
            while (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setEndereco(rs.getString("endereco"));
                usuario.setEmail(rs.getString("email"));
                usuario.setLogin(rs.getString("login"));
                usuario.setSenha(rs.getString("senha"));
                usuario.setAdministrador(rs.getBoolean("administrador"));
            }
            rs.close();
            s.close();
            c.close();
        } catch (Exception ex) {
            System.err.println("Erro ao obter usuário: " + ex.getMessage());
            usuario = null;
        }
        return usuario;
    }

}
