unit uniteRequete;

// Encapsule les données entrées par l’utilisateur
interface

uses
  SysUtils;

//Encapsule les données entrées par le client
type
  Requete = class

    private

      //Adresse de la source

      adresseDemandeur : String;

      //Date reception de la requete

      dateReception : TDateTime;

      //Version HTTP 1.0 ou 1.1

      versionProtocole : String;

      //methose GET

      methode : String;

      //URL demande

      url : String;

    public

      //Instancie la Requete avec tous ses attributs
      //
      //@param uneAdresseDemandeur l’adresse ip du demandeur exemple : 127.0.0.1
      //@param uneDateReception la date de réception de la requête exemple : 2013/09/21 10:51
      //@param uneVersionProtocole la version du protocole http utilisé par le client. exemple : HTTP/1.1
      //@param uneMethode la demande effectuée par le client exemple : GET, POST, etc
      //@param unUrl l'url de la page requise

      constructor create(uneAdresseDemandeur:String; uneDateReception:TDateTime; uneVersionProtocole:String; uneMethode:String; unUrl:String);

      //Accesseur de l'adresse du demandeur.
      //
      //@return String l'adresse du demandeur

      function getAdresseDemandeur:String;

      //Accesseur de la date de réception
      //
      //@return TdateTime la date de réception

      function getDateReception:TDateTime;

      //Accesseur de la version du protocole du client
      //
      //@return String la version du protocole du client

      function getVersionProtocole:String;

      //Accesseur de la méthode HTTP
      //
      //@return String la méthode HTTP

      function getMethode:String;

      //Accesseur de l'URL demandé par le client
      //
      //@return String l'URL demandé par le client

      function getUrl:String;

  end;

implementation

constructor Requete.create(uneAdresseDemandeur:String; uneDateReception:TDateTime; uneVersionProtocole:String; uneMethode:String; unUrl:String);
begin
end;

function Requete.getAdresseDemandeur:String;
begin
 result := '';
end;

function Requete.getDateReception:TDateTime;
begin
 result := 0;
end;

function Requete.getVersionProtocole:String;
begin
 result := '';
end;

function Requete.getMethode:String;
begin
 result := '';
end;

function Requete.getUrl:String;
begin
 result := '';
end;

end.
