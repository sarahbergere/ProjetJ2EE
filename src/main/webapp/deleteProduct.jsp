<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*" %>

<html>
<head>
    <title>Marketplace - Supprimer le produit</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
    <script>
        function redirectToEdit(productName) {
            window.location.href = "edit.jsp?productName=" + encodeURIComponent(productName);
        }

        function redirectToHome() {
            window.location.href = "bienvenue.jsp";
        }
    </script>
</head>
<body>
<%@ include file="header.html" %>

<div class="container">
    <%
        String productName = request.getParameter("productName");

        if (productName != null) {
            try {
                // Définir les informations de connexion à la base de données
                String url = "jdbc:mysql://localhost:3306/ecommerce";
                String username = "root";
                String password = "cytech0001";

                // Charger le pilote JDBC
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Établir la connexion à la base de données
                Connection connection = DriverManager.getConnection(url, username, password);

                // Créer la requête SQL pour supprimer le produit
                String deleteQuery = "DELETE FROM Produit WHERE Nom = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery);
                preparedStatement.setString(1, productName);

                // Exécuter la requête de suppression
                int rowsAffected = preparedStatement.executeUpdate();

                // Fermer les ressources
                preparedStatement.close();
                connection.close();

                if (rowsAffected > 0) {
    %>
    <div class="success-message">
        Le produit <%= productName %> a été supprimé avec succès.
    </div>
    <%
    } else {
    %>
    <div class="error-message">
        Erreur lors de la suppression du produit <%= productName %>. Veuillez réessayer.
    </div>
    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
    <br>
    <br>
    <button type="button" onclick="redirectToHome()">Retour à la page d'accueil</button>
</div>

</body>
</html>

