unit uniteConsigneur;

interface

uses
  SysUtils;

//Consigner des messages ou des erreurs
type
  Consigneur = class

    public

      constructor create( unRepertoireJournaux : String );

      //re?oit un message ? consigner et affiche ? l'?cran un message de la forme?: date[ERREUR ? origine]:
      //
      //@param date la date courante dans le format "AAAA-MM-JJ HH:MM:SS"
      //@param origine la partie du serveur d'o? origine la consignation
      //@param message le message de l'erreur ? consigner

      procedure consignerErreur(origine:String; message:String); virtual;

      //re?oit un message ? consigner et affiche ? l'?cran un message de la forme?: date [origine]: message.
      //
      //@param date la date courante dans le format "AAAA-MM-JJ HH:MM:SS"
      //@param origine la partie du serveur d'o? origine la consignation
      //@param message le message ? consigner

      procedure consigner(origine:String; message:String); virtual;

      function getRepertoireJournaux : String;
  end;

implementation

constructor Consigneur.create( unRepertoireJournaux : String );
begin
end;

procedure Consigneur.consignerErreur(origine:String; message:String);
begin
end;

procedure Consigneur.consigner(origine:String; message:String);
begin
end;

function Consigneur.getRepertoireJournaux : String;
begin
  result:='';
end;

end.
