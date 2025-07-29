<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.produto.Produto" %>
<%@ page import="modelo.carrinho.CarrinhoItem" %>
<%
    List<CarrinhoItem> carrinho = (List<CarrinhoItem>) session.getAttribute("carrinho");
    String erro = request.getParameter("erro");
%>
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8">
    <title>Carrinho de Compras - Loja Virtual</title>
    <link
      href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&family=Roboto:wght@300;400;500&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/styles/admin.css">
  </head>
  <body>
    <header>
      <h1>Meu Carrinho de Compras</h1>
    </header>
    <main>
      <div class="admin-container">
        <h2>Itens no seu Carrinho</h2>
        <% if (erro != null && !erro.isEmpty()) { %>
            <div class="error-message" style="color:#e74c3c;margin-bottom:1rem;"><%= erro %></div>
        <% } %>
        <table class="product-table" id="tabela-carrinho">
          <thead>
            <tr>
              <th>Produto</th>
              <th>Preço Unitário</th>
              <th>Quantidade</th>
              <th>Preço Total</th>
              <th>Ações</th>
            </tr>
          </thead>
          <tbody id="cart-body">
            <% 
            double total = 0;
            if (carrinho != null && !carrinho.isEmpty()) {
                for (CarrinhoItem item : carrinho) {
                    double precoTotal = item.getPreco() * item.getQuantidade();
                    total += precoTotal;
            %>
            <tr>
                <td class="product-name"><%= item.getDescricao() %></td>
                <td>R$ <%= String.format("%.2f", item.getPreco()).replace('.', ',') %></td>
                <td><%= item.getQuantidade() %></td>
                <td>R$ <%= String.format("%.2f", precoTotal).replace('.', ',') %></td>
                <td class="action-links">
                    <form action="<%= request.getContextPath() %>/CarrinhoServlet" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= item.getId() %>"/>
                        <input type="hidden" name="acao" value="remover"/>
                        <button class="remove" type="submit">Remover</button>
                    </form>
                    <!-- Removido botão de alterar -->
                </td>
            </tr>
            <% 
                }
            } else { 
            %>
            <tr>
                <td colspan="5" class="empty-cart">Seu carrinho está vazio</td>
            </tr>
            <% } %>
          </tbody>
        </table>
        <% 
          if (carrinho == null || carrinho.isEmpty()) {
        %>
        <div class="cart-actions" style="justify-content: flex-start;">
          <a href="<%= request.getContextPath() %>/" style="background:none;color:#2980b9;padding:0;border:none;text-decoration:underline;margin:0;">Voltar para a Página Principal</a>
        </div>
        <% 
          } else {
        %>
          <div class="cart-total" id="cart-total-area">
            Total: <span id="cart-total">R$ <%= String.format("%.2f", total).replace('.', ',') %></span>
          </div>
          <div class="cart-actions" id="cart-actions-area" style="display:flex;justify-content:space-between;align-items:center;">
            <a href="<%= request.getContextPath() %>/" style="background:none;color:#2980b9;padding:0;border:none;text-decoration:underline;margin:0;">Continuar Comprando</a>
            <form action="<%= request.getContextPath() %>/CarrinhoServlet" method="post" style="display:inline;">
              <input type="hidden" name="acao" value="finalizar"/>
              <button id="checkout-btn" class="checkout-btn" type="submit" style="margin-left:auto;">Finalizar Compra</button>
            </form>
          </div>
        <%
          }
        %>
      </div>
    </main>
    <footer>
      <p>&copy; 2025 Minha Loja Virtual - Todos os direitos reservados</p>
    </footer>
    <!-- Removido modal de alteração e scripts associados -->
  </body>
</html>