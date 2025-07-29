<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gerenciar Produtos</title>
    <%-- Links para fontes do Google e para o novo arquivo CSS --%>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/admin.css">
</head>
<body>
    <div class="admin-container">
        <h1>Gerenciar Produtos</h1>

        <c:if test="${not empty erro}">
            <p style="color: red; background: #ffebee; padding: 10px; border-radius: 4px;">${erro}</p>
        </c:if>

        <div class="form-section">
            <h2><c:choose><c:when test="${not empty produto}">Editar Produto</c:when><c:otherwise>Adicionar Produto</c:otherwise></c:choose></h2>

            <form action="${pageContext.request.contextPath}/admin/produtos" method="post" enctype="multipart/form-data">
                <c:if test="${not empty produto}">
                    <input type="hidden" name="id" value="${produto.id}">
                </c:if>

                <label for="descricao">Descrição:</label>
                <input type="text" id="descricao" name="descricao" value="<c:out value='${produto.descricao}'/>" placeholder="Descrição do Produto" required>

                <label for="preco">Preço:</label>
                <input type="number" id="preco" step="0.01" name="preco" value="${not empty produto ? produto.preco : ''}" placeholder="Preço" required>

                <label for="quantidade">Quantidade:</label>
                <input type="number" id="quantidade" name="quantidade" value="${not empty produto ? produto.quantidade : ''}" placeholder="Quantidade" required>

                <label for="foto">Foto:</label>
                <input type="file" id="foto" name="foto" accept="image/*">

                <label for="categoriaId">Categoria:</label>
                <select name="categoriaId" id="categoriaId" required>
                    <option value="" disabled <c:if test="${empty produto.categoria}">selected</c:if>>Selecione uma categoria</option>
                        <c:forEach var="cat" items="${categorias}">
                            <option value="${cat.id}" ${not empty produto.categoria && produto.categoria.id == cat.id ? 'selected' : ''}>
                                <c:out value="${cat.descricao}"/>
                            </option>
                            </c:forEach>
                            </select>

                                <button type="submit">Salvar</button>
                <c:if test="${not empty produto}">
                    <a href="${pageContext.request.contextPath}/admin/produtos" style="margin-left: 15px;">Cancelar Edição</a>
                </c:if>
            </form>
        </div>

        <hr>

        <h2>Produtos Cadastrados</h2>
        <table class="product-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Foto</th>
                    <th>Descrição</th>
                    <th>Preço</th>
                    <th>Quantidade</th>
                    <th>Categoria</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${produtos}">
                    <tr>
                        <td>${p.id}</td>
                        <td>
                            <c:if test="${not empty p.fotoBytes}">
                                <img src="${pageContext.request.contextPath}/imagem?id=${p.id}" alt="<c:out value='${p.descricao}'/>" />
                            </c:if>
                        </td>
                        <td><c:out value="${p.descricao}"/></td>
                        <td>
                            <fmt:setLocale value="pt_BR"/>
                            <fmt:formatNumber value="${p.preco}" type="currency"/>
                        </td>
                        <td>${p.quantidade}</td>
                        <td><c:out value="${p.categoria.descricao}"/></td>
                        <td class="action-links">
                            <a class="edit" href="${pageContext.request.contextPath}/admin/produtos?action=editar&id=${p.id}">Editar</a>
                            <a class="remove" href="${pageContext.request.contextPath}/admin/produtos?action=remover&id=${p.id}" onclick="return confirm('Tem certeza que deseja remover este produto?');">Remover</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="${pageContext.request.contextPath}/" class="back-link">Voltar para a Página Inicial</a>
    </div>
</body>
</html>