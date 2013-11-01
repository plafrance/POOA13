unit uniteTestConsigneur;

interface


uses TestFrameWork, SysUtils, shellapi;

type

TestConsigneur = class (TTestCase)
   procedure consigner;
   procedure consignerErreur;
end;

implementation
   procedure TestConsigneur.consigner;
      var sortie : String; fichierTest : TextFile;
   begin
      ShellExecute(0, 'Open', '"TestConsigner\TestConsigner.exe" > test.out',PChar(''), 0, 0);
      {ShellExecute appelle cmd.exe pour exécuter le programme TestConsignerErreur.exe
      dont la sortie est redirigée vers le fichier test.out.
      TestConsignerErreur.exe instancie un Consigneur et appelle la méthode ConsignerErreur
      avec les paramètres suivants :
      '2013-10-25 08:09:10'
      'Oscar Wilde'
      'Be warned in time, James, and remain, as I do, incomprehensible: to be great is to be misunderstood.'}

         assignFile(fichierTest, 'test.out');
         fileMode := fmOpenRead; //ne me demandez pas à quoi ça sert.
         reset(fichierTest);
         readln(fichierTest, sortie);
         checkEquals('2013-10-25 08:09:10 [Oscar Wilde] : Be warned in time, James, and remain, as I do, incomprehensible: to be great is to be misunderstood.', sortie);
         closeFile(fichierTest);
         erase(fichierTest);
   end;

   procedure TestConsigneur.consignerErreur;
      var sortie : String; fichierTest : TextFile;
   begin
      ShellExecute(0, 'Open', '"TestConsignerErreur\TestConsignerErreur.exe" > test.out',PChar(''), 0, 0);
      {ShellExecute appelle cmd.exe pour exécuter le programme TestConsignerErreur.exe
      dont la sortie est redirigée vers le fichier test.out.
      TestConsignerErreur.exe instancie un Consigneur et appelle la méthode ConsignerErreur
      avec les paramètres suivants :
      '2013-10-25 08:09:10'
      'Charles J. Sykes'
      '640K ought to be enough for anybody'}
      //try
         assignFile(fichierTest, 'test.out');
         fileMode := fmOpenRead; //ne me demandez pas à quoi ça sert.
         reset(fichierTest);
         readln(fichierTest, sortie);
         checkEquals('2013-10-25 08:09:10 [ERREUR - Charles J. Sykes] : 640K ought to be enough for anybody', sortie);
         closeFile(fichierTest);
         erase(fichierTest);
      //except on e : Exception do
      //   fail;
      //end;
   end;

//initialization
//   TestFrameWork.RegisterTest(TestConsigneur.Suite);
end.
