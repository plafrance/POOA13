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
      leConsigneur : Consigneur;

    public
    // Permet d'initialiser le serveur en créant la connexion et le protocole
    // @param unPort le numéro du port sur lequel le serveur écoute les requêtes
    // @param unConsigneur qui est de type Consigneur qui consigne les messages d'erreur et de connexion dans un format standardisé.
    // @param unRepertoireDeBase qui est de type string qui représente un répertore existant sur le serveur.
      constructor create(unPort:Word; unConsigneur:Consigneur; unRepertoireDeBase:String);
    // Destructeur qui détruit les objet connexion, protocole.
      destructor destroy;
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
      leConsigneur.consigner('Serveur',' Vanessa est démarrée sur le port '+ intToStr(unPort));
    end;

    //Le destructeur qui détruit les objets de la classe serveur.
    destructor Serveur.destroy;
    begin
      laConnexion.destroy;
      leProtocole.destroy;
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
          // Le protocole traite la requête
          uneReponse := leProtocole.traiterRequete(uneRequete);
          // Renvoie de la reponse au client
          laConnexion.ecrireReponse(uneReponse);
          // Message de confirmation de la réception de la requête
          leConsigneur.consigner('Serveur',' Requête reçue de '+uneRequete.getAdresseDemandeur+'.');
        except on e : Exception do
          begin
            leConsigneur.consignerErreur('Serveur',' Erreur d''entrée/sortie: '+ e.Message);
            halt;
          end;
        end;
        // Fermeture de la connexion
        laConnexion.fermerConnexion;
      end;
    end;
end.


