unit Num_row_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MathematicsFunc;

type
  TdlgRow = class(TForm)
    btnCompute: TButton;
    btnClose: TButton;
    gbFunction: TGroupBox;
    lbFunction: TLabel;
    edFunction: TEdit;
    gbLimits: TGroupBox;
    lbTopLimit: TLabel;
    edTopLimit: TEdit;
    lbBottomLimit: TLabel;
    edBottomLimit: TEdit;
    lbStep: TLabel;
    edStep: TEdit;
    gbResult: TGroupBox;
    edResult: TEdit;
    procedure edBottomLimitKeyPress(Sender: TObject; var Key: Char);
    procedure btnComputeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgRow: TdlgRow;

implementation

{$R *.dfm}

function Compute(Func:string;x,y,z,n:single):single;
var R:TE;
    _half:extended;
begin
  result:=0;
  if Parse_Line(Func,R) then
    if Count_Func(true,R,x,y,z,n,_half) then
      Result:=_half;
end;

procedure TdlgRow.btnComputeClick(Sender: TObject);
var x,_min,_max,_step:Extended;
    _half:extended;
begin
  _min:=strtofloat(edBottomLimit.Text);
  _max:=strtofloat(edTopLimit.Text);
  _step:=strtofloat(edStep.Text);
  x:=_min;
  _half:=0;
  while (x<_max) do
  begin
    _half:=_half+Compute(edFunction.Text,x,0,0,x);
    x:=x+_step;
  end;
  edResult.Text:=FloatToStr(_half);
end;

procedure TdlgRow.edBottomLimitKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9','.',#46,#8]) then
    Key:=#0;
end;

end.
