/* SQLEditor (Generic SQL)*/

CREATE TABLE Categorie
(
IDCategorie INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
'Nom catégorie' CHAR NOT NULL,
PRIMARY KEY (IDCategorie)
);

CREATE TABLE Client
(
IDClient INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
Nom CHAR NOT NULL,
Prenom CHAR NOT NULL,
VIlle CHAR NOT NULL,
Adresse CHAR NOT NULL,
Telephone CHAR,
Email CHAR NOT NULL,
'Mot de passe' CHAR NOT NULL,
'Date dinscription' DATE NOT NULL,
NBCommande INTEGER NOT NULL,
PRIMARY KEY (IDClient)
);

CREATE TABLE Entreprise
(
IDEntreprise INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
'Nom Entreprise' CHAR NOT NULL,
Rue CHAR NOT NULL,
Ville CHAR NOT NULL,
IDProduit INTEGER,
IDCategorie INTEGER,
PRIMARY KEY (IDEntreprise)
);

CREATE TABLE Livraison
(
IDEntreprise INTEGER NOT NULL,
IDProduit INTEGER NOT NULL,
IDcategorie INTEGER NOT NULL,
Quantit INTEGER NOT NULL,
'Date livraison' DATE NOT NULL,
PRIMARY KEY (IDEntreprise,IDProduit,IDcategorie,'Date livraison')
);

CREATE TABLE Panier
(
IDPanier INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
IDProduit INTEGER,
IDCategorie INTEGER,
Quantit INTEGER,
PRIMARY KEY (IDPanier)
);

CREATE TABLE Production
(
IDProduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL,
IDEntreprise INTEGER NOT NULL,
'Mois de production' DATE NOT NULL,
'Lieu de production' CHAR NOT NULL,
PRIMARY KEY (IDProduit,IDCategorie,IDEntreprise)
);

CREATE TABLE Produit
(
IDProduit INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
IDCategorie INTEGER,
'Nom produit' CHAR NOT NULL,
Quantit INTEGER,
'Date dajout' DATE,
'Date de péremption' DATE,
'Prix unitaire' INTEGER,
PRIMARY KEY (IDProduit,IDCategorie)
);

CREATE TABLE Remise
(
IDRemise INTEGER NOT NULL UNIQUE,
'Type remise' CHAR NOT NULL,
Remise INTEGER,
'Condition nb commande' INTEGER NOT NULL,
PRIMARY KEY (IDRemise)
);

CREATE TABLE Commande
(
IDCommande INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
IDClient INTEGER,
IDRemise INTEGER,
'Date Commande' DATE NOT NULL,
'Prix HT' INTEGER NOT NULL,
'Prix TTC' INTEGER NOT NULL,
PRIMARY KEY (IDCommande)
);

ALTER TABLE Livraison ADD FOREIGN KEY (IDcategorie) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Panier ADD FOREIGN KEY (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Production ADD FOREIGN KEY (IDEntreprise) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Produit ADD FOREIGN KEY (IDCategorie) REFERENCES Categorie (IDCategorie);

ALTER TABLE Commande ADD FOREIGN KEY (IDRemise) REFERENCES Remise (IDRemise);
