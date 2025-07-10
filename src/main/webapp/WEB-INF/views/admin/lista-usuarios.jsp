<%@ page import="modelo.usuario.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Usuários</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>

<h1>Administração de Usuários</h1>

<%
    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
    if (usuarios != null && !usuarios.isEmpty()) {
%>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Login</th>
            <th>Email</th>
        </tr>
    </thead>
    <tbody>
    <% for (Usuario usuario : usuarios) { %>
        <tr>
            <td><%= usuario.getId() %></td>
            <td><%= usuario.getNome() %></td>
            <td><%= usuario.getLogin() %></td>
            <td><%= usuario.getEmail() %></td>
        </tr>
    <% } %>
    </tbody>
</table>
<%
    } else {
%>
<p>Nenhum usuário cadastrado.</p>
<%
    }
%>

</body>
</html>