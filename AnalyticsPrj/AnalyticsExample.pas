unit AnalyticsExample;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Analytics, XPMan, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    XPManifest1: TXPManifest;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var translator : TTranslator;
    formula, dx, dy, error : string;
begin
  LabeledEdit2.Text:='';
  LabeledEdit3.Text:='';
  Label1.Caption:='';
  Application.ProcessMessages;
  translator:=TTranslator.Create;
  try
    formula := LabeledEdit1.Text;
    if translator.FindErrorInDerivativeFunction(formula,error) then
      begin
        Label1.Caption:=error;
        exit;
      end;

    translator.Derivative(formula,'x',dx);
    translator.Derivative(formula,'y',dy);
    LabeledEdit2.Text:=dx;
    LabeledEdit3.Text:=dy;
  finally
    translator.Free;
  end;
end;

end.
