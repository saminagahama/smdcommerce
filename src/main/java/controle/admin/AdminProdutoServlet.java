package controle.admin;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.categoria.Categoria;
import modelo.categoria.CategoriaDAO;
import modelo.produto.Produto;
import modelo.produto.ProdutoDAO;

@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
@WebServlet("/admin/produtos")
public class AdminProdutoServlet extends HttpServlet {

    private final ProdutoDAO produtoDAO = new ProdutoDAO();
    private final CategoriaDAO categoriaDAO = new CategoriaDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            String idParam = request.getParameter("id");
            String descricao = request.getParameter("descricao");
            BigDecimal preco = new BigDecimal(request.getParameter("preco"));
            int quantidade = Integer.parseInt(request.getParameter("quantidade"));
            int categoriaId = Integer.parseInt(request.getParameter("categoriaId"));

            Part fotoPart = request.getPart("foto");
            byte[] fotoBytes = null;

            if (fotoPart != null && fotoPart.getSize() > 0) {
                try (InputStream inputStream = fotoPart.getInputStream()) {
                    fotoBytes = inputStream.readAllBytes();
                }
            }

            Categoria categoria = new Categoria();
            categoria.setId(categoriaId);

            Produto produto = new Produto();
            produto.setDescricao(descricao);
            produto.setPreco(preco);
            produto.setQuantidade(quantidade);
            produto.setCategoria(categoria);
            produto.setFotoBytes(fotoBytes);

            if (idParam == null || idParam.isEmpty()) {
                produtoDAO.inserir(produto);
            } else {
                int id = Integer.parseInt(idParam);
                produto.setId(id);

                if (fotoBytes == null || fotoBytes.length == 0) {
                    Produto produtoExistente = produtoDAO.obterPorId(id);
                    if (produtoExistente != null) {
                        produto.setFotoBytes(produtoExistente.getFotoBytes());
                    }
                }
                produtoDAO.atualizar(produto);
            }

            response.sendRedirect(request.getContextPath() + "/admin/produtos");

        } catch (NumberFormatException e) {
            request.setAttribute("erro", "Erro: Preço e quantidade devem ser números válidos.");
            listarTodos(request, response);
        } catch (Exception e) {
            throw new ServletException("Erro ao salvar produto", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                action = "listar";
            }

            switch (action) {
                case "editar":
                    int idEditar = Integer.parseInt(request.getParameter("id"));
                    Produto produtoParaEditar = produtoDAO.obterPorId(idEditar);
                    request.setAttribute("produto", produtoParaEditar);
                    listarTodos(request, response);
                    break;
                case "remover":
                    int idRemover = Integer.parseInt(request.getParameter("id"));
                    produtoDAO.remover(idRemover);
                    response.sendRedirect(request.getContextPath() + "/admin/produtos");
                    break;
                default:
                    listarTodos(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("Erro no servlet de admin de produtos", e);
        }
    }

    private void listarTodos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Produto> produtos = produtoDAO.obterTodos();
        List<Categoria> categorias = categoriaDAO.obterTodos();
        request.setAttribute("produtos", produtos);
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("/WEB-INF/views/admin/gerenciar-produtos.jsp").forward(request, response);
    }
}