program NC;

uses
  Forms,
  CombineMain_u in 'CombineMain_u.pas' {wndMain},
  Graph_3D_u in 'Graph_3D_u.pas' {wnd3D},
  Graph_2D_u in 'Graph_2D_u.pas' {wnd2D},
  NewFile_u in 'NewFile_u.pas' {dlgNewFile},
  Icons_u in 'Icons_u.pas',
  Global_u in 'Global_u.pas',
  SelectMode_u in 'SelectMode_u.pas' {wndMode},
  Config_u in 'Config_u.pas' {dlgConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TwndMain, wndMain);
  Application.Run;
end.
