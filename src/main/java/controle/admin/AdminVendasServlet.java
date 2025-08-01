package controle.admin;

import modelo.venda.Venda;
import modelo.venda.VendaDAO;
import modelo.usuario.Usuario;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import java.time.format.DateTimeFormatter;

@WebServlet("/admin/vendas")
public class AdminVendasServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;
        if (usuario == null || !usuario.isAdministrador()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        VendaDAO vendaDAO = new VendaDAO();
        List<Venda> vendas = vendaDAO.listarTodas();

        // Formata a data para DD/MM/YYYY HH:mm
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        for (Venda venda : vendas) {
            if (venda.getData_hora() != null) {
                String dataFormatada = venda.getData_hora().format(formatter);
                venda.setDataFormatada(dataFormatada); // Adicione setter/getter em Venda
            }
        }
        request.setAttribute("vendas", vendas);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/admin/vendas.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Pega o ID da venda a ser excluída do parâmetro do formulário
            int vendaId = Integer.parseInt(request.getParameter("vendaId"));

            // Chama o DAO para excluir a venda do banco de dados
            VendaDAO vendaDAO = new VendaDAO();
            vendaDAO.excluirVenda(vendaId); // Certifique-se que este método existe no seu VendaDAO

        } catch (Exception e) {
            // Loga o erro para depuração
            e.printStackTrace();
            // Opcional: enviar uma mensagem de erro para a view
            request.getSession().setAttribute("mensagemErro", "Falha ao excluir a venda.");
        }

        // Redireciona de volta para a página de vendas para atualizar a lista
        response.sendRedirect(request.getContextPath() + "/admin/vendas");
    }
}