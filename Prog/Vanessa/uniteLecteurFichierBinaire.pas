unit uniteLecteurFichierBinaire;

interface

uses uniteLecteurFichier, sysUtils, System;

type

LecteurFichierBinaire = class (LecteurFichier)
   public

   //Accesseur du type MIME du fichier déduit de l'extension du fichier.

   //@return type MIME du fichier.
   function getType(chemin:String) : String; override;

   //Accesseur du contenu du fichier au format de chaîne de caractère long (le format, pas le caractère). Retourne image/jpeg pour les .jpg/.jpeg, image/gif pour les .gif, et application/octet-stream pour tout autre type. 

   //@return le contenu du fichier lu sous sa forme brute (octets) et retourné transposé en chaîne de caractères.
   function lireContenu(chemin:String) : Widestring; override;

end;

implementation
   function LecteurFichierBinaire.getType(chemin:String) : String;
   begin
      if (upCase(extractFileExt(chemin)) = '.JPG')
      or (upCase(extractFileExt(chemin)) = '.JPEG') then
         result:= 'image/jpeg'
      else if (upCase(extractFileExt(chemin)) = '.GIF') then
         result:= 'image/gif'
      else
         inherited getType;
   end;

   function LecteurFichierBinaire.lireContenu(chemin:String) : Widestring;
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
         raise Exception.Create('Problème lors de la lecture du fichier');
      end;
      result:='';
      for i:=0 to high(tableauCar) do
        result:=result+tableauCar[i];
   end;
end.
