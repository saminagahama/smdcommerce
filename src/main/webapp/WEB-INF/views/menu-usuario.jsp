<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <c:if test="${empty usuario}">
    <div style="color:red;">Erro: Usuário não autenticado.</div>
    <c:remove var="usuario" scope="session" />
    <c:redirect url="/smd-web-tf/index.jsp" />
  </c:if>
  <div id="menu-usuario">
    <p>Bem-vindo, ${usuario.nome}!</p>
    <a href="/smd-web-tf/LogoutServlet" onclick="logout(event)">Sair</a>
    <h3>Menu do usuário</h3>
    <a href="">Minha conta</a>
    <a href="">Meus pedidos</a>
    <c:if test="${usuario.administrador}">
      <h3>Menu do admin</h3>
      <a href="">Gerenciar produtos</a>
    </c:if>
  </div>
  <script>
    function logout(e) {
      e.preventDefault();
      fetch('/smd-web-tf/LogoutServlet')
        .then(() => {
          location.reload();
        });
    }
  </script>