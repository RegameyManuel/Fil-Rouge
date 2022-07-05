<?php
include "db/db.php";
$db = connectionBase();
$tabservice = findServices();
$tabrubrique = findRubrique();
include "partials/header.php";
?>
<div class="container">
    <p>Nous avons <span class="text-primary"><?= count($tabservice) ?></span> Services actifs : </p>
    <table class="table table-striped">
        <tr>
            <th>Services</th>
        </tr>

        <?php foreach ($tabservice as $service) : ?>

            <tr>
                <td class=""><?= $service->serv_nom ?></td>
                <td class=""> <a class="btn btn-dark btn-sm" href="detail.php?id=<?= $service->serv_id ?>&&name=<?= $service->serv_nom ?>"></a> </td>
            </tr>

        <?php endforeach; ?>

    </table>


    <br />
    <hr /><br />

    <p>Ajout d'une nouvelle rubrique</p>


    <label for="rubrique-select">Choisissez une rubrique mère:</label>

    <select name="rubrique" id="rubrique-select">
        <option value="">--racine--</option>
        <?php $id = 0 ?>
        <?php foreach ($tabrubrique as $rubrique) : ?>
            <option value="<?= $rubrique->rubriq_id ?>"><?= $rubrique->rubriq_nom ?></option>
        <?php endforeach; ?>
    </select>

    <br />
    <hr /><br />

    <form action="INSrub.php" method="post">

        <?php if (isset($_POST['rubrique'])) $choix = $_POST['rubrique']; ?>


        Nom : <input type="text" name="nom" size="20" maxlength="50" /> <br />
        Rubrique mère : <input type="text" name="rubrique" size="20" maxlength=50 />
        <input type="submit" value="ENVOYER" />
    </form>

    <br />
    <hr /><br />

    <form action='' method='post'>
        <div><br />
            <label>Nom de la nouvelle rubrique</label>
            <input type='text' name='nom de rubrique' />
        </div><br />
        <div>
            <label>Enregistrer</label>
            <input type='submit' value='' />
        </div>
    </form>


</div>
<?php include "partials/footer.php"; ?>