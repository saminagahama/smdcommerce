<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="menu-usuario">
  <c:if test="${empty usuario}">
    <div style="color:red;">Erro: Usuário não autenticado.</div>
    <c:remove var="usuario" scope="session" />
    <c:redirect url="/smd-web-tf/index.jsp" />
  </c:if>
  <p>Bem-vindo, ${usuario.nome}!</p>
  <a href="${pageContext.request.contextPath}/logout">Sair</a>
  <h3>Menu do usuário</h3>
  <a href="${pageContext.request.contextPath}/MinhaConta">Minha conta</a>
  <a href="${pageContext.request.contextPath}/MeusPedidos">Meus pedidos</a>
  <c:if test="${usuario.administrador}">
    <h3>Menu do administrador</h3>
    <a href="${pageContext.request.contextPath}/admin/relatorios">Relatórios</a>
    <a href="${pageContext.request.contextPath}/admin/vendas">Gerenciar vendas</a>
    <a href="${pageContext.request.contextPath}/admin/produtos">Gerenciar produtos</a>
    <a href="${pageContext.request.contextPath}/admin/categorias">Gerenciar categorias</a>
    <a href="${pageContext.request.contextPath}/admin/usuarios">Gerenciar usuários</a>
  </c:if>
</div>