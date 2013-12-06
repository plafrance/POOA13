unit uniteTestProtocole;

interface

uses SysUtils,TestFrameWork, uniteProtocole, uniteRequete, uniteReponse, uniteConsigneur, uniteConsigneurStub;

type
  TestProtocole = class (TTestCase)
     published
     procedure testTraiterRequeteTemoin;
     procedure testTraiterRequeteMethodeGetMinuscule;
     procedure testTraiterRequeteMethodePost;
     procedure testTraiterRequeteVersionProtocoleHTTP11;
     procedure testTraiterRequeteVersionProtocoleHTTP09;
     procedure testTraiterRequeteOrdreCodeReponse;
     procedure testTraiterRequeteVersionProtocoleString;
     procedure testCreateTemoin;
     procedure testCreateRepertoireInexistant;
     procedure testSetRepertoire;
     procedure testLecteurFichier;
  end;

implementation
 procedure TestProtocole.testTraiterRequeteTemoin;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:ConsigneurStub;
  begin
    objetRequete:=Requete.create('127.0.0.1', StrToDateTime('2013-09-21 10:51'), 'HTTP/1.0', 'GET', '/bob.html');
    objetConsigneur:=ConsigneurStub.create('');
    objetProtocole:=Protocole.create('C:\', objetConsigneur);

    objetReponse:=objetProtocole.traiterRequete(objetRequete);
    if objetReponse.getAdresseDemandeur<>'127.0.0.1' then
      fail('adresseDemandeur mal transféré');
    if objetReponse.getVersionProtocole<>'HTTP/1.1' then
      fail('La versionProtocole devrait être "HTTP/1.1"');
    if objetReponse.getCodeReponse<>404 then
      fail('Le code attendu est 404');
    if objetReponse.getMessage<> 'URL introuvable' then
      fail('message non attendu, devait être "URL introuvable" '); 
    if objetReponse.getReponseHTML<> 'L''URL n''existe pas sur le serveur, veuillez vérifier l''orthographe et réessayer' then
      fail('reponseHTML non attendu (vérifiez l''orthographe) ');

    objetRequete.destroy;
    objetReponse.destroy;
    objetProtocole.destroy;
    objetConsigneur.destroy;
  end;
     
procedure TestProtocole.testTraiterRequeteMethodeGetMinuscule;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:ConsigneurStub;
  begin
    objetRequete:=Requete.create('127.0.0.1', StrToDateTime('2013-09-21 10:51'), 'HTTP/1.0', 'get', '/bob.html');
    objetConsigneur:=ConsigneurStub.create('');
    objetProtocole:=Protocole.create('C:/', objetConsigneur);

    objetReponse:=objetProtocole.traiterRequete(objetRequete);
    if objetReponse.getCodeReponse<>404 then
      fail('Le code attendu est 404');
    if objetReponse.getMessage<> 'URL introuvable' then
      fail('message non attendu, devait être "URL introuvable" ');
    if objetReponse.getReponseHTML<> 'L''URL n''existe pas sur le serveur, veuillez vérifier l''orthographe et réessayer' then
      fail('reponseHTML non attendu (vérifiez l''orthographe) ');

    objetRequete.destroy;
    objetReponse.destroy;
    objetProtocole.destroy;
    objetConsigneur.destroy;
  end;



  procedure TestProtocole.testTraiterRequeteMethodePost;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:ConsigneurStub;
  begin
    objetRequete:=Requete.create('127.0.0.1', StrToDateTime('2013-09-21 10:51'), 'HTTP/1.0', 'Post', '/bob.html');
    objetConsigneur:=ConsigneurStub.create('');
    objetProtocole:=Protocole.create('C:/', objetConsigneur);

    objetReponse:=objetProtocole.traiterRequete(objetRequete);
    if objetReponse.getCodeReponse<>501 then
      fail('Le code attendu est 501');
    if objetReponse.getMessage<> 'Méthode non implémentée' then
      fail('message non attendu, devait être "Méthode non implémentée" ');
    if objetReponse.getReponseHTML<> 'La méthode « Post » n''est pas implémentée' then
      fail('reponseHTML non attendu (vérifiez l''orthographe) ');
      
    objetRequete.destroy;
    objetReponse.destroy;
    objetProtocole.destroy;
    objetConsigneur.destroy;
  end;

 procedure TestProtocole.testTraiterRequeteVersionProtocoleHTTP11;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:Consigneur;
  begin 
    objetRequete:=Requete.create('127.0.0.1', StrToDateTime('2013-09-21 10:51'), 'HTTP/1.1', 'GET', '/bob.html');
    objetConsigneur:=ConsigneurStub.create('');
    objetProtocole:=Protocole.create('C:/', objetConsigneur);

    objetReponse:=objetProtocole.traiterRequete(objetRequete);

    objetRequete.destroy;
    objetReponse.destroy;
    objetProtocole.destroy;
    objetConsigneur.destroy;
  end;



  procedure TestProtocole.testTraiterRequeteVersionProtocoleHTTP09;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:Consigneur;
  begin 
    objetRequete:=Requete.create('127.0.0.1', StrToDateTime('2013-09-21 10:51'), 'HTTP/0.9', 'GET', '/bob.html');;
    objetConsigneur:=ConsigneurStub.create('');
    objetProtocole:=Protocole.create('C:/', objetConsigneur);

    objetReponse:=objetProtocole.traiterRequete(objetRequete);
    if objetReponse.getVersionProtocole<>'HTTP/1.1' then
      fail('La versionProtocole devrait être "HTTP/1.1"');
    if objetReponse.getCodeReponse<>505 then
      fail('Le code attendu est 505');
    if objetReponse.getMessage<> 'Version HTTP HTTP/0.9 non supportée' then
      fail('message non attendu, devait être "Version HTTP HTTP/0.9 non supportée" ');

    objetRequete.destroy;
    objetReponse.destroy;
    objetProtocole.destroy;
    objetConsigneur.Destroy;
  end;

  procedure TestProtocole.testTraiterRequeteOrdreCodeReponse;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:Consigneur;
  begin
    objetRequete:=Requete.create('127.0.0.1', StrToDateTime('2013-09-21 10:51'), 'HTTP/0.9', 'Post', '/bob.html');
    objetConsigneur:=ConsigneurStub.create('');
    objetProtocole:=Protocole.create(' ', objetConsigneur);

    objetReponse:=objetProtocole.traiterRequete(objetRequete);
    if (objetReponse.getCodeReponse<505) then
      fail('L''erreur attendue est 505');

    objetRequete.destroy;
    objetReponse.destroy;
    objetProtocole.destroy;
    objetConsigneur.destroy;
  end;


  procedure TestProtocole.testTraiterRequeteVersionProtocoleString;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:Consigneur;
  begin
    objetRequete:=Requete.create('127.0.0.1', StrToDateTime('2013-09-21 10:51'), 'Salut les copains', 'GET', '/bob.html');;
    objetConsigneur:=ConsigneurStub.create('');

    try
      objetReponse:=objetProtocole.traiterRequete(objetRequete);
      fail('pas reçu l''exception attendue')
    except on e:exception do
      Check(e.message= 'Version HTTP incompatible');
    end;
    objetRequete.destroy;
    objetReponse.destroy;
    objetProtocole.destroy;
    objetConsigneur.destroy;
  end;


  procedure TestProtocole.testCreateTemoin;
  var
    leConsigneur:Consigneur;
    protocoleHTTP:Protocole;
  begin
    leConsigneur:= ConsigneurStub.create('');
    protocoleHTTP:=Protocole.create('C:\',leConsigneur);
    check(protocoleHTTP.getRepertoireDeBase='C:\');
  end;


  procedure TestProtocole.testCreateRepertoireInexistant;
  var
    leConsigneur:Consigneur;
    protocoleHTTP:Protocole;
    begin
    leConsigneur:= ConsigneurStub.create('');
    protocoleHTTP:=Protocole.create('C:\RepertoireInexistant', leConsigneur);
    check(protocoleHTTP.getRepertoireDeBase='C:\RepertoireInexistant');
  end;


  procedure TestProtocole.testSetRepertoire;
  var
    leConsigneur:Consigneur;
    protocoleHTTP:Protocole;
  begin
    leConsigneur:= ConsigneurStub.create('');
    protocoleHTTP:=Protocole.create('4
    protocoleHTTP.setRepertoireDeBase('C:\UnAutreRepertoire\');
    check(protocoleHTTP.getRepertoireDeBase='C:\UnAutreRepertoire\');
  end;

  procedure TestProtocole.testLecteurFichier;
  var
    leConsigneur : Consigneur;
    protocoleHTTP : Protocole;
    uneReponse : Reponse;
    uneRequete : Requete;
  begin
    uneRequete := Requete.create(100.1.0.100, now, 'HTTP/1.1', 'GET', 'test.html');
    leConsigneur := ConsigneurStub.create('');
    protocoleHTTP := Protocole.create('C:\RepertoireTest\fichierTest\test.html',leConsigneur);

    uneReponse := protocoleHTTP.traiterRequete(uneRequete);

    check(uneReponse.getCodeReponse := 200);

    protocoleHTTP.destroy;
    uneReponse.destroy;
    uneRequete.destroy;
    unConsigneur.destroy;
  end;

  procedure TestProtocole.testLecteurFichier;
    var
    leConsigneur : Consigneur;
    protocoleHTTP : Protocole;
    uneReponse : Reponse;
    uneRequete : Requete;
  begin
    uneRequete := Requete.create(100.1.0.100, now, 'HTTP/1.1', 'GET', 'inexistant.html');
    leConsigneur := ConsigneurStub.create('');
    protocoleHTTP := Protocole.create('C:\RepertoireTest\fichierTest\',leConsigneur);

    uneReponse := protocoleHTTP.traiterRequete(uneRequete);
    
    fail('Le fichier n''existe pas);
    check(e.message := 'Erreur Entrée / Sortie');

    protocoleHTTP.destroy;
    uneReponse.destroy;
    uneRequete.destroy;
    unConsigneur.destroy;

  end;

initialization
  TestFrameWork.RegisterTest(TestProtocole.Suite);
end.
