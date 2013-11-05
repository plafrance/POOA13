program Vanessa;

{$APPTYPE CONSOLE}



uses
  SysUtils,
  uniteServeur in 'uniteServeur.pas',
  uniteRequete in 'uniteRequete.pas',
  uniteProtocole in 'uniteProtocole.pas',
  uniteReponse in 'uniteReponse.pas',
  uniteConnexion in 'uniteConnexion.pas',
  uniteConnexionHTTPServeur in 'uniteConnexionHTTPServeur.pas',
  SocketUnit in 'SocketUnit.pas',
  uniteConsigneur in 'uniteConsigneur.pas';

const
   nomServeur = 'Vanessa';
var
   entierWord,numeroDuPort:Word;
   i:Byte;
   errorPos:Integer;
   validePort,valideRepertoire: String;
   leServeur: Serveur;
   leConsigneur:Consigneur;
begin
    leServeur := nil;
    i:=1;
    entierWord:=0;
    ValidePort:='80';
    numeroDuPort:=80;
    valideRepertoire:='c:/htdocs';
    //Instanciation de l'objet consigneur qui consigne les erreurs et les connexion du serveur.
    leConsigneur:=Consigneur.create;
   // Validation de la configuration.
   // ParamCount retourne le nombre de paramètres passés au programme sur la ligne de commande.
    while i<=paramCount do
    begin
      if paramStr(i)='-p' then
      begin
        validePort:=paramStr(i+1);
        inc(i);
      end
      else if paramStr(i)='-w' then
      begin
        valideRepertoire:= paramStr(i+1);
        inc(i);
      end
      else
      begin
        leConsigneur.consignerErreur(nomServeur,'Erreur sur les paramètres d''entrées, serveur non démarré');
        halt;
      end;
      inc(i);
    end;
   //Validation d'un entier.
    val(validePort,entierWord,errorPos);
    if (errorPos<>0) then
    begin
      leConsigneur.consignerErreur(nomServeur,'Erreur sur le type du numero de port');
      halt;
    end
    else
    begin
    //Validation de l'intervalle.
      if (strToInt(validePort)<1) or (strToInt(validePort)>65535)then
      begin
        leConsigneur.consignerErreur(nomServeur,'Erreur, numéro de port hors intervalle');
        halt;
      end;
    numeroDuPort:=strToInt(validePort);
    end;
    //Validation de l'existence du répertoire.
    if not directoryExists(valideRepertoire) then
    begin
      leConsigneur.consignerErreur(nomServeur,'Erreur, répertoire non existant');
      halt;
    end;
    try
    // Instanciation du serveur
    // L'initialisation du serveur sur un numéro de port et un répertoire de base.
    leServeur := Serveur.create(numeroDuPort,leConsigneur,valideRepertoire);
    except on e: Exception do
      begin
        //Consigne l'erreur et le concatène avec le message d'erreur de l'objet Exception.
        leConsigneur.consignerErreur(nomServeur,' Erreur d''entrée/sortie ' + e.Message);
        halt;
      end;
    end;

   leServeur.demarrer;

   readln;


end.
