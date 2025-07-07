package controle.admin;

import modelo.usuario.Usuario;
import modelo.usuario.UsuarioDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/usuarios")
public class AdminUsuarioServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");

        if ("editar".equals(acao)) {
            exibirFormularioEdicao(request, response);
        } else if ("remover".equals(acao)) {
            removerUsuario(request, response);
        } else {
            listarUsuarios(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String acao = request.getParameter("acao");

        if (acao == null) {
            response.sendRedirect(request.getContextPath() + "/admin/usuarios");
            return;
        }

        switch (acao) {
            case "inserir":
                inserirUsuario(request, response);
                break;
            case "atualizar":
                atualizarUsuario(request, response);
                break;
            default:
                listarUsuarios(request, response);
                break;
        }
    }

    private void exibirFormularioEdicao(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Usuario usuario = usuarioDAO.obterPorId(id);
            if (usuario != null) {
                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("/WEB-INF/views/admin/editar-usuario.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/usuarios");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/usuarios");
        }
    }

    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Usuario> usuarios = usuarioDAO.obterTodos();
        request.setAttribute("usuarios", usuarios);
        request.getRequestDispatcher("/WEB-INF/views/admin/gerenciar-usuarios.jsp").forward(request, response);
    }

    private void inserirUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        String endereco = request.getParameter("endereco");
        boolean administrador = "on".equals(request.getParameter("administrador"));

        if (nome != null && !nome.isEmpty() && email != null && !email.isEmpty() && senha != null && !senha.isEmpty() && login != null && !login.isEmpty() && endereco != null && !endereco.isEmpty()) {
            Usuario novoUsuario = new Usuario();
            novoUsuario.setNome(nome);
            novoUsuario.setEmail(email);
            novoUsuario.setLogin(login);
            novoUsuario.setSenha(senha);
            novoUsuario.setAdministrador(administrador);
            novoUsuario.setEndereco(endereco);

            usuarioDAO.inserir(novoUsuario);
        }

        response.sendRedirect(request.getContextPath() + "/admin/usuarios");
    }

    private void atualizarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String login = request.getParameter("login");
            String endereco = request.getParameter("endereco");
            boolean administrador = "on".equals(request.getParameter("administrador"));

            Usuario usuario = new Usuario();
            usuario.setId(id);
            usuario.setNome(nome);
            usuario.setEmail(email);
            usuario.setLogin(login);
            usuario.setEndereco(endereco);
            usuario.setAdministrador(administrador);

            usuarioDAO.atualizar(usuario);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/usuarios");
    }

    private void removerUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            usuarioDAO.remover(id);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/admin/usuarios");
    }
}