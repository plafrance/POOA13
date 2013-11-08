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
      //@param origine la partie du serveur d'où origine la consignation.
      //@param message le message de l'erreur à consigner

      procedure consignerErreur(origine:String; message:String); virtual;

      //reçoit un message à consigner et affiche à l'écran un message de la forme : date [origine]: message.
      //
      //@param origine la partie du serveur d'où origine la consignation
      //@param message le message à consigner

      procedure consigner(origine:String; message:String); virtual;

  end;

implementation

procedure Consigneur.consignerErreur(origine:String; message:String);
begin
  writeln(formatDateTime('YYYY-MM-DD HH:MM:SS',now),' [Erreur - '+origine+']: ',message);
end;

procedure Consigneur.consigner(origine:String; message:String);
begin
  writeln(formatDateTime('YYYY-MM-DD HH:MM:SS',now),' ['+origine+']: ',message);
end;

end.
