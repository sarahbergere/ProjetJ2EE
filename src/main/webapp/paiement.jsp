<%@ page import="entity.CompteBancaire" %>
<%@ page import="entity.Client" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Client client = (Client) session.getAttribute("client");
    Map<Integer, Integer> panier = (Map<Integer, Integer>) session.getAttribute("panier");

    if ((panier == null || panier.isEmpty()) && (client == null)) {
        response.sendRedirect("panier.jsp");
    }
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Paiement</title>
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
    </style>
</head>
<body>

<%@ include file="header.html" %>

<h2>Information de Livraison</h2>

<form method="post" action="ProcessPaymentServlet">

    <label for="nom">Nom :</label>
    <input type="text" id="nom" name="nom" required><br>

    <label for="adresse">Adresse :</label>
    <textarea id="adresse" name="adresse" rows="4" required></textarea><br>

    <label for="ville">Ville :</label>
    <input type="text" id="ville" name="ville" required><br>

    <label for="codePostal">Code Postal :</label>
    <input type="text" id="codePostal" name="codePostal" required><br>

    <label for="pays">Pays :</label>
    <input type="text" id="pays" name="pays" required><br>

    <label>Choisissez une option de paiement :</label><br>

    <input type="radio" id="lierCompte" name="optionCompte" value="lierCompte">
    <label for="lierCompte">Lier un nouveau compte bancaire</label><br>

    <input type="radio" id="choisirCompteLie" name="optionCompte" value="choisirCompteLie">
    <label for="choisirCompteLie">Choisir un compte bancaire déjà lié :</label><br>

    <div id="compteBancaireLie" style="display:none;">
        <label for="compteBancaire">Sélectionnez un compte bancaire existant :</label>
        <select id="compteBancaire" name="compteBancaire">
            <%
                Client client1 = (Client) session.getAttribute("client");
                if (client1 != null) {
                    List<CompteBancaire> comptesBancaires = client1.getComptes();
                    if (comptesBancaires != null) {
                        for (CompteBancaire compte : comptesBancaires) {
            %>
            <option value="<%= compte.getId() %>"><%= compte.getTitulaireDuCompte() %> - <%= compte.getSolde()%> €</option>
            <%
                        }
                    }
                }
            %>

        </select><br>
    </div>

    <div id="nouveauCompteBancaire" style="display:none;">
        <h2>Ajouter un nouveau compte bancaire</h2>
        <label for="titulaire">Nom du titulaire :</label>
        <input type="text" id="titulaire" name="titulaire"><br>

        <label for="numeroCompte">Numéro de compte bancaire :</label>
        <input type="text" id="numeroCompte" name="numeroCompte"><br>

        <label for="solde">Solde initial :</label>
        <input type="number" id="solde" name="solde" step="0.01"><br>
    </div>

    <input type="submit" value="Payer">
</form>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var compteBancaireLie = document.getElementById('compteBancaireLie');
        var nouveauCompteBancaire = document.getElementById('nouveauCompteBancaire');

        document.querySelectorAll('input[name="optionCompte"]').forEach(function(radio) {
            radio.addEventListener('change', function() {
                compteBancaireLie.style.display = this.value === 'choisirCompteLie' ? 'block' : 'none';
                nouveauCompteBancaire.style.display = this.value === 'lierCompte' ? 'block' : 'none';

                // Ajouter ou supprimer l'attribut required
                var requiredFields = nouveauCompteBancaire.querySelectorAll('[required]');
                requiredFields.forEach(function(field) {
                    field.required = this.value === 'lierCompte';
                });
            });
        });
    });
</script>

</body>
</html>