package modelo.produto;

import static config.Config.JDBC_DRIVER;
import static config.Config.JDBC_SENHA;
import static config.Config.JDBC_URL;
import static config.Config.JDBC_USUARIO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdutoDAO {
    public static List<Produto> listar() {
        List<Produto> produtos = new ArrayList<>();
        try {
            Class.forName(JDBC_DRIVER);
            Connection c = DriverManager.getConnection(JDBC_URL,JDBC_USUARIO, JDBC_SENHA);
            Statement s = c.createStatement();
            ResultSet rs = s.executeQuery("SELECT id, descricao, preco, image FROM produto");
            while (rs.next()) {
                Produto produto = new Produto();
                produto.setId(rs.getInt("id"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setPreco(rs.getBigDecimal("preco"));
                produto.setFoto(rs.getString("image"));
                produtos.add(produto);
            }
            rs.close();
            s.close();
            c.close();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
        return produtos;
    }

    public boolean inserir(String descricao) {
        boolean sucesso = false;
        try {
            Class.forName(JDBC_DRIVER);
            Connection c = DriverManager.getConnection(JDBC_URL,JDBC_USUARIO, JDBC_SENHA);
            PreparedStatement ps = c.prepareStatement("INSERT INTO produto (descricao) VALUES (?)");
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
