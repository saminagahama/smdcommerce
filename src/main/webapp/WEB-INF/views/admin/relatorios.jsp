<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
        <h1>Relatórios do E-commerce</h1>
        <a href="${pageContext.request.contextPath}/" class="back-link">Voltar para a Página Inicial</a>

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
                <tr>
                    <td>Exemplo Produto 1</td>
                    <td>120</td>
                    <td>R$ 5.400,00</td>
                </tr>
                <tr>
                    <td>Exemplo Produto 2</td>
                    <td>85</td>
                    <td>R$ 2.890,00</td>
                </tr>
                <!-- ...mais linhas... -->
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
                <tr>
                    <td>Maria Silva</td>
                    <td>15</td>
                    <td>R$ 2.150,00</td>
                </tr>
                <tr>
                    <td>João Souza</td>
                    <td>12</td>
                    <td>R$ 1.780,00</td>
                </tr>
                <!-- ...mais linhas... -->
            </tbody>
        </table>

        <!-- Relatório 3: Estoque Baixo -->
        <h2>Produtos com Estoque Baixo</h2>
        <table class="relatorio-table">
            <thead>
                <tr>
                    <th>Produto</th>
                    <th>Quantidade em Estoque</th>
                    <th>Categoria</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Exemplo Produto 3</td>
                    <td>2</td>
                    <td>Maquiagem</td>
                </tr>
                <tr>
                    <td>Exemplo Produto 4</td>
                    <td>5</td>
                    <td>Cuidados com a Pele</td>
                </tr>
                <!-- ...mais linhas... -->
            </tbody>
        </table>
    </div>
</body>
</html>
