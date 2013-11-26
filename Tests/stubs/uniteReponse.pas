unit uniteReponse;

//Encapsule les donn�es renvoyer par le serveur.
interface

uses
  SysUtils;

//Encapsule les donn�es renvoy�es par le serveur.
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

      //Cr�e un objet Reponse.
      //Re�oit en param�tres tous les attributs de la classe Reponse.
      //
      //@param uneAdresseDemandeur l'adresse ip du demandeur
      //@param uneVersionProtocole la version du protocole http
      //@param unCodeReponse le code r�ponse est un code d�erreur r�sultant de la requ�te
      //@param unMessage un bref message d'erreur
      //@param uneReponseHtml un message d�erreur plus descriptif 

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
end;

function Reponse.getAdresseDemandeur:String;
begin
  result:='';
end;

function Reponse.getVersionProtocole:String;
begin
  result:='';
end;

function Reponse.getCodeReponse:Word;
begin
  result:=0;
end;

function Reponse.getMessage:String;
begin
  result:='';

end;

function Reponse.getReponseHtml:String;
begin
  result:='';

end;

end.
