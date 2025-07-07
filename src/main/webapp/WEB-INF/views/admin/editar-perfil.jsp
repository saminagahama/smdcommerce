<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Perfil - Área Administrativa</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilo.css">
</head>
<body>
    <div class="container">
        <h1>Editar Perfil</h1>

        <c:if test="${not empty mensagem}">
            <div class="mensagem-sucesso">
                <p>${mensagem}</p>
            </div>
        </c:if>

        <c:if test="${not empty erro}">
            <div class="mensagem-erro">
                <p>${erro}</p>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/perfil" method="post">
            <input type="hidden" name="acao" value="atualizar">

            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="${usuario.nome}" required>
            </div>

            <div class="form-group">
                <label for="endereco">Endereço:</label>
                <input type="text" id="endereco" name="endereco" value="${usuario.endereco}" required>
            </div>

            <div class="form-group">
                <label for="email">E-mail:</label>
                <input type="email" id="email" name="email" value="${usuario.email}" required>
            </div>

            <div class="form-group">
                <label for="login">Login:</label>
                <input type="text" id="login" value="${usuario.login}" disabled>
                <small>O login não pode ser alterado</small>
            </div>

            <div class="form-group">
                <label for="senha">Nova Senha (deixe em branco para manter a atual):</label>
                <input type="password" id="senha" name="senha">
            </div>

            <div class="botoes">
                <button type="submit" class="btn-primario">Salvar Alterações</button>
                <a href="${pageContext.request.contextPath}/admin" class="btn-secundario">Voltar</a>
            </div>
        </form>

        <div class="secao-excluir">
            <h2>Excluir Conta</h2>
            <p>Atenção: Esta ação não pode ser desfeita.</p>
            <form action="${pageContext.request.contextPath}/admin/perfil" method="post" onsubmit="return confirm('Tem certeza que deseja excluir sua conta? Esta ação não pode ser desfeita.');">
                <input type="hidden" name="acao" value="excluir">
                <button type="submit" class="btn-perigo">Excluir Minha Conta</button>
            </form>
        </div>
    </div>
</body>
</html>