<?php

use PhpParser\Node\Expr\Cast\Object_;

//define( 'URL' , 'mysql:host=database:3306;dbname=greenvillage;charset=utf8');
define('URL', 'mysql:host=localhost;dbname=greenvillage;charset=utf8');
define('USER', 'Man');
define('PASS', 'Zatoichi*1670');

/**
 * fonction de connexion
 *
 * @return PDO
 */
function connectionBase() : PDO
{
    try 
    {
        $option =
        [
            PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
        ];
        $connection = new PDO(URL, USER, PASS, $option);
        return $connection;
    } 
    catch (Exception $e) 
    {
        echo 'Erreur : ' . $e->getMessage() . '<br />';
        echo 'N° : ' . $e->getCode();
        die('Fin du script');
    }
}

function findServices()
{
    try 
    {
        $db = connectionBase();
        $sql = 'SELECT * FROM services';
        $requete = $db->query($sql);
        // on récupère tous les résultats trouvés dans une variable
        $tableau = $requete->fetchAll(PDO::FETCH_OBJ);
        // on clôt la requête en BDD
        $requete->closeCursor();
    } 
    catch (Exception $e) 
    {
        echo 'Erreur : ' . $e->getMessage() . '<br />';
        echo 'N° : ' . $e->getCode();
        die('Fin du script');
    }
    return $tableau;
}

function insertService($nom, $telephone, $mail)
{
    try 
    {
        $db = connectionBase();
        // Construction de la requête INSERT sans injection SQL :
        $sql = "INSERT INTO services (serv_nom, serv_telephone, serv_mail) VALUES (:nom, :telephone, :mail );";
        $requete = $db->query($sql);

        // Association des valeurs aux paramètres via bindValue() :
        $requete->bindValue(":nom", $nom, PDO::PARAM_STR);
        $requete->bindValue(":telephone", $telephone, PDO::PARAM_STR);
        $requete->bindValue(":mail", $mail, PDO::PARAM_STR);

        // Lancement de la requête :
        $requete->execute();

        // Libération de la requête (utile pour lancer d'autres requêtes par la suite) :
        $requete->closeCursor();
    }


    catch (Exception $e) 
    {
        echo 'Erreur : ' . $e->getMessage() . '<br />';
        echo 'N° : ' . $e->getCode();
        die('Fin du script');
    }
    $tableau = findServices();

    return $tableau;
}





function findRubrique()
{
    try 
    {
        $db = connectionBase();
        $sql = "SELECT * FROM rubrique";
        $requete = $db->query($sql);
        // on récupère tous les résultats trouvés dans une variable
        $tableau = $requete->fetchAll(PDO::FETCH_OBJ);
        // on clôt la requête en BDD
        $requete->closeCursor();
    } 
    catch (Exception $e) 
    {
        echo 'Erreur : ' . $e->getMessage() . '<br />';
        echo 'N° : ' . $e->getCode();
        die('Fin du script');
    }
    return $tableau;
}

?>