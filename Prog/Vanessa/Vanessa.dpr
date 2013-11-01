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

var
   numeroDuPort: Word;
   repertoireDeBase: String;
   mess:String;
   origine:String;
   leServeur: Serveur;
   leConsigneur:Consigneur;


begin
   // validation de la configuration
   // ParamCount retourne le nombre de paramètres passés au programme sur la ligne de commande.
   leConsigneur:=Consigneur.create;
   begin
   case paramCount of

      // Cas où l'utilisateur n'utilise pas l'option ( -p ou -P )
      0: begin
          numeroDuPort := 80;
          repertoireDeBase:='c:\htdocs';
          mess:='Le serveur est connecte au port par defaut (80)';
          origine:='';
         end;

      // Cas où l'utilisateur saisit seulement l'option ( -p ou -P )
      // ou toute autre caractère sans le numéro de port
      1: begin
            // ParamStr retourne le contenu d'une sous chaîne
          if uppercase(paramStr(1)) = '-P' then
          begin
            mess:='Vous devez saisir un numéro de port dans l''intervalle [1, 65 535]';
            origine:=''
          end;
          if paramStr(1) = '80' then
          begin
            numeroDuPort:=80;
            repertoireDeBase:='c:\htdocs';
            mess:='Le serveur est connecte au port par defaut (80)';
            origine:='';
          end;
          if uppercase(paramStr(1)) = '-W' then
          begin
            mess:='Chemin d''acces ou repertoire de base invalide.';
            origine:='';
          end;
          if uppercase(paramStr(1)) <> '-P' and uppercase(paramStr(1)) <> '-W' and paramStr(1) <> '80' then
          begin
            mess:='L''option ', paramStr(1), ' est inconnue.';
            origine:='';
          end;
         end;
      // Pour vérifier que l'utilisateur a configuré le serveur
      // avec l'option -p ou -P et avec un numéro de port compris entre [ 1 et 65 535 ]
      2: begin
          if uppercase(paramStr(1))='-P' and paramStr(2)='80' then
          begin
            numeroDuPort:=80;
            repertoireDeBase:='c:\htdocs';
            mess:='['+formatDateTime('c',now)+'] Le serveur est demarre sur le port '+numeroDuPort+'.';
            origine:='';
          end;
          if uppercase(paramStr(1))='-P' and (paramStr(2)<'1' or paramStr(2)>'65535') then
          begin
            mess:='Vous devez saisir un numéro de port dans l''intervalle [1, 65 535]';
            origine:='';
          end;
          if uppercase(paramStr(1))='-W' and fileExists(paramstr(2)) then
          begin
            numeroDuPort:=80;
            repertoireDeBase:=paramStr(2);
            mess:='['+formatDateTime('c',now)+'] Le serveur est demarre sur le port '+numeroDuPort+'.';
            origine:='';
          end;
          if uppercase(paramStr(1))='-W' and fileExists('c:\'+paramstr(2)) then
          begin
            numeroDuPort:=80;
            repertoireDeBase:=paramStr(2);
            mess:='['+formatDateTime('c',now)+'] Le serveur est demarre sur le port '+numeroDuPort+'.';
            origine:='';
          end;
          if uppercase(paramStr(1)) = '-W' and paramStr(2)='c:\' then
          begin
            mess:='Chemin d''acces ou repertoire de base invalide.';
            origine:='';
          end
         end;
      3:begin
          if uppercase(paramStr(1))='-W' and uppercase(paramStr(2))='-P' and ( paramStr(3)<'1' or paramStr(3)>'65535') then
          begin
            mess:='Chemin d''acces ou repertoire invalide';
            origine:='';
          end;
          if uppercase(paramStr(1))='-P' and uppercase(paramStr(3))='-W' and ( paramStr(2)<'1' or paramStr(2)>'65535') then
          begin
            mess:='Chemin d''acces ou repertoire invalide';
            origine:='';
          end;
        end;
      4:begin
        if uppercase(paramStr(1))='-P' and (paramStr(2)>='1' or paramStr(2)<='65535') and uppercase(paramStr(3))='-W' and fileExists(paramStr(4)) then
        begin
          numeroDuPort:=strToInt(paramStr(2));
          repertoireDeBase:=paramStr(4);
          mess:='['+formatDateTime('c',now)+'] Le serveur est demarre sur le port '+numeroDuPort+'.';
        end;
        if uppercase(paramStr(1))='-W' and fileExists(paramStr(2)) and uppercase(paramStr(3))='-P' and (paramStr(4)>='1' or paramStr(4)<='65535') then
        begin
          numeroDuPort:=strToInt(paramStr(4));
          repertoireDeBase:=paramStr(2);
          mess:='['+formatDateTime('c',now)+'] Le serveur est demarre sur le port '+numeroDuPort+'.';
        end;
        end;

   end; // Fin de case

   end;
   // Instanciation du serveur
   try
   leServeur := Serveur.create(numeroDuPort,leConsigneur,repertoireDeBase);
   except on e: Exception do
   leConsigneur.
   end;

   // L'initialisation du serveur sur un numéro de port
//   leServeur.initialiser(numeroDuPort);

   // Démarrage du serveur
   leServeur.demarrer;


end.
