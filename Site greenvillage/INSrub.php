<?php
include "db/db.php";
use PhpParser\Node\Expr\Cast\Object_;
?>

<?php
//function insertRubrique($nom, $id)
//{
    //if (isset($_POST["nom"]) && isset($_POST["rubrique"])) 
    //    $rubriq_id = findRubrique_id($_POST["rubrique"]); 

function insertRubrique($nom, $id)
{
    try {
        $db = connectionBase();
        // Construction de la requête INSERT sans injection SQL :
        $requete = $db->prepare("INSERT INTO services (rubriq_nom, rubriq_id_1) VALUES (:nom, :id );");

        // Association des valeurs aux paramètres via bindValue() :
        $requete->bindValue(":nom", $nom, PDO::PARAM_STR);
        $requete->bindValue(":id", $id, PDO::PARAM_STR);

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
        die("Fin du script d'ajout de rubrique");
    }
    $tableau = findRubrique();

    return $tableau;
}

?>
