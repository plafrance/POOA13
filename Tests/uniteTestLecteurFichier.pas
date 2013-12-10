unit uniteTestLecteurFichier;

interface

uses TestFrameWork, SysUtils, uniteLecteurFichier, uniteLecteurFichierTexte;

type
  TestLecteurFichier = class (TTestCase)
     published
     procedure testGetTailleBonneTaille;
     procedure testGetTailleFichierInexistant;
     procedure testGetEnteteConcatener;
  end;

implementation


    procedure TestLecteurFichier.testGetTailleBonneTaille;
    var lecteurFichierTest:LecteurFichier;
        taille:Int64;
    begin
      lecteurFichierTest:=LecteurFichier.create('FichierExistant.txt');
      taille:=lecteurFichierTest.getTaille;
      check(taille = 4302);
      LecteurFichierTest.destroy;
    end;

    procedure TestLecteurFichier.testGetTailleFichierInexistant;
    var lecteurFichierTest:LecteurFichier;
    begin
      lecteurFichierTest:=LecteurFichier.create('FichierInexistant.txt');
      try
        lecteurFichierTest.getTaille;
        fail('Une exception n''a pas été lancée');
      except on e : Exception do
        check(e.Message = 'Le fichier est inexistant');
      end;
        lecteurFichierTest.destroy;
    end;

    procedure TestLecteurFichier.testGetEnteteConcatener;
    var lecteurFichierTest:LecteurFichier;
        chaine:WideString;
    begin
      lecteurFichierTest:=LecteurFichier.create('FichierExistant.txt');
      checkEquals(
      'Accept-Ranges: bytes'+#13#10 +'Content-Length: 4302' +#13#10 + 'Content-Type: application/octet-stream'+#13#10 +#13#10,
      LecteurFichierTest.getEntete);
      lecteurFichierTest.destroy;
    end;


initialization
  TestFrameWork.RegisterTest(TestLecteurFichier.Suite);
end.
