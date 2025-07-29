<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Meus Pedidos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
</head>
<body>
    <div class="admin-container">
        <h2>Meus Pedidos</h2>
        <a href="${pageContext.request.contextPath}/" class="back-link">Voltar para a Página Inicial</a>
        <table class="product-table">
            <thead>
                <tr>
                    <th>ID do Pedido</th>
                    <th>Data/Hora</th>
                    <th>Produto</th>
                    <th>Quantidade</th>
                    <th>Valor Unitário na Compra</th>
                    <th>Valor Total</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="pedido" items="${pedidos}">
                    <c:forEach var="item" items="${pedido.itens}">
                        <tr>
                            <td>${pedido.id}</td>
                            <td>${pedido.dataFormatada}</td>
                            <td>${item.produto.descricao}</td>
                            <td>${item.quantidade}</td>
                            <td>
                                <fmt:setLocale value="pt_BR"/>
                                <fmt:formatNumber value="${item.preco}" type="currency"/>
                            </td>
                            <td>
                                <fmt:setLocale value="pt_BR"/>
                                <fmt:formatNumber value="${item.preco * item.quantidade}" type="currency"/>
                            </td>
                        </tr>
                    </c:forEach>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
