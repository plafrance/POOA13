program Apatchee1;

{$APPTYPE CONSOLE}

uses
   SysUtils,
   uniteServeur in 'uniteServeur.pas';

uses

var
   numeroDuPort: Word;
   leServeur: Serveur;


begin
   // validation de la configuration
   // ParamCount retourne le nombre de paramètres passés au programme sur la ligne de commande.
   case paramCount of

      // Cas où l'utilisateur n'utilise pas l'option ( -p ou -P )
      0: numeroDuPort := 80;

      // Cas où l'utilisateur saisit seulement l'option ( -p ou -P )
      // ou toute autre caractère sans le numéro de port
      1: begin
            // ParamStr retourne le contenu d'une sous chaîne
            if ( paramStr(1) = '-p' ) or ( paramStr(1) = '-P' ) then
            begin
               writeln( 'Vous devez saisir un numéro de port dans l''intervalle [1, 65 535]' );
               halt;
            end

            else
            begin
               writeln( 'L''option ', paramStr(1), ' est inconnue.');
               halt;
            end;
         end;

      // Pour vérifier que l'utilisateur a configuré le serveur
      // avec l'option -p ou -P et avec un numéro de port compris entre [ 1 et 65 535 ]
      2: begin
            if ( paramStr(1) <> '-p' ) and ( paramStr(1) <> '-P' ) then
            begin
               writeln( 'L''option ', paramStr(1), ' est inconnue.');
               halt;
            end
            else
      // Désactive le contrôle des erreurs d'E/S pour la conversion
      {$I-}
      numeroDuPort := strToInt( paramStr(2) );
      controle := IOResult;
      if ( controle <> 0 ) or ( numeroDuPort < 1 ) or ( numeroDuPort > 65535 ) then
      begin
         writeln( 'Le numéro de port doit respecter l''intervalle [1, 65535]' );
         halt;
      end;
      // Active le contrôle des erreurs d'E/S
      {$I+}
               end;

   end; // Fin de case

   // Instanciation du serveur
   leServeur := Serveur.create;

   // L'initialisation du serveur sur un numéro de port
   leServeur.initialiser(numeroDuPort);

   // Démarrage du serveur
   leServeur.demarrer;
end.
