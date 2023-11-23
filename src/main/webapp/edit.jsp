<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Modifier le produit</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
</head>
<body>
<%@ include file="header.html" %>
<div class="container">

    <%
        // Récupérer le nom du produit à partir des paramètres de requête
        String productName = request.getParameter("productName");

        // Définir les informations de connexion à la base de données
        String url = "jdbc:mysql://localhost:3306/ecommerce";
        String username = "root";
        String password = "cytech0001";

        // Charger le pilote JDBC
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Établir la connexion à la base de données
        Connection connection = DriverManager.getConnection(url, username, password);

        // Créer la requête SQL pour obtenir les informations du produit sélectionné
        String sqlQuery = "SELECT * FROM Produit WHERE Nom=?";
        PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery);
        preparedStatement.setString(1, productName);
        ResultSet resultSet = preparedStatement.executeQuery();

        // Vérifier s'il y a un résultat (il devrait y en avoir un, car le nom du produit est unique)
        if (resultSet.next()) {
            // Récupérer les informations du produit
            double prix = resultSet.getDouble("Prix");
            int stock = resultSet.getInt("Stock");
            String imageUrl = resultSet.getString("Image");
    %>

    <form action="updateProduct.jsp" method="post">
        <input type="hidden" name="productName" value="<%= productName %>">
        <label for="price">Prix:</label>
        <input type="text" name="price" value="<%= prix %>">
        <br>
        <label for="stock">Stock:</label>
        <input type="text" name="stock" value="<%= stock %>">
        <br>
        <label for="imageUrl">URL de l'image:</label>
        <input type="text" name="imageUrl" value="<%= imageUrl %>">
        <br>
        <input type="submit" value="Enregistrer les modifications">
    </form>

    <%
    } else {
        // Gérer le cas où le produit n'est pas trouvé
    %>
    <p>Le produit <%= productName %> n'a pas été trouvé.</p>
    <%
        }

        // Fermer les ressources
        resultSet.close();
        preparedStatement.close();
        connection.close();
    %>

</div>

</body>
</html>

