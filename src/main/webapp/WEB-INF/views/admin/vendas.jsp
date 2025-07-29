<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Relatório de Vendas</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
</head>
<body>
    <div class="admin-container">
        <h2>Relatório de Vendas</h2>
        <a href="${pageContext.request.contextPath}/" class="back-link">Voltar para a Página Inicial</a>
        <table class="product-table">
            <thead>
                <tr>
                    <th>ID Venda</th>
                    <th>Data/Hora</th>
                    <th>Usuário</th>
                    <th>Produto</th>
                    <th>Quantidade</th>
                    <th>Valor Unitário</th>
                    <th>Valor Total Item</th>
                    <th>Valor Total Venda</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="venda" items="${vendas}">
                    <c:forEach var="item" items="${venda.itens}">
                        <tr>
                            <td>${venda.id}</td>
                            <td>${venda.dataFormatada}</td>
                            <td>${venda.usuario.nome} (${venda.usuario.email})</td>
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
                            <td>
                                <fmt:setLocale value="pt_BR"/>
                                <fmt:formatNumber value="${venda.valor_total}" type="currency"/>
                            </td>
                        </tr>
                    </c:forEach>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
