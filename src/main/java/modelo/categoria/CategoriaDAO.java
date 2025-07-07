package modelo.categoria;

import util.ConnectionFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {

    public void inserir(Categoria categoria) {
        String sql = "INSERT INTO Categoria (descricao) VALUES (?)";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, categoria.getDescricao());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException("Erro ao inserir categoria: " + ex.getMessage(), ex);
        }
    }

    public List<Categoria> obterTodos() {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT id, descricao FROM Categoria ORDER BY descricao";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Categoria cat = new Categoria();
                cat.setId(rs.getInt("id"));
                cat.setDescricao(rs.getString("descricao"));
                categorias.add(cat);
            }
        } catch (SQLException ex) {
            throw new RuntimeException("Erro ao listar categorias: " + ex.getMessage(), ex);
        }
        return categorias;
    }

    public void atualizar(Categoria categoria) {
        String sql = "UPDATE Categoria SET descricao = ? WHERE id = ?";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, categoria.getDescricao());
            stmt.setInt(2, categoria.getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException("Erro ao atualizar categoria: " + ex.getMessage(), ex);
        }
    }

    public void remover(int id) {
        String sql = "DELETE FROM Categoria WHERE id = ?";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException("Erro ao remover categoria: " + ex.getMessage(), ex);
        }
    }
}