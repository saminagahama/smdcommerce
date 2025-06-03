<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro - Loja Virtual</title>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
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
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Open Sans', sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background-color: #f9f9f9;
            margin: 0; padding: 0;
            min-height: 100vh;
            display: flex; flex-direction: column;
        }
        header { background-color: var(--primary-color); color: #fff; padding: 1.5rem 2rem; text-align: center; box-shadow: var(--box-shadow); }
        header h1 { font-size: 2.2rem; margin: 0; font-weight: 700; letter-spacing: 1px; }
        main { flex: 1; display: flex; flex-direction: column; justify-content: center; padding: 2rem 0; }
        .container {
            max-width: 600px; width: 90%; margin: 0 auto; padding: 2rem;
            background-color: #fff; border-radius: var(--border-radius); box-shadow: var(--box-shadow);
        }
        h2 {
            color: var(--primary-color); text-align: center; margin-bottom: 2rem; font-size: 1.8rem;
            position: relative; padding-bottom: 0.5rem;
        }
        h2::after {
            content: ""; position: absolute; bottom: 0; left: 50%; transform: translateX(-50%);
            width: 60px; height: 3px; background-color: var(--secondary-color);
        }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: 600; color: var(--dark-color); }
        .form-group input {
            width: 100%; padding: 0.8rem 1rem; border: 1px solid #ddd; border-radius: var(--border-radius);
            font-size: 1rem; transition: var(--transition);
        }
        .form-group input:focus { outline: none; border-color: var(--secondary-color); box-shadow: 0 0 0 2px rgba(52,152,219,0.2); }
        .form-group input.error { border-color: var(--error-color); }
        .error-message { color: var(--error-color); font-size: 0.85rem; margin-top: 0.3rem; display: block; }
        button[type="submit"] {
            width: 100%; padding: 0.8rem; background-color: var(--success-color); color: #fff; border: none;
            border-radius: var(--border-radius); font-size: 1rem; font-weight: 600; cursor: pointer; transition: var(--transition); margin-top: 1rem;
        }
        button[type="submit"]:hover { background-color: #219653; transform: translateY(-2px); }
        .back-link { display: block; text-align: center; margin-top: 1.5rem; color: var(--secondary-color); text-decoration: none; font-weight: 500; transition: var(--transition); }
        .back-link:hover { text-decoration: underline; color: #2980b9; }
        footer { background-color: var(--dark-color); color: #fff; text-align: center; padding: 1.5rem; font-size: 0.9rem; }
        @media (max-width: 768px) {
            .container { padding: 1.5rem; }
            header h1 { font-size: 1.8rem; }
        }
    </style>
</head>
<body>
    <header><h1>Cadastro de Novo Usuário</h1></header>
    <main>
        <div class="container">
            <h2>Crie sua Conta</h2>
            <form id="cadastro-form" novalidate>
                <div class="form-group"><label for="nome">Nome Completo:</label><input type="text" id="nome" required placeholder="Digite seu nome completo"><span class="error-message" id="nome-error"></span></div>
                <div class="form-group"><label for="endereco">Endereço:</label><input type="text" id="endereco" required placeholder="Digite seu endereço completo"><span class="error-message" id="endereco-error"></span></div>
                <div class="form-group"><label for="email">Email:</label><input type="email" id="email" required placeholder="Digite seu melhor e-mail"><span class="error-message" id="email-error"></span></div>
                <div class="form-group"><label for="login">Nome de Usuário:</label><input type="text" id="login" required placeholder="Escolha um nome de usuário"><span class="error-message" id="login-error"></span></div>
                <div class="form-group"><label for="senha">Senha:</label><input type="password" id="senha" required placeholder="Crie uma senha segura"><span class="error-message" id="senha-error"></span></div>
                <div class="form-group"><label for="confirma_senha">Confirme sua Senha:</label><input type="password" id="confirma_senha" required placeholder="Repita a senha criada"><span class="error-message" id="confirma_senha-error"></span></div>
                <button type="submit">Cadastrar</button>
            </form>
            <a href="/smd-web-tf/" class="back-link">Voltar para a Página Inicial</a>
        </div>
    </main>
    <footer><p>&copy; 2025 Minha Loja Virtual - Todos os direitos reservados</p></footer>
    <script>
        const form = document.getElementById('cadastro-form');
        const nomeInput = document.getElementById('nome');
        const enderecoInput = document.getElementById('endereco');
        const emailInput = document.getElementById('email');
        const loginInput = document.getElementById('login');
        const senhaInput = document.getElementById('senha');
        const confirmaSenhaInput = document.getElementById('confirma_senha');

        function showError(id, message) {
            document.getElementById(id + '-error').textContent = message;
            document.getElementById(id).classList.add('error');
        }
        function clearError(id) {
            document.getElementById(id + '-error').textContent = '';
            document.getElementById(id).classList.remove('error');
        }
        form.addEventListener('submit', e => {
            e.preventDefault();
            let isValid = true;
            ['nome','endereco','email','login','senha','confirma_senha'].forEach(clearError);
            if (!nomeInput.value.trim()) { showError('nome','O nome é obrigatório.'); isValid = false; }
            if (!enderecoInput.value.trim()) { showError('endereco','O endereço é obrigatório.'); isValid = false; }
            if (!emailInput.value.trim()) { showError('email','O email é obrigatório.'); isValid = false; }
            else if (!/\S+@\S+\.\S+/.test(emailInput.value)) { showError('email','Por favor, insira um email válido.'); isValid = false; }
            if (!loginInput.value.trim()) { showError('login','O nome de usuário é obrigatório.'); isValid = false; }
            if (!senhaInput.value.trim()) { showError('senha','A senha é obrigatória.'); isValid = false; }
            else if (senhaInput.value.length < 6) { showError('senha','A senha deve ter pelo menos 6 caracteres.'); isValid = false; }
            if (!confirmaSenhaInput.value.trim()) { showError('confirma_senha','Por favor, confirme sua senha.'); isValid = false; }
            if (senhaInput.value && confirmaSenhaInput.value && senhaInput.value !== confirmaSenhaInput.value) {
                showError('confirma_senha','As senhas não coincidem.'); isValid = false;
            }
            if (isValid) {
                const btn = form.querySelector('button[type="submit"]');
                btn.textContent = 'Cadastrando...'; btn.disabled = true;
                setTimeout(() => { alert('Cadastro realizado com sucesso!'); window.location.href = 'index.html'; }, 1500);
            }
        });
        [nomeInput,enderecoInput,emailInput,loginInput,senhaInput,confirmaSenhaInput].forEach(input => input.addEventListener('input', () => clearError(input.id)));
    </script>
</body>
</html>