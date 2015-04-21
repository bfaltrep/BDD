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
Pro_PrixUnitaireHTVente INTEGER,
Pro_DateDebutDisponibilite DATE,
Pro_DateFinDisponibilite DATE,
PRIMARY KEY (IDProduit)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ProduitFournisseur
(
IDEntreprise INTEGER NOT NULL,
IDProduit INTEGER NOT NULL,
PF_PrixUnitaireHT INTEGER,
PRIMARY KEY (IDEntreprise,IDProduit)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ProduitParCommande
(
IDCommande INTEGER NOT NULL,
IDProduit INTEGER NOT NULL,
PPC_Quantite INTEGER,
PRIMARY KEY (IDCommande,IDProduit)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE ProduitParLivraison
(
IDLivraisonFournisseur INTEGER NOT NULL,
IDProduit INTEGER NOT NULL,
PPL_QuantiteALaLivraison INTEGER,
PPL_PrixUnitaireHTAchat INTEGER,
PPL_QuantiteActuelle INTEGER,
PPL_DatePeremption DATE,
PRIMARY KEY (IDLivraisonFournisseur, IDProduit)
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

CREATE TABLE Ville
(
NomVille VARCHAR(100) NOT NULL,
CodePostal VARCHAR(5) NOT NULL,
Vil_Livrable TINYINT NOT NULL,
PRIMARY KEY (NomVille,CodePostal)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Entreprise
(
IDEntreprise INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
Ent_Nom VARCHAR(100) NOT NULL,
Ent_Adresse CHAR(100) NOT NULL,
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

ALTER TABLE ProduitFournisseur ADD FOREIGN KEY `IDEntreprise_Production_idxfk` (IDEntreprise) REFERENCES Entreprise (IDEntreprise);
ALTER TABLE ProduitFournisseur ADD FOREIGN KEY `IDProduit_Production_idxfk` (IDProduit) REFERENCES Produit (IDProduit);

ALTER TABLE ProduitParCommande ADD FOREIGN KEY `IDCommande_ProduitParCommande_idxfk` (IDCommande) REFERENCES Commande (IDCommande);
ALTER TABLE ProduitParCommande ADD FOREIGN KEY `IDProduit_ProduitParCommande_idxfk` (IDProduit) REFERENCES Produit (IDProduit);
ALTER TABLE ProduitParLivraison ADD FOREIGN KEY `IDLivraisonFournisseur_ProduitParLivraison_idxfk` (IDLivraisonFournisseur) REFERENCES LivraisonFournisseur (IDLivraisonFournisseur);  
ALTER TABLE ProduitParLivraison ADD FOREIGN KEY `IDProduit_ProduitParLivraison_idxfk` (IDProduit) REFERENCES Produit (IDProduit);
ALTER TABLE Commande ADD FOREIGN KEY `IDClient_Commande_idxfk` (IDClient) REFERENCES Client (IDClient); 
ALTER TABLE Commande ADD FOREIGN KEY `IDRemise_Commande_idxfk` (IDRemise) REFERENCES Remise (IDRemise); 

ALTER TABLE Entreprise ADD FOREIGN KEY `Ville_Entreprise_idxfk` (Ent_Ville,Ent_CodePostal) REFERENCES Ville (NomVille,CodePostal);
ALTER TABLE Client ADD FOREIGN KEY `Ville_Client_idxfk` (Cli_Ville,Cli_CodePostal) REFERENCES Ville (NomVille,CodePostal);

