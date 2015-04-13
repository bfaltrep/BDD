/* SQLEditor (MySQL (2))*/

CREATE TABLE Admin
(
IDAdmin VARCHAR(100) NOT NULL UNIQUE,
MotDePasse INTEGER NOT NULL,
PRIMARY KEY (IDAdmin)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Categorie
(
IDCategorie INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
NomCatégorie VARCHAR(100) NOT NULL,
PRIMARY KEY (IDCategorie)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Livraison
(
IDLivraison INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
DateLivraison DATE NOT NULL,
IDEntreprise INTEGER NOT NULL,
FraisDePort INTEGER NOT NULL,
PrixTotalHT INTEGER,
PRIMARY KEY (IDLivraison)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Produit
(
IDProduit INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
IDCategorie INTEGER NOT NULL,
NomProduit VARCHAR(100) NOT NULL,
DateAjout DATE,
PrixUnitaireHTVente INTEGER,
DateDebutDisponibilite DATE,
DateFinDisponibilite DATE,
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
Quantite INTEGER,
PRIMARY KEY (IDCommande,IDProduit,IDCategorie)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ProduitParLivraison
(
IDLivraison INTEGER NOT NULL UNIQUE,
IDProduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL,
Quantite INTEGER,
PrixUnitaireHTAchat INTEGER,
PRIMARY KEY (IDLivraison)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Remise
(
IDRemise INTEGER NOT NULL UNIQUE,
TypeRemise ENUM('pourcent','fixe'),
ValeurRemise INTEGER,
ConditionNbCommande INTEGER,
ConditionDuree INTEGER,
ConditionDate Date,
PRIMARY KEY (IDRemise)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Commande
(
IDCommande INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
idClient INTEGER NOT NULL,
DateCommande DATE,
IDRemise INTEGER,
Valide INTEGER,
PrixHT INTEGER,
FraisDePort INTEGER,
PRIMARY KEY (IDCommande)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Stock
(
IDLivraison INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
IDPoduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL UNIQUE,
Quantite INTEGER,
DatePeremption DATE,
PRIMARY KEY (IDLivraison,IDPoduit,IDCategorie)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Ville
(
CodePostal INTEGER NOT NULL,
NomVille VARCHAR(100) NOT NULL,
Livrable INTEGER NOT NULL,
PRIMARY KEY (CodePostal,NomVille)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Entreprise
(
IDEntreprise INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
NomEntreprise VARCHAR(100) NOT NULL,
Adresse VARCHAR(100) NOT NULL,
Ville VARCHAR(100) NOT NULL,
CodePostal INTEGER NOT NULL,
NomContact VARCHAR(100),
Contact VARCHAR(100),
PRIMARY KEY (IDEntreprise)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Client
(
IDClient INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
Nom VARCHAR(100) NOT NULL,
Prenom VARCHAR(100) NOT NULL,
Adresse VARCHAR(100) NOT NULL,
CodePostal INTEGER NOT NULL,
Ville VARCHAR(100) NOT NULL,
Telephone INTEGER,
Email VARCHAR(100) NOT NULL,
MotDePasse VARCHAR(100) NOT NULL,
DateInscription DATE NOT NULL,
NBCommande INTEGER NOT NULL,
PRIMARY KEY (IDClient)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*
ALTER TABLE Livraison ADD FOREIGN KEY IDEntreprise_idxfk (IDEntreprise) REFERENCES Entreprise (IDEntreprise);
ALTER TABLE Produit ADD FOREIGN KEY IDCategorie_idxfk (IDCategorie) REFERENCES Categorie (IDCategorie);
ALTER TABLE Production ADD FOREIGN KEY IDEntreprise_idxfk_1 (IDEntreprise) REFERENCES Entreprise (IDEntreprise);
ALTER TABLE Production ADD FOREIGN KEY IDProduit_idxfk (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);
ALTER TABLE ProduitParCommande ADD FOREIGN KEY IDCommande_idxfk (IDCommande) REFERENCES Commande (IDCommande);
ALTER TABLE ProduitParCommande ADD FOREIGN KEY IDProduit_idxfk_1 (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);
ALTER TABLE ProduitParLivraison ADD FOREIGN KEY IDLivraison_idxfk (IDLivraison) REFERENCES Livraison (IDLivraison);
ALTER TABLE ProduitParLivraison ADD FOREIGN KEY IDProduit_idxfk_2 (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);
ALTER TABLE Commande ADD FOREIGN KEY idClient_idxfk (idClient) REFERENCES Client (IDClient);
ALTER TABLE Commande ADD FOREIGN KEY IDRemise_idxfk (IDRemise) REFERENCES Remise (IDRemise);
ALTER TABLE Stock ADD FOREIGN KEY IDLivraison_idxfk_1 (IDLivraison) REFERENCES Livraison (IDLivraison);
ALTER TABLE Stock ADD FOREIGN KEY IDPoduit_idxfk (IDPoduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);
ALTER TABLE Entreprise ADD FOREIGN KEY CodePostal_idxfk (CodePostal,Ville) REFERENCES Ville (CodePostal,Ville);
ALTER TABLE Client ADD FOREIGN KEY Ville_idxfk (Ville,CodePostal) REFERENCES Ville (Ville,CodePostal);
*/

ALTER TABLE Livraison ADD CONSTRAINT IDEntreprise_idxfk FOREIGN KEY (IDEntreprise) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Produit ADD CONSTRAINT IDCategorie_idxfk FOREIGN KEY (IDCategorie) REFERENCES Categorie (IDCategorie);

ALTER TABLE Production ADD CONSTRAINT IDEntreprise_idxfk_1 FOREIGN KEY (IDEntreprise) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Production ADD CONSTRAINT IDProduit_idxfk FOREIGN KEY (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE ProduitParCommande ADD CONSTRAINT IDCommande_idxfk FOREIGN KEY (IDCommande) REFERENCES Commande (IDCommande);

ALTER TABLE ProduitParCommande ADD CONSTRAINT IDProduit_idxfk_1 FOREIGN KEY (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE ProduitParLivraison ADD CONSTRAINT IDLivraison_idxfk FOREIGN KEY (IDLivraison) REFERENCES Livraison (IDLivraison);

ALTER TABLE ProduitParLivraison ADD CONSTRAINT IDProduit_idxfk_2 FOREIGN KEY  (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Commande ADD CONSTRAINT idClient_idxfk FOREIGN KEY (idClient) REFERENCES Client (IDClient);

ALTER TABLE Commande ADD CONSTRAINT IDRemise_idxfk FOREIGN KEY (IDRemise) REFERENCES Remise (IDRemise);

ALTER TABLE Stock ADD CONSTRAINT IDLivraison_idxfk_1 FOREIGN KEY (IDLivraison) REFERENCES Livraison (IDLivraison);

ALTER TABLE Stock ADD CONSTRAINT IDPoduit_idxfk FOREIGN KEY (IDPoduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Entreprise ADD CONSTRAINT CodePostal_idxfk FOREIGN KEY (CodePostal,Ville) REFERENCES Ville (CodePostal,NomVille);

ALTER TABLE Client ADD CONSTRAINT Ville_idxfk FOREIGN KEY (CodePostal,Ville) REFERENCES Ville (CodePostal,NomVille);

/*Ajout contenu*/

INSERT INTO Client (Nom,Prenom,Adresse,CodePostal,Ville,Telephone,Email,MotDePasse,DateInscription,NBCommande) 
VALUES ('Craeyes','Nathalie',' 24 rue des hortensias',33600,'Pessac',0677777777,'nathalie.craeyes@chezmoi.com','monmotdepasse',2015-04-10,2),
VALUES ('Campbell','Troy','666 rue des bergers allemands',33000,'Lille',0688777777,'troy.campbell@chezmoi.com','monmotdepasse',2015-04-11,3),
VALUES ('Faltrept','Berenice','Appt 27, res des Lucioles, avenue Résistence',46100,'Figeac',0646125875,'berenice.f@chezmoi.com','tatayoyo',2014-11-14,20),
VALUES ('MORANT','Thibaut','4 rue des bruno',47000,'Agen', 064512378,'piloupilou@loupi.fr','loupiloupi',2014-01-25,70);

INSERT INTO Entreprise (NomEntreprise,Adresse,Ville,CodePostal,NomContact,Contact)
VALUES ('Le Rucher Fleuri','5 rue des marguerites','Eymet',33450,'Gerard Dumont',0610101010),
VALUES ('Christophe Heraut', 'Impasse toutes fleuries', 'Paquey', 24380, 'Christophe Heraut'),
VALUES ('Michael Bouyer', '19 chemin de planche', 24350, 'Mensignac', hetuyfylfxcv);

/*Commandes*/

/*
Produit périmés encore en stock pour les retirer de notre réserve.
*/
SELECT IDLivraison, NomProduit
FROM Stock NATURAL JOIN Produit
WHERE DATE(DatePeremption) < CURDATE()
AND Quantite > 0;

/*
je souhaite acheter de nouvelles tomates de barcelone. 
Je cherche quel producteurs va me fournir avec les prix les plus intéressant.
*/
SELECT IDEntreprise, IDProduit, NomEntreprise, NomContact, Contact
FROM Production NATURAL JOIN Entreprise NATURAL JOIN Produit
WHERE NomProduit = "tomates de barcelone";

SELECT T1.NomEntreprise, T1.NomContact, T1.Contact, PrixTotalHT
FROM Livraison NATURAL JOIN ProduitParLivraison NATURAL JOIN (
	SELECT IDEntreprise, IDProduit, NomEntreprise, NomContact, Contact
	FROM Production NATURAL JOIN Entreprise NATURAL JOIN Produit
	WHERE NomProduit = "tomates de barcelone") AS T1
WHERE T1.IDProduit == IDProduit;

/*
Combien d'avocat d'espagne ont été livrées durant les dernières 5 semaines.
*/



/*
Requete du moteur de recherche sur le site. Mot recherché : "avocat".
*/
SELECT * 
FROM Produit

/*
Récupérer les données modifiables par le client sur son compte.
*/

/*
chercher la remise correspondante à une livraison.
*/