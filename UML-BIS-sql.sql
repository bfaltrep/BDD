/* SQLEditor (MySQL (2))*/

CREATE TABLE Admin
(
IDAdmin VARCHAR(100) NOT NULL UNIQUE,
Adm_MotDePasse VARCHAR(100) NOT NULL,
PRIMARY KEY (IDAdmin)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Categorie
(
IDCategorie INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
Cat_Nom VARCHAR(100) NOT NULL,
PRIMARY KEY (IDCategorie)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE LivraisonFournisseur
(
IDLivraisonFournisseur INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
LF_DateDemande DATE NOT NULL,
LF_DateArrivee DATE NOT NULL,
IDEntreprise INTEGER NOT NULL,
LF_FraisDePort INTEGER NOT NULL,
LF_PrixTotalHT INTEGER,
PRIMARY KEY (IDLivraisonFournisseur)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Produit
(
IDProduit INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
IDCategorie INTEGER NOT NULL,
Pro_Nom VARCHAR(100) NOT NULL,
Pro_DateAjout DATE,
Pro_PrixUnitaireHTVente INTEGER,
Pro_DateDebutDisponibilite DATE,
Pro_DateFinDisponibilite DATE,
PRIMARY KEY (IDProduit,IDCategorie)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Production
(
IDEntreprise INTEGER NOT NULL,
IDProduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL,
PRIMARY KEY (IDEntreprise,IDProduit,IDCategorie)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ProduitParCommande
(
IDCommande INTEGER NOT NULL,
IDProduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL,
PPC_Quantite INTEGER,
PRIMARY KEY (IDCommande,IDProduit,IDCategorie)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ProduitParLivraison
(
IDLivraisonFournisseur INTEGER NOT NULL UNIQUE,
IDProduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL,
PPL_Quantite INTEGER,
PPL_PrixUnitaireHTAchat INTEGER,
PRIMARY KEY (IDLivraisonFournisseur, IDProduit, IDCategorie)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Remise
(
IDRemise INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
Rem_Type ENUM('pourcent','fixe'),
Rem_Valeur INTEGER,
Rem_ConditionNbCommande INTEGER,
Rem_ConditionDuree INTEGER,
Rem_ConditionDate Date,
PRIMARY KEY (IDRemise)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Commande
(
IDCommande INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
IDClient INTEGER NOT NULL,
Com_DateDemande DATE,
Com_DateLivraison DATE,
IDRemise INTEGER,
Com_Valide TINYINT,
Com_PrixHT INTEGER,
Com_FraisDePort INTEGER,
PRIMARY KEY (IDCommande)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Stock
(
IDLivraisonFournisseur INTEGER NOT NULL,
IDPoduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL,
Sto_Quantite INTEGER,
Sto_DatePeremption DATE,
PRIMARY KEY (IDLivraisonFournisseur,IDPoduit,IDCategorie)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Ville
(
NomVille VARCHAR(100) NOT NULL,
CodePostal VARCHAR(5) NOT NULL,
Vil_Livrable TINYINT NOT NULL,
PRIMARY KEY (NomVille,CodePostal)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
mysql> insert into Entreprise (Ent_Nom, Ent_Adresse, Ent_Ville, Ent_CodePostal, Ent_NomContact, Ent_Contact) values ('Dynabox', '6551 Aberg Trail', 'Pessac', 0, 'Richard Ward', '8-(548)457-0557');
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`bfaltrep/Entreprise`, CONSTRAINT `Entreprise_ibfk_1` FOREIGN KEY (`Ent_Ville`, `Ent_CodePostal`) REFERENCES `Ville` (`NomVille`, `CodePostal`))
CODE POSTAL A 0 donc pas 2000 entrées, mais on s'en tappe.

*/


CREATE TABLE Entreprise
(
IDEntreprise INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
Ent_Nom VARCHAR(100) NOT NULL,
Ent_Adresse VARmysqlCHAR(100) NOT NULL,
Ent_Ville VARCHAR(100) NOT NULL,
Ent_CodePostal VARCHAR(5) NOT NULL,
Ent_NomContact VARCHAR(100),
Ent_Contact VARCHAR(100),
PRIMARY KEY (IDEntreprise)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Client
(
IDClient INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
Cli_Nom VARCHAR(100) NOT NULL,
Cli_Prenom VARCHAR(100) NOT NULL,
Cli_Adresse VARCHAR(100) NOT NULL,
Cli_Ville VARCHAR(100) NOT NULL,
Cli_CodePostal VARCHAR(5) NOT NULL,
Cli_Telephone INTEGER,
Cli_Email VARCHAR(100) NOT NULL,
Cli_MotDePasse VARCHAR(100) NOT NULL,
Cli_DateInscription DATE NOT NULL,
Cli_NBCommande INTEGER NOT NULL,
PRIMARY KEY (IDClient)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE LivraisonFournisseur ADD FOREIGN KEY `IDEntreprise_LivraisonFournisseur_idxfk` (IDEntreprise) REFERENCES Entreprise (IDEntreprise); 
ALTER TABLE Produit ADD FOREIGN KEY `IDCategorie_Produit_idxfk` (IDCategorie) REFERENCES Categorie (IDCategorie);

ALTER TABLE Production ADD FOREIGN KEY `IDEntreprise_Production_idxfk` (IDEntreprise) REFERENCES Entreprise (IDEntreprise);
ALTER TABLE Production ADD FOREIGN KEY `IDProduit_Production_idxfk` (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE ProduitParCommande ADD FOREIGN KEY `IDCommande_ProduitParCommande_idxfk` (IDCommande) REFERENCES Commande (IDCommande);
ALTER TABLE ProduitParCommande ADD FOREIGN KEY `IDProduit_ProduitParCommande_idxfk` (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);
ALTER TABLE ProduitParLivraison ADD FOREIGN KEY `IDLivraisonFournisseur_ProduitParLivraison_idxfk` (IDLivraisonFournisseur) REFERENCES LivraisonFournisseur (IDLivraisonFournisseur);  
ALTER TABLE ProduitParLivraison ADD FOREIGN KEY `IDProduit_ProduitParLivraison_idxfk` (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);
ALTER TABLE Commande ADD FOREIGN KEY `IDClient_Commande_idxfk` (IDClient) REFERENCES Client (IDClient); 
ALTER TABLE Commande ADD FOREIGN KEY `IDRemise_Commande_idxfk` (IDRemise) REFERENCES Remise (IDRemise); 
ALTER TABLE Stock ADD FOREIGN KEY `IDLivraisonFournisseur_Stock_idxfk` (IDLivraisonFournisseur) REFERENCES LivraisonFournisseur (IDLivraisonFournisseur); 
ALTER TABLE Stock ADD FOREIGN KEY `IDPoduit_Stock_idxfk` (IDPoduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);
ALTER TABLE Entreprise ADD FOREIGN KEY `Ville_Entreprise_idxfk` (Ent_Ville,Ent_CodePostal) REFERENCES Ville (NomVille,CodePostal);
ALTER TABLE Client ADD FOREIGN KEY `Ville_Client_idxfk` (Cli_Ville,Cli_CodePostal) REFERENCES Ville (NomVille,CodePostal);


/*Commandes*/

/*
Produit périmés encore en stock pour les retirer de notre réserve.
*/

/*
SELECT IDLivraisonFournisseur, Pro_Nom
FROM Stock NATURAL JOIN Produit
WHERE DATE(Sto_DatePeremption) < CURDATE()
AND Sto_Quantite > 0;
*/

/*
je souhaite acheter de nouvelles tomates de barcelone. 
Je cherche quel producteurs va me fournir avec les prix les plus intéressant.
*/

/*
SELECT IDEntreprise, IDProduit, Ent_Nom, Ent_NomContact, Ent_Contact
FROM ProduitFournisseur NATURAL JOIN Entreprise NATURAL JOIN Produit
WHERE Pro_Nom = "quam pede lobortis ligula sit";

SELECT T1.Ent_nom, T1.Ent_NomContact, T1.Ent_Contact, LF_PrixTotalHT
FROM LivraisonFournisseur NATURAL JOIN ProduitParLivraison NATURAL JOIN (
	SELECT IDEntreprise, IDProduit, Ent_Nom, Ent_NomContact, Ent_Contact
	FROM ProduitFournisseur NATURAL JOIN Entreprise NATURAL JOIN Produit
	WHERE Pro_Nom = "quam pede lobortis ligula sit") AS T1
WHERE T1.IDProduit = IDProduit;
*/

/*
Combien d'avocat d'espagne ont été livrées durant l'interval d'une semaine donnée à aujourd'hui.
*/

/*
SELECT count(*)
FROM Commande NATURAL JOIN Produit
WHERE Pro_Nom = "avocat"
AND Com_DateLivraison BETWEEN "date donnée" AND CURDATE();
*/

/*
Requete du moteur de recherche sur le site. Mot recherché : "avocat".
*/

/*
SELECT *
FROM Produit
WHERE Pro_Nom = "avocat";
*/

/*
Récupérer les données modifiables par le client sur son compte.
*/

/*
SELECT Cli_Prenom, Cli_Nom, Cli_Adresse, Cli_Ville, Cli_CodePostal, Cli_Telephone, Cli_Email, Cli_MotDePasse
FROM Produit
WHERE IDClient = "idclient";
*/

/*
chercher la remise correspondante à une commande.
SELECT Rem_Type, Rem_Valeur
FROM Remise NATURAL JOIN Commande
WHERE IDCommande = "idcommande";
*/
