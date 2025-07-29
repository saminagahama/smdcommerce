<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
                    <th>Valor Total Venda</th>
                    <th>Produto</th>
                    <th>Quantidade</th>
                    <th>Valor Unitário</th>
                    <th>Valor Total Item</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="venda" items="${vendas}">
                    <c:forEach var="item" items="${venda.itens}" varStatus="loop">
                        <tr>
                            <c:if test="${loop.first}">
                                <td rowspan="${fn:length(venda.itens)}">${venda.id}</td>
                                <td rowspan="${fn:length(venda.itens)}">${venda.dataFormatada}</td>
                                <td rowspan="${fn:length(venda.itens)}">${venda.usuario.nome} (${venda.usuario.email})</td>
                                <td rowspan="${fn:length(venda.itens)}">
                                    <fmt:setLocale value="pt_BR"/>
                                    <fmt:formatNumber value="${venda.valor_total}" type="currency"/>
                                </td>
                            </c:if>
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
                            <c:if test="${loop.first}">
                                <td rowspan="${fn:length(venda.itens)}">
                                    <form action="${pageContext.request.contextPath}/admin/vendas" method="post" onsubmit="return confirm('Tem certeza que deseja excluir esta venda?');">
                                        <input type="hidden" name="vendaId" value="${venda.id}">
                                        <button type="submit" class="delete-button">Excluir</button>
                                    </form>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>