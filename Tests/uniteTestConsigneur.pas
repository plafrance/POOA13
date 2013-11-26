unit uniteTestConsigneur;

interface


uses TestFrameWork, SysUtils, shellapi, uniteConsigneur;

type

  TestConsigneur = class (TTestCase)
    published
      // Teste que les succes sont enregistrés
      procedure testConsigner;

      // Teste que les erreurs sont enregistrés
      procedure testConsignerErreur;

      //Sert a tester si on peut creer le fichier Acces.log
      procedure testConstructeurCreerFichierAcces;

      //Sert a tester si on peut ouvrire/fermer le fichier Erreur.log
      procedure testConstructeurCreerFichierErreur;

      // Teste le cas où on ne peut pas créer et ouvrir un fichier
      procedure testConstructeurOnNePeutPasCreerUnFichier;

      // Teste le cas où on ne peut pas écrire dans un fichier
      procedure testConstructeurOnNePeutPasEcrireDansUnFichier;


      //Vérifie si getRepertoire retourne le bon nom de répertoire.
      procedure testGetRepertoireJournaux;
  end;


implementation

procedure TestConsigneur.testConsigner;
var
  sortie : String;
  fichier : TextFile;
  unConsigneur : Consigneur;
begin
  unConsigneur := Consigneur.create('c:\repertoireJournaux');
  assignFile(fichier, 'c:\repertoireJournaux\Acces.log');
  fileMode := fmOpenRead;
  reset(fichier);
  readln(fichier, sortie);
  checkEquals('2013-10-25 08:09:10 [Oscar Wilde] : Be warned in time, James, and remain, as I do, incomprehensible: to be great is to be misunderstood.', sortie);
  close(fichier);
  erase(fichier);
end;


procedure TestConsigneur.testConsignerErreur;
var
  sortie : String;
  fichier : TextFile;  
  unConsigneur : Consigneur;
begin
  unConsigneur := Consigneur.create('c:\repertoireJournaux');;
  assignFile(fichier, 'c:\repertoireJournaux\Acces.log');
  fileMode := fmOpenRead;
  reset(fichier);
  readln(fichier, sortie);
  checkEquals('2013-10-25 08:09:10 [ERREUR - Charles J. Sykes] : 640K ought to be enough for anybody', sortie);
  close(fichier);
  erase(fichier);
end;


procedure testConsigneur.testConstructeurCreerFichierAcces;
var
  fichier : TextFile;
  unConsigneur : Consigneur;
begin
  // Creation d'un répertoire pour contenir les fichier .log
  unConsigneur := Consigneur.create('c:\repertoireJournaux');

  //nommer les fichier
  assignFile(fichier,'c:\repertoireJournaux\Acces.log');

  //On verifie si le fichier existe donc si il est créé.
  check(fileExists('c:\repertoireJournaux\Acces.log'));

  //ferme le fichier en question
  close(fichier);

  unConsigneur.destroy;
end;


procedure testConsigneur.testConstructeurCreerFichierErreur;
var
  fichier : TextFile;      
  unConsigneur : Consigneur;
begin
  unConsigneur := Consigneur.create('c:\repertoireJournaux');
  assignFile(fichier,'c:\repertoireJournaux\Erreur.log');
  check(fileExists('c:\repertoireJournaux\Erreur.log'));
  close(fichier);
  unConsigneur.destroy;
end;


procedure testConsigneur.testConstructeurOnNePeutPasCreerUnFichier;
var
  fichier : TextFile;
  unConsigneur : Consigneur;
begin
  try
    unConsigneur := Consigneur.create('c:\totoRina');
    unConsigneur.destroy;
    fail('Pas d''exception lancée');
  except on e:Exception do
    check(e.Message = 'Incapable de créer le fichier c:\totoRina\Acces.log dans le rpertoireJournaux');
  end;
end;


// On crée le fichier (Acces.log) manuellement dans le répertoire Journaux
// et on modifie manuellement aussi les perméssions on le mettons en LECTURE SEUL
// et on essaie de l'ouvrire en écriture
procedure testConsigneur.testConstructeurOnNePeutPasEcrireDansUnFichier;
var
  fichier : TextFile;
  unConsigneur : Consigneur;
begin
  unConsigneur := Consigneur.create('c:\journauxRO');
  try
    //On essaie d'ouvrire le fichier Acces.log en écriture
    unConsigneur.destroy;
    fail('Pas d''exception lancée');
  except on e:Exception do
    check(e.Message = 'Incapable d''ouvrire en écriture le fichier Acces.log dans le journauxRO');
  end;
end;

//Vérifie si getRepertoire retourne le bon nom de répertoire.
procedure testConsigneur.testGetRepertoireJournaux;
var
  unConsigneur : Consigneur;
begin
  unConsigneur := Consigneur.create('c:\repertoireJournaux');
  check(unConsigneur.getRepertoireJournaux = 'c:\repertoireJournaux');
  unConsigneur.destroy;
end;

initialization
  TestFrameWork.RegisterTest(TestConsigneur.Suite);
end.
