unit Graph_2D_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, AppEvnts, MathematicsFunc, Buttons, CheckLst;

type
  Twnd2D = class(TForm)
    pnlPad: TPanel;
    edFunction: TEdit;
    lbFunctionName: TLabel;
    edXmin: TEdit;
    edXmax: TEdit;
    edXdiv: TEdit;
    lbXmin: TLabel;
    lbXmax: TLabel;
    lbXdiv: TLabel;
    gbGrid: TGroupBox;
    cbDrawGrid: TCheckBox;
    edYdimension: TEdit;
    edXdimension: TEdit;
    lbX: TLabel;
    lbY: TLabel;
    btnDraw: TButton;
    gbAxis: TGroupBox;
    cbDrawXaxis: TCheckBox;
    cbDrawYaxis: TCheckBox;
    cbOutOfTheLimit: TCheckBox;
    sbZoomIn: TSpeedButton;
    sbZoomOut: TSpeedButton;
    gbGraphics: TGroupBox;
    clbGraphics: TCheckListBox;
    btnAdd: TSpeedButton;
    lbColor: TLabel;
    clBoxColors: TColorBox;
    procedure btnDrawClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgGraphMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgGraphMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgGraphMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cbDrawGridClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbZoomInMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbZoomInMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAddClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    procedure WMMOUSEWHEEL(var Msg:TMessage); message WM_MOUSEWHEEL;
    procedure WMMBUTTONDOWN(var Msg:TMessage); message WM_MBUTTONDOWN;
    { Private declarations }
  public
    procedure CreateGrid;
    procedure DrawGraphic;
    procedure LoadLanguage(_fileName: string);
    { Public declarations }
  end;

type
  TExtendValue=packed record
    Value:Extended;
    _IsValueExist:Boolean;
  end;

type
  T2DPoint=packed record
    x,y:single;
  end;

type
  TGraphInfo = packed record
    Formula:String;
    x_Min,x_Max,x_Step,x_Div:Single;
    drawX,drawY:boolean;
    color:TColor;
    ValuesArray:array of TExtendValue;
  end;

var
  wnd2D: Twnd2D;
  ImageCenter:T2DPoint;
  Zoom:Single;
  xa,ya:integer;
  _down:Boolean;
  _right:Boolean;
  _drawX,_drawY:Boolean;
  XMin,XMax,XStep,XDiv:Single;
  ChangeZoom:Boolean;
  Formula:string;
  Values:array of TExtendValue;
  Graphics:array of TGraphInfo;
  _lng:string;

implementation

uses CombineMain_u;

{$R *.dfm}

Function Compute(Func:String;X,Y,Z:Extended;var _IsFunctionExist:Boolean):Extended;
Var FuncResult:Extended;
    WorkFunc:TE;
begin
  if Parse_Line(Func,WorkFunc) then
  begin
    _IsFunctionExist:=Count_Func(true,WorkFunc,X,Y,Z,0,FuncResult);
    if _IsFunctionExist then
      Result:=FuncResult else
    Result:=0;
  end else
    Result:=0;
end;

procedure MoveToXY(x,y:single;Canvas:TCanvas);
begin
  Canvas.MoveTo(Trunc(ImageCenter.X+(x*Zoom)),Trunc(ImageCenter.Y-(y*Zoom)));
end;

procedure TextToXY(x,y:single;Text:String;Canvas:TCanvas);
begin
  Canvas.TextOut(Trunc(ImageCenter.X+(x*Zoom)),Trunc(ImageCenter.Y-(y*Zoom)),Text);
end;

procedure LineToXY(x,y:single;_color:TColor;Canvas:TCanvas);
var Temp:TColor;
begin
  Temp:=Canvas.Pen.Color;
  Canvas.Pen.Color:=_color;
  Canvas.LineTo(Trunc(ImageCenter.X+(x*Zoom)),Trunc(ImageCenter.y-(y*Zoom)));
  Canvas.Pen.Color:=Temp;
end;

procedure Twnd2D.cbDrawGridClick(Sender: TObject);
var b:boolean;
begin
  b:=cbDrawGrid.Checked;
  edYdimension.Enabled:=b;
  edXdimension.Enabled:=b;
