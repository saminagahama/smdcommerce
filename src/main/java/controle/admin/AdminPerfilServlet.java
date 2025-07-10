package controle.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.usuario.Usuario;
import modelo.usuario.UsuarioDAO;

import java.io.IOException;

@WebServlet("/admin/perfil")
public class AdminPerfilServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null || !usuario.isAdministrador()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("usuario", usuario);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/admin/editar-perfil.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null || !usuario.isAdministrador()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String acao = request.getParameter("acao");

        if ("atualizar".equals(acao)) {
            String nome = request.getParameter("nome");
            String endereco = request.getParameter("endereco");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");

            UsuarioDAO dao = new UsuarioDAO();
            boolean sucesso = dao.atualizarUsuario(usuario.getId(), nome, endereco, email, senha);

            if (sucesso) {
                usuario.setNome(nome);
                usuario.setEndereco(endereco);
                usuario.setEmail(email);
                if (senha != null && !senha.isEmpty()) {
                    usuario.setSenha(senha);
                }
                session.setAttribute("usuario", usuario);
                request.setAttribute("mensagem", "Perfil atualizado com sucesso!");
            } else {
                request.setAttribute("erro", "Erro ao atualizar perfil.");
            }

            request.setAttribute("usuario", usuario);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/admin/editar-perfil.jsp");
            dispatcher.forward(request, response);
        } else if ("excluir".equals(acao)) {
            UsuarioDAO dao = new UsuarioDAO();
            boolean sucesso = dao.excluirUsuario(usuario.getId());

            if (sucesso) {
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/login?mensagem=Conta excluída com sucesso");
            } else {
                request.setAttribute("erro", "Erro ao excluir conta.");
                request.setAttribute("usuario", usuario);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/admin/editar-perfil.jsp");
                dispatcher.forward(request, response);
            }
        }
    }
}