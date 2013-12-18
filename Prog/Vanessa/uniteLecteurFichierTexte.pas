// Cette unit� sert pour la lecture d'un fichier texte. Il permet de retourner
// le type MIME ainsi que le contenu d'un fichier.
unit uniteLecteurFichierTexte;

interface
    // Utilisation de la superclasse pour cr�er cette sous-classe.
    uses SysUtils, uniteLecteurFichier;

type
  // Nom de la classe. H�rite de la classe LecteurFichier.
  LecteurFichierTexte = class ( LecteurFichier )

   public
       // Cette fonction retourne le type MIME d'un fichier de type texte.
      // @return une cha�ne de caract�res repr�sentant le type MIME.
      function getType : String; override;

      // Cette fonction retourne le contenu d'un fichier texte
      // @return une cha�ne de caract�res du contenu d'un fichier texte.
      function lireContenu : WideString;

end;

implementation

   function LecteurFichierTexte.getType : String;
   begin
     // Retourne au programme appelant le type MIME d'un fichier apr�s
     // l'extraction de l'extension d'un chemin d'acc�s.
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
                 // C'est un fichier de type inconnu. La valeur par d�faut est
                 // retourn�e.
                 result := getType;
               end;
   end;

   function LecteurFichierTexte.lireContenu : WideString;

   var
      // Contenu textuel lu � partir du fichier.
      contenuFichier : WideString;

      // Sert pour la manipulation d'un fichier texte comme l'ouverture et
      // la lecture.
      fichierTexte : TextFile;

      // Conserve une ligne de texte lue dans le fichier.
      ligneTexte : String;

   begin
     // Le contenu est blanc est d�part puisque cette variable sert pour la
     // concat�nation d'une cha�ne de caract�res.
     contenuFichier := '';

     // Lien entre la variable de type fichier et le chemin d'acc�s sur le disque.
     assignFile( fichierTexte, chemin );

      // Contr�le de l'entr�e/sortie lors de l'ouverture du fichier en lecture.
     {$i-}
      reset( fichierTexte );
     {$i+}

     // Si le fichier ne s'est pas ouvert, une exception est lanc�e.
     if IOresult <> 0 then
        raise Exception.create( 'Erreur Entr�e / Sortie' );

     // Tant que ce n'est pas la fin du fichier, une ligne est lue dans le fichier.
     while not eof( fichierTexte ) do
     begin
       // Lecture d' une ligne dans le fichier.
       readln( fichierTexte, ligneTexte );

       // Concat�nation entre l'ancien contenu de la variable contenuFichier, de
       // la ligne lue dans le fichier et le caract�re Entr�e.
       contenuFichier := contenuFichier + ligneTexte + #13#10;
     end;

     // Fermeture du fichier.
     close( fichierTexte );

     // Retourne le contenu du fichier texte au programme appelant.
     result := contenuFichier;
   end;
end.
