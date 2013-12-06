unit uniteTestLecteurFichierBinaire;

interface

uses TestFrameWork, uniteClasse;

type
  TestLecteurFichierBinaire = class (TTestCase)
     published
     procedure testGetType;
     procedure testLireContenuInexistant;
     procedure testLireContenu;
  end;

implementation

    procedure TestLecteurFichierBinaire.testGetType;
    var
      unFichierBinaire : LecteurFichierBinaire;
    begin
      unFichierBinaire := LecteurFichierBinaire.create('C:\RepertoireTest\Test.jpg');

      check(unFichierBinaire.getType := 'image/jpeg');

      unFichierBinaire.destroy;

      unFichierBinaire := LecteurFichierBinaire.create('C:\RepertoireTest\Test.gif');

      check(unFichierBinaire.getType := 'image/gif');

      unFichierBinaire.destroy;

      unFichierBinaire := LecteurFichierBinaire.create('C:\RepertoireTest\Test.fdasoijfadsio');

      check(unFichierBinaire.getType := 'application/octet-stream');

      unFichierBinaire.destroy;
    end;

    procedure TestLecteurFichierBinaire.testlireContenuInexistant;
    var
      unFichierBinaire : LecteurFichierBinaire;
    begin
      unFichierBinaire := LecteurFichierBinaire.create('C:\RepertoireTest\inexistant.jpg');

      try
        unFichierBinaire.lireContenu;
        fail('Le fichier n''existe pas');
      except on e:Exception do
        Check(e.message= 'Erreur Entrée / Sortie');
      end;

      unFichierBinaire.destroy;
    end;
    
    procedure TestLecteurFichierBinaire.testlireContenu;
    var
      unFichierBinaire : LecteurFichierBinaire;
      fichier : TextFile;

    begin
      assignFile(fichier, 'C:\RepertoireTest\Test.txt');
      rewrite(fichier);
      writeln(fichier, '12345678');
      close(fichier);

      unFichierBinaire := LecteurFichierBinaire.create('C:\RepertoireTest\Test');

      check(unFichierBinaire.lireContenu := '12345678');

      unFichierBinaire.destroy;
    end;


initialization
  TestFrameWork.RegisterTest(TestClasse.Suite);
end.

