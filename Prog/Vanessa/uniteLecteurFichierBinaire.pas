unit uniteLecteurFichierBinaire;

interface

uses uniteLecteurFichier, sysUtils;

type

LecteurFichierBinaire = class (LecteurFichier)
   public

   //Accesseur du type MIME du fichier d�duit de l'extension du fichier.

   //@return type MIME du fichier.
   function getType : String; override;

   //Accesseur du contenu du fichier au format de cha�ne de caract�re long (le format, pas le caract�re). Retourne image/jpeg pour les .jpg/.jpeg, image/gif pour les .gif, et application/octet-stream pour tout autre type. 

   //@return le contenu du fichier lu sous sa forme brute (octets) et retourn� transpos� en cha�ne de caract�res.
   //@raises exception exception lev�e si il y a une erreur lors de la lecture du fichier (ouverture du fichier inclut)
   function lireContenu : Widestring; override;

end;

implementation
   function LecteurFichierBinaire.getType : String;
   begin
      if (AnsiUpperCase(extractFileExt(chemin)) = '.JPG')
      or (AnsiUpperCase(extractFileExt(chemin)) = '.JPEG') then
         result:= 'image/jpeg'
      else if (AnsiUpperCase(extractFileExt(chemin)) = '.GIF') then
         result:= 'image/gif'
      else
         inherited getType;
   end;

   function LecteurFichierBinaire.lireContenu : Widestring;
   var tableauCar : Array of Char;
       fichier : File;
       i : Integer;
   begin
      assignFile(fichier, chemin);
      setLength(tableauCar, getTaille);
      try
         reset(fichier);
         blockRead(fichier, tableauCar, 1);
         close(fichier);
      except on e : Exception do
         raise Exception.create('Probl�me lors de la lecture du fichier');
      end;
      result:='';
      for i:=0 to high(tableauCar) do
        result:=result+tableauCar[i];
   end;
end.
