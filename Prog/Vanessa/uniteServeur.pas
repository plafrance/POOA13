unit uniteServeur;

interface

uses
  SysUtils,
  uniteConsigneur,
  uniteConnexionHTTPServeur,
  uniteProtocole,
  uniteRequete,
  uniteReponse;

type

   //Un serveur HTTP minimaliste, supportant la méthode GET du protocole HTTP 1.1 uniquement.
  Serveur = class
    private
    // Le chemin par lequel les requêtes sont envoyées au serveur
    // et les réponses sont retournées au client
      laConnexion : ConnexionHTTPServeur;

    // Le protocole HTTP par lequel les requêtes sont traitées
      leProtocole : Protocole;


      leConsigneur : Consigneur;

    public
    // Permet d'initialiser le serveur en créant la connexion et le protocole
    // @param unPort le numéro du port sur lequel le serveur écoute les requêtes
      constructor create(unPort:Word; unConsigneur:Consigneur; unRepertoireDeBase:String);

      destructor destroy(unConsigneur:Consigneur);
    // Démare le traitement des requêtes
      procedure demarrer;



  end;

implementation


    constructor Serveur.create(unPort:Word; unConsigneur:Consigneur; unRepertoireDeBase:String);
    begin
      // Instanciation de l'objet ConnexionHTTPServeur
      laConnexion := ConnexionHTTPServeur.create(unPort);

      // Instanciation de l'objet Protocole
      leProtocole := Protocole.create(unRepertoireDeBase,unConsigneur);


      leConsigneur:=unConsigneur;


      // Affichage d'un message pour confirmer l'initialisation du serveur
      // FormatDateTime('c', now) permet d'afficher la date sous la forme jj/mm/aaaa hh:mm:ss
      leConsigneur.consigner(now, 'Serveur','Vanessa est demarré sur le port '+intToStr(unPort));
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
      try
        uneRequete := laConnexion.lireRequete;
        // Message de confirmation de la réception de la requête
        leConsigneur.consigner(now, 'Serveur',' Requête reçue de '+laConnexion.getAdresseDistante+'.');
      except on e : Exception do
        leConsigneur.consignerErreur(now, 'Serveur','Erreur d''entrée/sortie: '+e.Message);
      end;


      // Le protocole traite la requête
      try
        uneReponse := leProtocole.traiterRequete(uneRequete);

      except on e : Exception do
        leConsigneur.consignerErreur(now, 'Serveur','Erreur d''entrée/sortie: '+e.Message);
//        raise Exception.Create('Numéro de port invalide ou déjà utilisé');
      end;
      // Renvoie de la reponse au client
      laConnexion.ecrireReponse(uneReponse);
      // Fermeture de la connexion
      laConnexion.fermerConnexion;
    end;
  end;

  destructor Serveur.destroy(unConsigneur:Consigneur);
  begin
    laConnexion.destroy;
    leProtocole.destroy;
    unConsigneur.destroy;
  end;


end.


