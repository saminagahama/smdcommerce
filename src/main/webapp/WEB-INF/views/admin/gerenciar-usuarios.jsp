<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Gerenciar Usuários</title>
    <%-- Vinculando a folha de estilo admin.css --%>
    <link rel="stylesheet" href="${contextPath}/styles/admin.css">
</head>
<body>
    <div class="admin-container">
        <h2>Gerenciar Usuários</h2>

        <!-- Formulário para Adicionar Novo Usuário -->
        <div class="form-section">
            <h3>Novo Usuário</h3>
            <form action="${contextPath}/admin/usuarios" method="post">
                <input type="hidden" name="acao" value="inserir">

                <label for="nome">Nome</label>
                <input type="text" id="nome" name="nome" required>

                <label for="login">Login</label>
                <input type="text" id="login" name="login" required>

                <label for="email">Email</label>
                <input type="text" id="email" name="email" required>

                <label for="senha">Senha</label>
                <input type="password" id="senha" name="senha" required>

                <label for="endereco">Endereço</label>
                <input type="text" id="endereco" name="endereco" required>

                <div>
                    <input type="checkbox" id="administrador" name="administrador" value="on" style="width: auto; margin-bottom: 20px;">
                    <label for="administrador" style="display: inline;">É Administrador?</label>
                </div>

                <button type="submit">Adicionar Usuário</button>
            </form>
        </div>

        <!-- Tabela de Usuários Existentes -->
        <h3>Usuários Cadastrados</h3>
        <table class="product-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>Login</th>
                    <th>Admin</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="usuario" items="${usuarios}">
                    <tr>
                        <td>${usuario.id}</td>
                        <td>${usuario.nome}</td>
                        <td>${usuario.email}</td>
                        <td>${usuario.login}</td>
                        <td>${usuario.administrador ? 'Sim' : 'Não'}</td>
                        <td>
                            <div class="action-links">
                                <a href="${contextPath}/admin/usuarios?acao=editar&id=${usuario.id}" class="edit">
                                    Editar
                                </a>
                                <a href="${contextPath}/admin/usuarios?acao=remover&id=${usuario.id}" class="remove" onclick="return confirm('Tem certeza que deseja remover este usuário?');">
                                    Remover
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="${pageContext.request.contextPath}/" class="back-link">Voltar para a Página Inicial</a>
    </div>
</body>
</html>