end;

procedure Twnd2D.CreateGrid;
var x,y:integer;
    _x,_y:single;
    __x,__y:single;
procedure DrawPointer(x,y:Single;_horizontal:Boolean;_color:TColor);
begin
  if _horizontal then
    Begin
      MoveToXY(x,y,self.Canvas);
      LineToXY(x+0.7,y,_color,self.Canvas);
      LineToXY(x,y+0.1,_color,self.Canvas);
      LineToXY(x+0.1,y,_color,self.Canvas);
      LineToXY(x,y-0.1,_color,self.Canvas);
      LineToXY(x+0.7,y,_color,self.Canvas);
    End Else
    Begin
      MoveToXY(x,y,self.Canvas);
      LineToXY(x,y+0.7,_color,self.Canvas);
      LineToXY(x+0.1,y,_color,self.Canvas);
      LineToXY(x,y+0.1,_color,self.Canvas);
      LineToXY(x-0.1,y,_color,self.Canvas);
      LineToXY(x,y+0.7,_color,self.Canvas);
    End;
end;
begin
  if cbDrawGrid.Checked then
  begin
    For X:=-StrToInt(edXdimension.Text) to StrToInt(edXdimension.Text) Do
    begin
      MoveToXY(X,-StrToInt(edYdimension.Text),self.Canvas);
      LineToXY(x,StrToInt(edYdimension.Text),ColorConfig._2DGridColor,self.Canvas);
    end;
    For Y:=-StrToInt(edYdimension.Text) to StrToInt(edYdimension.Text) Do
    begin
      MoveToXY(-StrToInt(edXdimension.Text),Y,self.Canvas);
      LineToXY(StrToInt(edXdimension.Text),Y,ColorConfig._2DGridColor,self.Canvas);
    end;
  end;
  if _drawX then
  begin
    MoveToXY(-StrToInt(edXdimension.Text),0,self.Canvas);
    LineToXY(StrToInt(edXdimension.Text),0,ColorConfig._2DXaxisColor,self.Canvas);
  end;
  if _drawY then
  begin
    MoveToXY(0,-StrToInt(edYdimension.Text),self.Canvas);
    LineToXY(0,StrToInt(edYdimension.Text),ColorConfig._2DYaxisColor,self.Canvas);
  end;

  DrawPointer(StrToInt(edXdimension.Text),0,True,ColorConfig._2DXaxisColor);
  DrawPointer(0,StrToInt(edYdimension.Text),False,ColorConfig._2DYaxisColor);
  if _drawX then
  begin
    _x := -StrToFloat(edXdimension.Text);
    __x := StrToFloat(edXdimension.Text);
    while _x <= __x do
    begin
      if _x = Round(_x) then
      begin
        MoveToXY(_X ,-0.05,self.Canvas);
        LineToXY(_X ,0.05,ColorConfig._2DXaxisColor,self.Canvas);
        TextToXY(_X,-0.1,FloatToStr(_X),self.Canvas);
      end else
      begin
        MoveToXY(_X ,-0.03,self.Canvas);
        LineToXY(_X ,0.03,ColorConfig._2DXaxisColor,self.Canvas);
      end;
      _x := _x+0.25;
    end;
  end;
  {for X := -StrToInt(edXdimension.Text) to StrToInt(edXdimension.Text) do
  Begin
    MoveToXY(X ,-0.05,self.Canvas);
    LineToXY(X ,0.05,ColorConfig._2DXaxisColor,self.Canvas);
    TextToXY(X,-0.1,IntToStr(X),self.Canvas);
  End;}
  if _drawY then
    begin
    _y := -StrToFloat(edYdimension.Text);
    __y := StrToFloat(edYdimension.Text);
    while _y <= __y do
    begin
      if _y = 0 then
      begin
        _y := _y+0.25;
        Continue;
      end;
      if _Y = Round(_Y) then
      begin
        MoveToXY(-0.05 ,_y,self.Canvas);
        LineToXY(0.05 ,_y,ColorConfig._2DYaxisColor,self.Canvas);
        TextToXY(0.2, _y,FloatToStr(_Y),self.Canvas);
      end else
      begin
        MoveToXY(-0.03, _y,self.Canvas);
        LineToXY(0.03, _y,ColorConfig._2DYaxisColor,self.Canvas);
      end;
      _y := _y+0.25;
    end;
  end;
  {for Y := -StrToInt(edYdimension.Text) to StrToInt(edYdimension.Text) do
  Begin
    If Y=0 Then
      Continue;
    MoveToXY(-0.05,Y,self.Canvas);
    LineToXY(0.05,Y,ColorConfig._2DYaxisColor,self.Canvas);
    TextToXY(0.1,Y,IntToStr(Y),self.Canvas);
  End;}
