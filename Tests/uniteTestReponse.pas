unit UniteTestReponse;

interface

uses sysutils, TestFrameWork, uniteProtocole, uniteRequete, uniteReponse;

type
  TestReponse = class (TTestCase)
     published
     procedure testReponseCreate;

  end;


implementation

  procedure TestReponse.testReponseCreate;
  var
    reponseHTTP:Reponse;
  begin
    reponseHTTP:=Reponse.create('1', '2', 3, '4', '5');
    if getAdresseDemandeur <> '1' then
      fail('Premier paramètre eronné (adresseDemandeur)');
    if getVersionProtocole <> '2' then
      fail('Deuxième paramètre eronné (versionProtocole)');
    if getCodeReponse <> 3 then
      fail('troisième paramètre erroné (codeReponse)');
    if getMessage = '4' then
      fail('Quatrième paramètre erroné (message)');
    if getReponseHtml = '5' then
      fail('Cinquième paramètre erroné (reponseHtml)');
  end; //Suggestion : un seul fail, un seul message délivré résumant les méthodes get ayant retourné un résultat erroné. (if getBob <> 'bob' then Erreurs:= Erreurs+' bob'... fail('Échec sur : ' + Erreurs). Permettrait de ne pas répéter des tests séparés sur les accesseurs.




//initialization
//  TestFrameWork.RegisterTest(TestReponse.Suite);
end.