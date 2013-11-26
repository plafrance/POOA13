unit uniteConsigneur;

interface

uses
  SysUtils;

const

  //journalSucces est fichier texte conservant le nom de fichier acces.log.
  journalSucces= 'acces.log';

  //journalErreur est fichier texte conservant le nom de fichier erreurs.log.
  journalErreur= 'erreurs.log';

type
  //Consigneur des messages ou des erreurs
  Consigneur = class
    private
      //repertoireJournaux représentant le nom du répertoire dans lequel les journaux sont conservés.
      repertoireJournaux: String;

      fichierAcces: TextFile;
      fichierErreur: TextFile;

      procedure ouvertureFichier( nomFichier: String; var fichier: TextFile );

    public
      //creer l'objet consigneur
      //
      //@param unRepertoireJournaux où se trouvent les fichiers journaux. Il est de type string.
      //
      constructor create( unRepertoireJournaux:String );

      //La procedure consigner reçoit un message à consigner et consigne un message de la forme : date [origine]: messageConsigner.
      //
      //@param origine la partie du serveur d'où origine la consignation de type string
      //@param messageConsigne le message de l'erreur à consigner de type string.
      //
      procedure consigner( origine: String; messageConsigne: String ); virtual;

      //La procédure consignerErreur reçoit un message à consigner et consigne un message de la forme : date[ERREUR – origine]: messageConsigner.
      //
      //@param origine est la partie du serveur d'où origine la consignation de type string
      //@param messageConsigne est le message de l'erreur à consigner de type string
      //
      procedure consignerErreur( origine: String; messageConsigne: String ); virtual;

      //La fonction getRepertoireJournaux sert à prendre repertoireJournaux et le retourne ensuite.
      //
      //@return le répertoire où il y a les journaux sous la forme d'un string.
      //
      function getRepertoireJournaux:String;

      //Le destructeur ferme les fichiers qui ont été ouverts.
      destructor destroy;
  end;

implementation


constructor Consigneur.create( unRepertoireJournaux: String );
begin
  repertoireJournaux:= unRepertoireJournaux;
  ouvertureFichier( journalSucces, fichierAcces );
  ouvertureFichier( journalErreur, fichierErreur );
end;

procedure Consigneur.ouvertureFichier( nomFichier: String; var fichier: TextFile );
begin
  assignFile( fichier, repertoireJournaux + nomFichier );

  if FileExists( repertoireJournaux + nomFichier  ) then
    begin
      try

        append( fichier );

      except on e:Exception do
      begin
        raise exception.create( 'Incapable d''ouvrir le fichier ' + nomFichier + ' du répertoire ' + repertoireJournaux + '. Veuillez vérifier le chemin d''accès et les permissions.' );
      end;
      end;
    end
  else
    begin
      try

        rewrite( fichier );

      except on e:Exception do
        raise exception.create( 'Incapable de créer le fichier ' + nomFichier + ' du répertoire ' + repertoireJournaux + '.' );
      end;
    end;
end;

procedure Consigneur.consigner( origine: String; messageConsigne: String );
var
  uneLigne: String;
  nomFichier: String;
begin
  try

    uneLigne:=formatDateTime( 'YYYY-MM-DD HH:MM:SS', now ) + ' [' + origine + '] ' + messageConsigne;

    writeln( fichierAcces, uneLigne );
    flush(fichierAcces);

  except on e: Exception do
  begin
    raise exception.create( 'Incapable d''ecrire dans le fichier ' + nomFichier + ' du répertoire ' + repertoireJournaux );
    exit;
  end;
  end;
end;

procedure Consigneur.consignerErreur( origine:String;messageConsigne:String );
   var
    uneLigne: String;
    nomFichier: String;
  begin
    try

      uneLigne:=formatDateTime('YYYY-MM-DD HH:MM:SS',now) + ' [ERREUR - ' + origine + '] ' + messageConsigne;

      writeln( fichierErreur, uneLigne );
      flush(fichierErreur);

    except on e: Exception do
    begin
      raise exception.Create('Incapable d''ecrire dans le fichier ' + nomFichier + ' du répertoire ' + repertoireJournaux );
      exit;
    end;
    end;
  end;

function Consigneur.getRepertoireJournaux:String;
begin
  result:=repertoireJournaux;
end;

destructor Consigneur.destroy;
begin
  try
    close( fichierAcces );
  except on e:Exception do
  begin
    raise exception.create( 'Incapable de fermer le fichier' + journalSucces + 'du répertoire' + repertoireJournaux );
    exit;
  end;
  end;
  try
    close( fichierErreur );
  except on e:Exception do
  begin
    raise exception.create( 'Incapable de fermer le fichier' + journalErreur + 'du répertoire' + repertoireJournaux );
    exit;
  end;
  end;
end;

end.
