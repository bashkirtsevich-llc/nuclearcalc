unit AddVar_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TdlgAddVariable = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    leVarName: TLabeledEdit;
    leVarValue: TLabeledEdit;
    procedure leVarValueKeyPress(Sender: TObject; var Key: Char);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgAddVariable: TdlgAddVariable;

implementation

{$R *.dfm}

procedure TdlgAddVariable.btnOkClick(Sender: TObject);
begin
  if (self.leVarName.Text='') or (self.leVarValue.Text='') then
    MessageBox(Handle,'Please insert variable name & variable value','Attention',MB_OK+MB_ICONEXCLAMATION)
  else
    ModalResult:=mrOk;
end;

procedure TdlgAddVariable.leVarValueKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',#8]) then
    Key:=#0;
end;

end.
