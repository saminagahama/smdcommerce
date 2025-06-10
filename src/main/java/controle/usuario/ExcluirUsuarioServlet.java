package controle.usuario;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import modelo.usuario.Usuario;
import modelo.usuario.UsuarioDAO;

@WebServlet("/ExcluirUsuario")
public class ExcluirUsuarioServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession sessao = request.getSession(false);
        Usuario usuario = (sessao != null) ? (Usuario) sessao.getAttribute("usuario") : null;
        response.setContentType("text/html;charset=UTF-8");
        if (usuario == null) {
            response.getWriter().write("<div class='error-message'>Sessão expirada. Faça login novamente.</div>");
            return;
        }
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        boolean sucesso = usuarioDAO.excluirUsuario(usuario.getId());
        if (sucesso) {
            sessao.invalidate();
            response.getWriter().write("<div class='sucesso-message'></div>");
        } else {
            response.getWriter().write("<div class='error-message'>Erro ao excluir conta.</div>");
        }
    }
}
