package controle.produto;

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

@WebServlet("/produtos")
public class ProdutoServlet extends HttpServlet {
	protected void doGet(
			HttpServletRequest request,
			HttpServletResponse response
	) {
		String action = request.getParameter("action");
		
		if (action == null) {
			action = "listar";
		}

		try {
			switch(action) {
				case "novo":
					break;
				default:
					case "listar":
						listarTodosProdutos(request, response);
						break;
			}
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private void listarTodosProdutos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		List<Produto> produtos = ProdutoDAO.listar();
		response.setContentType("text/html;charset=UTF-8");
		if (produtos == null || produtos.isEmpty()) {
			response.getWriter().write("");
			return;
		}
		request.setAttribute("produtos", produtos);
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/gradeproduto.jsp");
        dispatcher.include(request, response);
	}
}
