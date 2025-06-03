<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Carrinho de Compras ‑ Loja Virtual</title>

    <link
      href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&family=Roboto:wght@300;400;500&display=swap"
      rel="stylesheet"
    />

    <style>
      :root {
        --primary-color: #2c3e50;
        --secondary-color: #3498db;
        --accent-color: #e74c3c;
        --light-color: #ecf0f1;
        --dark-color: #2c3e50;
        --success-color: #27ae60;
        --warning-color: #f39c12;
        --error-color: #e74c3c;
        --text-color: #333;
        --text-light: #7f8c8d;
        --border-radius: 8px;
        --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        --transition: all 0.3s ease;
      }

      * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
      }

      body {
        font-family: "Open Sans", sans-serif;
        line-height: 1.6;
        color: var(--text-color);
        background: #f9f9f9;
        margin: 0;
        padding: 0;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
      }

      header {
        background: var(--primary-color);
        color: #fff;
        padding: 1.5rem 2rem;
        text-align: center;
        box-shadow: var(--box-shadow);
      }

      header h1 {
        font-size: 2.2rem;
        margin: 0;
        font-weight: 700;
        letter-spacing: 1px;
      }

      main {
        flex: 1;
        display: flex;
        flex-direction: column;
        justify-content: center;
        padding: 2rem 0;
      }

      .container {
        max-width: 900px;
        width: 90%;
        margin: 0 auto;
        padding: 2rem;
        background: #fff;
        border-radius: var(--border-radius);
        box-shadow: var(--box-shadow);
      }

      h2 {
        color: var(--primary-color);
        text-align: center;
        margin-bottom: 2rem;
        font-size: 1.8rem;
        position: relative;
        padding-bottom: 0.5rem;
      }

      h2::after {
        content: "";
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 60px;
        height: 3px;
        background: var(--secondary-color);
      }

      .cart-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 2rem;
      }

      .cart-table th,
      .cart-table td {
        padding: 1rem;
        text-align: left;
        border-bottom: 1px solid #eee;
      }

      .cart-table th {
        background: var(--light-color);
        font-weight: 600;
        color: var(--dark-color);
      }

      .cart-table td.product-name {
        width: 40%;
        font-weight: 500;
      }

      .cart-table td.quantity input {
        width: 60px;
        padding: 0.5rem;
        text-align: center;
        border: 1px solid #ddd;
        border-radius: var(--border-radius);
        font-size: 1rem;
      }

      .cart-table td.quantity input:focus {
        outline: none;
        border-color: var(--secondary-color);
      }

      .cart-table td.actions {
        white-space: nowrap;
      }

      .cart-table td.actions button {
        padding: 0.5rem 1rem;
        color: #fff;
        border: none;
        border-radius: var(--border-radius);
        cursor: pointer;
        font-size: 0.9rem;
        margin-right: 0.5rem;
        transition: var(--transition);
      }

      .update-btn {
        background: var(--secondary-color);
      }

      .update-btn:hover {
        background: #2980b9;
        transform: translateY(-2px);
      }

      .remove-btn {
        background: var(--error-color);
      }

      .remove-btn:hover {
        background: #c0392b;
        transform: translateY(-2px);
      }

      .cart-total {
        text-align: right;
        margin-bottom: 2rem;
        padding: 1rem;
        background: var(--light-color);
        border-radius: var(--border-radius);
      }

      .cart-total h3 {
        margin: 0;
        font-size: 1.4rem;
        color: var(--dark-color);
      }

      .cart-total h3 span {
        color: var(--accent-color);
        font-weight: 700;
      }

      .cart-actions {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 1rem;
      }

      .cart-actions a,
      .cart-actions button {
        padding: 0.8rem 1.5rem;
        text-decoration: none;
        border-radius: var(--border-radius);
        cursor: pointer;
        font-size: 1rem;
        font-weight: 600;
        transition: var(--transition);
        text-align: center;
        flex: 1;
      }

      .continue-shopping {
        background: var(--warning-color);
        color: #fff;
        border: none;
      }

      .continue-shopping:hover {
        background: #e67e22;
        transform: translateY(-2px);
      }

      .checkout-button {
        background: var(--success-color);
        color: #fff;
        border: none;
      }

      .checkout-button:hover {
        background: #219653;
        transform: translateY(-2px);
      }

      .empty-cart {
        text-align: center;
        color: var(--text-light);
        padding: 3rem;
        font-size: 1.2rem;
      }

      footer {
        background: var(--dark-color);
        color: #fff;
        text-align: center;
        padding: 1.5rem;
        font-size: 0.9rem;
      }

      @media (max-width: 768px) {
        .container {
          padding: 1.5rem;
        }

        header h1 {
          font-size: 1.8rem;
        }

        .cart-table {
          display: block;
          overflow-x: auto;
        }

        .cart-actions {
          flex-direction: column;
        }

        .cart-actions a,
        .cart-actions button {
          width: 100%;
        }
      }
    </style>
  </head>

  <body>
    <header>
      <h1>Meu Carrinho de Compras</h1>
    </header>

    <main>
      <div class="container">
        <h2>Itens no seu Carrinho</h2>

        <div id="cart-content">
          <table class="cart-table">
            <thead>
              <tr>
                <th class="product-name">Produto</th>
                <th>Preço Unitário</th>
                <th>Quantidade</th>
                <th>Preço Total</th>
                <th>Ações</th>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td class="product-name">Produto Exemplo 1</td>
                <td>R$ 99,90</td>
                <td class="quantity">
                  <input type="number" value="1" min="1" />
                </td>
                <td>R$ 99,90</td>
                <td class="actions">
                  <button class="update-btn">Atualizar</button>
                  <button class="remove-btn">Remover</button>
                </td>
              </tr>

              <tr>
                <td class="product-name">Produto Exemplo 2</td>
                <td>R$ 49,50</td>
                <td class="quantity">
                  <input type="number" value="2" min="1" />
                </td>
                <td>R$ 99,00</td>
                <td class="actions">
                  <button class="update-btn">Atualizar</button>
                  <button class="remove-btn">Remover</button>
                </td>
              </tr>
            </tbody>
          </table>

          <div class="cart-total">
            <h3>Total: <span>R$ 198,90</span></h3>
          </div>

          <div class="cart-actions">
            <a href="index.html" class="continue-shopping">Continuar Comprando</a>
            <button id="checkout-btn" class="checkout-button">
              Finalizar Compra
            </button>
          </div>
        </div>
      </div>
    </main>

    <footer>
      <p>&copy; 2025 Minha Loja Virtual ‑ Todos os direitos reservados</p>
    </footer>

    <script>
      const checkoutButton = document.getElementById("checkout-btn");

      if (checkoutButton) {
        checkoutButton.addEventListener("click", () => {
          const logged = false;

          if (logged) {
            alert("Prosseguindo para o checkout...");
          } else if (
            confirm(
              "É necessário fazer login para finalizar a compra. Deseja ir para a página de login agora?"
            )
          ) {
            window.location.href = "index.html#login-area";
          }
        });
      }

      function updateRow(button) {
        const row = button.closest("tr");
        const qty = row.querySelector(".quantity input").value;
        const name = row.querySelector(".product-name").textContent;

        button.textContent = "Atualizando...";
        button.disabled = true;

        setTimeout(() => {
          alert(`Simulação: Quantidade de "${name}" atualizada para ${qty}.`);
          button.textContent = "Atualizar";
          button.disabled = false;
        }, 800);
      }

      function removeRow(button) {
        const row = button.closest("tr");
        const name = row.querySelector(".product-name").textContent;

        if (
          confirm(`Tem certeza que deseja remover "${name}" do carrinho?`)
        ) {
          button.textContent = "Removendo...";
          button.disabled = true;

          setTimeout(() => {
            row.style.opacity = "0";

            setTimeout(() => {
              row.remove();
              alert(`Simulação: "${name}" removido.`);

              if (
                document.querySelectorAll(".cart-table tbody tr").length === 0
              ) {
                document.getElementById("cart-content").innerHTML = `
                  <div class="empty-cart">
                    <p>Seu carrinho está vazio</p>
                    <a href="index.html" class="continue-shopping" style="display:inline-block;margin-top:1rem;">Voltar às compras</a>
                  </div>
                `;
              }
            }, 300);
          }, 500);
        }
      }

      document.querySelectorAll(".update-btn").forEach((btn) =>
        btn.addEventListener("click", () => updateRow(btn))
      );

      document.querySelectorAll(".remove-btn").forEach((btn) =>
        btn.addEventListener("click", () => removeRow(btn))
      );
    </script>
  </body>
</html>