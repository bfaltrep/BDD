/* SQLEditor (MySQL (2))*/

CREATE TABLE Categorie
(
IDCategorie INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
`Nom catégorie` VARCHAR2 NOT NULL,
PRIMARY KEY (IDCategorie)
);

CREATE TABLE Livraison
(
IDLivraison INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
`Date livraison` DATE NOT NULL,
IDEntreprise INTEGER NOT NULL,
Frais_de_port INTEGER,
`Prix TOTAL HT` INTEGER,
PRIMARY KEY (IDLivraison)
);

CREATE TABLE Produit
(
IDProduit INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
IDCategorie INTEGER,
`Nom produit` VARCHAR2 NOT NULL,
`Date Ajout` DATE,
`Prix unitaire HT VENTE` INTEGER,
Date_debut_disponibilite DATE,
Date-fin_disponibilite DATE,
PRIMARY KEY (IDProduit,IDCategorie)
);

CREATE TABLE Production
(
IDEntreprise INTEGER NOT NULL,
IDProduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL,
PRIMARY KEY (IDEntreprise,IDProduit,IDCategorie)
);

CREATE TABLE Produit_par_commandes
(
IDCommande INTEGER,
IDProduit INTEGER,
IDCategorie INTEGER,
Quantite INTEGER,
PRIMARY KEY (IDCommande,IDProduit,IDCategorie)
);

CREATE TABLE Produit_par_livraison
(
IDLivraison INTEGER NOT NULL UNIQUE,
IDProduit INTEGER,
IDCategorie INTEGER,
Quantite INTEGER,
`Prix unitaire HT ACHAT` INTEGER,
PRIMARY KEY (IDLivraison)
);

CREATE TABLE Remise
(
IDRemise INTEGER NOT NULL UNIQUE,
Type_remise VARCHAR2 NOT NULL,
Remise INTEGER,
Condition_nb_commande INTEGER,
Condition_date INTEGER,
PRIMARY KEY (IDRemise)
);

CREATE TABLE Commande
(
IDCommande INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
idClient INTEGER,
Date DATE,
IDRemise INTEGER,
Valide INTEGER,
PRIX_HT INTEGER,
`Frais de port` INTEGER,
PRIMARY KEY (IDCommande)
);

CREATE TABLE Stock
(
IDLivraison INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
IDPoduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL UNIQUE,
Quantite INTEGER,
`Date de peremption` DATE,
PRIMARY KEY (IDLivraison,IDPoduit,IDCategorie)
);

CREATE TABLE Ville
(
`Code Postal` INTEGER NOT NULL,
Ville CHAR NOT NULL,
Livrable CHAR,
PRIMARY KEY (`Code Postal`,Ville)
);

CREATE TABLE Entreprise
(
IDEntreprise INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
`Nom Entreprise` VARCHAR2 NOT NULL,
Rue VARCHAR2 NOT NULL,
Ville CHAR NOT NULL,
`Code Postal` INTEGER NOT NULL,
PRIMARY KEY (IDEntreprise)
);

CREATE TABLE Client
(
IDClient INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
Nom VARCHAR2 NOT NULL,
Prenom VARCHAR2 NOT NULL,
Rue VARCHAR2 NOT NULL,
`Code Postal` INTEGER NOT NULL,
Ville CHAR,
Telephone VARCHAR2,
Email VARCHAR2 NOT NULL,
`Mot de passe` VARCHAR2 NOT NULL,
`Date Inscription` DATE NOT NULL,
NBCommande INTEGER NOT NULL,
PRIMARY KEY (IDClient)
);

ALTER TABLE Livraison ADD FOREIGN KEY IDEntreprise_idxfk (IDEntreprise) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Produit ADD FOREIGN KEY IDCategorie_idxfk (IDCategorie) REFERENCES Categorie (IDCategorie);

ALTER TABLE Production ADD FOREIGN KEY IDEntreprise_idxfk_1 (IDEntreprise) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Production ADD FOREIGN KEY IDProduit_idxfk (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Produit_par_commandes ADD FOREIGN KEY IDCommande_idxfk (IDCommande) REFERENCES Commande (IDCommande);

ALTER TABLE Produit_par_commandes ADD FOREIGN KEY IDProduit_idxfk_1 (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Produit_par_livraison ADD FOREIGN KEY IDLivraison_idxfk (IDLivraison) REFERENCES Livraison (IDLivraison);

ALTER TABLE Produit_par_livraison ADD FOREIGN KEY IDProduit_idxfk_2 (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Commande ADD FOREIGN KEY idClient_idxfk (idClient) REFERENCES Client (IDClient);

ALTER TABLE Commande ADD FOREIGN KEY IDRemise_idxfk (IDRemise) REFERENCES Remise (IDRemise);

ALTER TABLE Stock ADD FOREIGN KEY IDLivraison_idxfk_1 (IDLivraison) REFERENCES Livraison (IDLivraison);

ALTER TABLE Stock ADD FOREIGN KEY IDPoduit_idxfk (IDPoduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Entreprise ADD FOREIGN KEY Code Postal_idxfk (`Code Postal`,Ville) REFERENCES Ville (`Code Postal`,Ville);

ALTER TABLE Client ADD FOREIGN KEY Ville_idxfk (Ville,`Code Postal`) REFERENCES Ville (Ville,`Code Postal`);
