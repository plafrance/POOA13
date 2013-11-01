unit uniteReponse;

//Encapsule les données renvoyer par le serveur.
interface

uses
  SysUtils;

//Encapsule les données renvoyées par le serveur.
type
  Reponse = class
    private

      //Adresse demandeur

      adresseDemandeur : String;

      //Version HTTP 1.0 ou 1.1

      versionProtocole : String;

      //Code d'erreur si necessaire ex : 404

      codeReponse : Word;

      //Message d'erreur

      message : String;
      
      //Reponse HTML --- message d'aide
      
      reponseHtml : String;

    public

      //Crée un objet Reponse.
      //Reçoit en paramètres tous les attributs de la classe Reponse.
      //
      //@param uneAdresseDemandeur l'adresse ip du demandeur
      //@param uneVersionProtocole la version du protocole http
      //@param unCodeReponse le code réponse est un code d’erreur résultant de la requête
      //@param unMessage un bref message d'erreur
      //@param uneReponseHtml un message d’erreur plus descriptif 

      constructor create(uneAdresseDemandeur:String;uneVersionProtocole:String;unCodeReponse:Word;unMessage:String;uneReponseHtml:String);

      //Accesseur adresseDemandeur
      //
      //@return retourne l'adresseDemandeur en String

      function getAdresseDemandeur:String;

      //Accesseur versionProtocole
      //
      //@return retourne la versionProtocole en String

      function getVersionProtocole:String;

      //Accesseur codeReponse
      //
      //@return retourne le codeReponse en Word

      function getCodeReponse:Word;

      //Accesseur message
      //
      //@return retourne le message en String

      function getMessage:String;

      //Accesseur reponseHtml
      //
      //@return retourne la reponseHtml en String
      
      function getReponseHtml:String;
  end;

implementation

constructor Reponse.create(uneAdresseDemandeur:String;uneVersionProtocole:String;unCodeReponse:Word;unMessage:String;uneReponseHtml:String);
begin
  adresseDemandeur:=uneAdresseDemandeur;
  versionProtocole:=uneVersionProtocole;
  codeReponse:=unCodeReponse;
  message:=unMessage;
  reponseHtml:=uneReponseHtml;
end;

function Reponse.getAdresseDemandeur:String;
begin
  result:=adresseDemandeur;
end;

function Reponse.getVersionProtocole:String;
begin
  result:=versionProtocole;
end;

function Reponse.getCodeReponse:Word;
begin
  result:=codeReponse;
end;

function Reponse.getMessage:String;
begin
  result:=message;
end;

function Reponse.getReponseHtml:String;
begin
  result:=reponseHtml;
end;

end.
