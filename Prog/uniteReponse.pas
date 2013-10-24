unit uniteReponse;

//Encapsule les données renvoyer par le serveur.
interface
  type
    Requete = class
      //Adresse demandeur
      adresseDemandeur : String;
      //Version HTTP 1.0 ou 1.1
      versionProtocole : String;
      //Code d'erreur si necessaire ex : 404
      codeReponse : word;
      //Message d'erreur
      message : String;
      //Reponse HTML --- message d'aide
      reponseHtml : String;

  end;

implementation

end.