end;

procedure Twnd2D.DrawGraphic;
var _xmin,_xmax:Integer;
    _x:single;
    Index,ItemIndex:Integer;
    a:trect;
begin
  a.Left:=pnlPad.Width;
  a.Top:=0;
  a.Right:=Width{-pnlPad.Width};
  a.Bottom:=Height;
  self.Canvas.FillRect(a);
  CreateGrid;
  //
  if clbGraphics.Items.Count = 0 then
  begin
    _xmin:=Round(XMin*XDiv);
    _xmax:=Round(XMax*XDiv);
    _x:=XMin;
    MoveToXY(_x,Values[_xmin].Value,Self.Canvas);
    for Index := _xmin to _xmax do
    begin
      if (Not Values[Abs(_xmin)+Index]._IsValueExist)or(((Values[Abs(_xmin)+index].Value>XMax)
          or(Values[Abs(_xmin)+index].Value<XMin)) and (not cbOutOfTheLimit.Checked)) then
      begin
        _x:=_x+XStep;
        MoveToXY(_x,Values[Abs(_xmin)+Index+1].Value,Self.Canvas);
        Continue;
      end;
      LineToXY(_x,Values[Abs(_xmin)+Index].Value,{ColorConfig._2DGraphColor}clBoxColors.Selected,Self.Canvas);
      _x:=_x+XStep;
    end;
    Exit;
  end;
  for ItemIndex := 0 to clbGraphics.Items.Count-1 do
  begin
    if not clbGraphics.Checked[ItemIndex] then Continue;
    xMin:=Graphics[ItemIndex].x_Min;
    xMax:=Graphics[ItemIndex].x_Max;
    xStep:=Graphics[ItemIndex].x_Step;
    xDiv:=Graphics[ItemIndex].x_Div;
    _drawX:=Graphics[ItemIndex].drawX;
    _drawY:=Graphics[ItemIndex].drawY;
    _xmin:=Round(XMin*XDiv);
    _xmax:=Round(XMax*XDiv);
    _x:=XMin;
    MoveToXY(_x,Graphics[ItemIndex].ValuesArray[_xmin].Value,Self.Canvas);
    for Index := _xmin to _xmax do
    begin
      if (Not Graphics[ItemIndex].ValuesArray[Abs(_xmin)+Index]._IsValueExist)or(((Graphics[ItemIndex].ValuesArray[Abs(_xmin)+index].Value>XMax)
          or(Graphics[ItemIndex].ValuesArray[Abs(_xmin)+index].Value<XMin)) and (not cbOutOfTheLimit.Checked)) then
      begin
        _x:=_x+XStep;
        MoveToXY(_x,Graphics[ItemIndex].ValuesArray[Abs(_xmin)+Index+1].Value,Self.Canvas);
        Continue;
      end;
      LineToXY(_x,Graphics[ItemIndex].ValuesArray[Abs(_xmin)+Index].Value,Graphics[ItemIndex].color,Self.Canvas);
      _x:=_x+XStep;
    end;
  end;
end;

