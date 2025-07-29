package modelo.venda_produto;

import modelo.produto.Produto;
import util.ConnectionFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class VendaProdutoDAO {
    public boolean inserir(VendaProduto vp) {
        String sql = "INSERT INTO venda_produto (venda_id, produto_id, quantidade, preco) VALUES (?, ?, ?, ?)";
        try (Connection conn = ConnectionFactory.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, vp.getVenda().getId());
            ps.setInt(2, vp.getProduto().getId());
            ps.setInt(3, vp.getQuantidade());
            ps.setBigDecimal(4, vp.getPreco());
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public List<VendaProduto> listarPorVenda(int vendaId) {
        List<VendaProduto> itens = new ArrayList<>();
        String sql = "SELECT vp.produto_id, vp.quantidade, vp.preco, p.descricao " +
                     "FROM venda_produto vp INNER JOIN produto p ON vp.produto_id = p.id WHERE vp.venda_id = ?";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, vendaId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    VendaProduto vp = new VendaProduto();
                    Produto produto = new Produto();
                    produto.setId(rs.getInt("produto_id"));
                    produto.setDescricao(rs.getString("descricao"));
                    vp.setProduto(produto);
                    vp.setQuantidade(rs.getInt("quantidade"));
                    vp.setPreco(rs.getBigDecimal("preco"));
                    itens.add(vp);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return itens;
    }
}
