package controle.usuario;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import modelo.usuario.Usuario;

@WebServlet("/MinhaConta")
public class MinhaContaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession sessao = request.getSession(false);
        Usuario usuario = (sessao != null) ? (Usuario) sessao.getAttribute("usuario") : null;
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        request.setAttribute("usuario", usuario);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/minha-conta.jsp");
        rd.forward(request, response);
    }
}
