unit uniteServeur;

interface

uses
  SysUtils,
  uniteConnexionHTTPServeur,
  uniteProtocole,
  uniteRequete,
  uniteReponse;

type

   //Un serveur HTTP minimaliste, supportant la méthode GET du protocole HTTP 1.1 uniquement.
  Serveur = class

    // Le chemin par lequel les requêtes sont envoyées au serveur
    // et les réponses sont retournées au client
    laConnexion : ConnexionHTTPServeur;

    // Le protocole HTTP par lequel les requêtes sont traitées
    leProtocole : Protocole;

    // Permet d'initialiser le serveur en créant la connexion et le protocole
    // @param unPort le numéro du port sur lequel le serveur écoute les requêtes
    procedure initialiser(unPort:Word);

    // Démare le traitement des requêtes
    procedure demarrer;

  end;

implementation


  procedure Serveur.initialiser(unPort:Word);
  begin
    // Instanciation de l'objet ConnexionHTTPServeur
    laConnexion := ConnexionHTTPServeur.create(unPort);

    // Instanciation de l'objet Protocole
    leProtocole := Protocole.create;

    // Affichage d'un message pour confirmer l'initialisation du serveur
    // FormatDateTime('c', now) permet d'afficher la date sous la forme jj/mm/aaaa hh:mm:ss
    writeln('[',formatDateTime('c', now),'] le serveur est demarré sur le port ',unPort,'.');
  end;


  procedure Serveur.demarrer;
  var
    uneRequete: Requete;
    uneReponse: Reponse;
  begin
    // Boucler infiniment
    while true do
    begin
      // Ouvre la connexion et attend une requête
      uneRequete := laConnexion.lireRequete;

      // Message de confirmation de la réception de la requête
      writeln('[',formatDateTime('c', uneRequete.dateReception),'] Requête reçue de ',uneRequete.adresseDemandeur,'.');

      // Le protocole traite la requête
      uneReponse := leProtocole.traiterRequete(uneRequete);

      // Renvoie de la reponse au client
      laconnexion.ecrireReponse(uneReponse);

      // Fermeture de la connexion
      laConnexion.fermerConnexion;
    end;
  end;

end.


