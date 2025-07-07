package controle;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.produto.Produto;
import modelo.produto.ProdutoDAO;

@WebServlet("/imagem")
public class ImagemServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            int id = Integer.parseInt(idParam);
            ProdutoDAO produtoDAO = new ProdutoDAO();
            Produto produto = produtoDAO.obterPorId(id);

            if (produto != null && produto.getFotoBytes() != null && produto.getFotoBytes().length > 0) {
                byte[] fotoBytes = produto.getFotoBytes();
                response.setContentType("image/jpeg");
                response.setContentLength(fotoBytes.length);
                response.getOutputStream().write(fotoBytes);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de produto inválido.");
        } catch (Exception e) {
            throw new ServletException("Erro ao servir imagem", e);
        }
    }
}