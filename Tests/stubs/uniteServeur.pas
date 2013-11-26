unit uniteServeur;

interface

uses
  SysUtils,
  uniteConsigneurStub,
  uniteProtocole,
  uniteRequete,
  uniteReponse;

type

   //Un serveur HTTP minimaliste, supportant la méthode GET du protocole HTTP 1.1 uniquement.
  Serveur = class
    private

    public
    // Permet d'initialiser le serveur en créant la connexion et le protocole
    // @param unPort le numéro du port sur lequel le serveur écoute les requêtes
      constructor create(unPort:Word; unConsigneur:ConsigneurStub; unRepertoireDeBase:String);

      destructor destroy;
    // Démare le traitement des requêtes
      procedure demarrer;



  end;

implementation


    constructor Serveur.create(unPort:Word; unConsigneur:ConsigneurStub; unRepertoireDeBase:String);
    begin end;

  procedure Serveur.demarrer;
  begin
  end;

  destructor Serveur.destroy;
  begin end;


end.


