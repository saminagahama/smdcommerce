package modelo.categoria;

import static config.Config.JDBC_DRIVER;
import static config.Config.JDBC_SENHA;
import static config.Config.JDBC_URL;
import static config.Config.JDBC_USUARIO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Leonardo Oliveira Moreira
 * 
 * Classe que implementa o padrão DAO para a entidade categoria
 */
public class CategoriaDAO {
       
    /**
     * Método para listar todas as categorias existentes
     * @return 
     */
    public List<Categoria> listar() {
        List<Categoria> categorias = new ArrayList<>();
        try {
            Class.forName(JDBC_DRIVER);
            Connection c = DriverManager.getConnection(JDBC_URL,JDBC_USUARIO, JDBC_SENHA);
            Statement s = c.createStatement();
            ResultSet rs = s.executeQuery("SELECT id, descricao FROM categoria");
            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setId(rs.getInt("id"));
                categoria.setDescricao(rs.getString("descricao"));
                categorias.add(categoria);
            }
            rs.close();
            s.close();
            c.close();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return categorias;
    }
    
    /**
     * Método para inserir uma nova categoria
     * 
     * @param descricao
     * @return 
     */
    public boolean inserir(String descricao) {
        boolean sucesso = false;
        try {
            Class.forName(JDBC_DRIVER);
            Connection c = DriverManager.getConnection(JDBC_URL,JDBC_USUARIO, JDBC_SENHA);
            PreparedStatement ps = c.prepareStatement("INSERT INTO categoria (descricao) VALUES (?)");
            ps.setString(1, descricao);
            sucesso = (ps.executeUpdate() == 1);
            ps.close();
            c.close();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return sucesso;
    }
    
}
