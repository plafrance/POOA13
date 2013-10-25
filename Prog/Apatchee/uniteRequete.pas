unit uniteRequete;

// Encapsule les données entrées par l’utilisateur
interface
  type
    Requete = class
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

  end;

implementation

end.
