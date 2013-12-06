unit uniteTestLecteurFichierBinaire;

interface

uses TestFrameWork, uniteClasse;

type
  TestLecteurFichierBinaire = class (TTestCase)
     published
     procedure testGetTypeJpg;
     procedure testGetTypeJpeg;
     procedure testGetTypeGif;
     procedure testGetTypeAutres;
     procedure testLireContenuInexistant;
     procedure testLireContenu;
  end;

implementation

    procedure TestLecteurFichierBinaire.testGetTypeJpg;
    var
      unFichierBinaire : LecteurFichierBinaire;
    begin
      unFichierBinaire := LecteurFichierBinaire.create('testLecteurFichierBinaire.jpg');

      check(unFichierBinaire.getType := 'image/jpeg');

      unFichierBinaire.destroy;
    end;

    procedure TestLecteurFichierBinaire.testGetTypeJpeg;
    var
      unFichierBinaire : LecteurFichierBinaire;
    begin
      unFichierBinaire := LecteurFichierBinaire.create('testLecteurFichierBinaire.jpeg');

      check(unFichierBinaire.getType := 'image/jpeg');

      unFichierBinaire.destroy;
    end;

    procedure testGetTypeGif;
    var
      unFichierBinaire : LecteurFichierBinaire;
    begin
      unFichierBinaire := LecteurFichierBinaire.create('testLecteurFichierBinaire.gif');

      check(unFichierBinaire.getType := 'image/gif');

      unFichierBinaire.destroy;
    end;

    procedure TestLecteurFichierBinaire.testGetTypeAutres;
    var
      unFichierBinaire : LecteurFichierBinaire;
    begin
      unFichierBinaire := LecteurFichierBinaire.create('testLecteurFichierBinaire.PFUDOR');

      check(unFichierBinaire.getType := 'application/octet-stream');

      unFichierBinaire.destroy;
    end;

    procedure TestLecteurFichierBinaire.testlireContenuInexistant;
    var
      unFichierBinaire : LecteurFichierBinaire;
    begin
      unFichierBinaire := LecteurFichierBinaire.create('inexistant.jpg');

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
      unFichierBinaire := LecteurFichierBinaire.create('testLecteurFichierBinaire.txt');

      check(unFichierBinaire.lireContenu := '12345678');

      unFichierBinaire.destroy;
    end;


initialization
  TestFrameWork.RegisterTest(TestClasse.Suite);
end.

