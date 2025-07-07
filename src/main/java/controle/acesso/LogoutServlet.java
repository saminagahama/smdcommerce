package controle.acesso;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;
import modelo.acesso.TokenDAO; // Importação adicionada

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("lembrar-me".equals(c.getName())) {
                    String tokenValor = c.getValue();
                    if (tokenValor != null && !tokenValor.isEmpty()) {
                        TokenDAO tokenDAO = new TokenDAO();
                        tokenDAO.excluirPeloToken(tokenValor);
                    }
                    break;
                }
            }
        }

        Cookie cookie = new Cookie("lembrar-me", "");
        cookie.setMaxAge(0);
        cookie.setPath(request.getContextPath());
        response.addCookie(cookie);

        HttpSession sessao = request.getSession(false);
        if (sessao != null) {
            sessao.invalidate();
        }

        response.sendRedirect(request.getContextPath() + "/");
    }
}