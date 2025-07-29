package controle.usuario;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;

import modelo.usuario.Usuario;
import modelo.usuario.UsuarioDAO;

/**
 *
 * @author Leonardo Oliveira Moreira
 *
 * Classe de controle para inserir um novo cliente
 */
@WebServlet("/CadastroCliente")
@MultipartConfig
public class InserirClienteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String endereco = request.getParameter("endereco");
        String email = request.getParameter("email");
        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = new Usuario(nome, endereco, email, login, senha);
        String mensagem;
        try {
        	usuarioDAO.inserir(usuario);
        	mensagem = "<div class='mensagem-cadastro'>Cliente inserido com sucesso</div>";
        } catch (Exception err) {
            err.printStackTrace();
        	mensagem = "<div class='mensagem-cadastro'>Não foi possível inserir o cliente</div>";
        }
        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().write(mensagem);
    }

}
