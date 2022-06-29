DROP DATABASE IF EXISTS greenvillage;

CREATE DATABASE greenvillage character set utf8mb4 collate utf8mb4_general_ci;

USE greenvillage;

CREATE TABLE service(
   serv_id INT AUTO_INCREMENT,
   serv_nom VARCHAR(50) ,
   serv_telephone VARCHAR(20) ,
   serv_mail VARCHAR(50) ,
   PRIMARY KEY(serv_id)
);

CREATE TABLE rubrique(
   rubriq_id INT AUTO_INCREMENT,
   rubriq_nom VARCHAR(50) ,
   rubriq_id_1 INT NOT NULL,
   PRIMARY KEY(rubriq_id),
   FOREIGN KEY(rubriq_id_1) REFERENCES rubrique(rubriq_id)
);

CREATE TABLE adresse(
   adr_id INT AUTO_INCREMENT,
   adr_adresse VARCHAR(200) ,
   adr_cp VARCHAR(5) ,
   adr_ville VARCHAR(50) ,
   adr_region VARCHAR(50) ,
   adr_pays VARCHAR(50) ,
   PRIMARY KEY(adr_id)
);

CREATE TABLE fournisseur(
   fourni_id INT AUTO_INCREMENT,
   fourni_nom VARCHAR(50) ,
   fourni_telephone VARCHAR(20) ,
   fourni_mail VARCHAR(50) ,
   fourni_constructeur BOOLEAN,
   fourni_importateur BOOLEAN,
   serv_id INT NOT NULL,
   PRIMARY KEY(fourni_id),
   FOREIGN KEY(serv_id) REFERENCES service(serv_id)
);

CREATE TABLE commercial(
   com_id INT AUTO_INCREMENT,
   com_nom VARCHAR(50) ,
   com_telephone VARCHAR(20) ,
   com_mail VARCHAR(50) ,
   com_particulier BOOLEAN,
   serv_id INT,
   PRIMARY KEY(com_id),
   FOREIGN KEY(serv_id) REFERENCES service(serv_id)
);

CREATE TABLE produit(
   prod_id INT AUTO_INCREMENT,
   prod_lib_court VARCHAR(50)  NOT NULL,
   prod_lib_long VARCHAR(255) ,
   prod_prix DECIMAL(7,2)  ,
   prod_photo VARCHAR(255) ,
   rubriq_id INT NOT NULL,
   fourni_id INT NOT NULL,
   PRIMARY KEY(prod_id),
   FOREIGN KEY(rubriq_id) REFERENCES rubrique(rubriq_id),
   FOREIGN KEY(fourni_id) REFERENCES fournisseur(fourni_id)
);

CREATE TABLE client(
   cli_id INT AUTO_INCREMENT,
   cli_nom VARCHAR(50) ,
   cli_siret VARCHAR(50) ,
   cli_reference VARCHAR(50) ,
   cli_coefficient FLOAT,
   cli_reduction FLOAT,
   com_id INT NOT NULL,
   PRIMARY KEY(cli_id),
   FOREIGN KEY(com_id) REFERENCES commercial(com_id)
);

CREATE TABLE commande(
   commande_id INT AUTO_INCREMENT,
   commande_dt_paiement DATE,
   commande_dt_expedition DATE,
   commande_virement BOOLEAN,
   commande_cheque BOOLEAN,
   commande_valide BOOLEAN,
   commande_archive BOOLEAN,
   cli_id INT NOT NULL,
   PRIMARY KEY(commande_id),
   FOREIGN KEY(cli_id) REFERENCES client(cli_id)
);

CREATE TABLE bl(
   bl_id INT AUTO_INCREMENT,
   bl_date DATE,
   commande_id INT NOT NULL,
   PRIMARY KEY(bl_id),
   FOREIGN KEY(commande_id) REFERENCES commande(commande_id)
);

CREATE TABLE facture(
   fact_id INT AUTO_INCREMENT,
   fact_dt DATE,
   fact_sauvegarde VARCHAR(255) ,
   commande_id INT NOT NULL,
   PRIMARY KEY(fact_id),
   FOREIGN KEY(commande_id) REFERENCES commande(commande_id)
);

CREATE TABLE administre(
   prod_id INT,
   serv_id INT,
   rubriq_id INT,
   admin_droit BOOLEAN,
   PRIMARY KEY(prod_id, serv_id, rubriq_id),
   FOREIGN KEY(prod_id) REFERENCES produit(prod_id),
   FOREIGN KEY(serv_id) REFERENCES service(serv_id),
   FOREIGN KEY(rubriq_id) REFERENCES rubrique(rubriq_id)
);

CREATE TABLE detail_commande(
   prod_id INT,
   commande_id INT,
   detail_qte INT NOT NULL,
   detail_prix DECIMAL(7,2)  ,
   detail_qte_livree INT,
   PRIMARY KEY(prod_id, commande_id),
   FOREIGN KEY(prod_id) REFERENCES produit(prod_id),
   FOREIGN KEY(commande_id) REFERENCES commande(commande_id)
);

CREATE TABLE localise(
   fourni_id INT,
   cli_id INT,
   adr_id INT,
   loc_adr_facturation BOOLEAN,
   loc_adr_livraison BOOLEAN,
   PRIMARY KEY(fourni_id, cli_id, adr_id),
   FOREIGN KEY(fourni_id) REFERENCES fournisseur(fourni_id),
   FOREIGN KEY(cli_id) REFERENCES client(cli_id),
   FOREIGN KEY(adr_id) REFERENCES adresse(adr_id)
);
