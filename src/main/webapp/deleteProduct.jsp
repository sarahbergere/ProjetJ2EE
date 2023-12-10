<%@ page import="java.sql.*" %>
<%@ page import="dao.ProduitDAO" %>
<%@ page import="entity.Produit" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Marketplace - Supprimer le produit</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
    <script>
        function redirectToEdit(productName) {
            window.location.href = "edit.jsp?productName=" + encodeURIComponent(productName);
        }

        function redirectToHome() {
            window.location.href = "bienvenue.jsp";
        }
    </script>
</head>
<body>
<%@ include file="header.html" %>

<div class="container">
    <%
        int idproduct = 0;
        idproduct = Integer.parseInt(request.getParameter("idproduct"));

        if (idproduct != 0) {
            try {
                ProduitDAO produitDAO = new ProduitDAO();
                Produit produit = produitDAO.findById(idproduct);

                boolean isDeleted = produitDAO.delete(produit);

                if (isDeleted) {
    %>
    <div class="success-message">
        Le produit <%= produit.getNom() %> a été supprimé avec succès.
    </div>
    <%
    } else {
    %>
    <div class="error-message">
        Erreur lors de la suppression du produit <%= produit.getNom() %>. Veuillez réessayer.
    </div>
    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
    <br>
    <br>
    <button type="button" onclick="redirectToHome()">Retour à la page d'accueil</button>
</div>

</body>
</html>

