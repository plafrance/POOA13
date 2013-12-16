unit uniteProtocole;

interface

uses
   SysUtils, uniteReponse, uniteRequete, uniteConsigneur, uniteLecteurFichier, uniteLecteurFichierBinaire, uniteLecteurFichierTexte;

//Traite les requêtes HTTP et fournit une réponse appropriée selon l'état du serveur
type
   Protocole = class
   private
      //Le répertoire local qui contient tous les sites web de notre serveur
      repertoireDeBase:String;

      //Un consigneur permettant de consigner tous les messages
      leConsigneur:Consigneur;

      //LecteurFichier que l'on pourra Transtyper
      unLecteurFichier:LecteurFichier;

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
   unFichier:Textfile;
   uneLigne:String;
begin

   //write('[', formatDateTime('c',uneRequete.getDateReception), ']',' ', uneRequete.getAdresseDemandeur,' ', uneRequete.getMethode,' ', uneRequete.getUrl,' ', uneRequete.getVersionProtocole);

   leConsigneur.consigner('ProtocoleHTTP', uneRequete.getAdresseDemandeur+'-'+uneRequete.getMethode+' ( '+uneRequete.getVersionProtocole+' )');

   //Initialisation des données pour l'objet Reponse qui retourne une erreur pour le moment.

   uneAdresseDemandeur:=uneRequete.getAdresseDemandeur;
   uneVersionProtocole:='HTTP/1.1';

   //Vérification de la méthode
   //Reception de la requete
   if fileExists(repertoireDeBase+uneRequete.getUrl)then
   begin
    unCodeReponse:=200;
    unMessage:='OK';
    if (upCase(extractFileExt(repertoireDeBase+uneRequete.getUrl)) = '.HTML')
    or (upCase(extractFileExt(repertoireDeBase+uneRequete.getUrl)) = '.XML') then
      unLecteurFichier:=lecteurFichierTexte.create
    else
      unLecteurFichier:=lecteurFichierBinaire.create;
    try
      if unLecteurFichier is lecteurFichierTexte then
        ReponseHtml:=unLecteurFichier.getEntete+#13+#13+lecteurFichierTexte(unLecteurFichier).lireContenu;
      if unLecteurFichier is lecteurFichierTexte then
        ReponseHtml:=unLecteurFichier.getEntete+#13+#13+lecteurFichierBinaire(unLecteurFichier).lireContenu;
    except on e:Exception do
      begin
        unCodeReponse:=500;
        unMessage:='erreur interne du serveur';
        leConsigneur.consignerErreur('unProtocoleHTTP','impossible de lire la page demandée');
      end;
    end;
   unLecteurFichier.destroy;
   end
   else
   begin
    unCodeReponse:=404;
    unMessage:='URL introuvable';
    uneReponseHTML:='L''URL ('+uneRequete.getUrl+') n''existe pas sur le serveur, veuillez verifier l''orthographe et reessayer';
   end;

   if (uneRequete.getMethode<>uppercase('GET')) then
   begin
      unCodeReponse:=501;
      unMessage:='Methode non implémentée';
      uneReponseHTML:=('La methode '+uneRequete.getMethode+' n''est pas implémentée');
   end;

   //Utilisation d'un subString pour vérifier HTTP/ seulement

   stringTemporaire:=copy(uneRequete.getVersionProtocole,1,5);

   //Vérification de x.y c'est à dire la 6e et 8e lettre du String pour qu'il soit bien entre 0 et 9
   //Sinon, lève une exception

   if  (stringTemporaire <> 'HTTP/') or
          ((uneRequete.getVersionProtocole[6] < '0')) or
              ((uneRequete.getVersionProtocole[6] > '9')) or
          ((uneRequete.getVersionProtocole[8] < '0')) or
              ((uneRequete.getVersionProtocole[8] > '9')) or
          (uneRequete.getVersionProtocole[7] <> '.') or (length(uneRequete.getVersionProtocole) <> 8) then
   begin
      raise Exception.create('Version HTTP incompatible');
   end;

   //Vérifie le protocole HTTP

   if (uneRequete.getVersionProtocole <> 'HTTP/1.0') and (uneRequete.getVersionProtocole <> 'HTTP/1.1') then
   begin
      unCodeReponse:=505;
      unMessage:='Version HTTP' +uneRequete.getVersionProtocole +'non supportée';
      uneReponseHtml:=('Protocole '+uneRequete.getVersionProtocole+' incompatble avec le serveur');
   end;

   //Créer l'objet réponse avec tous les paramètres plus haut

   uneReponse:=Reponse.create(uneAdresseDemandeur,uneVersionProtocole,unCodeReponse,unMessage,uneReponseHtml);
   //Retourne l'objet réponse

   result:=uneReponse;

   //Case of pour ainsi consigner une seule fois dépendament de la variable unCodeReponse
   Case unCodeReponse of
   200:leConsigneur.consigner('ProtocoleHTTP', uneReponse.getAdresseDemandeur+' – 200 : '+uneReponse.getMessage);
   500:leConsigneur.consignerErreur('ProtocoleHTTP','impossible d''ouvrir la page demandée');
   501:leConsigneur.consigner('ProtocoleHTTP','La méthode '+uneRequete.getMethode+' n''est pas implémentée');
   505:leConsigneur.consigner('ProtocoleHTTP','Version HTTP'+uneRequete.getVersionProtocole+'incompatible avec le serveur');
   404:leConsigneur.consigner('ProtocoleHTTP',uneReponse.getAdresseDemandeur +' - 404 : '+uneReponse.getMessage);
   else leConsigneur.consignerErreur('ProtocoleHTTP','Erreur interne du serveur');
   end;
end;


constructor Protocole.create(unRepertoireDeBase:String;unConsigneur:Consigneur);
begin
   setRepertoireDeBase(unRepertoireDeBase);
   leConsigneur:=unConsigneur;
   //Verifie si le repertoire existe et affecte a la variable code le numero de code si le repertoire existe ou pas
   if not directoryExists(unRepertoireDeBase)then
    raise Exception.create('Repertoire de Base inexistant');

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
