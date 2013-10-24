unit uniteProtocole;

//La classe protocole prend une requete, vérifie que la page demandée existe(404),
//que la méthode utilisée est la bonne (501) et que le protocole est compatible (505)
//Retourne le code et le message approprié à l'utilisateur.
interface


uses
uniteReponse, uniteRequete;

type
  Protocole = class

    //La methode traiterRequete analyse la requete et renvoie le code approprié au fureteur.

    //Elle  reçoit la requete envoyée par le fureteur en paramètre et retourne un objet de type Reponse.

    //@param uneRequete Reçoit la requête de l'utilisateur
    //@return Reponse  Traite la requête et retourne une réponse (Code d'erreur + message)
    function traiterRequete(uneRequete:Requete):Reponse;

  end;


implementation

//Le protocole sert a transformer une requete en reponse
//@function
function Protocole.traiterRequete;

begin

  //La fonction prend et affiche l'ensemble des éléments contenus dans

  //l'élément passé en paramètre, incluant la date de réception, et les affiche.}
  write('[', formatDateTimeune('c',Requete.dateReception), ']',' ', uneRequete.adresseDemandeur,' ', uneRequete.methode,' ', uneRequete.url,' ', uneRequete.versionProtocole);
  
  //Création de l'objet réponse qui sera retourné.
  uneReponse:=Reponse.create;

  //Attribution des valeurs de l'adresse du demandeur et
  //de la version du protocole de l'objet requête à l'objet réponse.}
  uneReponse.adresseDemandeur:=uneRequete.adresseDemandeur;
  uneReponse.versionDemandeur:='HTTP/1.1';

  //Attribution d'un code de réponse à l'attribut codeReponse de l'objet
  //uneReponse le 404 est pour un URL inexistant, de moindre priorité
  //que les suivants.
  uneReponse.codeReponse:= 404;

  //Les messages de réponse sont attribués ici à leurs attributs respectifs
  uneReponse.message:=('URL introuvable');
  uneReponse.reponseHTML:=('L’URL n’existe pas sur le serveur, veuillez vérifier l’orthographe et réessayer');

  {Vérification de la méthode envoyée au serveur. Si elle est autre que GET, changement du message d'erreur retourné pour le 501.

  Si le code d'erreur est modifié, les messages correspondants sont également modifiés pour le refléter.

  Le code d'erreur 501 est de priotité plus élevée que le 404 quant au retour par notre serveur. }
  if (uneRequete.methode<>'GET') and (uneRequete.methode<>'gET') and (uneRequete.methode<>'GeT') and (uneRequete.methode<>'GEt') and (uneRequete.methode<>'geT') and (uneRequete.methode<>'Get') and (uneRequete.methode<>'gEt') and (uneRequete.methode<>'get') then
  begin
    uneReponse.codeReponse:=501;
    uneReponse.message:=('Méthode incompatible');
    uneReponse.reponseHTML:=('La méthode '+uneRequete.methode+' n''est pas compatible');
  end;

  {Vérification de la version du protocole. Si celle-ci n'est pas égale

  à 1.0 ou 1.1, changement du message d'erreur pour 505.

  Si le code d'erreur est modifié de la sorte, les messages d'erreur

  correspondants sont également modifiés pour le refléter.

  Le code d'erreur 505 est de priorité plus élevée que le 501 pour notre serveur,

  d'où son assignation en dernier dans le protocole. }
  if (uneRequete.versionProtocole <> 'HTTP/1.0') and (uneRequete.versionProtocole <> 'HTTP/1.1') then
  begin
    uneReponse.codeReponse:= 505;
    uneReponse.message:=('Version HTTP non supportée');
    uneReponse.reponseHtml:=('Protocole '+uneRequete.Version+' incompatble avec le serveur');
  end;

  {Le protocole affiche la date de réception de la demande, l'adresse du demandeur,

  maintenant passée en attributs à uneReponse

  le codeReponse ainsi que le message déterminés par la fonction traiterRequete}
  write('[', FormatDateTime('c', Now),']',' ', uneReponse.adresseDemandeur,' ', uneReponse.codeReponse,' ', uneReponse.message);

  //Le résultat retourné est un objet de type Réponse.
  result:=uneReponse;
end.
