<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inscription</title>
    <link rel="stylesheet" type="text/css" href="style.CSS">
    <style>
        #titreInscription {
            text-align: center;
            padding-top: 20px;
            color: #333;
        }

        .register {
            width: 500px;
            border: none;
            background: #efefef;
            box-shadow: 5px 5px 10px rgba(163, 177, 198, 0.5),
            -5px -5px 10px rgba(255, 255, 255, 0.6);
            padding: 20px;
            border-radius: 15px;
            display: flex;
            flex-direction: column;
            margin: 0 auto;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        .register input[type="text"],
        .register input[type="password"],
        .register input[type="email"],
        .register input[type="tel"] {
            background: #efefef;
            padding: 10px;
            height: 30px;
            border: none;
            box-shadow: inset 5px 5px 10px rgba(163, 177, 198, 0.5),
            inset -5px -5px 12px rgba(255, 255, 255, 0.8);
            outline: none;
            border-radius: 10px;
        }

        .register input[type="submit"] {
            width: 50%;
            margin: 0 25%;
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

        .register input[type="submit"]:hover {
            background-color: #337ab7;
        }

        p {
            text-align: center;
            color: red;
        }

        a#connecte {
            color: #337ab7;
            text-decoration: none;
            position: relative;
            display: inline-block;
        }
        .column {
            float: left;
            width: 50%;
            padding: 10px;
        }

        .row {
            flex-direction: row;
            margin-bottom: 10px;
        }

        .email-column {
            margin-top: 40px;
        }
    </style>
</head>
<body>
<%@ include file="header.html" %>
<h1 id="titreInscription">Inscription</h1>
<form method="post" action="RegisterServlet" class="register">
    <p><%= request.getAttribute("message") %> </p>
    <div class="row">
        <div class="column">
            <label for="pseudo">Nom d'utilisateur:</label>
            <input type="text" name="pseudo" id="pseudo" required><br><br>

            <label for="nom">Nom:</label>
            <input type="text" name="nom" id="nom" required><br><br>

            <label for="prenom">Prenom:</label>
            <input type="text" name="prenom" id="prenom" required><br><br>

            <label for="adresse">Adresse:</label>
            <input type="text" name="adresse" id="adresse" required><br><br>
        </div>

        <div class="email-column">
            <label for="email">Email:</label>
            <input type="email" name="email" id="email" required><br><br>

            <label for="telephone">Telephone:</label>
            <input type="tel" name="telephone" id="telephone" required><br><br>

            <label for="password">Mot de passe:</label>
            <input type="password" name="password" id="password" required><br><br>
        </div>
    </div>
    <input type="submit" value="S'inscrire"><br><br>
    <a id="connecte" href="LoginServlet">Connectez-vous</a><br>
</form>
</body>
</html>