package modelo.acesso;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import util.ConnectionFactory;

public class TokenDAO {

    public void salvar(String token, int usuarioId) {
        String sql = "INSERT INTO tokens (token, usuario_id, data_expiracao) VALUES (?, ?, ?)";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            stmt.setInt(2, usuarioId);
            // Define a expiração para 30 dias a partir de agora
            stmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now().plusDays(30)));
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao salvar o token no banco de dados", e);
        }
    }

    public Integer obterUsuarioIdPeloToken(String token) {
        String sql = "SELECT usuario_id FROM tokens WHERE token = ? AND data_expiracao > NOW()";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("usuario_id");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao obter usuário pelo token", e);
        }
        return null;
    }

    public void excluirPeloToken(String token) {
        String sql = "DELETE FROM tokens WHERE token = ?";
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao excluir o token", e);
        }
    }
}