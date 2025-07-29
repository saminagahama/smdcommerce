package controle.admin;

import modelo.relatorio.RelatorioCliente;
import modelo.relatorio.RelatorioDAO;
import modelo.relatorio.RelatorioEstoque;
import modelo.relatorio.RelatorioProdutoVendido;
import modelo.usuario.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/relatorios")
public class AdminRelatorioServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        // Verifica se o usuário é administrador
        if (usuario == null || !usuario.isAdministrador()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        try {
            RelatorioDAO relatorioDAO = new RelatorioDAO();

            // Busca os dados dos relatórios através do DAO
            List<RelatorioProdutoVendido> produtosMaisVendidos = relatorioDAO.getProdutosMaisVendidos();
            List<RelatorioCliente> clientesMaisCompradores = relatorioDAO.getClientesMaisCompradores();
            List<RelatorioEstoque> produtosEstoqueBaixo = relatorioDAO.getProdutosEstoqueBaixo();

            // Adiciona as listas como atributos na requisição para o JSP
            request.setAttribute("produtosMaisVendidos", produtosMaisVendidos);
            request.setAttribute("clientesMaisCompradores", clientesMaisCompradores);
            request.setAttribute("produtosEstoqueBaixo", produtosEstoqueBaixo);

            // Encaminha para a página JSP para exibir os dados
            request.getRequestDispatcher("/WEB-INF/views/admin/relatorios.jsp").forward(request, response);

        } catch (Exception e) {
            // Em caso de erro, lança uma ServletException
            e.printStackTrace(); // É uma boa prática logar o erro
            throw new ServletException("Erro ao buscar dados para os relatórios", e);
        }
    }
}