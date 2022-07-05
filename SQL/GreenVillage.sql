DROP DATABASE IF EXISTS greenvillage;

CREATE DATABASE greenvillage character set utf8mb4 collate utf8mb4_general_ci;

USE greenvillage;

CREATE TABLE services(
   serv_id INT AUTO_INCREMENT NOT NULL,
   serv_nom VARCHAR(50),
   serv_telephone VARCHAR(20),
   serv_mail VARCHAR(50),
   PRIMARY KEY(serv_id)
);

CREATE TABLE rubrique(
   rubriq_id INT AUTO_INCREMENT NOT NULL,
   rubriq_nom VARCHAR(50),
   rubriq_id_1 INT,
   PRIMARY KEY(rubriq_id),
   FOREIGN KEY(rubriq_id_1) REFERENCES rubrique(rubriq_id)
);

CREATE TABLE adresse(
   adr_id INT AUTO_INCREMENT NOT NULL,
   adr_adresse VARCHAR(200),
   adr_cp VARCHAR(5),
   adr_ville VARCHAR(50),
   adr_region VARCHAR(50),
   adr_pays VARCHAR(50),
   PRIMARY KEY(adr_id)
);

CREATE TABLE fournisseur(
   fourni_id INT AUTO_INCREMENT NOT NULL,
   fourni_nom VARCHAR(50),
   fourni_prenom VARCHAR(50),
   fourni_societe VARCHAR(50),
   fourni_telephone VARCHAR(20),
   fourni_mail VARCHAR(50),
   fourni_constructeur BOOLEAN,
   fourni_importateur BOOLEAN,
   fourni_serv_id INT NOT NULL,
   PRIMARY KEY(fourni_id),
   FOREIGN KEY(fourni_serv_id) REFERENCES services(serv_id)
);

CREATE TABLE commercial(
   com_id INT AUTO_INCREMENT NOT NULL,
   com_nom VARCHAR(50),
   com_prenom VARCHAR(50),
   com_telephone VARCHAR(20),
   com_mail VARCHAR(50),
   com_particulier BOOLEAN,
   com_serv_id INT NOT NULL,
   PRIMARY KEY(com_id),
   FOREIGN KEY(com_serv_id) REFERENCES services(serv_id)
);

CREATE TABLE produit(
   prod_id INT AUTO_INCREMENT NOT NULL,
   prod_marque VARCHAR(50),
   prod_modele VARCHAR(50),
   prod_finition VARCHAR(50),
   prod_lib_court VARCHAR(50)  NOT NULL,
   prod_lib_long VARCHAR(255),
   prod_prix DECIMAL(7,2) ,
   prod_photo VARCHAR(255),
   prod_rubriq_id INT NOT NULL,
   prod_fourni_id INT NOT NULL,
   PRIMARY KEY(prod_id),
   FOREIGN KEY(prod_rubriq_id) REFERENCES rubrique(rubriq_id),
   FOREIGN KEY(prod_fourni_id) REFERENCES fournisseur(fourni_id)
);

CREATE TABLE client(
   cli_id INT AUTO_INCREMENT NOT NULL,
   cli_societe VARCHAR(50),
   cli_nom VARCHAR(50),
   cli_prenom VARCHAR(50),
   cli_telephone VARCHAR(20),
   cli_mail VARCHAR(50),
   cli_siret VARCHAR(50),
   cli_reference VARCHAR(50),
   cli_coefficient FLOAT,
   cli_reduction FLOAT,
   cli_com_id INT NOT NULL,
   PRIMARY KEY(cli_id),
   FOREIGN KEY(cli_com_id) REFERENCES commercial(com_id)
);

CREATE TABLE commande(
   commande_id INT AUTO_INCREMENT NOT NULL,
   commande_dt_paiement DATE,
   commande_dt_expedition DATE,
   commande_virement BOOLEAN,
   commande_cheque BOOLEAN,
   commande_valide BOOLEAN NOT NULL DEFAULT FALSE,
   commande_archive BOOLEAN,
   commande_cli_id INT NOT NULL,
   PRIMARY KEY(commande_id),
   FOREIGN KEY(commande_cli_id) REFERENCES client(cli_id)
);

CREATE TABLE bl(
   bl_id INT AUTO_INCREMENT NOT NULL,
   bl_date DATE,
   bl_commande_id INT NOT NULL,
   PRIMARY KEY(bl_id),
   FOREIGN KEY(bl_commande_id) REFERENCES commande(commande_id)
);

CREATE TABLE facture(
   fact_id INT AUTO_INCREMENT NOT NULL,
   fact_dt DATE,
   fact_sauvegarde VARCHAR(255),
   fact_commande_id INT NOT NULL,
   PRIMARY KEY(fact_id),
   FOREIGN KEY(fact_commande_id) REFERENCES commande(commande_id)
);

CREATE TABLE administre(
   admin_prod_id INT,
   admin_serv_id INT NOT NULL,
   admin_rubriq_id INT,
   admin_droit BOOLEAN,
   PRIMARY KEY(admin_prod_id, admin_serv_id, admin_rubriq_id),
   FOREIGN KEY(admin_prod_id) REFERENCES produit(prod_id),
   FOREIGN KEY(admin_serv_id) REFERENCES services(serv_id),
   FOREIGN KEY(admin_rubriq_id) REFERENCES rubrique(rubriq_id)
);

CREATE TABLE detail_commande(
   detail_prod_id INT NOT NULL,
   detail_commande_id INT NOT NULL,
   detail_qte INT NOT NULL,
   detail_prix DECIMAL(7,2),
   detail_qte_livree INT,
   PRIMARY KEY(detail_prod_id, detail_commande_id),
   FOREIGN KEY(detail_prod_id) REFERENCES produit(prod_id),
   FOREIGN KEY(detail_commande_id) REFERENCES commande(commande_id)
);

CREATE TABLE localise(
   loc_id INT AUTO_INCREMENT NOT NULL,
   loc_fourni_id INT,
   loc_cli_id INT,
   loc_adr_id INT,
   loc_adr_facturation BOOLEAN NOT NULL DEFAULT FALSE,
   loc_adr_livraison BOOLEAN NOT NULL DEFAULT FALSE,
   PRIMARY KEY(loc_id, loc_fourni_id, loc_cli_id, loc_adr_id),
   FOREIGN KEY(loc_fourni_id) REFERENCES fournisseur(fourni_id),
   FOREIGN KEY(loc_cli_id) REFERENCES client(cli_id),
   FOREIGN KEY(loc_adr_id) REFERENCES adresse(adr_id)
);

-----------------------------------------------------------------------------

INSERT INTO services( serv_nom, serv_telephone, serv_mail) VALUES 

( 'Après-Vente', '0100000001', 'AV@GV.com' ),
( 'Commercial', '0100000002', 'Commercial@GV.com' ),
( 'Comptabilité', '0100000003', 'Compta@GV.com' );

-----------------------------------------------------------------------------

INSERT INTO rubrique(rubriq_nom) VALUES 

('GreenVillage');

INSERT INTO rubrique( rubriq_nom, rubriq_id_1) VALUES
   
('Guitares-Basses','1'),
('Amplis-Effets','1'),
('Batteries-Percussions','1'),
('Claviers-Pianos','1'),
('Synthés','1'),
('Home Studio','1'),
('Sonorisation','1'),
('Librairie','1'),
('Vents','1'),
('Quatuor','1');


