package controle.acesso;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import modelo.acesso.TokenDAO;
import modelo.usuario.Usuario;
import modelo.usuario.UsuarioDAO;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("usuario") == null) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("lembrar-me".equals(cookie.getName())) {
                        String tokenValor = cookie.getValue();

                        TokenDAO tokenDAO = new TokenDAO();
                        Integer usuarioId = tokenDAO.obterUsuarioIdPeloToken(tokenValor);
                        if (usuarioId != null) {
                            UsuarioDAO usuarioDAO = new UsuarioDAO();
                            Usuario usuario = usuarioDAO.obterPorId(usuarioId);
                            if (usuario != null) {
                                session = request.getSession(true);
                                session.setAttribute("usuario", usuario);
                            }
                        }
                        break;
                    }
                }
            }
        }
        chain.doFilter(req, res);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }


    @Override
    public void destroy() {

    }
}