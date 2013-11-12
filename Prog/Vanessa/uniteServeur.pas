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

   //Un serveur HTTP minimaliste, supportant la m�thode GET du protocole HTTP 1.1 uniquement.
  Serveur = class
    private
    // Le chemin par lequel les requ�tes sont envoy�es au serveur
    // et les r�ponses sont retourn�es au client
      laConnexion : ConnexionHTTPServeur;

    // Le protocole HTTP par lequel les requ�tes sont trait�es
      leProtocole : Protocole;

    //Le consigneur qui r�achemine les messages d'erreur et de succ�s dans un format pr�cis.
      leConsigneur : Consigneur;

    public
    // Permet d'initialiser le serveur en cr�ant la connexion et le protocole
    // @param unPort le num�ro du port sur lequel le serveur �coute les requ�tes
    // @param unConsigneur qui est de type Consigneur qui consigne les messages d'erreur et de connexion dans un format standardis�.
    // @param unRepertoireDeBase qui est de type string qui repr�sente un r�pertore existant sur le serveur.
      constructor create(unPort:Word; unConsigneur:Consigneur; unRepertoireDeBase:String);
    // Destructeur qui d�truit les objet connexion, protocole.
      destructor destroy;
    // D�marre le traitement des requ�tes
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

      // Affichage d'un message standardis� pour confirmer l'initialisation (Instanciation) du serveur.
      leConsigneur.consigner('Serveur',' Vanessa est d�marr�e sur le port '+ intToStr(unPort));
    end;

    //Le destructeur qui d�truit les objets de la classe serveur.
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
      // Ouvre la connexion et attend une requ�te
        try
          uneRequete := laConnexion.lireRequete;
          // Le protocole traite la requ�te
          uneReponse := leProtocole.traiterRequete(uneRequete);
          // Renvoie de la reponse au client
          laConnexion.ecrireReponse(uneReponse);
          // Message de confirmation de la r�ception de la requ�te
          leConsigneur.consigner('Serveur',' Requ�te re�ue de '+uneRequete.getAdresseDemandeur+'.');
        except on e : Exception do
          begin
            leConsigneur.consignerErreur('Serveur',' Erreur d''entr�e/sortie: '+ e.Message);
            halt;
          end;
        end;
        // Fermeture de la connexion
        laConnexion.fermerConnexion;
      end;
    end;
end.


