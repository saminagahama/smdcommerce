package controle.carrinho;

import modelo.produto.Produto;
import modelo.venda.Venda;
import modelo.venda_produto.VendaProduto;
import modelo.usuario.Usuario;
import modelo.venda.VendaDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/FinalizarCompra")
public class FinalizarCompraServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession sessao = request.getSession(false);
        Usuario usuario = (sessao != null) ? (Usuario) sessao.getAttribute("usuario") : null;

        // Recupera o carrinho da sessão (deve ser uma List<VendaProduto>)
        @SuppressWarnings("unchecked")
        List<VendaProduto> carrinho = (List<VendaProduto>) sessao.getAttribute("carrinho");

        if (carrinho == null || carrinho.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/carrinho.jsp?erro=Carrinho vazio");
            return;
        }

        // Cria a venda
        Venda venda = new Venda();
        venda.setUsuario(usuario);
        venda.setData_hora(LocalDateTime.now());

        // Calcula o valor total
        BigDecimal total = BigDecimal.ZERO;
        for (VendaProduto vp : carrinho) {
            total = total.add(vp.getPreco().multiply(BigDecimal.valueOf(vp.getQuantidade())));
            vp.setVenda(venda); // vincula a venda ao item
        }
        venda.setValor_total(total);

        // Salva a venda e os itens no banco
        VendaDAO vendaDAO = new VendaDAO();
        boolean sucesso = vendaDAO.inserir(venda, carrinho);

        // Limpa o carrinho da sessão
        sessao.removeAttribute("carrinho");

        if (sucesso) {
            response.sendRedirect(request.getContextPath() + "/MeusPedidos?sucesso=Compra realizada");
        } else {
            response.sendRedirect(request.getContextPath() + "/carrinho.jsp?erro=Erro ao finalizar compra");
        }
    }
}
