/**
 * Dans le cas où des bactéries mortelles ont été découvert sur un produit, il faut prévenir les clients pour qu’ils sachent qu’ils doivent aller chez le médecin:   
 *Exemple: Tous les clients qui ont reçu une livraison contenant des avocats d’Espagne entre le 3 Avril 2015 et le 10 Avril 2015.
 */

Select * FROM Client WHERE Client.IDClient IN ( SELECT Commande.IDClient FROM Commande NATURAL JOIN ProduitParCommande WHERE Commande.Date BETWEEN "2015-04-03" AND "2015-04-10" AND ProduitParCommande.IDProduit=3234);

/**
 * Dans le cas où on veut considérer la ville non-livrable la plus rentable qu’on servira dans le futur … 
 * Exemple: La ville non-livrable avec le plus grand nombre de clients.  
 */

SELECT Client.CodePostal, Client.NomVille, count(Client.IDClient) FROM Client NATURAL JOIN Ville WHERE Ville.livrable=0 GROUP BY (Client.CodePostal, Client.NomVille) LIMIT 1;   


/**
 *Dans le cas où on veut vérifier qu’un utilisateur existe et que le mot de passe qu’il a rentré est juste (pour qu’il puisse se connecter).
 * Exemple: Quelqu’un tente de se connecter avec le pseudo ‘bergerallemand@chocolatine.fr’ et le mot de passe ‘chocolatinepaspainauchocolat’.  
 */

SELECT IDClient FROM Client WHERE Cli_email="bergerallemand@chocolatine.fr" AND Cli_motDePasse="chocolatinepaspainauchocolat";  


/**
 *  Dans le cas où on veut savoir quels produits qui ne sont plus en stock.
 */

SELECT * FROM Produit WHERE Produit.IDProduit IN (SELECT ProduitParLivraison.IDProduit FROM ProduitParLivraison WHERE PPL_QuantiteActuelle = 0); 

/**
 *   Dans le cas où on veut savoir quels produits qui ne sont pas en stock. (Jamais achèté, ou on n'en a plus)
 */
SELECT * FROM Produit WHERE Produit.IDProduit NOT IN (SELECT ProduitParLivraison.IDProduit FROM ProduitParLivraison WHERE PPL_QuantiteActuelle <> 0); 

/**
 * Dans le cas où on veut savoir quel produit nous a fait gagné le plus grand bénéfice (c’est à dire, qui nous a fait gagné le plus haut montant d’argent avant de soustraire ce qu’on a payé pour les acheter) pendant une période spécifiée.  
 * Exemple: Entre 1 Janvier 2015 et 31 Janvier 2015
 *
 * TODO
 */


/**
 * Dans le cas où quelqu’un est malade à cause de nos produit, on veut savoir quels produits cette personne a acheté sur une date précise.
 * Exemple: jstewartp@un.org nous a écrit pour nous dire qu'il a eu mal au ventre après avoir mangé des produits de la commande qu'il a reçu le 7 Mai 2014.  
 */
SELECT * FROM Produit WHERE IDProduit IN (SELECT pro_id FROM ProduitParCommande WHERE com_id IN (SELECT com_id FROM Commande WHERE  com.cli_id IN (SELECT cli_id FROM client WHERE cli_email = ‘jstewartp@un.org’) AND com_dateValidation=‘2014-05-07’));



/**
 * Dans le cas où on veut...
 *
 */

