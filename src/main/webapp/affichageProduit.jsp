<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Marketplace</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
    <script>
        function redirectToPageDesc(idproduct) {
            window.location.href = "pageDesc.jsp?idproduct=" + encodeURIComponent(idproduct);
        }
    </script>
</head>
<body>
<%@ include file="header.html" %>

<div class="container">

    <%
        // Définir les informations de connexion à la base de données
        String url = "jdbc:mysql://localhost:3306/ecommerce";
        String username = "root";
        String password = "eisti0001";

        // Charger le pilote JDBC
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Établir la connexion à la base de données
        Connection connection = DriverManager.getConnection(url, username, password);

        // Créer la requête SQL
        String sqlQuery = "SELECT * FROM Produit";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sqlQuery);
    %>

    <h2>Produits disponibles :</h2>

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

</body>
</html>