procedure Twnd2D.btnAddClick(Sender: TObject);
var _b:boolean;
begin
  clbGraphics.Items.Add(edFunction.Text);
  clbGraphics.Checked[clbGraphics.Items.Count-1]:=True;
  //
  Graphics[clbGraphics.Items.Count-1].Formula:=edFunction.Text;
  Graphics[clbGraphics.Items.Count-1].X_Min:=(Compute(edXmin.Text,0,0,0,_b));
  Graphics[clbGraphics.Items.Count-1].X_Max:=(Compute(edXmax.Text,0,0,0,_b));
  Graphics[clbGraphics.Items.Count-1].X_Div:=Abs(Compute(edXdiv.Text,0,0,0,_b));
  Graphics[clbGraphics.Items.Count-1].X_Step:=((Abs(Graphics[clbGraphics.Items.Count-1].x_min)+
                                               Abs(Graphics[clbGraphics.Items.Count-1].x_max))/
                                               Graphics[clbGraphics.Items.Count-1].X_Div)/
                                               (Abs(Graphics[clbGraphics.Items.Count-1].x_min)+
                                               Abs(Graphics[clbGraphics.Items.Count-1].x_max));
  Graphics[clbGraphics.Items.Count-1].drawX:=cbDrawXaxis.Checked;
  Graphics[clbGraphics.Items.Count-1].drawY:=cbDrawYaxis.Checked;
  Graphics[clbGraphics.Items.Count-1].color:=clBoxColors.Selected;
  {if clbGraphics.Items.Count > 0 then
    btnDraw.Caption:='Draw checked graphics';}
end;

procedure Twnd2D.btnDrawClick(Sender: TObject);
var Index,ItemIndex:Integer;
    Val:Extended;
    _b:Boolean;
    _xmin,_xmax:Integer;
    _x:single;
begin
  if clbGraphics.Items.Count = 0 then
  begin
    Formula:=edFunction.Text;
    XMin:=(Compute(edXmin.Text,0,0,0,_b));
    XMax:=(Compute(edXmax.Text,0,0,0,_b));
    XDiv:=Abs(Compute(edXdiv.Text,0,0,0,_b));
    XStep:=((Abs(xmin)+Abs(xmax))/XDiv)/(Abs(xmin)+Abs(xmax));

    _drawX:=cbDrawXaxis.Checked;
    _drawY:=cbDrawYaxis.Checked;

    _xmin:=Round(XMin*XDiv);
    _xmax:=Round(XMax*XDiv);
    _x:=XMin;
    Setlength(Values,Abs(_xMin)+Abs(_xMax));
    for Index := _xmin to _xmax do
      begin
        Val:=Compute(Formula,_x,0,0,_b);
        Values[Abs(_xmin)+Index].Value:=Val;
        Values[Abs(_xmin)+Index]._IsValueExist:=_b;
        _x:=_x+XStep;
      end;
    DrawGraphic;
    Exit;
  End;
  for ItemIndex:=0 to clbGraphics.Items.Count -1 do
  begin
    if not clbGraphics.Checked[ItemIndex] then Continue;
    Formula:=Graphics[ItemIndex].Formula;
    xMin:=Graphics[ItemIndex].x_Min;
    xMax:=Graphics[ItemIndex].x_Max;
    xStep:=Graphics[ItemIndex].x_Step;
    xDiv:=Graphics[ItemIndex].x_Div;
    _drawX:=Graphics[ItemIndex].drawX;
    _drawY:=Graphics[ItemIndex].drawY;
    _xmin:=Round(XMin*XDiv);
    _xmax:=Round(XMax*XDiv);
    _x:=XMin;
    Setlength(Graphics[ItemIndex].ValuesArray,Abs(_xMin)+Abs(_xMax));
    for Index := _xmin to _xmax do
      begin
        Val:=Compute(Formula,_x,0,0,_b);
        Graphics[ItemIndex].ValuesArray[Abs(_xmin)+Index].Value:=Val;
        Graphics[ItemIndex].ValuesArray[Abs(_xmin)+Index]._IsValueExist:=_b;
        _x:=_x+XStep;
      end;
  end;
  DrawGraphic;
end;

procedure Twnd2D.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure Twnd2D.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  {FreeMem(@Graphics);
  FreeMem(@Values);}
end;

