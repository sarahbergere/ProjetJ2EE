<%@ page import="java.util.Map" %>
<%@ page import="dao.ProduitDAO" %>
<%@ page import="entity.Produit" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Panier</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
</head>
<body>
<%@ include file="header.html" %>

<h2>Votre Panier</h2>

<%
    Map<Integer, Integer> panier = (Map<Integer, Integer>) session.getAttribute("panier");

    if (panier != null && !panier.isEmpty()) {
%>

<table border="1">
    <thead>
    <tr>
        <th>Image</th>
        <th>Nom</th>
        <th>Quantité</th>
        <th>Actions</th>
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

<%
} else {
%>
<p>Votre panier est vide.</p>
<%
    }
%>

</body>
</html>