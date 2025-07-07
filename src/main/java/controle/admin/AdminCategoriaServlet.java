package controle.admin;

import modelo.categoria.Categoria;
import modelo.categoria.CategoriaDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categorias")
public class AdminCategoriaServlet extends HttpServlet {

    private final CategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        // Se a ação for "remover", executa a remoção e redireciona
        if ("remover".equals(acao)) {
            try {
                removerCategoria(request);
                response.sendRedirect(request.getContextPath() + "/admin/categorias");
                return; // Importante para parar a execução aqui
            } catch (Exception e) {
                throw new ServletException("Erro ao remover categoria", e);
            }
        }

        // Comportamento padrão: listar todas as categorias
        List<Categoria> categorias = categoriaDAO.obterTodos();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("/WEB-INF/views/admin/gerenciar-categorias.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String acao = request.getParameter("acao");

        if (acao == null) {
            acao = "inserir";
        }

        try {
            switch (acao) {
                case "atualizar":
                    atualizarCategoria(request);
                    break;
                case "inserir":
                default:
                    inserirCategoria(request);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Erro ao processar requisição de categoria", e);
        }

        response.sendRedirect(request.getContextPath() + "/admin/categorias");
    }

    private void inserirCategoria(HttpServletRequest request) {
        String descricao = request.getParameter("descricao");
        if (descricao != null && !descricao.trim().isEmpty()) {
            Categoria novaCategoria = new Categoria();
            novaCategoria.setDescricao(descricao);
            categoriaDAO.inserir(novaCategoria);
        }
    }

    private void atualizarCategoria(HttpServletRequest request) {
        String descricao = request.getParameter("descricao");
        int id = Integer.parseInt(request.getParameter("id"));

        if (descricao != null && !descricao.trim().isEmpty()) {
            Categoria categoria = new Categoria();
            categoria.setId(id);
            categoria.setDescricao(descricao);
            categoriaDAO.atualizar(categoria);
        }
    }

    private void removerCategoria(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        categoriaDAO.remover(id);
    }
}