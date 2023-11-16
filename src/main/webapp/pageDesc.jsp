<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Détails du Produit</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
</head>
<body>
<%@ include file="header.html" %>
<%
    // Récupérer le nom du produit depuis le paramètre de l'URL
    String productName = request.getParameter("productName");

    // Définir les informations de connexion à la base de données
    String url = "jdbc:mysql://localhost:3306/ecommerce";
    String username = "root";
    String password = "cytech0001";

    try {
        // Charger le pilote JDBC
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Établir la connexion à la base de données
        Connection connection = DriverManager.getConnection(url, username, password);

        // Créer la requête SQL pour récupérer les informations du produit
        String sqlQuery = "SELECT * FROM Produit WHERE Nom=?";
        PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery);
        preparedStatement.setString(1, productName);

        // Exécuter la requête
        ResultSet resultSet = preparedStatement.executeQuery();

        // Afficher les informations du produit
        if (resultSet.next()) {
            String imageUrl = resultSet.getString("Image");
            double prix = resultSet.getDouble("Prix");
            String description = resultSet.getString("Description");
            int stock = resultSet.getInt("Stock");

%>

<div class="product-details">
    <div class="product-image">
        <img src="<%= imageUrl %>" alt="<%= productName %> Image" width="150">
    </div>
    <div class="product-info">
        <h2>Détails du Produit</h2>
        <p><strong>Nom :</strong> <%= productName %></p>
        <p><strong>Prix :</strong> <%= prix %> €</p>
        <p><strong>Description :</strong> <%= description %></p>
        <p><strong>Stock :</strong> <%= stock %></p>
        <br>
        <br>
        <br>
        <button type="button">Acheter</button>
    </div>
</div>
<%
} else {
%>
<div>
    <h2>Produit non trouvé</h2>
    <p>Le produit sélectionné n'a pas été trouvé dans la base de données.</p>
</div>
<%
        }

        // Fermer les ressources
        resultSet.close();
        preparedStatement.close();
        connection.close();

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>

