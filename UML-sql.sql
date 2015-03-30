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
PRIMARY KEY (IDEntreprise)
);

CREATE TABLE Livraison
(
'Date livraison' DATE NOT NULL,
IDEntreprise INTEGER NOT NULL,
IDProduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL,
IDLivraison INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
Quantite UNSIGNED-INTEGER NOT NULL,
PRIMARY KEY ('Date livraison',IDEntreprise,IDProduit,IDCategorie)
);

CREATE TABLE Production
(
IDProduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL,
IDEntreprise INTEGER NOT NULL,
'Mois de production' DATE NOT NULL,
'Lieu de production' VARCHAR2 NOT NULL,
PRIMARY KEY (IDProduit,IDCategorie,IDEntreprise)
);

CREATE TABLE Produit
(
IDProduit INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
IDCategorie INTEGER,
'Nom produit' VARCHAR2 NOT NULL,
Quantite INTEGER,
'Date dajout' DATE,
'Date de péremption' DATE,
'Prix unitaire' INTEGER,
PRIMARY KEY (IDProduit,IDCategorie)
);

CREATE TABLE detail_commandes
(
idCommande INTEGER,
IDProduit INTEGER,
IDCategorie INTEGER,
Prix_HT INTEGER,
Prix_TTC INTEGER,
Quantite CHAR,
IDEntreprise INTEGER,
PRIMARY KEY (idCommande,IDProduit,IDCategorie)
);

CREATE TABLE Panier
(
IDPanier INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
IDProduit INTEGER,
IDCategorie INTEGER,
Quantite INTEGER,
PRIMARY KEY (IDPanier)
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
Quantite VARCHAR2,
'Date de peremption' DATE,
IDProduit INTEGER,
PRIMARY KEY (IDLivraison,IDPoduit,IDCategorie)
);

CREATE TABLE Commande
(
idCommande INTEGER NOT NULL AUTO_INCREMENT  UNIQUE,
idClient INTEGER,
'Date' DATE,
IDRemise INTEGER,
Valide INTEGER,
PRIX_HT INTEGER,
PRIX_TTC INTEGER,
PRIMARY KEY (id_commande)
);

ALTER TABLE Livraison ADD FOREIGN KEY (IDCategorie) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Production ADD FOREIGN KEY (IDEntreprise) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Produit ADD FOREIGN KEY (IDCategorie) REFERENCES Categorie (IDCategorie);

ALTER TABLE detail_commandes ADD FOREIGN KEY (idCommande) REFERENCES Commande (idCommande);

ALTER TABLE detail_commandes ADD FOREIGN KEY (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Panier ADD FOREIGN KEY (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Stock ADD FOREIGN KEY (IDLivraison) REFERENCES Livraison (IDLivraison);

ALTER TABLE Stock ADD FOREIGN KEY (IDPoduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Commande ADD FOREIGN KEY (idClient) REFERENCES Client (IDClient);

ALTER TABLE Commande ADD FOREIGN KEY (IDRemise) REFERENCES Remise (IDRemise);
