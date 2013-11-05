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
      //@param unRepertoireDeBase le répertoire qui contient tous les sites web de notre serveur
      //@param unConsigneur sert à consigner des messages

      constructor create(unRepertoireDeBase:String;unConsigneur:Consigneur);

      //Accesseur du répertoire de base
      //
      //@return String retourne le répertoire de base

      function getRepertoireDeBase:String;

      //Mutateur du répertoire de base
      //
      //@param unRepertoire le répertoire de base

      procedure setRepertoireDeBase(unRepertoireDeBase:String);

  end;


implementation

function Protocole.traiterRequete(uneRequete:Requete):Reponse;
var
  uneReponse:Reponse;
  uneAdresseDemandeur:String;
  uneVersionProtocole:String;
  unCodeReponse:Word;
  unMessage:String;
  uneReponseHtml:String;
  stringTemporaire:String;
begin

  //write('[', formatDateTime('c',uneRequete.getDateReception), ']',' ', uneRequete.getAdresseDemandeur,' ', uneRequete.getMethode,' ', uneRequete.getUrl,' ', uneRequete.getVersionProtocole);

  leConsigneur.consigner('ProtocoleHTTP', uneRequete.getAdresseDemandeur+'-'+uneRequete.getMethode+' ( '+uneRequete.getVersionProtocole+' )');

  //Initialisation des données pour l'objet Reponse qui retourne une erreur pour le moment.

  uneAdresseDemandeur:=uneRequete.getAdresseDemandeur;
  uneVersionProtocole:='HTTP/1.1';
  unCodeReponse:=404;
  unMessage:='L''URL introuvable';
  uneReponseHTML:='L''URL ('+uneRequete.getUrl+') n''existe pas sur le serveur, veuillez verifier l''orthographe et reessayer';

  //Vérification de la méthode

  if (uneRequete.getMethode<>uppercase('GET')) then
  begin
    unCodeReponse:=501;
    unMessage:='Methode incompatible';
    uneReponseHTML:=('La methode '+uneRequete.getMethode+' n''est pas compatible');
  end;

  //Utilisation d'un subString pour vérifier HTTP/ seulement
  
  stringTemporaire:=copy(uneRequete.getVersionProtocole,1,5);

  //Vérification de x.y c'est à dire la 6e et 8e lettre du String pour qu'il soit bien entre 0 et 9
  //Sinon, lève une exception

  if  (stringTemporaire = 'HTTP/') and
      ((strToInt(uneRequete.getVersionProtocole[6]) >= 0) and
      (strToInt(uneRequete.getVersionProtocole[6]) <= 9)) and
      ((strToInt(uneRequete.getVersionProtocole[8]) >= 0) and
      (strToInt(uneRequete.getVersionProtocole[8]) <=9)) and
      (uneRequete.getVersionProtocole[7] = '.') and (length(uneRequete.getVersionProtocole) < 9) then
  else
    raise Exception.create('Requete HTTP invalide');

  //Vérifie le protocole HTTP

  if (uneRequete.getVersionProtocole <> 'HTTP/1.0') and (uneRequete.getVersionProtocole <> 'HTTP/1.1') then
  begin
    unCodeReponse:=505;
    unMessage:='Version HTTP non supportee';
    uneReponseHtml:=('Protocole '+uneRequete.getVersionProtocole+' incompatble avec le serveur');
  end;

  //Créer l'objet réponse avec tous les paramètres plus haut

  uneReponse:=Reponse.create(uneAdresseDemandeur,uneVersionProtocole,unCodeReponse,unMessage,uneReponseHtml);

  //Retourne l'objet réponse

  result:=uneReponse;

  //Utilise la méthode consignerErreur du consigneur

  leConsigneur.consignerErreur('ProtocoleHTTP', uneReponseHtml);
end;

constructor Protocole.create(unRepertoireDeBase:String;unConsigneur:Consigneur);
begin
  setRepertoireDeBase(unRepertoireDeBase);
  leConsigneur:=unConsigneur;
end;

function Protocole.getRepertoireDeBase:String;
begin
  result:=repertoireDeBase;
end;

procedure Protocole.setRepertoireDeBase(unRepertoireDeBase:String);
begin
  repertoireDeBase:=unRepertoireDeBase;
end;

end.
