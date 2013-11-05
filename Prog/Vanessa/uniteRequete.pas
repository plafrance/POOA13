unit uniteRequete;

// Encapsule les données entrées par l’utilisateur
interface
  uses SysUtils;
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
      //Le constructeur de la classe requête qui donne les valeur à la requête tel que l'adresse du demandeur, la date, la version du protocole, la méthode utilisée et le lien URL.
      //@param unAdresseDemandeur qui représente l'adresse IP du demandeur.
      //@param uneDateReception qui représente la date et l'heure du moment.
      //@param uneVersionProtocole qui est la version HTTP du protocole utilisé. Pouvant être 1.1.
      //@param uneMethode que représente la méthode utilisé pour l'envoi de la requête.
      //@param unURL qui représente le lien URL.
      constructor create(unAdresseDemandeur:String;uneDateReception:TDateTime;uneVersionProtocole:String;uneMethode:String;unURL:String);
      //Accesseur getAdresseDemandeur qui retourne un String de l'adresse.
      //@return returne l'adresse IP du demandeur
      function getAdresseDemandeur:String;
      //Accesseur getDateReception qui retourne la date et l'heure du moment.
      //@return retourne la date el l'heure en chaine de caractère.
      function getDateReception:TDateTime;
      //Accesseur de la version du protocole utilisé par le client pouvant être HTTP 1.1 par exemple.
      //@return retourne la version du protocole en chaine de caractère.
      function getVersionProtocole:String;
      //Accesseur l'adresse IP du demandeur qui renvoi un String de l'adresse.
      //return une chaîne de caractère de la méthode utilisés.
      function getMethode:String;
      //Accesseur de la page d'Internet demande par le client
      //@return retourne la page d'Internet en chaine de caractère.
      function getUrl:String;

    end;

implementation

      constructor Requete.create(unAdresseDemandeur:String;uneDateReception:TDateTime;uneVersionProtocole:String;uneMethode:String;unURL:String);
      begin
        adresseDemandeur:=unAdresseDemandeur;
        dateReception:=uneDateReception;
        versionProtocole:=uneVersionProtocole;
        methode:=uneMethode;
        url:=unURL;
      end;

      function Requete.getAdresseDemandeur:String;
      begin
        result:=adresseDemandeur;
      end;

      function Requete.getDateReception:TDateTime;
      begin
        result:=dateReception;
      end;

      function Requete.getVersionProtocole:String;
      begin
        result:=versionProtocole;
      end;

      function Requete.getMethode:String;
      begin
        result:=methode;
      end;

      function Requete.getUrl:String;
      begin
        result:=url;
      end;
end.
