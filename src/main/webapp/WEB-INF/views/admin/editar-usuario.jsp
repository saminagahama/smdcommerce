<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Editar Usuário</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Editar Usuário</h2>

        <div class="card">
            <div class="card-body">
                <form action="${contextPath}/admin/usuarios" method="post">
                    <!-- Ação para o servlet e ID do usuário -->
                    <input type="hidden" name="acao" value="atualizar">
                    <input type="hidden" name="id" value="${usuario.id}">

                    <div class="mb-3">
                        <label for="nome" class="form-label">Nome</label>
                        <input type="text" class="form-control" id="nome" name="nome" value="${usuario.nome}" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="${usuario.email}" required>
                    </div>
                    <div class="mb-3">
                        <label for="login" class="form-label">Login</label>
                        <input type="text" class="form-control" id="login" name="login" value="${usuario.login}" required>
                    </div>
                    <div class="mb-3">
                        <label for="endereco" class="form-label">Endereço</label>
                        <input type="text" class="form-control" id="endereco" name="endereco" value="${usuario.endereco}">
                    </div>
                    <div class="form-check mb-3">
                        <input type="checkbox" class="form-check-input" id="administrador" name="administrador" value="on" ${usuario.administrador ? 'checked' : ''}>
                        <label class="form-check-label" for="administrador">É Administrador?</label>
                    </div>

                    <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                    <a href="${contextPath}/" class="btn btn-secondary">Cancelar</a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>