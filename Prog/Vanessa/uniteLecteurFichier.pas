// Cette unit� sert � effectuer la lecture d'un fichier de n'importe quel format
// afin de lire sa taille en octets, son type MIME et son contenu. De plus, il
// construit un en-t�te contenant des informations sur le fichier.
unit uniteLecteurFichier;

interface

    uses SysUtils;

type
   // Nom de la classe.
   LecteurFichier = class

   protected

      chemin : String; // Conserve le chemin d'acc�s d'un fichier.

   private
      // Cette fonction priv�e retourne la taille d'un fichier.
      // fileName : Cha�ne de caract�res repr�sentant une cha�ne de caract�res.
      // Retourne une valeur enti�re de 64 bits.
      function fileSize( fileName : String) : Int64;

   public
      // Ce constructeur sert pour la construction d'un lecteur de fichier.
      //@param : Chemin: c'est le chemin d'acc�s au fichier.
      constructor create( unChemin : String );

      // Cette fonction permet de retourner la taille d'un fichier en 64 bits.
      //@return une valeur enti�re de 64 bits repr�sentant la taille d'un fichier.
      function getTaille : Int64;

      // Cette fonction retourne le type MIME d'un fichier de n'importe quel type.
      //@return une cha�ne de caract�res repr�sentant le type MIME.
      function getType : String; virtual;

      // Cette fonction retourne une en-t�te repr�sentant des informations sur le fichier.
      //@return une cha�ne de caract�res repr�sentant des informations sur le fichier.
      function getEntete : String;

      // Cette fonction retourne le contenu d'un fichier. Elle n'est pas d�finie
      // dans cette classe mais elle doit �tre d�finie dans les sous-classes de
      // celle-ci.
      //@return une cha�ne de caract�res du contenu d'un fichier.
      function lireContenu : WideString; virtual; abstract;

end;

implementation

   constructor LecteurFichier.create( unChemin : String );
   begin
       // Chemin d'acc�s au fichier.
       chemin := unChemin;
   end;

   function LecteurFichier.fileSize( fileName : String ) : Int64;
      var
         // R�sultat d'une recherche sur le disque.
         sr : TSearchRec;
      begin
         // Trouve la premi�re occurence correspondant � la requ�te demand�e.
         // Cette fonction prend en param�tres le nom d'un fichier, un attribut et
         // une variable pour le r�sultat de la recherche. faAnyFile signifie que
         // c'est n'importe quel fichier. La fonction retourne 0 si le fichier
         // est trouv�e.
         if FindFirst( fileName, faAnyFile, sr ) = 0 then

            // retourne le r�sultat de la taille du ficher.
            result := Int64( sr.FindData.nFileSizeHigh ) shl Int64(32) + Int64( sr.FindData.nFileSizeLow )
      else
      begin
         // Le fichier n'a pas �t� trouv�.
         result := -1;

         // Fermeture de la recherche sur le disque.
         FindClose( sr ) ;
      end;

   end;

   function LecteurFichier.getTaille : Int64;
   begin
     // Le fichier n'a pas �t� trouv�. Une exception est lanc�e.
     if fileSize( chemin ) = -1 then
        raise Exception.create( 'Le fichier est inexistant' );

     // Le fichier a �t� trouv�e et la taille du fichier est retourn�e.
     result := fileSize( chemin );
   end;

   function LecteurFichier.getType : String;
   begin
     // La valeur par d�faut du type d'un fichier est application/octet.stream;
     result := 'application/octet.stream';
   end;


   function LecteurFichier.getEntete : String;
   begin
     // Retourne un en-t�te contenant des informations dans un fichier.
     result := 'Accept-Ranges: bytes ' + #13#10 + 'Content-Length: ' +
                floatToStr( getTaille ) + #13#10 + 'Content-Type: ' + getType + #13#10 + #13#10;
   end;

end.
