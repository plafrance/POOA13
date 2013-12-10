unit uniteTestLecteurFichierTexte;

interface

uses TestFrameWork, SysUtils, uniteLecteurFichierTexte, uniteLecteurFichier;

type
  TestLecteurFichierTexte = class (TTestCase)
     published
     procedure testGetTypeBonneExtensionHTM;
     procedure testGetTypeBonneExtensionHTML;
     procedure testGetTypeBonneExtensionXML;
     procedure testGetTypeBonneExtensionPLAIN;
     procedure testLireContenuJusquaFinDeFichier;
     procedure testLireContenuFichierNOuvrePas;
  end;

implementation

    procedure TestLecteurFichierTexte.testGetTypeBonneExtensionHTM;
    var lecteurFichierTexteTest:LecteurFichierTexte;
    begin
      lecteurFichierTexteTest:=LecteurFichierTexte.create('fichier.htm');
      check(lecteurFichierTexteTest.getType = 'text/htm');
      lecteurFichierTexteTest.destroy;
    end;

    procedure TestLecteurFichierTexte.testGetTypeBonneExtensionHTML;
    var lecteurFichierTexteTest:LecteurFichierTexte;
    begin
      lecteurFichierTexteTest:=LecteurFichierTexte.create('fichier.html');
      check(lecteurFichierTexteTest.getType = 'text/html');
      lecteurFichierTexteTest.destroy;
    end;

    procedure TestLecteurFichierTexte.testGetTypeBonneExtensionXML;
    var lecteurFichierTexteTest:LecteurFichierTexte;
    begin
      lecteurFichierTexteTest:=LecteurFichierTexte.create('fichier.xml');
      check(lecteurFichierTexteTest.getType = 'text/xml');
      lecteurFichierTexteTest.destroy;
    end;

    procedure TestLecteurFichierTexte.testGetTypeBonneExtensionPLAIN;
    var lecteurFichierTexteTest:LecteurFichierTexte;
    begin
      lecteurFichierTexteTest:=LecteurFichierTexte.create('fichier.txt');
      check(lecteurFichierTexteTest.getType = 'text/plain');
      lecteurFichierTexteTest.destroy;
    end;

    procedure TestLecteurFichierTexte.testLireContenuJusquaFinDeFichier;
    var lecteurFichierTexteTest:LecteurFichierTexte;
    begin
      lecteurFichierTexteTest:=LecteurFichierTexte.create('Salut.txt');
      checkEquals ( 'Salut' +#13#10 + 'le monde'+#13#10, lecteurFichierTexteTest.lireContenu);

      lecteurFichierTexteTest.destroy;
    end;

    procedure TestLecteurFichierTexte.testLireContenuFichierNOuvrePas;
    var lecteurFichierTexteTest:LecteurFichierTexte;
    begin
      lecteurFichierTexteTest:=LecteurFichierTexte.create('FichierInexistant.txt');
      try
        lecteurFichierTexteTest.lireContenu;
        fail('Une exception n''a pas été lancée');
      except on e : Exception do
        checkEquals('Erreur Entrée / Sortie', e.Message)
      end;
        lecteurFichierTexteTest.destroy;
    end;

initialization
  TestFrameWork.RegisterTest(TestLecteurFichierTexte.Suite);
end.
