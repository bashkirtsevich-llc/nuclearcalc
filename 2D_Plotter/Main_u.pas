unit Main_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, MathematicsFunc, ComCtrls, AppEvnts;

type
  TForm1 = class(TForm)
    imgGraph: TImage;
    pnlMain: TPanel;
    lbXmin: TLabel;
    lbXmax: TLabel;
    lbXdv: TLabel;
    btnDrawGraph: TButton;
    TrackBar1: TTrackBar;
    edFunction: TEdit;
    edXmin: TEdit;
    edXmax: TEdit;
    edXdiv: TEdit;
    cbDrawGrid: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure imgGraphMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgGraphMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgGraphMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnDrawGraphClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  T2DPoint=packed record
    x,y:single;
  end;

type
  TExtended=packed record
    Value:Extended;
    _isFunctionExists:Boolean;
  end;

var
  Form1: TForm1;
  ImageCenter:T2DPoint;
  Zoom:Single;
  xa,ya:integer;
  _down:Boolean;
  XMin,XMax,XStep,XDiv:Single;
  Vals:Array [-1000..1000] Of TExtended;

implementation

{$R *.dfm}

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

procedure MoveToXY(x,y:single);
begin
  Form1.imgGraph.Canvas.MoveTo(Trunc(ImageCenter.X+(x*Zoom)),Trunc(ImageCenter.Y-(y*Zoom)));
end;

procedure TextToXY(x,y:single;Text:String);
begin
  Form1.imgGraph.Canvas.TextOut(Trunc(ImageCenter.X+(x*Zoom)),Trunc(ImageCenter.Y-(y*Zoom)),Text);
end;

procedure LineToXY(x,y:single;_color:TColor);
var Temp:TColor;
begin
  Temp:=Form1.imgGraph.Canvas.Pen.Color;
  Form1.imgGraph.Canvas.Pen.Color:=_color;
  Form1.imgGraph.Canvas.LineTo(Trunc(ImageCenter.X+(x*Zoom)),Trunc(ImageCenter.y-(y*Zoom)));
  Form1.imgGraph.Canvas.Pen.Color:=Temp;
end;

procedure CreateGrid;
var X,Y:Integer;
procedure DrawPointer(x,y:Single;_horizontal:Boolean;_color:TColor);
begin
  if _horizontal then
    Begin
      MoveToXY(x,y);
      LineToXY(x+0.7,y,_color);
      LineToXY(x,y+0.1,_color);
      LineToXY(x+0.1,y,_color);
      LineToXY(x,y-0.1,_color);
      LineToXY(x+0.7,y,_color);
    End Else
    Begin
      MoveToXY(x,y);
      LineToXY(x,y+0.7,_color);
      LineToXY(x+0.1,y,_color);
      LineToXY(x,y+0.1,_color);
      LineToXY(x-0.1,y,_color);
      LineToXY(x,y+0.7,_color);
    End;

end;
begin
  if Form1.cbDrawGrid.Checked Then
    begin
      For X:=-10 to 10 Do
        begin
          MoveToXY(X,-10);
          LineToXY(x,10,clSilver);
        end;
      For Y:=-10 to 10 Do
        begin
          MoveToXY(-10,Y);
          LineToXY(10,Y,clSilver);
        end;
    end;   
  MoveToXY(-10,0);
  LineToXY(10,0,clRed);
  MoveToXY(0,-10);
  LineToXY(0,10,clLime);
  DrawPointer(10,0,True,clRed);
  DrawPointer(0,10,False,clLime);
  
  for X := -10 to 10 do
    Begin
      MoveToXY(X,-0.05);
      LineToXY(X,0.05,clRed);
      TextToXY(X,-0.1,IntToStr(X));
    End;

  for Y := -10 to 10 do
    Begin
      If Y=0 Then
        Continue;
      MoveToXY(-0.05,Y);
      LineToXY(0.05,Y,clLime);
      TextToXY(0.1,Y,IntToStr(Y));
    End;
end;

procedure DrawGraphic;
var _xmin,_xmax:Integer;
    _x:single;
    Index:Integer;
begin
  Form1.imgGraph.Picture:=Nil;
  CreateGrid;
  //
  _xmin:=Round(XMin*XDiv);
  _xmax:=Round(XMax*XDiv);
  _x:=XMin;
  MoveToXY(_x,Vals[_xmin].Value);
  for Index := _xmin to _xmax do
    begin
      if (Not Vals[Index]._isFunctionExists)or(vals[index].Value>XMax)
          or(vals[index].Value<XMin) then
        begin
          _x:=_x+XStep;
          MoveToXY(_x,Vals[Index+1].Value);
          Continue;
        end;
      LineToXY(_x,Vals[Index].Value,clGray);
      _x:=_x+XStep;
    end;
end;

procedure TForm1.btnDrawGraphClick(Sender: TObject);
var Index:Integer;
    Val:Extended;
    _b:Boolean;
    _xmin,_xmax:Integer;
    _x:single;
begin
  XMin:=StrToFloat(edXmin.Text);                                                 
  XMax:=StrToFloat(edXmax.Text);
  XDiv:=StrToFloat(edXdiv.Text);
  XStep:=((Module(xmin)+module(xmax))/XDiv)/(Module(xmin)+module(xmax));
  
  _xmin:=Round(XMin*XDiv);
  _xmax:=Round(XMax*XDiv);
  _x:=XMin;
  for Index := _xmin to _xmax do
    begin
      Val:=Compute(edFunction.Text,_x,0,0,_b);
      Vals[Index].Value:=Val;
      Vals[Index]._isFunctionExists:=_b;
      _x:=_x+XStep;
    end;
  DrawGraphic;    
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ImageCenter.X:=imgGraph.Width/2;
  ImageCenter.Y:=imgGraph.Height/2;
  Zoom:=50;
  DrawGraphic;
  Self.DoubleBuffered:=True;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  DrawGraphic;
end;

procedure TForm1.imgGraphMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _down:=True;
  xa:=x;
  ya:=y;
end;

procedure TForm1.imgGraphMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If _down Then
    begin
      ImageCenter.x:=ImageCenter.x-Trunc(xa-x);
      ImageCenter.y:=ImageCenter.y-Trunc(ya-y);
      DrawGraphic;
    end;
  xa:=x;
  ya:=y;
  //Caption:=Format('x=%f y=%f',[(-(ImageCenter.x-x)/Zoom),((ImageCenter.y-y)/Zoom)]);
  imgGraph.Canvas.TextOut(10,10,Format('x=%f y=%f',[(-(ImageCenter.x-x)/Zoom),((ImageCenter.y-y)/Zoom)]));
end;

procedure TForm1.imgGraphMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _down:=False;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Zoom:=TrackBar1.Position*5;
  DrawGraphic;
end;

end.
