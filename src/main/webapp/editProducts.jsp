<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Marketplace</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
    <script>
        function redirectToEdit(productName) {
            window.location.href = "edit.jsp?productName=" + encodeURIComponent(productName);
        }
        function redirectToDeleteProduct(productName) {
            window.location.href = "deleteProduct.jsp?productName=" + encodeURIComponent(productName);
        }
        function redirectToAddProduit() {
            window.location.href = "addProduit.jsp";
        }
    </script>
</head>
<body>
<%@ include file="header.html" %>
<button type="button" onclick="redirectToAddProduit()">Ajouter un produit</button>
<div class="container">


    <%
        // Définir les informations de connexion à la base de données
        String url = "jdbc:mysql://localhost:3306/ecommerce";
        String username = "root";
        String password = "cytech0001";

        // Charger le pilote JDBC
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Établir la connexion à la base de données
        Connection connection = DriverManager.getConnection(url, username, password);

        // Créer la requête SQL
        String sqlQuery = "SELECT * FROM Produit";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sqlQuery);
    %>

    <%
        while (resultSet.next()) {
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
        <button type="button" onclick="redirectToEdit('<%= nom %>')">Modifier</button>
        <br>
        <br>
        <button type="button" onclick="redirectToDeleteProduct('<%= nom %>')">Supprimer</button>
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













