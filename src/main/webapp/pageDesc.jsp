<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Détails du Produit</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            var buyButton = document.getElementById('buyButton');
            var quantityInput = document.getElementById('quantiteInput');
            var plusButton = document.getElementById('plusButton');
            var minusButton = document.getElementById('minusButton');

            plusButton.addEventListener('click', function () {
                var currentQuantity = parseInt(quantityInput.value, 10);
                quantityInput.value = currentQuantity + 1;

                checkQuantity();
            });

            minusButton.addEventListener('click', function () {
                var currentQuantity = parseInt(quantityInput.value, 10);
                if (currentQuantity >= 1) {
                    quantityInput.value = currentQuantity - 1;
                }

                checkQuantity();
            });

            function checkQuantity() {
                var currentQuantity = parseInt(quantityInput.value, 10);
                var maxQuantity = parseInt(quantityInput.max, 10);

                plusButton.disabled = currentQuantity >= maxQuantity;
            }

            buyButton.addEventListener('click', function () {
                var idProduit = this.getAttribute('data-product');
                var quantite = quantityInput.value;

                var xhr = new XMLHttpRequest();
                xhr.open('POST', 'AddBasketServlet', true);
                xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        alert('Produit ajouté au panier avec succès !');
                        location.reload();
                    }
                };
                xhr.send('productId=' + encodeURIComponent(idProduit) + '&quantity=' + encodeURIComponent(quantite));
            });
        });
    </script>
</head>
<body>
<%@ include file="header.html" %>
<%
    int idproduct = Integer.parseInt(request.getParameter("idproduct"));

    // Définir les informations de connexion à la base de données
    String url = "jdbc:mysql://localhost:3306/ecommerce";
    String username = "root";
    String password = "cytech0001";

    Map<Integer, Integer> panier = (Map<Integer, Integer>) session.getAttribute("panier");
    int quantitePanier = (panier != null && panier.containsKey(idproduct) ? panier.get(idproduct) : 0);

    try {
        // Charger le pilote JDBC
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Établir la connexion à la base de données
        Connection connection = DriverManager.getConnection(url, username, password);

        // Créer la requête SQL pour récupérer les informations du produit
        String sqlQuery = "SELECT * FROM Produit WHERE idproduit=?";
        PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery);
        preparedStatement.setInt(1, idproduct);

        // Exécuter la requête
        ResultSet resultSet = preparedStatement.executeQuery();

        // Afficher les informations du produit
        if (resultSet.next()) {
            String productName = resultSet.getString("Nom");
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
        <button type="button" id="minusButton">-</button>
        <input type="number" id="quantiteInput" value="0" min="0" max="<%= stock - quantitePanier %>">
        <button type="button" id="plusButton">+</button>
        <br>
        <br>
        <button type="button" id="buyButton" data-product="<%= idproduct %>">Acheter</button>
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

