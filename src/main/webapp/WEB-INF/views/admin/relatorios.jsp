<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Relatórios - Administração</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
    <style>
        .relatorio-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }
        .relatorio-table th, .relatorio-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .relatorio-table th {
            background-color: #f5f5f5;
        }
        h2 {
            margin-top: 2rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <jsp:include page="_header.jsp" />
        <h1>Relatórios do E-commerce</h1>

        <!-- Relatório 1: Produtos mais vendidos -->
        <h2>Produtos Mais Vendidos</h2>
        <table class="relatorio-table">
            <thead>
                <tr>
                    <th>Produto</th>
                    <th>Quantidade Vendida</th>
                    <th>Receita Total</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${produtosMaisVendidos}" var="item">
                    <tr>
                        <td><c:out value="${item.produtoNome}"/></td>
                        <td><c:out value="${item.quantidadeVendida}"/></td>
                        <td><fmt:formatNumber value="${item.receitaTotal}" type="currency" currencySymbol="R$ "/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Relatório 2: Clientes que mais compraram -->
        <h2>Clientes que Mais Compraram</h2>
        <table class="relatorio-table">
            <thead>
                <tr>
                    <th>Cliente</th>
                    <th>Pedidos Realizados</th>
                    <th>Valor Total Comprado</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${clientesMaisCompradores}" var="cliente">
                    <tr>
                        <td><c:out value="${cliente.clienteNome}"/></td>
                        <td><c:out value="${cliente.totalPedidos}"/></td>
                        <td><fmt:formatNumber value="${cliente.valorTotalGasto}" type="currency" currencySymbol="R$ "/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Relatório 3: Estoque Baixo -->
        <h2>Produtos com Estoque Baixo</h2>
        <table class="relatorio-table">
            <thead>
                <tr>
                    <th>Produto</th>
                    <th>Categoria</th>
                    <th>Quantidade em Estoque</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${produtosEstoqueBaixo}" var="produto">
                    <tr>
                        <td><c:out value="${produto.produtoNome}"/></td>
                        <td><c:out value="${produto.categoriaNome}"/></td>
                        <td><c:out value="${produto.quantidadeEstoque}"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>