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
        <a href="/smd-web-tf/carrinho.jsp">Meu Carrinho</a>
    </nav>

    <div class="container">
        <div class="main-content">
            <h2>Produtos Disponíveis</h2>
            <div id="product-list"></div>
        </div>

        <aside class="sidebar">
        <%
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            if (usuario == null) {
        %>
            <div id="login-area">
                <h3>Login</h3>
                <form id="login-form" action="<%= request.getContextPath() %>/Login" method="post">
                    <label for="login">E-mail ou usuário:</label>
                    <input type="text" id="login" name="login" required placeholder="Digite seu e-mail ou usuário">

                    <label for="senha">Senha:</label>
                    <input type="password" id="senha" name="senha" required placeholder="Digite sua senha">

                    <button type="submit" value="">Entrar</button>
                    <a href="<%= request.getContextPath() %>/cadastro.jsp">Não tem conta? Cadastre-se</a>
                </form>
                <div id="mensagem"></div>
            </div>
        <%
            } else {
        %>
                <jsp:include page="/WEB-INF/views/menu-usuario.jsp" />
        <% } %>
            
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
                    var conteudo = xhr.responseText.trim();
                    if (!conteudo) {
                        document.getElementById("product-list").innerHTML = "<p>Não há produtos disponíveis no momento.</p>";
                    } else {
                        document.getElementById("product-list").innerHTML = conteudo;
                    }
                } else if (xhr.readyState === 4) {
                    document.getElementById("product-list").innerHTML = "<p>Erro ao carregar lista de produtos.</p>";
                    console.error("Erro AJAX: " + xhr.status + " - " + xhr.statusText);
                }
            };
            xhr.send();
        }
        
        function adicionarAoCarrinho(id) {
        	
        }
        
        if (document.getElementById('login-form')) {
            document.getElementById('login-form').addEventListener('submit', function(event) {
                event.preventDefault();
                
                var form = event.target;
                var formData = new FormData(form);
                var btn = form.querySelector('button[type="submit"]');
                var originalText = btn.textContent;
                btn.disabled = true;
                btn.textContent = 'Entrando...';
                document.getElementById('mensagem').innerHTML = '';

                fetch('<%= request.getContextPath() %>/Login', {
                    method: 'POST',
                    body: formData,
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                .then(
                    response => response.text()
                )
                .then(html => {
                    if (html.includes('id="menu-usuario"')) {
                        const loginArea = document.getElementById('login-area');
                        if (loginArea) loginArea.remove();

                        const oldMenu = document.getElementById('menu-area') || document.getElementById('menu-usuario');
                        if (oldMenu) oldMenu.remove();

                        const aside = document.querySelector('.sidebar');
                        const div = document.createElement('div');
                        div.id = 'menu-area';
                        div.innerHTML = html;
                        aside.appendChild(div);
                    } else {
                        document.getElementById('mensagem').innerHTML = html;
                        btn.disabled = false;
                        btn.textContent = originalText;
                    }
                })
                .catch(err => {
                    console.log(err);
                    btn.disabled = false;
                    btn.textContent = originalText;
                });
            });
        }

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
        
        function logout(e) {
        e.preventDefault();
        fetch('/smd-web-tf/logout')
            .then(() => {
                window.location.reload(true);
            });
        }
        
        window.onload = carregarListaProdutos;
    </script>

</body>
</html>