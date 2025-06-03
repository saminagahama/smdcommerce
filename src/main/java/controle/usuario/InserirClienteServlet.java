package controle.usuario;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.usuario.UsuarioDAO;

/**
 *
 * @author Leonardo Oliveira Moreira
 *
 * Classe de controle para inserir um novo cliente
 */
public class InserirClienteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // entrada
        String nome = request.getParameter("nome");
        String endereco = request.getParameter("endereco");
        String email = request.getParameter("email");
        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        // processamento
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        boolean sucesso = usuarioDAO.inserirCliente(nome, endereco, email, login, senha);
        // saída
        if (sucesso) {
            request.setAttribute("mensagem", "Cliente inserido com sucesso");
        } else {
            request.setAttribute("mensagem", "Não foi possível inserir o cliente");
        }
        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.forward(request, response);
    }

}
