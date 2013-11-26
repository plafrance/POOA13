program ProjetTest;

uses
  Forms,
  TestFrameWork,
  GUITestRunner,
  uniteTestConsigneur in 'uniteTestConsigneur.pas',
  uniteTestProtocole in 'uniteTestProtocole.pas',
  uniteTestReponse in 'uniteTestReponse.pas',
  uniteTestRequete in 'uniteTestRequete.pas',
  uniteTestServeur in 'uniteTestServeur.pas',
  uniteConsigneurStub in 'stubs\uniteConsigneurStub.pas';

{$R *.res}

begin
  Application.Initialize;
  GUITestRunner.RunRegisteredTests;
end.
