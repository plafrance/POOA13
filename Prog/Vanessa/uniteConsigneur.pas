unit uniteConsigneur;

interface

uses
  SysUtils;

//Consigner des messages ou des erreurs
type
  Consigneur = class

    public

      //re�oit un message � consigner et affiche � l'�cran un message de la forme�: date[ERREUR � origine]:
      //
      //@param origine la partie du serveur d'o� origine la consignation.
      //@param message le message de l'erreur � consigner

      procedure consignerErreur(origine:String; message:String); virtual;

      //re�oit un message � consigner et affiche � l'�cran un message de la forme�: date [origine]: message.
      //
      //@param origine la partie du serveur d'o� origine la consignation
      //@param message le message � consigner

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
