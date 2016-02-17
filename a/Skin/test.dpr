program test;

uses
  Forms,
  Main_u in 'Main_u.pas' {wndMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TwndMain, wndMain);
  Application.Run;
end.
