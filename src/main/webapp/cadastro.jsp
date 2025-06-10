<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro - Loja Virtual</title>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="styles/cadastro.css">
</head>
<body>
    <header><h1>Cadastro de Novo Usuário</h1></header>
    <main>
        <div class="container">
            <h2>Crie sua Conta</h2>
            <form id="cadastro-form" method="post" action="CadastroCliente" novalidate>
                <div class="form-group">
                    <label for="nome">Nome Completo:</label>
                    <input type="text" id="nome" name="nome" required placeholder="Digite seu nome completo">
                    <span class="error-message" id="nome-error"></span>
                </div>
                <div class="form-group">
                    <label for="endereco">Endereço:</label>
                    <input type="text" id="endereco" name="endereco" required placeholder="Digite seu endereço completo">
                    <span class="error-message" id="endereco-error"></span>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required placeholder="Digite seu melhor e-mail">
                    <span class="error-message" id="email-error"></span>
                </div>
                <div class="form-group">
                    <label for="login">Nome de Usuário:</label>
                    <input type="text" id="login" name="login" required placeholder="Escolha um nome de usuário">
                    <span class="error-message" id="login-error"></span>
                </div>
                <div class="form-group">
                    <label for="senha">Senha:</label>
                    <input type="password" id="senha" name="senha" required placeholder="Crie uma senha segura">
                    <span class="error-message" id="senha-error"></span>
                </div>
                <div class="form-group">
                    <label for="confirma_senha">Confirme sua Senha:</label>
                    <input type="password" id="confirma_senha" name="confirma_senha" required placeholder="Repita a senha criada">
                    <span class="error-message" id="confirma_senha-error"></span>
                </div>
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

                const formData = new FormData(form);

                fetch('CadastroCliente', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.text())
                .then(html => {
                    const temp = document.createElement('div');
                    temp.innerHTML = html;
                    let msg = temp.querySelector('.mensagem-cadastro');
                    if (msg && msg.textContent.includes('sucesso')) {
                        alert('Cadastro realizado com sucesso!');
                        window.location.href = '/smd-web-tf/';
                    } else {
                        let erro = msg ? msg.textContent : 'Erro ao cadastrar usuário.';
                        alert(erro);
                        btn.disabled = false;
                        btn.textContent = 'Cadastrar';
                    }
                })
                .catch(() => {
                    alert('Erro ao cadastrar usuário.');
                    btn.disabled = false;
                    btn.textContent = 'Cadastrar';
                });
            }
        });
        [nomeInput,enderecoInput,emailInput,loginInput,senhaInput,confirmaSenhaInput].forEach(input => input.addEventListener('input', () => clearError(input.id)));
    </script>
</body>
</html>