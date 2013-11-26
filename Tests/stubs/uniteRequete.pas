unit uniteRequete;

// Encapsule les donn�es entr�es par l�utilisateur
interface

uses
  SysUtils;

//Encapsule les donn�es entr�es par le client
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
      //@param uneAdresseDemandeur l�adresse ip du demandeur exemple : 127.0.0.1
      //@param uneDateReception la date de r�ception de la requ�te exemple : 2013/09/21 10:51
      //@param uneVersionProtocole la version du protocole http utilis� par le client. exemple : HTTP/1.1
      //@param uneMethode la demande effectu�e par le client exemple : GET, POST, etc
      //@param unUrl l'url de la page requise

      constructor create(uneAdresseDemandeur:String; uneDateReception:TDateTime; uneVersionProtocole:String; uneMethode:String; unUrl:String);

      //Accesseur de l'adresse du demandeur.
      //
      //@return String l'adresse du demandeur

      function getAdresseDemandeur:String;

      //Accesseur de la date de r�ception
      //
      //@return TdateTime la date de r�ception

      function getDateReception:TDateTime;

      //Accesseur de la version du protocole du client
      //
      //@return String la version du protocole du client

      function getVersionProtocole:String;

      //Accesseur de la m�thode HTTP
      //
      //@return String la m�thode HTTP

      function getMethode:String;

      //Accesseur de l'URL demand� par le client
      //
      //@return String l'URL demand� par le client

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
