// Cette unité sert à tester la classe Serveur afin de vérifier
// si le numéro de port et le répertoire de base sont
// correctement programmés dans la classe.
unit uniteTestServeur;

interface

uses TestFrameWork, uniteServeur, uniteConsigneurStub, SysUtils;

type
  TestServeur = class (TTestCase)
     published

     // Cette procédure vérifie si un message d'erreur est envoyé
     // dans le cas où le port est inférieur à 1.
     procedure testConstructeurPortLimiteInferieurInvalide;

     // Cette procédure vérifie si le constructeur prend le port 1
     // qui est le numéro de port minimum acceptable.
     procedure testConstructeurPortInferieurLimiteValide;

     // Cette procédure vérifie si le constructeur prend le port 65535
     // qui est le numéro de port maximum acceptable.
     procedure testConstructeurPortSuperieurLimiteValide;

     // Cette procédure vérifie si un message d'erreur est envoyé
     // dans le cas où le dossier est inexistant.
     procedure testConstructeurRepertoireInvalide;
  end;

implementation

     // Cette procédure vérifie si un message d'erreur est envoyé
     // dans le cas où le port est inférieur à 1.
     procedure TestServeur.testConstructeurPortLimiteInferieurInvalide;

    var
      // La classe Serveur a besoin d'un consigneur dans son constructeur.
      // Il n'est pas testé dans cette unité.
      unConsigneur : ConsigneurStub;

      // Sert à conserver les informations sur le serveur courant.
      unServeur : Serveur;

    begin
      // On récupère l'exception si elle est lancé.
      // Le constructeur de type Serveur a besoin d'un consigneur pour fonctionner.
      // Cette unité ne sert pas à vérifier le fonctionnement de la classe
      unConsigneur := ConsigneurStub.create;

      try
        // Création d'un serveur avec des informations invalides.
         unServeur := Serveur.create( 0, unConsigneur, 'c:\htdocs' );

         // Destruction de l'objet.
         unServeur.destroy;

         // Aucun message a été lancé de la classe Serveur.
         fail('Pas d''exception lancée');

      // Vérifie si le message de l'exception est le bon message à afficher.
      except on e:Exception do
        check( e.message = 'Le numéro de port doit respecter l''intervalle de [1..65535].' );
      end;
    end;

     // Cette procédure vérifie si le constructeur prend le port 1
     // qui est le numéro de port minimum acceptable.
     procedure TestServeur.testConstructeurPortInferieurLimiteValide;

     var
      // La classe Serveur a besoin d'un consigneur dans son constructeur.
      // Il n'est pas testé dans cette unité.
      unConsigneur : ConsigneurStub;

      // Sert à conserver les informations sur le serveur courant.
      unServeur : Serveur;

    begin

         // Le constructeur de type Serveur a besoin d'un consigneur pour fonctionner.
         // Cette unité ne sert pas à vérifier le fonctionnement de la classe
         unConsigneur := ConsigneurStub.create;

         // Création d'un serveur avec des informations valides. Le port numéro 1
         // est un port valide.
         unServeur := Serveur.create( 1, unConsigneur, 'c:\htdocs' );

         // Destruction de l'objet.
         unServeur.destroy;
    end;

    // Cette procédure vérifie si le constructeur prend le port 65535
    // qui est le numéro de port maximum acceptable.
    procedure TestServeur.testConstructeurPortSuperieurLimiteValide;

    var
      // La classe Serveur a besoin d'un consigneur dans son constructeur.
      // Il n'est pas testé dans cette unité.
      unConsigneur : ConsigneurStub;

      // Sert à conserver les informations sur le serveur courant.
      unServeur : Serveur;

   begin
         // Le constructeur de type Serveur a besoin d'un consigneur pour fonctionner.
         // Cette unité ne sert pas à vérifier le fonctionnement de la classe
         unConsigneur := ConsigneurStub.create;

         // Création d'un serveur avec des informations valides. Le port numéro 65535
         // est un port valide.
         unServeur := Serveur.create( 65535, unConsigneur, 'c:\htdocs' );

         // Destruction de l'objet.
         unServeur.destroy;
   end;


   // Cette procédure vérifie si un message d'erreur est envoyé
   // dans le cas où le dossier est inexistant.
   procedure TestServeur.testConstructeurRepertoireInvalide;

   var
      // La classe Serveur a besoin d'un consigneur dans son constructeur.
      // Il n'est pas testé dans cette unité.
      unConsigneur : ConsigneurStub;

      // Sert à conserver les informations sur le serveur courant.
      unServeur : Serveur;

   begin
         // Le constructeur de type Serveur a besoin d'un consigneur pour fonctionner.
         // Cette unité ne sert pas à vérifier le fonctionnement de la classe
         unConsigneur := ConsigneurStub.create;

      // On récupère l'exception si elle est lancé.
      try

         // Création d'un serveur avec des informations invalides.
         unServeur := Serveur.create( 80, unConsigneur, 'c:\toto' );

         // Destruction de l'objet.
         unServeur.destroy;

        // Aucun message a été lancé de la classe Serveur.
        fail('Pas d''exception lancée');

      // Vérifie si le message de l'exception est le bon message à afficher.
      except on e:Exception do
        check( e.message = 'Chemin d''accès au répertoire de base invalide.' );
      end;
    end;


initialization
  TestFrameWork.RegisterTest(TestServeur.Suite);
end.
