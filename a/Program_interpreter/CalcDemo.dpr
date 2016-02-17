program CalcDemo;

uses
  Forms,
  Main in 'Main.pas' {DemoForm},
  uCalcul in 'ucalcul.pas',
  uFunctions in 'uFunctions.pas',
  uInterpreter in 'uInterpreter.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDemoForm, DemoForm);
  Application.Run;
end.
