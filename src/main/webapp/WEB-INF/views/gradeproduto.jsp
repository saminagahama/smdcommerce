<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:when test="${not empty listaProdutos}">
	<c:forEach var="produto" items="listaProdutos">
		<div class="product-item">
		    <img src="<c:out value='${produto.image}' />" alt="<c:out value='${produto.descricao}' />">
		    <div class="product-info">
		        <h4><c:out value="${produto.descricao}" /></h4>
		        <span class="price"><c:out value="${produto.preco}" /></span>
		        <button
		        	id="btn-produto-<c:out value='${produto.id}' />"
		        	onclick="adicionarAoCarrinho(<c:out value='${produto.id}' />)"
		        >Adicionar ao Carrinho</button>
		    </div>
		</div>
	</c:forEach>
</c:when>