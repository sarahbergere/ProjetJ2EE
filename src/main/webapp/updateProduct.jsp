<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Mise à jour du produit</title>
  <link rel="stylesheet" type="text/css" href="style.CSS">
</head>
<body>
<%@ include file="header.html" %>
<div class="container">

  <%
    // Récupérer les paramètres du formulaire
    String productName = request.getParameter("productName");
    double price = Double.parseDouble(request.getParameter("price"));
    int stock = Integer.parseInt(request.getParameter("stock"));
    String imageUrl = request.getParameter("imageUrl");

    // Définir les informations de connexion à la base de données
    String url = "jdbc:mysql://localhost:3306/ecommerce";
    String username = "root";
    String password = "cytech0001";

    // Charger le pilote JDBC
    Class.forName("com.mysql.cj.jdbc.Driver");

    // Établir la connexion à la base de données
    Connection connection = DriverManager.getConnection(url, username, password);

    // Créer la requête SQL pour mettre à jour les informations du produit
    String sqlQuery = "UPDATE Produit SET Prix=?, Stock=?, Image=? WHERE Nom=?";
    PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery);
    preparedStatement.setDouble(1, price);
    preparedStatement.setInt(2, stock);
    preparedStatement.setString(3, imageUrl);
    preparedStatement.setString(4, productName);

    // Exécuter la mise à jour
    int rowsAffected = preparedStatement.executeUpdate();

    // Vérifier si la mise à jour a réussi
    if (rowsAffected > 0) {
  %>
  <p>Les informations du produit <%= productName %> ont été mises à jour avec succès.</p>
  <%
  } else {
  %>
  <p>Échec de la mise à jour du produit <%= productName %>.</p>
  <%
    }

    // Fermer les ressources
    preparedStatement.close();
    connection.close();
  %>

</div>

</body>
</html>

