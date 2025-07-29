package controle.admin;

import modelo.usuario.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/relatorios")
public class AdminRelatorioServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;
        if (usuario == null || !usuario.isAdministrador()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/admin/relatorios.jsp").forward(request, response);
    }
}
