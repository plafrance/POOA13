unit uniteServeur;

interface

uses
  SysUtils,
  uniteConsigneurStub,
  uniteProtocole,
  uniteRequete,
  uniteReponse;

type

   //Un serveur HTTP minimaliste, supportant la m�thode GET du protocole HTTP 1.1 uniquement.
  Serveur = class
    private

    public
    // Permet d'initialiser le serveur en cr�ant la connexion et le protocole
    // @param unPort le num�ro du port sur lequel le serveur �coute les requ�tes
      constructor create(unPort:Word; unConsigneur:ConsigneurStub; unRepertoireDeBase:String);

      destructor destroy;
    // D�mare le traitement des requ�tes
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


