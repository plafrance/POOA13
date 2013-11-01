//Connexion V1.1
//
//Révision 2011/10/04
//Patrick Lafrance 2011/09/17

unit uniteConnexion;

interface

uses SysUtils, StrUtils, SocketUnit;

type

   //Connexion TCP client ou serveur à une adresse et un port quelconque
   //Permet de recevoir ou envoyer une ligne de texte à la fois.
   //Il est important de terminer chaque ligne par un retour de chariot (#13#10)
   Connexion = class
   public


      const
      //Raccourci pour le retour de chariot
      CRLF = chr(13) + chr(10);

      //Crée une connexion client vers le serveur spécifié par l'adresse et le port
      //
      //@param uneAdresse L'adresse du serveur distant
      //@param unPort Le port sur lequel se connecter sur le serveur
      //
      //@raises Exception si la connexion ne peut être établie
      constructor create( uneAdresse : String; unPort : Integer ); overload;

      //Crée un objet Connexion serveur qui écoutera sur le port spécifié
      //
      //@param unPort Le port local sur lequel écouter les connection entrantes
      constructor create( unPort : Integer ); overload;

      //Destructeur par défaut. Ferme toutes les connexions existantes.
      destructor destroy;

      //Donne l'adresse de l'hôte distant lorsque connecté. Chaîne vide si la connexion
      //n'est pas établie
      //
      //@return L'adresse de l'hôte distant ou chaîne vide si la connexion n'est pas établie.
      function getAdresseDistante : String;

      //Lit une chaîne de caractère de l'ordinateur distant
      //
      //@param uneChaine La variable qui contiendra la chaîne reçue
      //
      //@raises Exception si la connexion ne permet pas de lire une chaîne
      procedure lireChaine (var uneChaine : String ); overload;

      //Lit une chaîne de caractère de l'ordinateur distant
      //
      //@return La chaîne reçue
      //
      //@raises Exception si la connexion ne permet pas de lire une chaîne
      function lireChaine : String; overload;

      //Envoie une chaîne de caractère à l'ordinateur distant
      //
      //@param uneChaine La chaîne à envoyer. Elle doit se terminer par un retour
      //de chariot (caractères 13 et 10)
      //
      //@raises Exception si la connexion ne permet pas d'écrire une chaîne
      procedure ecrireChaine ( uneChaine:String );

      //Ferme la connexion.
      //
      //@raises Exception si la connexion ne peut être refermée
      procedure fermerConnexion; virtual;

  protected

      //Adresse du serveur distant
      adresse : String;

      //Port utilisé par la connexion (autant serveur que client)
      port : Integer;

   private
      //Tampon pour recevoir les messages
      buffer : String;
      //Connexion client
      clientSocket : TClientSocket;
      //Connexion serveur
      serveurSocket: TServerSocket;

   end;

implementation

constructor Connexion.create( uneAdresse : String; unPort : Integer );
begin
   if (unPort<1) or (unPort>65535) then
      raise Exception.Create('Numéro de port invalide');

   port := unPort;
   adresse := uneAdresse;
   clientSocket:=TClientSocket.create;
   clientSocket.Connect(uneAdresse, unPort);
end;

constructor Connexion.create( unPort : Integer );
begin
   if (unPort<1) or (unPort>65535) then
      raise Exception.Create('Numéro de port invalide');

   port := unPort;
   serveurSocket:=TServerSocket.create;
   try
      serveurSocket.listen(unPort);
   except on e:Exception do
      raise Exception.Create('Impossible d''ouvrir le port '+intToStr(unPort)+'.');
   end;
end;

destructor Connexion.destroy;
begin
   serveurSocket.destroy;
   if not (clientSocket = nil) then clientSocket.destroy;
end;

function Connexion.getAdresseDistante : String;
begin
  result := '';
  if serveurSocket <> nil then
    result := clientSocket.RemoteAddress

end;

procedure Connexion.lireChaine( var uneChaine : String );
var
   longueur:Integer;
   errorCode : Integer;
begin
   //Si le buffer n'est pas vide, on doit d'abord le vider
   if (length(buffer) = 0) then
   begin
      //S'il n'y a pas de client connecté, attendre une connexion
      if (clientSocket=nil) then
        if(adresse<>'') then
          raise Exception.create('Connexion non établie')
        else
        begin
          clientSocket:=serveurSocket.accept;
        end;

      //Initialise le buffer
      setlength(buffer,0);
      repeat
         begin
            //Lit les données
            longueur := clientSocket.Receivelength;
            if longueur>0 then
               buffer:=buffer + clientSocket.ReceiveString
         end;
         //Jusqu'à la fin d'une ligne
//      until ansiRightStr( buffer, 2 ) = CRLF;
        until (length(buffer) > 0) and (longueur = 0);
   end;

   //Extrait la première ligne terminée par un retour de chariot du buffer
   uneChaine := buffer;
   if ansiPos( chr(13), buffer) > 0 then
   begin
      //S''il en reste, le conserve dans le buffer

      buffer := ansiMidStr( uneChaine, ansiPos( CRLF, uneChaine) + 2, length( uneChaine));
      uneChaine := AnsiLeftStr( uneChaine, ansiPos( CRLF, uneChaine)-1 );
   end
   else
      buffer := '';

end;

function Connexion.lireChaine : String;
var
  chaine : String;
begin
   lireChaine( chaine );
   result := chaine;
end;

procedure Connexion.ecrireChaine( uneChaine:String );
begin
   if clientSocket = nil then
      if adresse <> '' then
         raise Exception.create('Connexion non établie')
      else
      begin
         clientSocket:=TClientSocket.create;
         clientSocket.Connect(adresse, port);
      end;

   clientSocket.SendString(uneChaine);
end;

procedure Connexion.fermerConnexion;
begin
   if (clientSocket=nil) or (not clientSocket.Connected) then
      exit;

   clientSocket.Disconnect;
   clientSocket.destroy;
   clientSocket := nil;
   buffer := '';


end;
end.
