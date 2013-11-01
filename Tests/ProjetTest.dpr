program ProjetTest;

uses
  Forms,
  TestFrameWork,
  GUITestRunner,
  uniteTestServeur in 'uniteTestServeur.pas',
  uniteTestConsigneur in 'uniteTestConsigneur.pas',
  uniteTestProtocole in 'uniteTestProtocole.pas',
  uniteTestReponse in 'uniteTestReponse.pas',
  uniteTestRequete in 'uniteTestRequete.pas';

{$R *.res}

begin
  Application.Initialize;
  GUITestRunner.RunRegisteredTests;
end.
