unit uniteConsigneur;

interface

uses
  SysUtils;

//Consigner des messages ou des erreurs
type
  Consigneur = class

    public

      //reçoit un message à consigner et affiche à l'écran un message de la forme : date[ERREUR – origine]:
      //
      //@param date la date courante dans le format "AAAA-MM-JJ HH:MM:SS"
      //@param origine la partie du serveur d'où origine la consignation
      //@param message le message de l'erreur à consigner

      procedure consignerErreur(date:TDateTime;origine:String; message:String);

      //reçoit un message à consigner et affiche à l'écran un message de la forme : date [origine]: message.
      //
      //@param date la date courante dans le format "AAAA-MM-JJ HH:MM:SS"
      //@param origine la partie du serveur d'où origine la consignation
      //@param message le message à consigner

      procedure consigner(date:TDateTime;origine:String; message:String);

  end;

implementation

procedure Consigneur.consignerErreur(date:TDateTime;origine:String; message:String);
begin
  writeln(formatDateTime('c',date),' [Erreur - '+origine+']: ',message);
end;

procedure Consigneur.consigner(date:TDateTime;origine:String; message:String);
begin
  writeln(formatDateTime('c',date),' [',origine,']: ',message);
end;

end.
