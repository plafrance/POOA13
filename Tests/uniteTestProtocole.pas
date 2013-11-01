unit uniteTestProtocole;

interface

uses TestFrameWork, uniteProtocole, uniteRequete, uniteReponse, uniteConsigneur;

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
  end;

implementation
 procedure TestProtocole.testTraiterRequeteTemoin;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:Consigneur;
  begin 
    objetRequete:=Requete.create;
    objetConsigneur:=Consigneur.create;
    objetProtocole:=Protocole.create('C:\', objetConsigneur);
    objetRequete.setAdresseDemandeur('127.0.0.1');
    objetRequete.setDateReception(StrToDate('2013/09/21 10:51'));
    objetRequete.setVersionProtocole('HTTP/1.0');
    objetRequete.setMethode('GET');
    objetRequete.setURL('/bob.html');

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
      //Résumer les erreurs dans un seul fail, à la façon de la suggestion dans TestReponse ? (si on le fait, à généraliser dans les autres test de cette unité)      
    objetRequete.destroy;
    objetReponse.destroy;
    objetProtocole.destroy;
     //objetConsigneur.destroy ? Consigneur jamais détruit.
  end;
     
procedure TestProtocole.testTraiterRequeteMethodeGetMinuscule;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:Consigneur;
  begin
    objetRequete:=Requete.create;
    objetConsigneur:=Consigneur.create;
    objetProtocole:=Protocole.create('C:/', objetConsigneur);
    objetRequete.setAdresseDemandeur('127.0.0.1');
    objetRequete.setDateReception(StrToDate('2013/09/21 10:51'));
    objetRequete.setVersionProtocole('HTTP/1.0');
    objetRequete.setMethode('get');
    objetRequete.setURL('/bob.html');

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
     //objetConsigneur.destroy ?
  end;



  procedure TestProtocole.testTraiterRequeteMethodePost;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:Consigneur;
  begin 
    objetRequete:=Requete.create;
    objetConsigneur:=Consigneur.create;
    objetProtocole:=Protocole.create('C:/', objetConsigneur);
    objetRequete.setAdresseDemandeur('127.0.0.1');
    objetRequete.setDateReception(StrToDate('2013/09/21 10:51'));
    objetRequete.setVersionProtocole('HTTP/1.0');
    objetRequete.setMethode('Post');
    objetRequete.setURL('/bob.html');

    objetReponse:=objetProtocole.traiterRequete(objetRequete);
    if objetReponse.getAdresseDemandeur<>'127.0.0.1' then
      fail('adresseDemandeur mal transféré');
    if objetReponse.getVersionProtocole<>'HTTP/1.1' then
      fail('La versionProtocole devrait être "HTTP/1.1"');
    if objetReponse.getCodeReponse<>501 then
      fail('Le code attendu est 501');
    if objetReponse.getMessage<> 'Méthode non implémentée' then
      fail('message non attendu, devait être "Méthode non implémentée" ');
    if objetReponse.getReponseHTML<> 'La méthode “Post” n''est pas implémentée' then
      fail('reponseHTML non attendu (vérifiez l''orthographe) ');
      
    objetRequete.destroy;
    objetReponse.destroy;
    objetProtocole.destroy;
     //objetConsigneur.destroy ?
  end;

 procedure TestProtocole.testTraiterRequeteVersionProtocoleHTTP11;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:Consigneur;
  begin 
    objetRequete:=Requete.create;
    objetConsigneur:=Consigneur.create;
    objetProtocole:=Protocole.create('C:/', objetConsigneur);
    objetRequete.setAdresseDemandeur('127.0.0.1');
    objetRequete.setDateReception(StrToDate('2013/09/21 10:51'));
    objetRequete.setVersionProtocole('HTTP/1.1');
    objetRequete.setMethode('GET');
    objetRequete.setURL('/bob.html');

    objetReponse:=objetProtocole.traiterRequete(objetRequete);
    if objetReponse.getAdresseDemandeur<>'127.0.0.1' then
      fail('adresseDemandeur mal transféré');
    if objetReponse.getVersionProtocole<>'HTTP/1.1' then
      fail('La versionProtocole devrait être "HTTP/1.1"');
    if objetReponse.getCodeReponse<>404 then
      fail('Le code attendu est 404');
    if objetReponse.getMessage<> 'URL introuvable' then
      fail('message non attendu, devait être "URL introuvable" ');
    if objetReponse.getReponseHTML<> 'Protocole HTTP/1.1 incompatible avec le serveur' then
      fail('reponseHTML non attendu (vérifiez l''orthographe) ');
      
    objetRequete.destroy;
    objetReponse.destroy;
    objetProtocole.destroy;
     //objetConsigneur.destroy ?
  end;



  procedure TestProtocole.testTraiterRequeteVersionProtocoleHTTP09;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:Consigneur;
  begin 
    objetRequete:=Requete.create;
    objetConsigneur:=Consigneur.create;
    objetProtocole:=Protocole.create('C:/', objetConsigneur);
    objetRequete.setAdresseDemandeur('127.0.0.1');
    objetRequete.setDateReception(StrToDate('2013/09/21 10:51'));
    objetRequete.setVersionProtocole('HTTP/0.9');
    objetRequete.setMethode('GET');
    objetRequete.setURL('/bob.html');

    objetReponse:=objetProtocole.traiterRequete(objetRequete);
    if objetReponse.getAdresseDemandeur<>'127.0.0.1' then
      fail('adresseDemandeur mal transféré');
    if objetReponse.getVersionProtocole<>'HTTP/1.1' then
      fail('La versionProtocole devrait être "HTTP/1.1"');
    if objetReponse.getCodeReponse<>505 then
      fail('Le code attendu est 505');
    if objetReponse.getMessage<> 'Version HTTP HTTP/0.9 non supportée' then
      fail('message non attendu, devait être "Version HTTP HTTP/0.9 non supportée" ');

    objetRequete.destroy;
    objetReponse.destroy;
    objetProtocole.destroy;
  end;

  procedure TestProtocole.testTraiterRequeteOrdreCodeReponse;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:Consigneur;
  begin
    objetRequete:=Requete.create;
    objetConsigneur:=Consigneur.create;
    objetProtocole:=Protocole.create(' ', objetConsigneur);
    objetRequete.setAdresseDemandeur('127.0.0.1');
    objetRequete.setDateReception(StrToDate('2013/09/21 10:51'));
    objetRequete.setVersionProtocole('HTTP/0.9');
    objetRequete.setMethode('Post');
    objetRequete.setURL('/bob.html');

    objetReponse:=objetProtocole.traiterRequete(objetRequete);
    if (objetReponse.getCodeReponse<505) then
      fail('L''erreur attendue est 505');

    objetRequete.setVersionProtocole('HTTP/1.1')
    objetReponse:=objetProtocole.traiterRequete(objetRequete);
    if objetReponse.getCodeReponse<501 then
      fail('L''erreur attendue est 501');

    objetRequete.destroy;
    objetReponse.destroy;
    objetProtocole.destroy;
  end;


  procedure TestProtocole.testTraiterRequeteVersionProtocoleString;
  var
    objetRequete:Requete;
    objetReponse:Reponse;
    objetProtocole:Protocole;
    objetConsigneur:Consigneur;
  begin
    objetRequete:=Requete.create;
    objetConsigneur:=Consigneur.create;
    objetProtocole:=Protocole.create(' ', objetConsigneur);
    objetRequete.setAdresseDemandeur('127.0.0.1');
    objetRequete.setDateReception(StrToDate('2013/09/21 10:51'));
    objetRequete.setVersionProtocole('Salut les copains');
    objetRequete.setMethode('GET');
    objetRequete.setURL('/bob.html');
    try
    objetReponse:=objetProtocole.traiterRequete(objetRequete);
     //fail('pas reçu l''exception attendue') << si on ne met pas de fail, le test sera positif même si on ne reçoit pas une exception.
    except on e:exception do
    Check((e.message= 'Version HTTP incompatible');
     //manque un end; à la fin du except, je suppose que ça finit ici.
    objetRequete.destroy;
    objetReponse.destroy;
    objetProtocole.destroy;
  end;

  
  procedure TestProtocole.testCreateTemoin;
  var
    leConsigneur:Consigneur;
    protocoleHTTP:Protocole;
  begin
    //leConsigneur:= Consigneur.create (jamais instancié)
    protocoleHTTP:=Protocole.create(leConsigneur, 'C:\');
    check(protocoleHTTP.getRepertoire='C:\');
    check(protocoleHTTP.consigneur=leConsigneur);
  end;

  
  procedure TestProtocole.testCreateRepertoireInexistant;
  var
    leConsigneur:Consigneur;
    protocoleHTTP:Protocole;
    begin
    //leConsigneur:= Consigneur.create (jamais instancié)
    protocoleHTTP:=Protocole.create(leConsigneur, 'C:\RepertoireInexistant');
    check(protocoleHTTP.getRepertoire='C:\RepertoireInexistant');
    check(protocoleHTTP.consigneur=leConsigneur);
  end;


  procedure TestProtocole.testSetRepertoire;
  var
    leConsigneur:Consigneur;
    protocoleHTTP:Protocole;
  begin
    //leConsigneur:= Consigneur.create (jamais instancié)
    protocoleHTTP:=Protocole.create(leConsigneur, 'C:\RepertoireTest\');
    protocoleHTTP.setRepertoire('C:\UnAutreRepertoire\');
    check(protocoleHTTP.getRepertoire='C:\UnAutreRepertoire\');
    check(protocoleHTTP.consigneur=leConsigneur);
  end;
	  
//initialization
//  TestFrameWork.RegisterTest(TestProtocole.Suite);
end.
