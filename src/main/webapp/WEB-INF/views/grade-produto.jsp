<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="product-list">
    <c:forEach var="produto" items="${produtos}">
        <div class="product-card">
            <c:if test="${not empty produto.fotoBytes}">
                <img src="${pageContext.request.contextPath}/imagem?id=${produto.id}" alt="<c:out value='${produto.descricao}'/>">
            </c:if>
            <h3><c:out value="${produto.descricao}" /></h3>
            <p class="price">
                <fmt:setLocale value="pt_BR"/>
                <fmt:formatNumber value="${produto.preco}" type="currency"/>
            </p>
            <button onclick="adicionarAoCarrinho(${produto.id})">Adicionar ao Carrinho</button>
        </div>
    </c:forEach>
</div>