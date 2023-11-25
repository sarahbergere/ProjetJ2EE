<%@ page import="entity.Commande" %>
<%@ page import="entity.DetailCommande" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="entity.Client" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Client client = (Client) session.getAttribute("client");
    Map<Integer, Integer> panier = (Map<Integer, Integer>) session.getAttribute("panier");

    if ((panier == null || panier.isEmpty()) || (client == null)) {
        response.sendRedirect("panier.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Confirmation de commande</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
    <style>
        ul {
            list-style: none;
        }
    </style>
</head>
<body>
<%@ include file="header.html" %>
<h1>Confirmation de commande</h1>

<%
    Commande commande = (Commande) session.getAttribute("commande");
    List<DetailCommande> detailsCommande = (List<DetailCommande>) session.getAttribute("detailsCommande");

    if (commande != null && detailsCommande != null) {
%>

<p>Merci pour votre commande !</p>
<p>Détails de la commande :</p>

<ul>
    <li>Numéro de commande : <%= commande.getId() %></li>
    <li>Date de commande : <%= commande.getDateDeCommande() %></li>
    <li>Montant total : <%= commande.getMontant() %> €</li>
</ul>

<p>Produits commandés :</p>
<ul>
    <% for (DetailCommande detail : detailsCommande) { %>
    <li><%= detail.getProduit().getNom() %> (Quantité : <%= detail.getQuantite() %>)</li>
    <% } %>
</ul>

<%
} else {
%>

<p>Aucune commande trouvée.</p>

<%
    }
%>

</body>
</html>
