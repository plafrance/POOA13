unit uniteProtocole;

interface

uses
  SysUtils, uniteReponse, uniteRequete, uniteConsigneur;

//Traite les requ�tes HTTP et fournit une r�ponse appropri�e selon l'�tat du serveur
type
  Protocole = class
    private
      //Le r�pertoire local qui contient tous les sites web de notre serveur
      repertoireDeBase:String;

      //Un consigneur permettant de consigner tous les messages
      leConsigneur:Consigneur;

    public
      //La methode traiterRequete analyse la requete et renvoie le code appropri� au fureteur.
      //Elle  re�oit la requete envoy�e par le fureteur en param�tre et retourne un objet de type Reponse.
      //
      //@param uneRequete Re�oit la requ�te de l'utilisateur
      //
      //@return Reponse  Traite la requ�te et retourne une r�ponse (Code d'erreur + message)
      //
      //@exception Exception Si la requ�te n'est pas une requ�te HTTP valide (si la 3i�me partie n'est pas de la forme HTTP/x.y o� x et y sont des entiers)

      function traiterRequete(uneRequete:Requete):Reponse;

      //Cr�e un objet Protocole qui traite les requ�tes HTTP
      //et fournit une r�ponse appropri�e selon l'�tat du serveur.
      //
      //@param unRepertoire le r�pertoire qui contient tous les sites web de notre serveur
      //@param unConsigneur sert � consigner des messages

      constructor create(unRepertoire:String;unConsigneur:Consigneur);

      //Accesseur du r�pertoire de base
      //
      //@return String retourne le r�pertoire de base

      function getRepertoire:String;

      //Mutateur du r�pertoire de base
      //
      //@param unRepertoire le r�pertoire de base

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
