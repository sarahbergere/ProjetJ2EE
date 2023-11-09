<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
<h1>Login</h1>

<form method="post" action="LoginServlet"> <!-- L'action doit pointer vers le servlet qui gère la requête POST -->
    <label for="param1">Nom d'utilisateur:</label>
    <input type="text" name="param1" id="param1" required><br><br>

    <label for="param2">Mot de passe:</label>
    <input type="password" name="param2" id="param2" required><br><br>

    <input type="submit" value="Se connecter">
</form>
</body>
</html>