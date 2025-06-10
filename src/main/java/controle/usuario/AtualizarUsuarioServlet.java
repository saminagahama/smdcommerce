package controle.usuario;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import modelo.usuario.Usuario;
import modelo.usuario.UsuarioDAO;
import javax.servlet.annotation.MultipartConfig;

@WebServlet("/AtualizarUsuario")
@MultipartConfig
public class AtualizarUsuarioServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession sessao = request.getSession(false);
        Usuario usuario = (sessao != null) ? (Usuario) sessao.getAttribute("usuario") : null;
        if (usuario == null) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<div class='error-message'>Sessão expirada. Faça login novamente.</div>");
            return;
        }
        String nome = request.getParameter("nome");
        String endereco = request.getParameter("endereco");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        boolean sucesso = usuarioDAO.atualizarUsuario(usuario.getId(), nome, endereco, email, senha);

        if (sucesso) {
            usuario.setNome(nome);
            usuario.setEndereco(endereco);
            usuario.setEmail(email);
            if (senha != null && !senha.isEmpty()) {
                usuario.setSenha(senha);
            }
            sessao.setAttribute("usuario", usuario);
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<div class='success-message'>Dados atualizados com sucesso!</div>");
        } else {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<div class='error-message'>Erro ao atualizar dados.</div>");
        }
    }
}
