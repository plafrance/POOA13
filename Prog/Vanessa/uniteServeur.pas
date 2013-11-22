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

    //Le consigneur qui réachemine les messages d'erreur et de succès dans un format précis.
    //FormatDateTime('c', now) permet d'afficher la date sous la forme jj/mm/aaaa hh:mm:ss
      leConsigneur : Consigneur;

    public
    // Permet d'initialiser le serveur en créant la connexion et le protocole
    // @param unPort le numéro du port sur lequel le serveur écoute les requêtes
    // @param unConsigneur qui est de type Consigneur qui consigne les messages d'erreur et de connexion dans un format standardisé.
    // @param unRepertoireDeBase qui est de type string qui représente un répertore existant sur le serveur.
      constructor create(unPort:Word; unConsigneur:Consigneur; unRepertoireDeBase:String);
    // Destructeur qui détruit les objet connexion, protocole et consigneur.
    // @param unConsigneur de type Consigneur qui représente le consigneur à détruire.
      destructor destroy(unConsigneur:Consigneur);
    // Démarre le traitement des requêtes
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

      // Affichage d'un message standardisé pour confirmer l'initialisation (Instanciation) du serveur.
      leConsigneur.consigner('Serveur',' Le serveur est connecte sur le port '+ intToStr(unPort));
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
          leConsigneur.consigner('Serveur',' Requête reçue de '+laConnexion.getAdresseDistante+'.');
        except on e : Exception do
          leConsigneur.consignerErreur('Serveur',' Erreur d''entrée/sortie: '+ e.Message);
        end;


      // Le protocole traite la requête
        try
          uneReponse := leProtocole.traiterRequete(uneRequete);
        except on e : Exception do
          leConsigneur.consignerErreur('Serveur',' Erreur d''entrée/sortie: '+ e.Message);
          //Les consignes sur moodle parlais d'un lancement d'exception mais je ne savais pas ou le mettre
          // ou même si je devais le mettre?
          //raise Exception.create('Numéro de port invalide ou déjà utilisé');
        end;
        // Renvoie de la reponse au client
        laConnexion.ecrireReponse(uneReponse);
        // Fermeture de la connexion
        laConnexion.fermerConnexion;
      end;
    end;
    //Le destructeur qui détruit les objets de la classe serveur.
    destructor Serveur.destroy(unConsigneur:Consigneur);
    begin
      laConnexion.destroy;
      leProtocole.destroy;
      unConsigneur.destroy;
    end;
    
end.

