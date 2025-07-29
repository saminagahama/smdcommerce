package modelo.venda;

import modelo.usuario.Usuario;
import modelo.venda_produto.VendaProduto;
import modelo.venda_produto.VendaProdutoDAO;
import util.ConnectionFactory;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class VendaDAO {
    public boolean inserir(Venda venda, List<VendaProduto> itens) {
        String sql = "INSERT INTO venda (data_hora, usuario_id, valor_total) VALUES (?, ?, ?)";
        try (Connection conn = ConnectionFactory.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setTimestamp(1, Timestamp.valueOf(venda.getData_hora()));
            ps.setInt(2, venda.getUsuario() != null ? venda.getUsuario().getId() : 0);
            ps.setBigDecimal(3, venda.getValor_total());
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int vendaId = rs.getInt(1);
                        venda.setId(vendaId);
                        VendaProdutoDAO vendaProdutoDAO = new VendaProdutoDAO();
                        for (VendaProduto vp : itens) {
                            vp.setVenda(venda);
                            vendaProdutoDAO.inserir(vp);
                        }
                      }
                }
                return true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public List<Venda> listarTodas() {
        List<Venda> vendas = new ArrayList<>();
        // Altere para LEFT JOIN para garantir que todas as vendas sejam listadas,
        // mesmo que o usuário associado tenha sido removido.
        String sql = "SELECT v.id, v.data_hora, v.usuario_id, v.valor_total, u.nome, u.email " +
                "FROM venda v LEFT JOIN usuario u ON v.usuario_id = u.id ORDER BY v.data_hora DESC";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Venda venda = new Venda();
                venda.setId(rs.getInt("id"));
                venda.setData_hora(rs.getTimestamp("data_hora").toLocalDateTime());
                venda.setValor_total(rs.getBigDecimal("valor_total"));

                modelo.usuario.Usuario usuario = new modelo.usuario.Usuario();
                usuario.setId(rs.getInt("usuario_id"));
                usuario.setNome(rs.getString("nome")); // Será null se o usuário não for encontrado
                usuario.setEmail(rs.getString("email")); // Será null se o usuário não for encontrado
                venda.setUsuario(usuario);

                // Busca os itens da venda
                VendaProdutoDAO vendaProdutoDAO = new VendaProdutoDAO();
                venda.setItens(vendaProdutoDAO.listarPorVenda(venda.getId()));
                vendas.add(venda);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vendas;
    }

    public List<Venda> listarTodas() {
        List<Venda> vendas = new ArrayList<>();
        String sql = "SELECT v.id, v.data_hora, v.usuario_id, v.valor_total, u.nome, u.email " +
                     "FROM venda v INNER JOIN usuario u ON v.usuario_id = u.id ORDER BY v.data_hora DESC";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Venda venda = new Venda();
                venda.setId(rs.getInt("id"));
                venda.setData_hora(rs.getTimestamp("data_hora").toLocalDateTime());
                venda.setValor_total(rs.getBigDecimal("valor_total"));
                modelo.usuario.Usuario usuario = new modelo.usuario.Usuario();
                usuario.setId(rs.getInt("usuario_id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setEmail(rs.getString("email"));
                venda.setUsuario(usuario);
                // Busca os itens da venda
                VendaProdutoDAO vendaProdutoDAO = new VendaProdutoDAO();
                venda.setItens(vendaProdutoDAO.listarPorVenda(venda.getId()));
                vendas.add(venda);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return vendas;
    }

    // Em modelo/venda/VendaDAO.java
    public void excluirVenda(int vendaId) throws SQLException {
        String sqlDeleteItens = "DELETE FROM Venda_Produto WHERE venda_id = ?";
        String sqlDeleteVenda = "DELETE FROM Venda WHERE id = ?";

        Connection conn = null;
        try {
            conn = ConnectionFactory.getConnection();
            conn.setAutoCommit(false); // Inicia a transação

            // 1. Exclui os itens da venda (try-with-resources)
            try (PreparedStatement stmtItens = conn.prepareStatement(sqlDeleteItens)) {
                stmtItens.setInt(1, vendaId);
                stmtItens.executeUpdate();
            }

            // 2. Exclui a venda (try-with-resources)
            try (PreparedStatement stmtVenda = conn.prepareStatement(sqlDeleteVenda)) {
                stmtVenda.setInt(1, vendaId);
                stmtVenda.executeUpdate();
            }

            conn.commit(); // Confirma a transação se tudo deu certo

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Desfaz a transação em caso de erro
                } catch (SQLException ex) {
                    ex.printStackTrace(); // Log do erro de rollback
                }
            }
            e.printStackTrace();
            throw e; // Propaga a exceção original
        } finally {
            if (conn != null) {
                try {
                    conn.close(); // Fecha a conexão principal
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
