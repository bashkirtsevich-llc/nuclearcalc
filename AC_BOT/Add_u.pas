unit Add_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TdlgAdd = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    gbJIDorUIN: TGroupBox;
    leJIDorUIN: TLabeledEdit;
    lePass: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgAdd: TdlgAdd;

implementation

{$R *.dfm}

end.
