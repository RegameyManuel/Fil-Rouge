<?php
include "db/db.php";

    // Récupération du Nom :
    if (isset($_POST['nom']) && $_POST['nom'] != "") {
        $nom = $_POST['nom'];
    }
    else {
        $nom = Null;
    }

    // Récupération de l'URL (même traitement, avec une syntaxe abrégée)
    $id = (isset($_POST['id']) && $_POST['id'] != "") ? $_POST['id'] : Null;

    // En cas d'erreur, on renvoie vers le formulaire
    if ($nom == Null || $id == Null) {
        header("Location: rubrique_new.php");
        exit;
    }

    // S'il n'y a pas eu de redirection vers le formulaire (= si la vérification des données est ok) :
    require "db.php"; 
    $db = connexionBase();


try {
    // Construction de la requête INSERT sans injection SQL :
    $requete = $db->prepare("INSERT INTO rubrique (rubriq_nom, rubriq_id_1) VALUES (:nom, :id);");

    // Association des valeurs aux paramètres via bindValue() :
    $requete->bindValue(":id", $id, PDO::PARAM_STR);
    $requete->bindValue(":nom", $nom, PDO::PARAM_STR);

    // Lancement de la requête :
    $requete->execute();

    // Libération de la requête (utile pour lancer d'autres requêtes par la suite) :
    $requete->closeCursor();
}

// Gestion des erreurs
catch (Exception $e) {
    var_dump($requete->queryString);
    var_dump($requete->errorInfo());
    echo "Erreur : " . $requete->errorInfo()[2] . "<br>";
    die("Fin du script (script_rubrique_ajout.php)");
}

// Si OK: redirection vers la page artists.php
header("Location: rubrique.php");

// Fermeture du script
exit;
?>