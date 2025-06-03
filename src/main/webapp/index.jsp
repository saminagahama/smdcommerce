
<%@page import="modelo.usuario.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loja Virtual</title>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="styles/index.css">
</head>
<body>
    <header>
        <h1>Minha Loja Virtual</h1>
    </header>

    <nav>
        <a href="/smd-web-tf/views/carrinho.jsp">Meu Carrinho</a>
    </nav>

    <div class="container">
        <div class="main-content">
            <h2>Produtos Disponíveis</h2>
            <div id="products">
            	
            </div>
        </div>

        <aside class="sidebar">
        <%
		    Usuario usuario = (Usuario) session.getAttribute("usuario");
		    if (usuario != null) {
		%>
            <div class="login-area">
                <h3>Login</h3>
                <form id="login-form" action="Login" method="post">
                    <label for="login">E-mail ou usuário:</label>
                    <input type="text" id="login" name="login" required placeholder="Digite seu e-mail ou usuário">

                    <label for="senha">Senha:</label>
                    <input type="password" id="senha" name="senha" required placeholder="Digite sua senha">

                    <button type="submit" value="">Entrar</button>
                    <a href="/smd-web-tf/views/cadastro.jsp">Não tem conta? Cadastre-se</a>
                </form>
            </div>
        <%
		    } else {
        %>
        <!-- Menu do usuário ----------------- -->
        <!-- Minha conta -->
        <!-- Meus pedidos -->
        <!-- Sair -->
        <!-- Menu do admin ------------------- -->
        <!-- Gerenciar produto -->
        <%
		    }
		 %>
            
        </aside>
    </div>

    <footer>
        <p>&copy; 2025 Minha Loja Virtual - Todos os direitos reservados</p>
    </footer>

    <script>
	    function carregarListaProdutos() {
	        var xhr = new XMLHttpRequest();
	        xhr.open("GET", "produtos?action=listar", true);
	        xhr.onreadystatechange = function () {
	            if (xhr.readyState === 4 && xhr.status === 200) {
	                document.getElementById("products").innerHTML = xhr.responseText;
	            } else if (xhr.readyState === 4) {
	                document.getElementById("products").innerHTML = "<p>Erro ao carregar lista de produtos.</p>";
	                console.error("Erro AJAX: " + xhr.status + " - " + xhr.statusText);
	            }
	        };
	        xhr.send(); // Envia a requisição
	    }
	    
        document.getElementById('login-form').addEventListener('submit', function(event) {
            event.preventDefault();
            alert('Funcionalidade de login ainda não implementada.');
        });

        document.querySelectorAll('.product-item button').forEach(button => {
            button.addEventListener('click', () => {
                const product = button.closest('.product-item').querySelector('h4').textContent;
                button.textContent = 'Adicionado ✓';
                button.style.backgroundColor = 'var(--success-color)';
                
                setTimeout(() => {
                    button.textContent = 'Adicionar ao Carrinho';
                    button.style.backgroundColor = 'var(--secondary-color)';
                }, 2000);
            });
        });
        
        window.onload = carregarListaProdutos;
    </script>

</body>
</html>