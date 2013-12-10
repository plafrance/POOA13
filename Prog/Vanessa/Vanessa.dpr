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
  uniteConsigneur in 'uniteConsigneur.pas',
  uniteLecteurFichierTexte in 'uniteLecteurFichierTexte.pas',
  uniteLecteurFichier in 'uniteLecteurFichier.pas',
  uniteLecteurFichierBinaire in 'uniteLecteurFichierBinaire.pas';

const
   nomServeur = 'Vanessa';
var
   //Type de conversion est utilisé pour erreurPos
   typeConversion,numeroDuPort:Word;
   i:Byte;
   //erreurPos veut dire qu'il y a eu une exception(un erreur est survenu,ErreurPositive)
   errorPos:Integer;
   validePort,valideRepertoireDeBase,valideRepertoireJournaux: String;
   leServeur: Serveur;
   leConsigneur:Consigneur;
begin
   i:=1;
   //Port utilisé par défaut
   ValidePort:='80';
   //Repertoire de base utilisé par défaut
   validerepertoiredebase:='C:\htdocs';
   //Reperoire des fichiers log utilisé par défaut
   valideRepertoireJournaux:='C:\journaux';
   // Validation de la configuration.
   // ParamCount retourne le nombre de paramètres passés au programme sur la ligne de commande.

   //vérifie dans la ligne de commande si l'utilisateur ne veut pas utiliser un numéro de port peronnalisé
   while i<=paramCount do
   begin
      if paramStr(i)='-p' then
      begin
         validePort:=paramStr(i+1);
         inc(i);
      end
      //vérifie dans la ligne de commande si l'utilisateur ne veut pas utiliser un chemin peronnalisé pour le repertoire journaux
      else if paramStr(i)='-j' then
      begin
         valideRepertoireJournaux:= paramStr(i+1);
         inc(i);
      end
      //vérifie dans la ligne de commande si l'utilisateur ne veut pas utiliser un repertoire de base peronnalisé
      else if paramStr(i)='-w' then
      begin
         valideRepertoireDeBase:= paramStr(i+1);
         inc(i);
      end
      else
      begin
         writeln(nomServeur+'Erreur sur les paramètres d''entrées, serveur non démarré');
         halt;
      end;
      inc(i);
   end;

    //Validation de l'existence des fichiers journaux.
    if not directoryExists (valideRepertoireJournaux) then

    begin
      writeln('le répertoire des fichiers journaux est invalide ');
      halt;
    end;

   //Instanciation de l'objet consigneur le plus tot possible,consigne les erreurs et les connexion du serveur.
   leConsigneur:=Consigneur.create(valideRepertoireJournaux+'\');

   //Validation d'un entier.
   val(validePort,typeConversion,errorPos);
   //si il n'y a pas d'Erreur erreurPos est en quelque sorte un boolean, et 0 veut dire qu'il n'y a pas d'Erreur , autre(qui ne peut que etre 1) veut dire qu'il y a une erreur.
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
         writeln('Le numéro de port est invalide');
         halt;
      end;
      numeroDuPort:=strToInt(validePort);
   end;


   //Validation de l'existence du répertoire.
   if not directoryExists(validerepertoiredebase) then
   begin
      leConsigneur.consignerErreur(nomServeur,'Erreur, répertoire non existant');
      writeln('Le répertoire source est invalide ou inexistant');
      halt;
   end;

   try
      // Instanciation du serveur
      // L'initialisation du serveur sur un numéro de port et un répertoire de base.
      leServeur := Serveur.create(numeroDuPort,leConsigneur,validerepertoiredebase+'\');
   except on e: Exception do
   begin
      //Consigne l'erreur et le concatène avec le message d'erreur de l'objet Exception.
      leConsigneur.consignerErreur(nomServeur,' Erreur d''entrée/sortie ' + e.Message);
      halt;
   end;
   end;

   //On instancie le serveur 
   leServeur.demarrer;



end.
