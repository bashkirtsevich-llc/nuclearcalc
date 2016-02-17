program AC_online;

uses
  Forms,
  Main_u in 'Main_u.pas' {wndMain},
  Proxy_u in 'Proxy_u.pas' {dlgProxy},
  uCalcul in 'core\ucalcul.pas',
  uFunctions in 'core\uFunctions.pas',
  MathematicsFunc in 'core\MathematicsFunc.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TwndMain, wndMain);
  Application.Run;
end.
