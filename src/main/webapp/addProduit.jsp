<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajouter un Produit</title>
    <style>
        body {
            background: #ccc;
            font-family: Arial, sans-serif;
            place-items: center;
            height: 300px;
        }
        h2 {
            text-align: center;
        }
        .neumorphic-header {
            background-color: #f0f0f0; /* Couleur de fond */
            border-radius: 15px; /* Rayon des bords */
            box-shadow: 5px 5px 10px #bcbcbc, -5px -5px 10px #ffffff; /* Ombre neumorphique */
            padding: 15px; /* Espacement intérieur */
            margin-bottom: 20px; /* Marge inférieure */
            display: flex; /* Utilisation de flexbox pour aligner les éléments horizontalement */
            justify-content: space-between; /* Alignement des éléments sur l'espace disponible */
            align-items: center; /* Alignement vertical au centre */
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

        form {
            width: 250px;
            background: #ccc;
            border: none;
            box-shadow: 5px 5px 10px rgba(163, 177, 198, 0.5),
            -5px -5px 10px rgba(255, 255, 255, 0.6);
            padding: 20px;
            border-radius: 15px;
            display: flex;
            flex-direction: column;
            margin : 0 auto;
        }

        label {
            padding: 10px 5px;
        }

        form input[type="text"] {
            background: #ccc;
            padding: 10px;
            height: 30px;
            border: none;
            box-shadow: inset 5px 5px 10px rgba(163, 177, 198, 0.5),
            inset -5px -5px 12px rgba(255, 255, 255, 0.8);
            outline: none;
            border-radius: 10px;
        }
        form input[type="number"] {
            background: #ccc;
            padding: 10px;
            height: 30px;
            border: none;
            box-shadow: inset 5px 5px 10px rgba(163, 177, 198, 0.5),
            inset -5px -5px 12px rgba(255, 255, 255, 0.8);
            outline: none;
            border-radius: 10px;
        }

    </style>
</head>
<body>
<div class="neumorphic-header">
    <div>
        <button>Accueil</button>
        <button>Mon Compte</button>
    </div>
    <h1>Marketplace</h1>
    <div>
        <button>Contact</button>
        <button>Connexion</button>
    </div>
</div>
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

