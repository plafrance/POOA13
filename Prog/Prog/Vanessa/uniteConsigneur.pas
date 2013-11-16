unit uniteConsigneur;

interface

uses
  SysUtils;

const

  //journalSucces est fichier texte conservant le nom de fichier acces.log.
  journalSucess= 'acces.log';

  //journalErreur est fichier texte conservant le nom de fichier erreurs.log.
  journalErreur= 'erreurs.log';

type
  //Consigneur des messages ou des erreurs
  Consigneur = class
    private
      //repertoireJournaux repr�sentant le nom du r�pertoire dans lequel les journaux sont conserv�s.
      repertoireJournaux: String;

    public
      //creer l'objet consigneur
      //
      //@param unRepertoireJournaux o� se trouvent les fichiers journaux. Il est de type string.
      //
      constructor create( unRepertoireJournaux:String );

      //La procedure consigner re�oit un message � consigner et consigne un message de la forme�: date [origine]: messageConsigner.
      //
      //@param origine la partie du serveur d'o� origine la consignation de type string
      //@param messageConsigne le message de l'erreur � consigner de type string.
      //
      procedure consigner( origine: String; messageConsigne: String );

      //La proc�dure consignerErreur re�oit un message � consigner et consigne un message de la forme�: date[ERREUR � origine]: messageConsigner.
      //
      //@param origine est la partie du serveur d'o� origine la consignation de type string
      //@param messageConsigne est le message de l'erreur � consigner de type string
      //
      procedure consignerErreur( origine: String; messageConsigne: String );

      //La fonction getRepertoireJournaux sert � prendre repertoireJournaux et le retourne ensuite.
      //
      //@return le r�pertoire o� il y a les journaux sous la forme d'un string.
      //
      function getRepertoireJournaux:String;

      //Le destructeur ferme les fichiers qui ont �t� ouverts.
      destructor destroy;
  end;

implementation


constructor Consigneur.create( unRepertoireJournaux: String );
var
  //compteur de la boucle.
  compteur: Byte;
  //nomFichier est la variable qui va contenir le chemin d'acces des fichiers.
  nomFichier: String;
  //fichier est la variable qui contiendra le pointeur au fichier fournit par le SE.
  fichier:TextFile;
begin
  repertoireJournaux:= unRepertoireJournaux;

  compteur:= 1;

  nomFichier:= repertoireJournaux+journalSucess;

  while compteur <= 2 do
  begin
    assignFile( fichier, nomFichier );

    if not FileExists( repertoireJournaux + nomFichier  ) then
      begin
        try

          rewrite( fichier );

        except on e:Exception do
          raise exception.create( 'Incapable de cr�er le fichier ' + nomFichier + ' du r�pertoire ' + repertoireJournaux + '.' );
        end
      end
    else
      begin
        try

          append( fichier );

        except on e:Exception do
        begin
          raise exception.create( 'Incapable d''ouvrir le fichier ' + journalErreur + ' du r�pertoire ' + repertoireJournaux + '. Veuillez v�rifier le chemin d''acc�s et les permissions.' );
        end;
        end;
        compteur:= compteur + 1;

        nomFichier:= journalErreur;
      end;
  end;
end;

procedure Consigneur.consigner( origine: String; messageConsigne: String );
var
  uneLigne: String;
  fichier: TextFile;
  nomFichier: String;

begin
  try

    uneLigne:=formatDateTime( 'YYYY-MM-DD HH:MM:SS', now )+ '[' + origine + ']'+ messageConsigne;

    writeln( fichier, uneLigne );

  except on e: Exception do
  begin
    raise exception.create( 'Incapable d''ecrire dans le fichier ' + nomFichier + ' du r�pertoire ' + repertoireJournaux );
    exit;
  end;
  end;
end;

procedure Consigneur.consignerErreur( origine:String;messageConsigne:String );
   var
    uneLigne: String;
    nomFichier: String;
    fichier:TextFile;
  begin
    try

      uneLigne:=formatDateTime('YYYY-MM-DD HH:MM:SS',now)+ ' [Erreur - ' + origine + ']'+ messageConsigne;

      writeln( fichier, uneLigne );

    except on e: Exception do
    begin
      raise exception.Create('Incapable d''ecrire dans le fichier ' + nomFichier + ' du r�pertoire ' + repertoireJournaux );
      exit;
    end;
    end;
  end;

function Consigneur.getRepertoireJournaux:String;
begin
  result:=repertoireJournaux;
end;

destructor Consigneur.destroy;
var
  nomFichier: String;
  fichier:TextFile;
begin
  nomFichier:= journalSucess;
  try
    close( fichier );
  except on e:Exception do
  begin
    raise exception.create( 'Incapable de fermer le fichier' + nomFichier + 'du r�pertoire' + repertoireJournaux );
    exit;
  end;
  end;
  nomFichier:= journalErreur;
  try
    close( fichier );
  except on e:Exception do
  begin
    raise exception.create( 'Incapable de fermer le fichier' + nomFichier + 'du r�pertoire' + repertoireJournaux );
    exit;
  end;
  end;
end;

end.
