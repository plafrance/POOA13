// Cette unité sert pour la lecture d'un fichier texte. Il permet de retourner
// le type MIME ainsi que le contenu d'un fichier.
unit uniteLecteurFichierTexte;

interface
    // Utilisation de la superclasse pour créer cette sous-classe.
    uses SysUtils, uniteLecteurFichier;

type
  // Nom de la classe. Hérite de la classe LecteurFichier.
  LecteurFichierTexte = class ( LecteurFichier )

   public
       // Cette fonction retourne le type MIME d'un fichier de type texte.
      // @return une chaîne de caractères représentant le type MIME.
      function getType : String; override;

      // Cette fonction retourne le contenu d'un fichier texte
      // @return une chaîne de caractères du contenu d'un fichier texte.
      function lireContenu : WideString;

end;

implementation

   function LecteurFichierTexte.getType : String;
   begin
     // Retourne au programme appelant le type MIME d'un fichier après
     // l'extraction de l'extension d'un chemin d'accès.
     if ( extractFileExt( chemin ) = '.htm' ) then
        result := 'text/htm'
     else if ( extractFileExt( chemin ) = '.html' ) then
              result := 'text/html'
          else if ( extractFileExt( chemin ) = '.xml' ) then
                   result := 'text/xml'
               else if ( extractFileExt( chemin ) = '.txt' ) then
                   result := 'text/plain'
               else
               begin
                 // C'est un fichier de type inconnu. La valeur par défaut est
                 // retournée.
                 result := getType;
               end;
   end;

   function LecteurFichierTexte.lireContenu : WideString;

   var
      // Contenu textuel lu à partir du fichier.
      contenuFichier : WideString;

      // Sert pour la manipulation d'un fichier texte comme l'ouverture et
      // la lecture.
      fichierTexte : TextFile;

      // Conserve une ligne de texte lue dans le fichier.
      ligneTexte : String;

   begin
     // Le contenu est blanc est départ puisque cette variable sert pour la
     // concaténation d'une chaîne de caractères.
     contenuFichier := '';

     // Lien entre la variable de type fichier et le chemin d'accès sur le disque.
     assignFile( fichierTexte, chemin );

      // Contrôle de l'entrée/sortie lors de l'ouverture du fichier en lecture.
     {$i-}
      reset( fichierTexte );
     {$i+}

     // Si le fichier ne s'est pas ouvert, une exception est lancée.
     if IOresult <> 0 then
        raise Exception.create( 'Erreur Entrée / Sortie' );

     // Tant que ce n'est pas la fin du fichier, une ligne est lue dans le fichier.
     while not eof( fichierTexte ) do
     begin
       // Lecture d' une ligne dans le fichier.
       readln( fichierTexte, ligneTexte );

       // Concaténation entre l'ancien contenu de la variable contenuFichier, de
       // la ligne lue dans le fichier et le caractère Entrée.
       contenuFichier := contenuFichier + ligneTexte + #13#10;
     end;

     // Fermeture du fichier.
     close( fichierTexte );

     // Retourne le contenu du fichier texte au programme appelant.
     result := contenuFichier;
   end;
end.
