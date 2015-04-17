/* SQLEditor (MySQL (2))*/

CREATE TABLE Admin
(
IDAdmin VARCHAR(100) NOT NULL UNIQUE,
Adm_MotDePasse INTEGER NOT NULL,
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
LF_Date DATE NOT NULL,
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
Com_Date DATE,
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
CodePostal INTEGER NOT NULL,
Vil_Livrable TINYINT NOT NULL,
PRIMARY KEY (NomVille,CodePostal)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Entreprise
(
IDEntreprise INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
Ent_Nom VARCHAR(100) NOT NULL,
Ent_Adresse VARCHAR(100) NOT NULL,
Ent_Ville VARCHAR(100) NOT NULL,
Ent_CodePostal INTEGER NOT NULL,
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
Cli_CodePostal INTEGER NOT NULL,
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

/*
ALTER TABLE LivraisonFournisseur ADD CONSTRAINT `IDEntreprise_LivraisonFournisseur_idxfk` FOREIGN KEY (IDEntreprise) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Produit ADD CONSTRAINT `IDCategorie_idxfk` FOREIGN KEY (IDCategorie) REFERENCES Categorie (IDCategorie);

ALTER TABLE Production ADD CONSTRAINT `IDEntreprise_Production_idxfk` FOREIGN KEY (IDEntreprise) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Production ADD CONSTRAINT `IDProduit_Production_idxfk` FOREIGN KEY (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE ProduitParCommande ADD CONSTRAINT `IDCommande_idxfk` FOREIGN KEY (IDCommande) REFERENCES Commande (IDCommande);

ALTER TABLE ProduitParCommande ADD CONSTRAINT `IDProduit_ProduitParCommande_idxfk` FOREIGN KEY (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE ProduitParLivraison ADD CONSTRAINT `IDLivraisonFournisseur_idxfk` FOREIGN KEY (IDLivraisonFournisseur) REFERENCES LivraisonFournisseur (IDLivraisonFournisseur);

ALTER TABLE ProduitParLivraison ADD CONSTRAINT `IDProduit_ProduitParLivraison_idxfk` FOREIGN KEY  (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Commande ADD CONSTRAINT `IdClient_idxfk` FOREIGN KEY (IdClient) REFERENCES Client (IDClient);

ALTER TABLE Commande ADD CONSTRAINT `IDRemise_idxfk` FOREIGN KEY (IDRemise) REFERENCES Remise (IDRemise);

ALTER TABLE Stock ADD CONSTRAINT `IDLivraisonFournisseur_Stock_idxfk` FOREIGN KEY (IDLivraisonFournisseur) REFERENCES LivraisonFournisseur (IDLivraisonFournisseur);

ALTER TABLE Stock ADD CONSTRAINT `IDPoduit_Stock_idxfk` FOREIGN KEY (IDPoduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Entreprise ADD CONSTRAINT `Ville_Entreprise_idxfk` FOREIGN KEY (CodePostal,Ville) REFERENCES Ville (CodePostal,NomVille);

ALTER TABLE Client ADD CONSTRAINT `Ville_idxfk` FOREIGN KEY (CodePostal,Ville) REFERENCES Ville (CodePostal,NomVille);
*/



/*Ajout contenu*/







/*
INSERT INTO Client (Nom,Prenom,Adresse,CodePostal,Ville,Telephone,Email,MotDePasse,DateInscription,NBCommande) 
VALUES ('Craeyes','Nathalie',' 24 rue des hortensias',33600,'Pessac',0677777777,'nathalie.craeyes@chezmoi.com','monmotdepasse',2015-04-10,2),
VALUES ('Campbell','Troy','666 rue des bergers allemands',33000,'Lille',0688777777,'troy.campbell@chezmoi.com','monmotdepasse',2015-04-11,3),
VALUES ('Faltrept','Berenice','Appt 27, res des Lucioles, avenue Résistence',46100,'Figeac',0646125875,'berenice.f@chezmoi.com','tatayoyo',2014-11-14,20),
VALUES ('MORANT','Thibaut','4 rue des bruno',47000,'Agen', 064512378,'piloupilou@loupi.fr','loupiloupi',2014-01-25,70);

INSERT INTO Entreprise (NomEntreprise,Adresse,Ville,CodePostal,NomContact,Contact)
VALUES ('Le Rucher Fleuri','5 rue des marguerites','Eymet',33450,'Gerard Dumont',0610101010),
VALUES ('Christophe Heraut', 'Impasse toutes fleuries', 'Paquey', 24380, 'Christophe Heraut'),
VALUES ('Michael Bouyer', '19 chemin de planche', 24350, 'Mensignac', hetuyfylfxcv);
*/





/*Commandes*/

/*
Produit périmés encore en stock pour les retirer de notre réserve.
*/
/*
SELECT IDLivraisonFournisseur, NomProduit
FROM Stock NATURAL JOIN Produit
WHERE DATE(DatePeremption) < CURDATE()
AND Quantite > 0;
*/
/*
je souhaite acheter de nouvelles tomates de barcelone. 
Je cherche quel producteurs va me fournir avec les prix les plus intéressant.
*/
/*
SELECT IDEntreprise, IDProduit, NomEntreprise, NomContact, Contact
FROM Production NATURAL JOIN Entreprise NATURAL JOIN Produit
WHERE NomProduit = "tomates de barcelone";

SELECT T1.NomEntreprise, T1.NomContact, T1.Contact, PrixTotalHT
FROM LivraisonFournisseur NATURAL JOIN ProduitParLivraison NATURAL JOIN (
	SELECT IDEntreprise, IDProduit, NomEntreprise, NomContact, Contact
	FROM Production NATURAL JOIN Entreprise NATURAL JOIN Produit
	WHERE NomProduit = "tomates de barcelone") AS T1
WHERE T1.IDProduit == IDProduit;
*/
/*
Combien d'avocat d'espagne ont été livrées durant les dernières 5 semaines.
*/



/*
Requete du moteur de recherche sur le site. Mot recherché : "avocat".
*/
/*
SELECT * 
FROM Produit
*/
/*
Récupérer les données modifiables par le client sur son compte.
*/

/*
chercher la remise correspondante à une livraison.
*/
