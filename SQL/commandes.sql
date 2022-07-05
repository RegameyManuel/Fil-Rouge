----------------------------------------SERVICE

INSERT INTO services(
   serv_nom,
   serv_telephone,
   serv_mail)
   
   VALUES 
   ( 'Après-Vente', '0100000001', 'AV@GV.com' ),
   ( 'Commercial', '0100000002', 'Commercial@GV.com' ),
   ( 'Comptabilité', '0100000003', 'Compta@GV.com' );

----------------------------------------RUBRIQUE


INSERT INTO rubrique(
   rubriq_nom,
   rubriq_id_1)
   
   VALUES
   
   
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

   
   


--------------------------------------------------------------------------------------------


INSERT INTO rubrique(
   rubriq_nom,
   rubriq_id_1)
   
   VALUES
   
   ('sous-rubrique', 
   (SELECT rubriq_id FROM rubrique WHERE rubriq_nom = 'rubrique'));


CREATE TABLE rubrique(
   rubriq_id INT AUTO_INCREMENT NOT NULL,
   rubriq_nom VARCHAR(50),
   rubriq_id_1 INT,
   PRIMARY KEY(rubriq_id),
   FOREIGN KEY(rubriq_id_1) REFERENCES rubrique(rubriq_id)
);

INSERT INTO rubrique(rubriq_nom) VALUES ('GreenVillage');

INSERT INTO rubrique( rubriq_nom, rubriq_id_1) INNER JOIN rubrique AS rub VALUES ('Instruments', (SELECT rubriq_id FROM rub WHERE rubriq_nom = 'GreenVillage'));


--------------------------------------------------------------------------------------------

INSERT INTO client(
   cli_societe,
   cli_nom,
   cli_prenom ,
   cli_telephone,
   cli_mail,
   cli_siret,
   cli_reference,
   cli_coefficient,
   cli_reduction,
   cli_com_id)

VALUES ('REEVES','HUBERT','A000000', 'RHA000000', 1.5, 0.1, 1);



 
INSERT INTO user (nom,prenom)values('martin','serge');
-- La ligne précédente comporte la valeur de user.id s'il s'agit d'un incrément automatique
INSERT INTO News(exp,dest,msg, id_user) 
  SELECT 'txt_exp','txtdes','txt_msg', id_user 
  FROM user
  WHERE nom = 'martin'
      AND prenom = 'serge'
