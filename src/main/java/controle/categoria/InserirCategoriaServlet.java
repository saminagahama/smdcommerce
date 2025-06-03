package controle.categoria;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.categoria.CategoriaDAO;

/**
 *
 * @author Leonardo Oliveira Moreira
 *
 * Classe de controle para inserir uma nova categoria
 */
public class InserirCategoriaServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // entrada
        String descricao = request.getParameter("descricao");
        // processamento
        CategoriaDAO categoriaDAO = new CategoriaDAO();
        boolean sucesso = categoriaDAO.inserir(descricao);
        // saída
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>smd e-commerce</title>");
            out.println("</head>");
            out.println("<body>");
            if (sucesso) {
                out.println("<h1>Categoria inserida com sucesso</h1>");
            } else {
                out.println("<h1>Não foi possível inserir a categoria</h1>");
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

}
