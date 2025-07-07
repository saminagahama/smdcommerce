<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gerenciar Usuários</title>
</head>
<body>
    <h1>Gerenciar Usuários</h1>
    <a href="${pageContext.request.contextPath}/admin">Voltar ao painel</a>
    <table border="1" cellpadding="5">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>E-mail</th>
                <th>Administrador?</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="usuario" items="${usuarios}">
                <tr>
                    <td>${usuario.id}</td>
                    <td>${usuario.nome}</td>
                    <td>${usuario.email}</td>
                    <td>
                        <c:choose>
                            <c:when test="${usuario.administrador}">Sim</c:when>
                            <c:otherwise>Não</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <!-- Adicione links de editar/excluir conforme necessário -->
                        <a href="#">Editar</a> | <a href="#">Excluir</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>