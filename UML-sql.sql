/* SQLEditor (Generic SQL)*/

CREATE TABLE Categorie
(
IDCategorie INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
'Nom catégorie' VARCHAR2 NOT NULL,
PRIMARY KEY (IDCategorie)
);

CREATE TABLE Client
(
IDClient INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
Nom VARCHAR2 NOT NULL,
Prenom VARCHAR2 NOT NULL,
VIlle VARCHAR2 NOT NULL,
Adresse VARCHAR2 NOT NULL,
Telephone VARCHAR2,
Email VARCHAR2 NOT NULL,
'Mot de passe' VARCHAR2 NOT NULL,
'Date dinscription' DATE NOT NULL,
NBCommande INTEGER NOT NULL,
PRIMARY KEY (IDClient)
);

CREATE TABLE Entreprise
(
IDEntreprise INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
'Nom Entreprise' VARCHAR2 NOT NULL,
Rue VARCHAR2 NOT NULL,
Ville VARCHAR2 NOT NULL,
IDProduit INTEGER,
IDCategorie INTEGER,
'Date livraison' DATE,
PRIMARY KEY (IDEntreprise)
);

CREATE TABLE Livraison
(
'Date livraison' DATE NOT NULL,
IDEntreprise INTEGER NOT NULL,
IDLivraison INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
Frais_de_port INTEGER,
PRIMARY KEY ('Date livraison',IDEntreprise)
);

CREATE TABLE Produit
(
IDProduit INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
IDCategorie INTEGER,
'Nom produit' VARCHAR2 NOT NULL,
Quantite INTEGER,
'Date dajout' DATE,
'Date de péremption' DATE,
'Prix unitaire HT' INTEGER,
'Prix unitaire TTC' INTEGER,
Date_debut_disponibilite CHAR,
Date-fin_disponibilite CHAR,
PRIMARY KEY (IDProduit,IDCategorie)
);

CREATE TABLE Production
(
IDEntreprise INTEGER NOT NULL,
IDProduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL,
IDCategorie_1 INTEGER,
PRIMARY KEY (IDEntreprise,IDProduit,IDCategorie)
);

CREATE TABLE Produit_par_commandes
(
IDCommande INTEGER,
IDProduit INTEGER,
IDCategorie INTEGER,
Quantite CHAR,
IDEntreprise INTEGER,
PRIMARY KEY (IDCommande,IDProduit,IDCategorie)
);

CREATE TABLE Produit_par_livraison
(
IDLivraison INTEGER NOT NULL UNIQUE,
IDProduit INTEGER,
IDCategorie INTEGER,
Quantite INTEGER,
PRIMARY KEY (IDLivraison)
);

CREATE TABLE Remise
(
IDRemise INTEGER NOT NULL UNIQUE,
Type_remise VARCHAR2 NOT NULL,
Remise INTEGER,
Condition_nb_commande INTEGER,
Condition_date_dinscription INTEGER,
PRIMARY KEY (IDRemise)
);

CREATE TABLE Stock
(
IDLivraison INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
IDPoduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL UNIQUE,
Quantite VARCHAR,
'Date de peremption' DATE,
PRIMARY KEY (IDLivraison,IDPoduit,IDCategorie)
);

CREATE TABLE Commande
(
IDCommande INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
idClient INTEGER,
'Date' DATE,
IDRemise INTEGER,
Valide INTEGER,
PRIX_HT INTEGER,
PRIX_TTC INTEGER,
'Frais de port' INTEGER,
PRIMARY KEY (IDCommande)
);

ALTER TABLE Livraison ADD FOREIGN KEY (IDEntreprise) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Produit ADD FOREIGN KEY (IDCategorie) REFERENCES Categorie (IDCategorie);

ALTER TABLE Production ADD FOREIGN KEY (IDEntreprise) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Production ADD FOREIGN KEY (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Produit_par_commandes ADD FOREIGN KEY (IDCommande) REFERENCES Commande (IDCommande);

ALTER TABLE Produit_par_commandes ADD FOREIGN KEY (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Produit_par_livraison ADD FOREIGN KEY (IDLivraison) REFERENCES Livraison (IDLivraison);

ALTER TABLE Produit_par_livraison ADD FOREIGN KEY (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Stock ADD FOREIGN KEY (IDLivraison) REFERENCES Livraison (IDLivraison);

ALTER TABLE Stock ADD FOREIGN KEY (IDPoduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Commande ADD FOREIGN KEY (idClient) REFERENCES Client (IDClient);

ALTER TABLE Commande ADD FOREIGN KEY (IDRemise) REFERENCES Remise (IDRemise);
