unit Integral_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MathematicsFunc, Icons_u, Buttons, ExtCtrls;

type
  TdlgIntegral = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    lbIntegralType: TLabel;
    cbIntegralType: TComboBox;
    lbTopLimit: TLabel;
    edXTopLimit: TEdit;
    lbBottomLimit: TLabel;
    edXBottomLimit: TEdit;
    lbfx: TLabel;
    edFunction: TEdit;
    lbFx1: TLabel;
    edFx1: TEdit;
    lbFy1: TLabel;
    edFy1: TEdit;
    lbResult: TLabel;
    edResult: TEdit;
    edFx2: TEdit;
    edFy2: TEdit;
    edYTopLimit: TEdit;
    edYBottomLimit: TEdit;
    imgVisualisation: TImage;
    procedure cbIntegralTypeChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
  private
    procedure ComputeIntegral;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgIntegral: TdlgIntegral;

implementation

{$R *.dfm}
                          
function ComputeFunc(func:String;x,y,z:Extended):Extended;
var R:TE;
    _result:Extended;
begin                                                 
  Result:=0;
  if Parse_Line(func,R) then
    if Count_func(True,R,x,y,z,0,_result) then
      Result:=_result;
end;

procedure DrawAsPicture(Canvas:TCanvas;TopLimit,BottomLimit,Func,FuncResult:String;Doubled:Boolean);
var _IntBmp:TBitmap;
    Data:TMemoryStream;
    a:TRect;
begin
  Data:=TMemoryStream.Create;
  Data.Write(bmp_integraldata,SizeOf(bmp_integraldata));
  Data.Position:=0;
  _IntBmp:=TBitmap.Create;
  _IntBmp.LoadFromStream(Data);
  Data.Free;
  //
  a.Left:=0;
  a.Top:=0;
  a.Right:=500;
  a.Bottom:=100;
  Canvas.Brush.Color:=clBtnFace;
  Canvas.FillRect(a);
  Canvas.Font.Style:=[fsItalic,fsBold];
  Canvas.Draw(4,16,_IntBmp); //Draw integral symbol
  Canvas.TextOut(26,2,TopLimit); //Draw top limit
  Canvas.TextOut(2,54,BottomLimit); //Draw bottom limit
  Canvas.TextOut(28,29,Format('%s=%s',[Func,FuncResult])); //Draw function
  Canvas.Font.Style:=[];
end;

procedure TdlgIntegral.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TdlgIntegral.btnOkClick(Sender: TObject);
var {Diff,}TopLim,BotLim:String;
begin
  ComputeIntegral;
  case cbIntegralType.ItemIndex of
    0:begin
    //Diff:='dx';
    TopLim:=edXTopLimit.Text;
    BotLim:=edXBottomLimit.Text;
    end;
    1:begin
    //Diff:='dy';
    TopLim:=edYTopLimit.Text;
    BotLim:=edYBottomLimit.Text;
    end;
    2:begin
    //Diff:='dxdy';
    end;
  end;
  DrawAsPicture(imgVisualisation.Canvas,TopLim,BotLim,edFunction.Text,edResult.Text,False);
end;

procedure TdlgIntegral.cbIntegralTypeChange(Sender: TObject);
begin
  case cbIntegralType.ItemIndex of
    0:begin
      lbfx.Caption:='F(x)';
      edYTopLimit.Enabled:=False;
      edYBottomLimit.Enabled:=False;
      edXTopLimit.Enabled:=True;
      edXBottomLimit.Enabled:=True;
      lbTopLimit.Caption:='Top limit (x):';
      lbBottomLimit.Caption:='Bottom limit (x):';
      edFy1.Enabled:=False;
      edFy2.Enabled:=False;
      edFx1.Enabled:=True;
      edFx2.Enabled:=True;
    end;
    1:begin
      lbfx.Caption:='F(y)';
      edYTopLimit.Enabled:=True;
      edYBottomLimit.Enabled:=True;
      edXTopLimit.Enabled:=False;
      edXBottomLimit.Enabled:=False;
      lbTopLimit.Caption:='Top limit (y):';
      lbBottomLimit.Caption:='Bottom limit (y):';
      edFy1.Enabled:=True;
      edFy2.Enabled:=True;
      edFx1.Enabled:=False;
      edFx2.Enabled:=False;
    end;
    2:begin
      lbfx.Caption:='F(x,y)';
      edYTopLimit.Enabled:=True;
      edYBottomLimit.Enabled:=True;
      edXTopLimit.Enabled:=True;
      edXBottomLimit.Enabled:=True;
      lbTopLimit.Caption:='Top limit (x,y):';
      lbBottomLimit.Caption:='Bottom limit (x,y):';
      edFy1.Enabled:=True;
      edFy2.Enabled:=True;
      edFx1.Enabled:=True;
      edFx2.Enabled:=True;
    end;
  end;
end;

procedure TdlgIntegral.ComputeIntegral;
var func:string;
    Fx1,Fx2,Fy1,Fy2:Extended;
    //_result:String;
    xmin,xmax,ymin,ymax:Extended;
begin
  func:=edFunction.Text;
  xmin:=ComputeFunc(edXBottomLimit.Text,0,0,0);
  xmax:=ComputeFunc(edXTopLimit.Text,0,0,0);
  ymin:=ComputeFunc(edYBottomLimit.Text,0,0,0);
  ymax:=ComputeFunc(edYTopLimit.Text,0,0,0);
  case cbIntegralType.ItemIndex of
    0:begin
      Fx1:=ComputeFunc(edFunction.Text,xmin,0,0);
      Fx2:=ComputeFunc(edFunction.Text,xmax,0,0);
      edFx1.Text:=FloatToStr(Fx1);
      edFx2.Text:=FloatToStr(Fx2);
      edResult.Text:=FloatToStr(Fx2-Fx1);
    end;
    1:begin
      Fy1:=ComputeFunc(edFunction.Text,0,ymin,0);
      Fy2:=ComputeFunc(edFunction.Text,0,ymax,0);
      edFy1.Text:=FloatToStr(Fy1);
      edFy2.Text:=FloatToStr(Fy2);
      edResult.Text:=FloatToStr(Fy2-Fy1);
    end;
    2:begin
      Fx1:=ComputeFunc(edFunction.Text,xmin,0,0);
      Fx2:=ComputeFunc(edFunction.Text,xmax,0,0);
      Fy1:=ComputeFunc(edFunction.Text,0,ymin,0);
      Fy2:=ComputeFunc(edFunction.Text,0,ymax,0);
      edFx1.Text:=FloatToStr(Fx1);
      edFx2.Text:=FloatToStr(Fx2);
      edFy1.Text:=FloatToStr(Fy1);
      edFy2.Text:=FloatToStr(Fy2);
      edResult.Text:=FloatToStr((Fx2-Fx1)*(Fy2-Fy1));
    end;
  end;

end;

procedure TdlgIntegral.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

end.
