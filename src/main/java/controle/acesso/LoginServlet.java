package controle.acesso;

import java.io.IOException;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.usuario.Usuario;
import modelo.usuario.UsuarioDAO;
import modelo.acesso.TokenDAO; // Importação adicionada
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;

@WebServlet("/Login")
@MultipartConfig
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.obter(login, senha);
        if (usuario == null) {
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().write("<span style='color:red;'>Credenciais incorretas</span>");
            } else {
                request.setAttribute("mensagem", "Credenciais incorretas");
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
            }
        } else {
            HttpSession sessao = request.getSession(true);
            sessao.setAttribute("usuario", usuario);

            String lembrar = request.getParameter("lembrar");
            if (lembrar != null && lembrar.equals("on")) {
                String tokenValor = UUID.randomUUID().toString();

                TokenDAO tokenDAO = new TokenDAO();
                tokenDAO.salvar(tokenValor, usuario.getId());

                Cookie cookie = new Cookie("lembrar-me", tokenValor);
                cookie.setMaxAge(30 * 24 * 60 * 60); // Expira em 30 dias
                cookie.setPath(request.getContextPath());
                response.addCookie(cookie);
            }

            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                response.setContentType("text/html;charset=UTF-8");
                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/menu-usuario.jsp");
                rd.include(request, response);
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("principal.jsp");
                rd.forward(request, response);
            }
        }
    }
}