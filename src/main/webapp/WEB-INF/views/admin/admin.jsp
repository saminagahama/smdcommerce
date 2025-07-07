<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Painel do Administrador</title>
</head>
<body>
    <h1>Painel do Administrador</h1>

    <%-- Verifica se o usuário está logado e é administrador --%>
    <c:if test="${empty sessionScope.usuario || !sessionScope.usuario.isAdministrador()}">
        <c:redirect url="${pageContext.request.contextPath}/login.jsp">
            <c:param name="erro" value="Acesso negado."/>
        </c:redirect>
    </c:if>
    <a href="${pageContext.request.contextPath}/admin/perfil" class="botao-menu">Meu Perfil</a>
    <h3>Bem-vindo(a), ADMINISTRADOR ${sessionScope.usuario.nome}!</h3>

    <ul>
        <li><a href="${pageContext.request.contextPath}/admin/produtos">Gerenciar Produtos</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/categorias" class="dashboard-link">Gerenciar Categorias</a></li>
        <li><a href="${pageContext.request.contextPath}/minha-conta">Minha Conta</a></li>
    </ul>

    <a href="${pageContext.request.contextPath}/logout">Sair</a>
</body>
</html>