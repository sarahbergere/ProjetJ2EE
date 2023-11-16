<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter un Produit</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
</head>
<body>
<%@ include file="header.html" %>
<h2>Ajouter un Produit</h2>
<form action="AjouterProduitAction.jsp" method="post">
    Nom: <input type="text" name="nom" required><br>
    Prix: <input type="number" name="prix" required><br>
    Description: <input type="text" name="nom" required><br>
    Stock: <input type="number" name="stock" required><br>
    Image: <input type="text" name="image" required><br>
    <input type="submit" value="Ajouter" class="neumorphic-header button">
</form>
</body>
</html>

