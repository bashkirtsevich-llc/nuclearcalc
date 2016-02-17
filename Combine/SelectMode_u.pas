unit SelectMode_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TwndMode = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    cbMode: TComboBox;
    lbMode: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wndMode: TwndMode;

implementation

{$R *.dfm}

end.
