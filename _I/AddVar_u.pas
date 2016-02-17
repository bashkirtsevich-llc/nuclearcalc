unit AddVar_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TdlgAddVar = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    leVarName: TLabeledEdit;
    leVarValue: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgAddVar: TdlgAddVar;

implementation

{$R *.dfm}

end.
