unit uniteConsigneur;

interface

uses
  SysUtils;

//Consigner des messages ou des erreurs
type
  Consigneur = class

    public

      //reçit un message ・consigner et affiche ・l'馗ran un message de la forme: date[ERREUR ・origine]:message
      //
      //@param date la date courante dans le format "AAAA-MM-JJ HH:MM:SS"
      //@param origine la partie du programme d'o・origine la consignation
      //@param message le message de l'erreur ・consigner

      procedure consignerErreur(origine:String; message:String); virtual;

      //reçit un message ・consigner et affiche ・l'馗ran un message de la forme: date [origine]: message.
      //
      //@param date la date courante dans le format "AAAA-MM-JJ HH:MM:SS"
      //@param origine la partie du programme d'o・origine la consignation
      //@param message le message ・consigner

      procedure consigner(origine:String; message:String); virtual;

  end;

implementation

procedure Consigneur.consignerErreur(origine:String; message:String);
begin
  writeln(formatDateTime('YYYY-MM-DD HH:MM:SS',date),' [Erreur - '+origine+']: ',message);
end;

procedure Consigneur.consigner(origine:String; message:String);
begin
  writeln(formatDateTime('YYYY-MM-DD HH:MM:SS',now),' [',origine,']: ',message);
end;

end.
