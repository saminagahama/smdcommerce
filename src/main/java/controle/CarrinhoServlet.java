package controle;

import modelo.carrinho.CarrinhoItem;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CarrinhoServlet")
public class CarrinhoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        List<CarrinhoItem> carrinho = (List<CarrinhoItem>) session.getAttribute("carrinho");
        if (carrinho == null) carrinho = new ArrayList<>();

        String acao = request.getParameter("acao");
        if (acao == null) {
            // Adicionar produto
            String json = request.getReader().lines().reduce("", (a, b) -> a + b);
            // Parse simples (use uma lib JSON para produção)
            int id = Integer.parseInt(json.replaceAll(".*\"id\":(\\d+).*", "$1"));
            String descricao = json.replaceAll(".*\"descricao\":\"([^\"]+)\".*", "$1");
            double preco = Double.parseDouble(json.replaceAll(".*\"preco\":([\\d\\.]+).*", "$1"));
            int quantidade = Integer.parseInt(json.replaceAll(".*\"quantidade\":(\\d+).*", "$1"));
            boolean found = false;
            for (CarrinhoItem item : carrinho) {
                if (item.getId() == id) {
                    item.setQuantidade(item.getQuantidade() + quantidade);
                    found = true;
                    break;
                }
            }
            if (!found) {
                carrinho.add(new CarrinhoItem(id, descricao, preco, quantidade));
            }
        } else if ("remover".equals(acao)) {
            int id = Integer.parseInt(request.getParameter("id"));
            carrinho.removeIf(item -> item.getId() == id);
        } else if ("finalizar".equals(acao)) {
            // Finalizar compra (implementar lógica)
            session.removeAttribute("carrinho");
            response.sendRedirect(request.getContextPath() + "/MeusPedidos?sucesso=Compra realizada");
            return;
        }
        session.setAttribute("carrinho", carrinho);
        response.sendRedirect(request.getContextPath() + "/carrinho.jsp");
    }
}
