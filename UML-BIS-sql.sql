/* SQLEditor (MySQL (2))*/

CREATE TABLE Admin
(
IDAdmin VARCHAR(255) NOT NULL UNIQUE,
MotDePasse INTEGER NOT NULL,
PRIMARY KEY (IDAdmin)
);

CREATE TABLE Categorie
(
IDCategorie INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
NomCatégorie VARCHAR2 NOT NULL,
PRIMARY KEY (IDCategorie)
);

CREATE TABLE Livraison
(
IDLivraison INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
DateLivraison DATE NOT NULL,
IDEntreprise INTEGER NOT NULL,
FraisDePort INTEGER NOT NULL,
PrixTotalHT INTEGER,
PRIMARY KEY (IDLivraison)
);

CREATE TABLE Produit
(
IDProduit INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
IDCategorie INTEGER,
NomProduit VARCHAR2 NOT NULL,
DateAjout DATE,
PrixUnitaireHTVente INTEGER,
DateDebutDisponibilite DATE,
DateFinDisponibilite DATE,
PRIMARY KEY (IDProduit,IDCategorie)
);

CREATE TABLE Production
(
IDEntreprise INTEGER NOT NULL,
IDProduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL,
PRIMARY KEY (IDEntreprise,IDProduit,IDCategorie)
);

CREATE TABLE ProduitParCommande
(
IDCommande INTEGER,
IDProduit INTEGER,
IDCategorie INTEGER,
Quantite INTEGER,
PRIMARY KEY (IDCommande,IDProduit,IDCategorie)
);

CREATE TABLE ProduitParLivraison
(
IDLivraison INTEGER NOT NULL UNIQUE,
IDProduit INTEGER,
IDCategorie INTEGER,
Quantite INTEGER,
PrixUnitaireHTAchat INTEGER,
PRIMARY KEY (IDLivraison)
);

CREATE TABLE Remise
(
IDRemise INTEGER NOT NULL UNIQUE,
TypeRemise VARCHAR2 NOT NULL,
ValeurRemise INTEGER,
ConditionNbCommande INTEGER,
ConditionDuree INTEGER,
ConditionDate Date,
PRIMARY KEY (IDRemise)
);

CREATE TABLE Commande
(
IDCommande INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
idClient INTEGER,
DateCommande DATE,
IDRemise INTEGER,
Valide INTEGER,
PrixHT INTEGER,
FraisDePort INTEGER,
PRIMARY KEY (IDCommande)
);

CREATE TABLE Stock
(
IDLivraison INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
IDPoduit INTEGER NOT NULL,
IDCategorie INTEGER NOT NULL UNIQUE,
Quantite INTEGER,
DatePeremption DATE,
PRIMARY KEY (IDLivraison,IDPoduit,IDCategorie)
);

CREATE TABLE Ville
(
CodePostal INTEGER NOT NULL,
NomVille VARCHAR2 NOT NULL,
Livrable INTEGER NOT NULL,
PRIMARY KEY (CodePostal,NomVille)
);

CREATE TABLE Entreprise
(
IDEntreprise INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
NomEntreprise VARCHAR2 NOT NULL,
Rue VARCHAR2 NOT NULL,
Ville CHAR NOT NULL,
CodePostal INTEGER NOT NULL,
NomContact INTEGER,
Contact INTEGER,
PRIMARY KEY (IDEntreprise)
);

CREATE TABLE Client
(
IDClient INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
Nom VARCHAR2 NOT NULL,
Prenom VARCHAR2 NOT NULL,
Rue VARCHAR2 NOT NULL,
CodePostal INTEGER NOT NULL,
Ville CHAR,
Telephone VARCHAR2,
Email VARCHAR2 NOT NULL,
MotDePasse VARCHAR2 NOT NULL,
DateInscription DATE NOT NULL,
NBCommande INTEGER NOT NULL,
PRIMARY KEY (IDClient)
);

ALTER TABLE Livraison ADD FOREIGN KEY IDEntreprise_idxfk (IDEntreprise) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Produit ADD FOREIGN KEY IDCategorie_idxfk (IDCategorie) REFERENCES Categorie (IDCategorie);

ALTER TABLE Production ADD FOREIGN KEY IDEntreprise_idxfk_1 (IDEntreprise) REFERENCES Entreprise (IDEntreprise);

ALTER TABLE Production ADD FOREIGN KEY IDProduit_idxfk (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE ProduitParCommandes ADD FOREIGN KEY IDCommande_idxfk (IDCommande) REFERENCES Commande (IDCommande);

ALTER TABLE ProduitParCommandes ADD FOREIGN KEY IDProduit_idxfk_1 (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE ProduitParLivraison ADD FOREIGN KEY IDLivraison_idxfk (IDLivraison) REFERENCES Livraison (IDLivraison);

ALTER TABLE ProduitParLivraison ADD FOREIGN KEY IDProduit_idxfk_2 (IDProduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Commande ADD FOREIGN KEY idClient_idxfk (idClient) REFERENCES Client (IDClient);

ALTER TABLE Commande ADD FOREIGN KEY IDRemise_idxfk (IDRemise) REFERENCES Remise (IDRemise);

ALTER TABLE Stock ADD FOREIGN KEY IDLivraison_idxfk_1 (IDLivraison) REFERENCES Livraison (IDLivraison);

ALTER TABLE Stock ADD FOREIGN KEY IDPoduit_idxfk (IDPoduit,IDCategorie) REFERENCES Produit (IDProduit,IDCategorie);

ALTER TABLE Entreprise ADD FOREIGN KEY Code Postal_idxfk (CodePostal,Ville) REFERENCES Ville (CodePostal,Ville);

ALTER TABLE Client ADD FOREIGN KEY Ville_idxfk (Ville,CodePostal) REFERENCES Ville (Ville,CodePostal);
