package modelo.relatorio;

import util.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RelatorioDAO {

    public List<RelatorioProdutoVendido> getProdutosMaisVendidos() throws SQLException {
        List<RelatorioProdutoVendido> lista = new ArrayList<>();
        String sql = "SELECT p.nome as produto_nome, " +
                "SUM(vp.quantidade) as quantidade_vendida, " +
                "SUM(vp.quantidade * vp.preco_unitario) as receita_total " +
                "FROM venda_produto vp " +
                "JOIN produto p ON vp.produto_id = p.id " +
                "GROUP BY p.id, p.nome " +
                "ORDER BY receita_total DESC LIMIT 10";

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                RelatorioProdutoVendido item = new RelatorioProdutoVendido();
                item.setProdutoNome(rs.getString("produto_nome"));
                item.setQuantidadeVendida(rs.getInt("quantidade_vendida"));
                item.setReceitaTotal(rs.getDouble("receita_total"));
                lista.add(item);
            }
        }
        return lista;
    }

    public List<RelatorioCliente> getClientesMaisCompradores() throws SQLException {
        List<RelatorioCliente> lista = new ArrayList<>();
        String sql = "SELECT u.nome as cliente_nome, " +
                "COUNT(v.id) as total_pedidos, " +
                "SUM(v.valor_total) as valor_total_gasto " +
                "FROM venda v " +
                "JOIN usuario u ON v.usuario_id = u.id " +
                "GROUP BY u.id, u.nome " +
                "ORDER BY valor_total_gasto DESC LIMIT 10";

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                RelatorioCliente item = new RelatorioCliente();
                item.setClienteNome(rs.getString("cliente_nome"));
                item.setTotalPedidos(rs.getInt("total_pedidos"));
                item.setValorTotalGasto(rs.getDouble("valor_total_gasto"));
                lista.add(item);
            }
        }
        return lista;
    }

    public List<RelatorioEstoque> getProdutosEstoqueBaixo() throws SQLException {
        List<RelatorioEstoque> lista = new ArrayList<>();
        // Define o limite de estoque baixo como 10 unidades
        String sql = "SELECT p.nome as produto_nome, c.nome as categoria_nome, p.estoque " +
                "FROM produto p " +
                "JOIN categoria c ON p.categoria_id = c.id " +
                "WHERE p.estoque < 10 " +
                "ORDER BY p.estoque ASC";

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                RelatorioEstoque item = new RelatorioEstoque();
                item.setProdutoNome(rs.getString("produto_nome"));
                item.setCategoriaNome(rs.getString("categoria_nome"));
                item.setQuantidadeEstoque(rs.getInt("estoque"));
                lista.add(item);
            }
        }
        return lista;
    }
}