procedure Twnd2D.FormCreate(Sender: TObject);
begin
  SetLength(Values,1000);
  SetLength(Graphics,1000);
  ChangeZoom:=False;
  Tag:=2;
  ImageCenter.X:=((Self.Width-pnlPad.Width)/2)+pnlPad.Width;
  ImageCenter.Y:=Self.Height/2;
  Zoom:=50;
  //Self.DoubleBuffered:=True;
  _drawX:=cbDrawXaxis.Checked;
  _drawY:=cbDrawYaxis.Checked;
  CreateGrid;
  LoadLanguage(_lng);
end;

procedure Twnd2D.FormDestroy(Sender: TObject);
begin
  SetLength(Values,0);
  SetLength(Graphics,0);
end;

procedure Twnd2D.FormResize(Sender: TObject);
begin
  ImageCenter.X:=(Width/2)+(pnlPad.Width/2);
  ImageCenter.Y:=Height/2;
  DrawGraphic;
end;

procedure Twnd2D.imgGraphMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _down:=true;
  _right:=Button=mbRight;
  xa:=x;
  ya:=y;
end;

procedure Twnd2D.imgGraphMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var a:TRect;
begin
  If _down Then
  begin
    if not _right then
    begin
      //self.Picture:=nil;
      (*a.Left:=pnlPad.Width;
      a.Top:=0;
      a.Right:=Width{-pnlPad.Width};
      a.Bottom:=Height;
      self.Canvas.FillRect(a);  *)
      ImageCenter.x:=ImageCenter.x-Trunc(xa-x);
      ImageCenter.y:=ImageCenter.y-Trunc(ya-y);
    end else
      Zoom:=Zoom-(y-ya);
    DrawGraphic;
  end;
  xa:=x;
  ya:=y;
end;

procedure Twnd2D.imgGraphMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _down:=false;
  _right:=false;
end;

procedure Twnd2D.sbZoomInMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChangeZoom:=True;
  while ChangeZoom do
  begin
    Zoom:=Zoom+(Sender as TSpeedButton).Tag;
    DrawGraphic;
    Sleep(100);
    Application.HandleMessage;
  end;
end;

procedure Twnd2D.sbZoomInMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ChangeZoom:=False;
end;

procedure Twnd2D.WMMOUSEWHEEL(var Msg: TMessage);
var _factor:integer;
begin
  if Msg.WParam > 1 then
    _factor :=5
  else
    _factor := -5;
  Zoom:=Zoom+_factor;
  DrawGraphic;
  Application.HandleMessage;
end;

procedure Twnd2D.WMMBUTTONDOWN(var Msg: TMessage);
begin
  ImageCenter.X:=((Self.Width-pnlPad.Width)/2)+pnlPad.Width;
  ImageCenter.Y:=Self.Height/2;
  Zoom:=50;
  DrawGraphic;
end;

procedure Twnd2D.LoadLanguage(_fileName: string);
var index:integer;
    _dllHandle:THandle;

    function GetCaption(ID:cardinal):string;
    var buff:array [0..$FF] of Char;
    begin
      Result := '';
      if LoadString(_dllHandle,ID,@buff,$FF) >0 then
        Result := buff;
    end;

begin
  if not FileExists(_fileName) then
    Exit;
  _dllHandle := LoadLibrary(PWideChar(_fileName));
  if _dllHandle = 0 then
    Exit;
  lbFunctionName.Caption := GetCaption(129);
  lbXmin.Caption := GetCaption(130);
  lbXmax.Caption := GetCaption(131);
  lbXdiv.Caption := GetCaption(132);
  lbColor.Caption := GetCaption(133);
  gbGrid.Caption := GetCaption(134);
  cbDrawGrid.Caption := GetCaption(135);
  lbY.Caption := GetCaption(136);
  lbX.Caption := GetCaption(137);
  gbAxis.Caption := GetCaption(138);
  cbDrawXaxis.Caption := GetCaption(139);
  cbDrawYaxis.Caption := GetCaption(140);
  gbGraphics.Caption := GetCaption(141);
  cbOutOfTheLimit.Caption := GetCaption(142);
  btnDraw.Caption := GetCaption(143);
  FreeLibrary(_dllHandle);
end;

end.
