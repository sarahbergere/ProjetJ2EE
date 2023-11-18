<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Marketplace</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
    <script>
        function redirectToPageDesc(id) {
            window.location.href = "pageDesc.jsp?idproduct=" + encodeURIComponent(id);
        }
    </script>
</head>
<body>
<%@ include file="header.html" %>

<div class="container">
    <h2>Bienvenue sur notre Marketplace !</h2>
    <p>Découvrez nos produits populaires :</p>

    <%
        // Définir les informations de connexion à la base de données
        String url = "jdbc:mysql://localhost:3306/ecommerce";
        String username = "root";
        String password = "cytech0001";

        // Charger le pilote JDBC
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Établir la connexion à la base de données
        Connection connection = DriverManager.getConnection(url, username, password);

        // Créer la requête SQL pour récupérer des produits aléatoires
        String sqlQuery = "SELECT * FROM Produit ORDER BY RAND() LIMIT 4";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sqlQuery);
    %>

    <div class="card-container">
        <%
            while (resultSet.next()) {
                int id = resultSet.getInt("idproduit");
                String nom = resultSet.getString("Nom");
                double prix = resultSet.getDouble("Prix");
                int stock = resultSet.getInt("Stock");
                String imageUrl = resultSet.getString("Image");
        %>

        <div class="card">
            <h3><%= nom %></h3>
            <img src="<%= imageUrl %>" alt="<%= nom %> Image">
            <p><b><%= prix %> €</b></p>
            <p class="stock"><i>Il en reste <%= stock %> !</i></p>
            <button type="button" onclick="redirectToPageDesc('<%= id %>')">Acheter</button>
        </div>

        <%
            }
            // Fermer les ressources
            resultSet.close();
            statement.close();
            connection.close();
        %>
    </div>

</div>

</body>
</html>