unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, uCalcul, uInterpreter;

type
  TDemoForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    CalcBtn: TButton;
    Vars: TMemo;
    ComboBox1: TComboBox;
    Memo1: TMemo;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Memo2: TMemo;
    Button1: TButton;
    Label6: TLabel;
    procedure CalcBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
  private
    Calcul1:TCalcul;
    Interpreter1:TInterpreter;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DemoForm: TDemoForm;

implementation

{$R *.DFM}

procedure TDemoForm.CalcBtnClick(Sender: TObject);
var s:string;
begin
  Calcul1.Variables:=Vars.text;
  Calcul1.Formula := ComboBox1.text;
  s:=Calcul1.calc;
  Vars.text:=Calcul1.Variables;
  if Calcul1.CalcError=false then
    ShowMessage(Calcul1.Formula+'='+s)
  else
    ShowMessage(Calcul1.CalcErrorText);
end;

procedure TDemoForm.FormCreate(Sender: TObject);
begin
  Calcul1:=TCalcul.Create;
  Interpreter1:=Tinterpreter.Create;
  Interpreter1.Calcul:=Calcul1;
end;

procedure TDemoForm.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then begin key:=#0; calcBtnClick(sender); end;
end;

procedure TDemoForm.Button1Click(Sender: TObject);
begin
  Screen.Cursor:=crHourglass;
  try
    Calcul1.Variables:=Vars.text;
    Interpreter1.Prog:=Memo2.text;
    Interpreter1.Execute;
    Vars.text:=Calcul1.Variables;
    if Interpreter1.Error then begin
      ShowMessage(Interpreter1.ErrorText);
      Memo2.SetFocus;
      Memo2.SelStart:=Interpreter1.ErrorPos-1;
    end;
  finally
   Screen.cursor:=crDefault;
  end;
end;

end.
