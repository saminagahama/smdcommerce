package controle;

import modelo.carrinho.CarrinhoItem;
import modelo.venda.Venda;
import modelo.venda.VendaDAO;
import modelo.venda_produto.VendaProduto;
import modelo.venda_produto.VendaProdutoDAO;
import modelo.usuario.Usuario;
import modelo.produto.Produto;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
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
        request.setCharacterEncoding("UTF-8");

        if (acao == null) {
            String contentType = request.getContentType();
            if (contentType != null && contentType.contains("application/json")) {
                String json = request.getReader().lines().reduce("", (a, b) -> a + b);
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
                session.setAttribute("carrinho", carrinho);
                response.setStatus(HttpServletResponse.SC_OK);
                return;
            }
        } else if ("remover".equals(acao)) {
            int id = Integer.parseInt(request.getParameter("id"));
            carrinho.removeIf(item -> item.getId() == id);
        } else if ("finalizar".equals(acao)) {
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            if (usuario == null) {
                // Salva o carrinho temporariamente para restaurar após cadastro
                session.setAttribute("carrinho_pendente", carrinho);
                response.sendRedirect(request.getContextPath() + "/cadastro.jsp?retorno=carrinho");
                return;
            }
            if (carrinho.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/carrinho.jsp?erro=Carrinho ou usuário inválido");
                return;
            }
            Venda venda = new Venda();
            venda.setUsuario(usuario);
            venda.setData_hora(LocalDateTime.now());
            BigDecimal total = BigDecimal.ZERO;
            List<VendaProduto> itensVenda = new ArrayList<>();
            for (CarrinhoItem item : carrinho) {
                VendaProduto vp = new VendaProduto();
                Produto produto = new Produto();
                produto.setId(item.getId());
                produto.setDescricao(item.getDescricao());
                vp.setProduto(produto);
                vp.setQuantidade(item.getQuantidade());
                vp.setPreco(BigDecimal.valueOf(item.getPreco()));
                total = total.add(BigDecimal.valueOf(item.getPreco()).multiply(BigDecimal.valueOf(item.getQuantidade())));
                itensVenda.add(vp);
            }
            venda.setValor_total(total);

            VendaDAO vendaDAO = new VendaDAO();
            boolean sucesso = vendaDAO.inserir(venda, itensVenda);

            if (sucesso) {
                session.removeAttribute("carrinho");
                response.sendRedirect(request.getContextPath() + "/MeusPedidos?sucesso=Compra realizada");
            } else {
                // Não limpa o carrinho, envia mensagem de erro via parâmetro
                response.sendRedirect(request.getContextPath() + "/carrinho.jsp?erro=Erro ao finalizar compra");
            }
            return;
        }
        // Restaura carrinho pendente após cadastro
        if (session.getAttribute("carrinho_pendente") != null && session.getAttribute("usuario") != null) {
            session.setAttribute("carrinho", (List<CarrinhoItem>) session.getAttribute("carrinho_pendente"));
            session.removeAttribute("carrinho_pendente");
        }
        session.setAttribute("carrinho", carrinho);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/carrinho.jsp");
        dispatcher.forward(request, response);
    }
}
