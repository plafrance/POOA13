// Cette unité sert à effectuer la lecture d'un fichier de n'importe quel format
// afin de lire sa taille en octets, son type MIME et son contenu. De plus, il
// construit un en-tête contenant des informations sur le fichier.
unit uniteLecteurFichier;

interface

    uses SysUtils;

type
   // Nom de la classe.
   LecteurFichier = class

   protected

      chemin : String; // Conserve le chemin d'accès d'un fichier.

   private
      // Cette fonction privée retourne la taille d'un fichier.
      // fileName : Chaîne de caractères représentant une chaîne de caractères.
      // Retourne une valeur entière de 64 bits.
      function fileSize( fileName : String) : Int64;

   public
      // Ce constructeur sert pour la construction d'un lecteur de fichier.
      //@param : Chemin: c'est le chemin d'accès au fichier.
      constructor create( unChemin : String );

      // Cette fonction permet de retourner la taille d'un fichier en 64 bits.
      //@return une valeur entière de 64 bits représentant la taille d'un fichier.
      function getTaille : Int64;

      // Cette fonction retourne le type MIME d'un fichier de n'importe quel type.
      //@return une chaîne de caractères représentant le type MIME.
      function getType : String; virtual;

      // Cette fonction retourne une en-tête représentant des informations sur le fichier.
      //@return une chaîne de caractères représentant des informations sur le fichier.
      function getEntete : String;

      // Cette fonction retourne le contenu d'un fichier. Elle n'est pas définie
      // dans cette classe mais elle doit être définie dans les sous-classes de
      // celle-ci.
      //@return une chaîne de caractères du contenu d'un fichier.
      function lireContenu : WideString; virtual; abstract;

end;

implementation

   constructor LecteurFichier.create( unChemin : String );
   begin
       // Chemin d'accès au fichier.
       chemin := unChemin;
   end;

   function LecteurFichier.fileSize( fileName : String ) : Int64;
      var
         // Résultat d'une recherche sur le disque.
         sr : TSearchRec;
      begin
         // Trouve la première occurence correspondant à la requête demandée.
         // Cette fonction prend en paramètres le nom d'un fichier, un attribut et
         // une variable pour le résultat de la recherche. faAnyFile signifie que
         // c'est n'importe quel fichier. La fonction retourne 0 si le fichier
         // est trouvée.
         if FindFirst( fileName, faAnyFile, sr ) = 0 then

            // retourne le résultat de la taille du ficher.
            result := Int64( sr.FindData.nFileSizeHigh ) shl Int64(32) + Int64( sr.FindData.nFileSizeLow )
      else
      begin
         // Le fichier n'a pas été trouvé.
         result := -1;

         // Fermeture de la recherche sur le disque.
         FindClose( sr ) ;
      end;

   end;

   function LecteurFichier.getTaille : Int64;
   begin
     // Le fichier n'a pas été trouvé. Une exception est lancée.
     if fileSize( chemin ) = -1 then
        raise Exception.create( 'Le fichier est inexistant' );

     // Le fichier a été trouvée et la taille du fichier est retournée.
     result := fileSize( chemin );
   end;

   function LecteurFichier.getType : String;
   begin
     // La valeur par défaut du type d'un fichier est application/octet.stream;
     result := 'application/octet.stream';
   end;


   function LecteurFichier.getEntete : String;
   begin
     // Retourne un en-tête contenant des informations dans un fichier.
     result := 'Accept-Ranges: bytes ' + #13#10 + 'Content-Length: ' +
                floatToStr( getTaille ) + #13#10 + 'Content-Type: ' + getType + #13#10 + #13#10;
   end;

end.
