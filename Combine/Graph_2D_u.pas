unit Graph_2D_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, AppEvnts, MathematicsFunc, Buttons;

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
    imgGraph: TImage;
    btnDraw: TButton;
    gbAxis: TGroupBox;
    cbDrawXaxis: TCheckBox;
    cbDrawYaxis: TCheckBox;
    cbOutOfTheLimit: TCheckBox;
    sbZoomIn: TSpeedButton;
    sbZoomOut: TSpeedButton;
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
    procedure sbZoomInClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CreateGrid;
    procedure DrawGraphic;
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

  TVals=array[-1000..1000]of TExtendValue;
  PVals=^TVals;

var
  wnd2D: Twnd2D;
  ImageCenter:T2DPoint;
  Zoom:Single;
  xa,ya:integer;
  _down:Boolean;
  _right:Boolean;
  _drawX,_drawY:Boolean;
  Vals:{array[-1000..1000] of TExtendValue;}TVals;
  XMin,XMax,XStep,XDiv:Single;
  
implementation

uses CombineMain_u;

{$R *.dfm}

function GetArrayValue(A:PVals;X:Integer):TExtendValue;
var Temp:TExtendValue;
begin
  Temp:=A^[X];
  Result:=Temp;
end;

function Module(x:Extended):Extended;
begin
  If x<0 Then
    Result:=x*-1
  else
    Result:=x;
end;

Function Compute(Func:String;X,Y,Z:Extended;var _IsFunctionExist:Boolean):Extended;
Var FuncResult:Extended;
    WorkFunc:TE;
begin
  if Parse_Line(Func,WorkFunc) then
    begin
      _IsFunctionExist:=Count_Func(true,WorkFunc,X,Y,Z,FuncResult);
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
procedure DrawPointer(x,y:Single;_horizontal:Boolean;_color:TColor);
begin
  if _horizontal then
    Begin
      MoveToXY(x,y,self.imgGraph.Canvas);
      LineToXY(x+0.7,y,_color,self.imgGraph.Canvas);
      LineToXY(x,y+0.1,_color,self.imgGraph.Canvas);
      LineToXY(x+0.1,y,_color,self.imgGraph.Canvas);
      LineToXY(x,y-0.1,_color,self.imgGraph.Canvas);
      LineToXY(x+0.7,y,_color,self.imgGraph.Canvas);
    End Else
    Begin
      MoveToXY(x,y,self.imgGraph.Canvas);
      LineToXY(x,y+0.7,_color,self.imgGraph.Canvas);
      LineToXY(x+0.1,y,_color,self.imgGraph.Canvas);
      LineToXY(x,y+0.1,_color,self.imgGraph.Canvas);
      LineToXY(x-0.1,y,_color,self.imgGraph.Canvas);
      LineToXY(x,y+0.7,_color,self.imgGraph.Canvas);
    End;
end;
begin
  if cbDrawGrid.Checked then
    begin
      For X:=-StrToInt(edXdimension.Text) to StrToInt(edXdimension.Text) Do
        begin
          MoveToXY(X,-StrToInt(edYdimension.Text),self.imgGraph.Canvas);
          LineToXY(x,StrToInt(edYdimension.Text),ColorConfig._2DGridColor,self.imgGraph.Canvas);
        end;
      For Y:=-StrToInt(edYdimension.Text) to StrToInt(edYdimension.Text) Do
        begin
          MoveToXY(-StrToInt(edXdimension.Text),Y,self.imgGraph.Canvas);
          LineToXY(StrToInt(edXdimension.Text),Y,ColorConfig._2DGridColor,self.imgGraph.Canvas);
        end;
    end;
  if _drawX then
    begin
      MoveToXY(-StrToInt(edXdimension.Text),0,self.imgGraph.Canvas);
      LineToXY(StrToInt(edXdimension.Text),0,ColorConfig._2DXaxisColor,self.imgGraph.Canvas);
    end;
  if _drawY then
    begin
      MoveToXY(0,-StrToInt(edYdimension.Text),self.imgGraph.Canvas);
      LineToXY(0,StrToInt(edYdimension.Text),ColorConfig._2DYaxisColor,self.imgGraph.Canvas);
    end;

  DrawPointer(StrToInt(edXdimension.Text),0,True,ColorConfig._2DXaxisColor);
  DrawPointer(0,StrToInt(edYdimension.Text),False,ColorConfig._2DYaxisColor);
  if _drawX then
  for X := -StrToInt(edXdimension.Text) to StrToInt(edXdimension.Text) do
    Begin
      MoveToXY(X,-0.05,self.imgGraph.Canvas);
      LineToXY(X,0.05,ColorConfig._2DXaxisColor,self.imgGraph.Canvas);
      TextToXY(X,-0.1,IntToStr(X),self.imgGraph.Canvas);
    End;
  if _drawY then
  for Y := -StrToInt(edYdimension.Text) to StrToInt(edYdimension.Text) do
    Begin
      If Y=0 Then
        Continue;
      MoveToXY(-0.05,Y,self.imgGraph.Canvas);
      LineToXY(0.05,Y,ColorConfig._2DYaxisColor,self.imgGraph.Canvas);
      TextToXY(0.1,Y,IntToStr(Y),self.imgGraph.Canvas);
    End;
