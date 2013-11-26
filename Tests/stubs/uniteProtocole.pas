unit uniteProtocole;

interface

uses
  SysUtils, uniteReponse, uniteRequete, uniteConsigneur;

//Traite les requêtes HTTP et fournit une réponse appropriée selon l'état du serveur
type
  Protocole = class
    private
      //Le répertoire local qui contient tous les sites web de notre serveur
      repertoireDeBase:String;

      //Un consigneur permettant de consigner tous les messages
      leConsigneur:Consigneur;

    public
      //La methode traiterRequete analyse la requete et renvoie le code approprié au fureteur.
      //Elle  reçoit la requete envoyée par le fureteur en paramètre et retourne un objet de type Reponse.
      //
      //@param uneRequete Reçoit la requête de l'utilisateur
      //
      //@return Reponse  Traite la requête et retourne une réponse (Code d'erreur + message)
      //
      //@exception Exception Si la requête n'est pas une requête HTTP valide (si la 3ième partie n'est pas de la forme HTTP/x.y où x et y sont des entiers)

      function traiterRequete(uneRequete:Requete):Reponse;

      //Crée un objet Protocole qui traite les requêtes HTTP
      //et fournit une réponse appropriée selon l'état du serveur.
      //
      //@param unRepertoire le répertoire qui contient tous les sites web de notre serveur
      //@param unConsigneur sert à consigner des messages

      constructor create(unRepertoire:String;unConsigneur:Consigneur);

      //Accesseur du répertoire de base
      //
      //@return String retourne le répertoire de base

      function getRepertoire:String;

      //Mutateur du répertoire de base
      //
      //@param unRepertoire le répertoire de base

      procedure setRepertoire(unRepertoire:String);

  end;


implementation

function Protocole.traiterRequete(uneRequete:Requete):Reponse;
begin
  result := Reponse.create('', '', 0, '', '');
end;

constructor Protocole.create(unRepertoire:String;unConsigneur:Consigneur);
begin
end;

function Protocole.getRepertoire:String;
begin

end;

procedure Protocole.setRepertoire(unRepertoire:String);
begin
end;

end.
