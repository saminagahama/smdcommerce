package controle.usuario;

import modelo.usuario.Usuario;
import modelo.venda.Venda;
import modelo.venda.VendaDAO;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import java.time.format.DateTimeFormatter;

@WebServlet("/MeusPedidos")
public class MeusPedidosServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession sessao = request.getSession(false);
        Usuario usuario = (sessao != null) ? (Usuario) sessao.getAttribute("usuario") : null;
        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        // Busca todas as compras do usuário
        VendaDAO vendaDAO = new VendaDAO();
        List<Venda> pedidos = vendaDAO.listarPorUsuario(usuario.getId());

        // Formata a data para DD/MM/YYYY e adiciona como atributo em cada pedido
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        for (Venda pedido : pedidos) {
            if (pedido.getData_hora() != null) {
                String dataFormatada = pedido.getData_hora().format(formatter);
                pedido.setDataFormatada(dataFormatada); // Adicione um setter/getter para dataFormatada em Venda
            }
        }
        request.setAttribute("pedidos", pedidos);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/meus-pedidos.jsp");
        rd.forward(request, response);
    }
}
