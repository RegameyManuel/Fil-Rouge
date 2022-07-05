<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>PDO - Ajout</title>
</head>
<body>

    <h1>Saisie d'une nouvelle rubrique</h1>

    <a href="rubrique.php"><button>Retour à la liste des rubriques</button></a>

    <br>
    <br>

    <form action ="script_rubrique_ajout.php" method="post">

        <label for="nom_for_label">Nom de la rubrique :</label><br>
        <input type="text" name="nom" id="nom_for_label">
        <br><br>

        <label for="id_for_label">Id de la rubrique mère :</label><br>
        <input type="text" name="id" id="id_for_label">
        <br><br>

        <input type="submit" value="Ajouter">

    </form>
</body>
</html>