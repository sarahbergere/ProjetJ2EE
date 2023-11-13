<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Marketplace</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom right, #FFD2E5, #AAD8FF); /* Utilisez les couleurs pastel de votre choix */
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

        .card button {
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

        .card button:hover {
            box-shadow: -2px -2px 6px rgba(255, 255, 255, .6),
            -2px -2px 4px rgba(255, 255, 255, .4),
            2px 2px 2px rgba(255, 255, 255, .05),
            2px 2px 4px rgba(0, 0, 0, .1);
        }

        .card button:active {
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
    </style>
</head>
<body>

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

    <h2>Produits disponibles :</h2>

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
        <form action="AchatServlet" method="post">
            <input type="hidden" name="productName" value="<%= nom %>">
            <button type="submit">Acheter</button>
        </form>
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













