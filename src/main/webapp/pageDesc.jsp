<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Détails du Produit</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom right, #FFD2E5, #AAD8FF); /* Utilisez les couleurs pastel de votre choix */
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .neumorphic-header {
            background-color: #f0f0f0;
            border-radius: 15px;
            box-shadow: 5px 5px 10px #bcbcbc, -5px -5px 10px #ffffff;
            padding: 15px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 80%; /* Ajustez la largeur du header en fonction de vos besoins */
        }

        .neumorphic-header button {
            padding: 0.5em 1.5em;
            background: #efefef;
            border: none;
            border-radius: .5rem;
            color: #444;
            font-size: 1rem;
            font-weight: 700;
            text-align: center;
            outline: none;
            cursor: pointer;
            transition: .2s ease-in-out;
            box-shadow: -6px -6px 14px rgba(255, 255, 255, .7),
            -6px -6px 10px rgba(255, 255, 255, .5),
            6px 6px 8px rgba(255, 255, 255, .075),
            6px 6px 10px rgba(0, 0, 0, .15);
        }

        .neumorphic-header button:hover {
            box-shadow: -2px -2px 6px rgba(255, 255, 255, .6),
            -2px -2px 4px rgba(255, 255, 255, .4),
            2px 2px 2px rgba(255, 255, 255, .05),
            2px 2px 4px rgba(0, 0, 0, .1);
        }

        .neumorphic-header button:active {
            box-shadow: inset -2px -2px 6px rgba(255, 255, 255, .7),
            inset -2px -2px 4px rgba(255, 255, 255, .5),
            inset 2px 2px 2px rgba(255, 255, 255, .075),
            inset 2px 2px 4px rgba(0, 0, 0, .15);
        }

        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }

        .categories {
            margin-bottom: 20px;
        }

        .category {
            display: inline-block;
            margin-right: 10px;
            color: #333;
            text-decoration: none;
            font-weight: bold;
        }

        .card {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-radius: 20px;
            padding: 20px;
            margin: 10px;
            width: 200px;
            float: left;
            background-color: rgba(255, 255, 255, 0.5); /* Couleur avec opacité de 50% */
            text-align: center; /* Ajout de la propriété pour centrer le contenu */
            transition: transform 0.2s ease-in-out;
        }

        .card:hover {
            transform: scale(1.05); /* Applique un effet de zoom au survol */
        }

        .product-info button {
            padding: 0.5em 1.5em;
            background: #efefef;
            border: none;
            border-radius: .5rem;
            color: #444;
            font-size: 1rem;
            font-weight: 700;
            text-align: center;
            outline: none;
            cursor: pointer;
            transition: .2s ease-in-out;
            box-shadow: -6px -6px 14px rgba(255, 255, 255, .7),
            -6px -6px 10px rgba(255, 255, 255, .5),
            6px 6px 8px rgba(255, 255, 255, .075),
            6px 6px 10px rgba(0, 0, 0, .15);
        }

        .product-info button:hover {
            box-shadow: -2px -2px 6px rgba(255, 255, 255, .6),
            -2px -2px 4px rgba(255, 255, 255, .4),
            2px 2px 2px rgba(255, 255, 255, .05),
            2px 2px 4px rgba(0, 0, 0, .1);
        }

        .product-info button:active {
            box-shadow: inset -2px -2px 6px rgba(255, 255, 255, .7),
            inset -2px -2px 4px rgba(255, 255, 255, .5),
            inset 2px 2px 2px rgba(255, 255, 255, .075),
            inset 2px 2px 4px rgba(0, 0, 0, .15);
        }

        .card img {
            max-width: 100%;
            height: auto;
            width: 200px; /* Fixe la largeur à 200px */
            height: 200px; /* Fixe la hauteur à 200px */
        }

        .card p {
            margin: 10px 0;
            font-size: 1.8rem; /* Agrandir la taille du texte */
        }

        .card p.stock {
            font-size: 0.8rem; /* Réduire la taille du texte pour le stock */
            color: #444444;
        }
        .product-details {
            display: flex;
            align-items: center;
            max-width: 800px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: rgba(255, 255, 255, 0.5);
        }

        .product-image {
            margin-right: 20px;
        }
        .product-image img {
            width: 400px;
        }

        .product-info {
            max-width: 400px;
            
        }

        .product-info p {
            margin: 0;
        }

        .product-info p {
            margin: 0;
        }
    </style>
</head>
<body>

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

