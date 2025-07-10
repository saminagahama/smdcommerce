<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Gerenciar Categorias</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@700&display=swap" rel="stylesheet">
</head>
<body>

<div class="admin-container">
    <h1>Gerenciar Categorias</h1>

    <!-- Formulário para Adicionar Nova Categoria -->
    <div class="form-section">
        <h2>Nova Categoria</h2>
        <form action="${pageContext.request.contextPath}/admin/categorias" method="post">
            <input type="hidden" name="acao" value="inserir">
            <label for="descricao">Descrição:</label>
            <input type="text" id="descricao" name="descricao" required>
            <button type="submit">Adicionar Categoria</button>
        </form>
    </div>

    <!-- Tabela de Categorias Existentes -->
    <h2>Categorias Existentes</h2>
    <table class="product-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Descrição</th>
                <th style="width: 200px;">Ações</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="categoria" items="${categorias}">
                <!-- Cada linha é um formulário para permitir a submissão da atualização -->
                <tr id="row-${categoria.id}">
                    <form action="${pageContext.request.contextPath}/admin/categorias" method="post" style="display: contents;">
                        <input type="hidden" name="id" value="${categoria.id}">
                        <td>${categoria.id}</td>
                        <td>
                            <!-- Modo de Visualização (padrão) -->
                            <span class="view-mode">
                                <c:out value='${categoria.descricao}'/>
                            </span>
                            <!-- Modo de Edição (oculto) -->
                            <input type="text" name="descricao" value="<c:out value='${categoria.descricao}'/>" class="edit-mode" style="display:none;" required>
                        </td>
                        <td class="action-links">
                            <!-- Ações no Modo de Visualização -->
                            <div class="view-mode">
                                <a href="#" class="edit" onclick="toggleEditMode(${categoria.id}, true); return false;">Editar</a>
                                <a href="${pageContext.request.contextPath}/admin/categorias?acao=remover&id=${categoria.id}" class="remove" onclick="return confirm('Tem certeza que deseja remover esta categoria?');">Remover</a>
                            </div>
                            <!-- Ações no Modo de Edição -->
                            <div class="edit-mode" style="display:none;">
                                <button type="submit" name="acao" value="atualizar" class="edit">Salvar</button>
                                <a href="#" class="cancel" onclick="toggleEditMode(${categoria.id}, false); return false;">Cancelar</a>
                            </div>
                        </td>
                    </form>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/admin/admin.jsp" class="back-link">Voltar ao Painel</a>
</div>

<script>
    const style = document.createElement('style');
    style.innerHTML = `
        .action-links .cancel {
            background-color: #7f8c8d; /* Cinza */
            padding: 6px 12px;
            border-radius: 4px;
            color: white;
            text-decoration: none;
            font-size: 14px;
        }
        .action-links .cancel:hover {
            background-color: #95a5a6;
        }
    `;
    document.head.appendChild(style);

    function toggleEditMode(id, isEditing) {
        const row = document.getElementById('row-' + id);
        if (!row) return;

        const viewElements = row.querySelectorAll('.view-mode');
        const editElements = row.querySelectorAll('.edit-mode');

        if (isEditing) {
            viewElements.forEach(el => el.style.display = 'none');
            editElements.forEach(el => {
                el.style.display = 'flex';
                if(el.tagName === 'INPUT') el.style.display = 'block';
            });
            row.querySelector('input[name="descricao"]').focus();
        } else {
            viewElements.forEach(el => el.style.display = 'flex');
            editElements.forEach(el => el.style.display = 'none');
        }
    }
</script>

</body>
</html>