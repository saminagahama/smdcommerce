package controle;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.produto.Produto;
import modelo.produto.ProdutoDAO;

@WebServlet(name = "PrincipalServlet", urlPatterns = {"/principal"})
public class PrincipalServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ProdutoDAO produtoDAO = new ProdutoDAO();
            List<Produto> listaProdutos = produtoDAO.listarDisponiveis();
            request.setAttribute("listaProdutos", listaProdutos);
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Erro ao carregar produtos", e);
        }
    }


}