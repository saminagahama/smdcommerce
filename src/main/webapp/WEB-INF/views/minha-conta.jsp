<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modelo.usuario.Usuario" %>
<%
    Usuario usuario = (Usuario) request.getAttribute("usuario");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Minha Conta - Loja Virtual</title>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/cadastro.css">
</head>
<body>
    <div class="container">
        <h2>Minha Conta</h2>
        <a href="<%= request.getContextPath() %>/" class="back-link">Voltar para a Página Inicial</a>
        <div id="msg"></div>
        <form id="form-minha-conta" autocomplete="off">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="<%= usuario != null ? usuario.getNome() : "" %>" required>
            </div>
            <div class="form-group">
                <label for="endereco">Endereço:</label>
                <input type="text" id="endereco" name="endereco" value="<%= usuario != null ? usuario.getEndereco() : "" %>" required>
            </div>
            <div class="form-group">
                <label for="email">E-mail:</label>
                <input type="email" id="email" name="email" value="<%= usuario != null ? usuario.getEmail() : "" %>" required>
            </div>
            <div class="form-group">
                <label for="login">Usuário:</label>
                <input type="text" id="login" name="login" value="<%= usuario != null ? usuario.getLogin() : "" %>" required readonly>
            </div>
            <div class="form-group">
                <label for="senha">Nova Senha:</label>
                <input type="password" id="senha" name="senha" placeholder="Deixe em branco para não alterar">
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                <button type="button" class="btn btn-danger" id="btn-excluir">Excluir Conta</button>
            </div>
        </form>
    </div>
    <script>
        document.getElementById('form-minha-conta').addEventListener('submit', function(e) {
            e.preventDefault();
            const form = e.target;
            const formData = new FormData(form);
            fetch('AtualizarUsuario', {
                method: 'POST',
                body: formData
            })
            .then(r => r.text())
            .then(msg => {
                document.getElementById('msg').innerHTML = msg;
                if (msg.includes('sucesso')) setTimeout(() => window.location.reload(), 1000);
            })
            .catch(() => {
                document.getElementById('msg').innerHTML = "<div class='error-message'>Erro ao atualizar dados.</div>";
            });
        });

        function habilitarCampos() {
            const form = document.getElementById('form-minha-conta');
            Array.from(form.elements).forEach(el => el.disabled = false);
            document.getElementById('btn-excluir').disabled = false;
        }

        document.getElementById('btn-excluir').addEventListener('click', function() {
            if (confirm('Tem certeza que deseja excluir sua conta? Esta ação não poderá ser desfeita.')) {
                const form = document.getElementById('form-minha-conta');
                Array.from(form.elements).forEach(el => el.disabled = true);
                document.getElementById('btn-excluir').disabled = true;

                fetch('ExcluirUsuario', { method: 'POST' })
                .then(r => r.text())
                .then(msg => {
                    document.getElementById('msg').innerHTML = msg;
                    if (msg.includes('sucesso')) {
                        alert("Conta excluída com sucesso!");
                        window.location.href = '<%= request.getContextPath() %>/index.jsp';
                    } else {
                        habilitarCampos();
                    }
                })
                .catch(() => {
                    document.getElementById('msg').innerHTML = "<div class='error-message'>Erro ao excluir conta.</div>";
                    habilitarCampos();
                });
            }
        });
    </script>
</body>
</html>