end;

procedure Twnd2D.DrawGraphic;
var _xmin,_xmax:Integer;
    _x:single;
    Index:Integer;
begin
  imgGraph.Picture:=Nil;
  CreateGrid;
  //
  _xmin:=Round(XMin*XDiv);
  _xmax:=Round(XMax*XDiv);
  _x:=XMin;
  MoveToXY(_x,GetArrayValue(@Vals,_xmin).Value,Self.imgGraph.Canvas);
  for Index := _xmin to _xmax do
    begin
      if (Not GetArrayValue(@Vals,Index)._IsValueExist)or(((GetArrayValue(@Vals,index).Value>XMax)
          or(GetArrayValue(@Vals,index).Value<XMin)) and (not cbOutOfTheLimit.Checked)) then
        begin
          _x:=_x+XStep;
          MoveToXY(_x,GetArrayValue(@Vals,Index+1).Value,Self.imgGraph.Canvas);
          Continue;
        end;
      LineToXY(_x,GetArrayValue(@Vals,Index).Value,ColorConfig._2DGraphColor,Self.imgGraph.Canvas);
      _x:=_x+XStep;
    end;
end;

procedure Twnd2D.btnDrawClick(Sender: TObject);
var Index:Integer;
    Val:Extended;
    _b:Boolean;
    _xmin,_xmax:Integer;
    _x:single;
    function Sign(X:Integer):integer;
    begin
      if X>1 then result:=x
        else
      result:=-x;
    end;
begin
  XMin:=Compute(edXmin.Text,0,0,0,_b);
  XMax:=Compute(edXmax.Text,0,0,0,_b);
  XDiv:=Compute(edXdiv.Text,0,0,0,_b);
  XStep:=((Module(xmin)+module(xmax))/XDiv)/(Module(xmin)+module(xmax));

  _drawX:=cbDrawXaxis.Checked;
  _drawY:=cbDrawYaxis.Checked;

  _xmin:=Round(XMin*XDiv);
  _xmax:=Round(XMax*XDiv);
  _x:=XMin;
  //SetLength(Vals,Sign(_xmin)+Sign(_xmax));
  for Index := _xmin to _xmax do
    begin
      Val:=Compute(edFunction.Text,_x,0,0,_b);
      Vals[Index].Value:=Val;
      Vals[Index]._IsValueExist:=_b;
      _x:=_x+XStep;
    end;
  DrawGraphic;
end;

procedure Twnd2D.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure Twnd2D.FormCreate(Sender: TObject);
begin
  Tag:=2;
  ImageCenter.X:=imgGraph.Width/2;
  ImageCenter.Y:=imgGraph.Height/2;
  Zoom:=50;
  Self.DoubleBuffered:=True;
  _drawX:=cbDrawXaxis.Checked;
  _drawY:=cbDrawYaxis.Checked;
  CreateGrid;
end;

procedure Twnd2D.FormResize(Sender: TObject);
begin
  ImageCenter.X:=imgGraph.Width/2;
  ImageCenter.Y:=imgGraph.Height/2;
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
begin
  If _down Then
    begin
      if not _right then
        begin
          self.imgGraph.Picture:=nil;
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

procedure Twnd2D.sbZoomInClick(Sender: TObject);
begin
  Zoom:=Zoom+(Sender as TSpeedButton).Tag;
  DrawGraphic;
end;

end.
