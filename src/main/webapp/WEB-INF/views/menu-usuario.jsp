<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="menu-usuario">
  <c:if test="${empty usuario}">
    <div style="color:red;">Erro: Usuário não autenticado.</div>
    <c:remove var="usuario" scope="session" />
    <c:redirect url="/smd-web-tf/index.jsp" />
  </c:if>
  <p>Bem-vindo, ${usuario.nome}!</p>
  <a href="#" onclick="logout(event)">Sair</a>
  <h3>Menu do usuário</h3>
  <a href="MinhaConta">Minha conta</a>
  <a href="">Meus pedidos</a>
  <c:if test="${usuario.administrador}">
    <h3>Menu do admin</h3>
    <a href="">Gerenciar produtos</a>
    <a href="">Gerenciar categorias</a>
    <a href="">Gerenciar usuários</a>
  </c:if>
</div>