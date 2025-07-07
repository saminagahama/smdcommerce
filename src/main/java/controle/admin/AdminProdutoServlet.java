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
            // Obtenção dos parâmetros do formulário
            String idParam = request.getParameter("id");
            String descricao = request.getParameter("descricao");
            BigDecimal preco = new BigDecimal(request.getParameter("preco"));
            int quantidade = Integer.parseInt(request.getParameter("quantidade"));
            int categoriaId = Integer.parseInt(request.getParameter("categoriaId"));

            // Obtenção da parte do arquivo (foto)
            Part fotoPart = request.getPart("foto");
            byte[] fotoBytes = null;

            // Lê os bytes do arquivo se um novo arquivo foi enviado
            if (fotoPart != null && fotoPart.getSize() > 0) {
                try (InputStream inputStream = fotoPart.getInputStream()) {
                    fotoBytes = inputStream.readAllBytes();
                }
            }

            // Montagem do objeto Categoria
            Categoria categoria = new Categoria();
            categoria.setId(categoriaId);

            // Montagem do objeto Produto
            Produto produto = new Produto();
            produto.setDescricao(descricao);
            produto.setPreco(preco);
            produto.setQuantidade(quantidade);
            produto.setCategoria(categoria);
            produto.setFotoBytes(fotoBytes); // Define os bytes da imagem

            if (idParam == null || idParam.isEmpty()) {
                // Inserir novo produto
                produtoDAO.inserir(produto);
            } else {
                // Atualizar produto existente
                int id = Integer.parseInt(idParam);
                produto.setId(id);

                // Se nenhuma nova foto foi enviada, mantém a foto antiga
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
        List<Categoria> categorias = categoriaDAO.obterTodos(); // Busca as categorias
        request.setAttribute("produtos", produtos);
        request.setAttribute("categorias", categorias); // Adiciona as categorias à requisição
        request.getRequestDispatcher("/WEB-INF/views/admin/gerenciar-produtos.jsp").forward(request, response);
    }
}