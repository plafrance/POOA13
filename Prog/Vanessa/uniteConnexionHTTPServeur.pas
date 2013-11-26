//Connexion V1.1
//
//Patrick Lafrance 2012/10/03

unit uniteConnexionHTTPServeur;

interface

uses StrUtils, SysUtils, DateUtils, uniteConnexion, uniteRequete, uniteReponse;

type

   ConnexionHttpServeur = class(Connexion)
   private
      requeteRecue : Requete;
   public
      //Lit une requ�te d'un ordinateur distant
      //
      //@return Un objet Requete qui contiendra la requete re�ue
      //
      //@raises Exception si la connexion ne permet pas de lire une cha�ne
      function lireRequete : Requete ;

      //Envoie une r�ponse � l'ordinateur distant
      //
      //@param uneReponse La un objet Reponse � renvoyer.
      //
      //@raises Exception si la connexion ne permet pas d'�crire une cha�ne
      procedure ecrireReponse ( uneReponse : Reponse );

   end;

implementation
function ConnexionHttpServeur.lireRequete : Requete;
var
   chaine : String;
begin
   lireChaine( chaine );

   requeteRecue := Requete.Create (getAdresseDistante,
                                    date,
                                    ansiRightStr( chaine, 8),
                                    ansiLeftStr( chaine, ansiPos( ' ', chaine)-1 ),
                                    ansiMidStr( chaine, ansiPos( ' ', chaine)+1, ansiPos( ' HTTP', chaine) - ansiPos( ' ', chaine)-1),
                                  );

   result := requeteRecue;

end;

procedure ConnexionHttpServeur.ecrireReponse( uneReponse : Reponse );
begin

   ecrireChaine( 'HTTP/1.1 ' + intToStr(uneReponse.getCodeReponse) + ' ' + uneReponse.getMessage + CRLF + CRLF + uneReponse.getReponseHtml + CRLF);

end;

end.
