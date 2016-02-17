program Example;

uses
  Forms,
  AnalyticsExample in 'AnalyticsExample.pas' {Form1},
  GenTypes in 'GenTypes.pas',
  Analytics in 'Analytics.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
