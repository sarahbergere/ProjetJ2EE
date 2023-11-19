<%@ page import="java.util.Map" %>
<%@ page import="dao.ProduitDAO" %>
<%@ page import="entity.Produit" %>
<%@ page import="static Functions.PanierUtil.calculateTotalAmount" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Panier</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
    <style>
        button {
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

        input[type="number"] {
            margin: 0 15px;
            width: 50%;
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
            box-shadow: -6px -6px 14px rgba(255, 255, 255, .7),
            -6px -6px 10px rgba(255, 255, 255, .5),
            6px 6px 8px rgba(255, 255, 255, .075),
            6px 6px 10px rgba(0, 0, 0, .15);
        }
        table {
            align-content: center;
            width: 80%;
            border-collapse: collapse;
            margin-top: 40px; /* Add some space between the header and the table */
        }

        thead {
            background-color: #f2f2f2;
        }

        th, td {
            padding: 12px;
            text-align: center;
        }

        /* Style alternating rows for better readability */
        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* Adjust the image size for better alignment */
        td img {
            max-width: 100%;
            height: auto;
        }
        .erreur-message {
            color: red;
            font-weight: bold;
        }
        .cart-summary{
            margin-top : 50px;
        }
    </style>
</head>
<body>
    <%@ include file="header.html" %>

    <h2>Votre Panier</h2>

    <%
        Map<Integer, Integer> panier = (Map<Integer, Integer>) session.getAttribute("panier");

        if (panier != null && !panier.isEmpty()) {
    %>

    <table>
        <thead>
            <tr>
                <th>Image</th>
                <th>Nom</th>
                <th>Quantité</th>
                <th>Prix</th>
            </tr>
        </thead>
        <tbody>
        <%
            for (Map.Entry<Integer, Integer> entry : panier.entrySet()) {
                int productId = entry.getKey();
                int quantity = entry.getValue();

                // Récupérer les informations du produit à partir de la base de données
                ProduitDAO produitDAO = new ProduitDAO();
                Produit produit = produitDAO.findById(productId);
        %>
        <tr>
            <td><img src="<%= produit.getImage() %>" alt="<%= productId %> Image" width="150"></td>
            <td><%= produit.getNom() %></td>
            <td>
                <form method="post" action="UpdateCartServlet">
                    <input type="hidden" name="productId" value="<%= productId %>">
                    <input type="number" name="quantity" value="<%= quantity %>" min="0">
                    <button type="submit">Mettre à jour</button>
                </form>
            </td>
            <td>
                <%= produit.getPrix() * quantity %> €
            </td>
            <td>
                <form method="post" action="RemoveFromCartServlet">
                    <input type="hidden" name="productId" value="<%= productId %>">
                    <button type="submit">Supprimer</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <div class="cart-summary">
        <%
            double totalAmount = calculateTotalAmount(panier);
        %>

        <b>Total du panier : <%= totalAmount %> euros</b><br><br>

        <form method="post" action="ValiderPanierServlet">
            <button type="submit">Valider le Panier</button>
        </form>
    </div>
    <%
    } else {
    %>
    <p>Votre panier est vide.</p>
    <%
        }
    %>

    <%
        String erreurMessage = (String) session.getAttribute("erreurMessage");
        if (Objects.nonNull(erreurMessage)) {
    %>
    <p class="erreur-message"><%= erreurMessage %></p>
    <%
            session.removeAttribute("erreurMessage");
        }
    %>
</body>
</html>