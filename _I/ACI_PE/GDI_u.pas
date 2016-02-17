unit GDI_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  Twnd2D = class(TForm)
    pbGraph: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    PointList:TList;
    _AxisX,_AxisY:Single;
    procedure DrawGraphic;
    { Public declarations }
  end;

type T2Dpoint=packed record
  X,Y:Single;
  _move:Boolean;
end;  

type P2Dpoint=^T2Dpoint;

var
  wnd2D: Twnd2D;
  _center:T2Dpoint;
  _Zoom:Single;
  xa,ya:integer;
  _down:Boolean;

implementation

{$R *.dfm}

procedure MoveToXY(x,y:single);
begin
  wnd2D.pbGraph.Canvas.MoveTo(Trunc(_center.X+(x*_Zoom)),Trunc(_center.Y-(y*_Zoom)));
end;

procedure TextToXY(x,y:single;Text:String);
begin
  wnd2D.pbGraph.Canvas.TextOut(Trunc(_center.X+(x*_Zoom)),Trunc(_center.Y-(y*_Zoom)),Text);
end;

procedure LineToXY(x,y:single;_color:TColor);
var Temp:TColor;
begin
  Temp:=wnd2D.Canvas.Pen.Color;
  wnd2D.pbGraph.Canvas.Pen.Color:=_color;
  wnd2D.pbGraph.Canvas.LineTo(Trunc(_center.X+(x*_Zoom)),Trunc(_center.y-(y*_Zoom)));
  wnd2D.pbGraph.Canvas.Pen.Color:=Temp;
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
  if true Then
    begin
      For X:=-Round(wnd2D._AxisX) to Round(wnd2D._AxisX) Do
        begin
          MoveToXY(X,-wnd2D._AxisY);
          LineToXY(x,wnd2D._AxisY,clSilver);
        end;
      For Y:=-Round(wnd2D._AxisY) to Round(wnd2D._AxisY) Do
        begin
          MoveToXY(-wnd2D._AxisX,Y);
          LineToXY(wnd2D._AxisX,Y,clSilver);
        end;
    end;   
  MoveToXY(-wnd2D._AxisX,0);
  LineToXY(wnd2D._AxisX,0,clRed);
  MoveToXY(0,-wnd2D._AxisY);
  LineToXY(0,wnd2D._AxisY,clLime);
  DrawPointer(wnd2D._AxisX,0,True,clRed);
  DrawPointer(0,wnd2D._AxisY,False,clLime);
  
  for X := -Round(wnd2D._AxisX) to Round(wnd2D._AxisX) do
    Begin
      MoveToXY(X,-0.05);
      LineToXY(X,0.05,clRed);
      TextToXY(X,-0.1,IntToStr(X));
    End;

  for Y := -Round(wnd2D._AxisY) to Round(wnd2D._AxisY) do
    Begin
      If Y=0 Then
        Continue;
      MoveToXY(-0.05,Y);
      LineToXY(0.05,Y,clLime);
      TextToXY(0.1,Y,IntToStr(Y));
    End;
end;

function GetPoint(_point:P2Dpoint):T2Dpoint;
begin
  Result:=_point^;
end;

procedure Twnd2D.DrawGraphic;
var Index:LongWord;
    _start:T2Dpoint;
begin
  pbGraph.Picture:=nil;
  CreateGrid;
  MoveToXY(0,0);
  if PointList.Count=0 then Exit;
  for Index:=0 to PointList.Count-1 do
    begin
      _start:=GetPoint(PointList.Items[Index]);
      if _start._move then
        MoveToXY(_start.X,_start.Y)
      else
        LineToXY(_start.X,_start.Y,clGray);
    end;    
end;

procedure Twnd2D.FormCreate(Sender: TObject);
begin
  _AxisX:=10;
  _AxisY:=5;
  PointList:=TList.Create;
  _center.X:=Self.Width/2;
  _center.Y:=Self.Height/2;
  _Zoom:=50;
end;

procedure Twnd2D.FormDestroy(Sender: TObject);
begin
  PointList.Free;
end;

procedure Twnd2D.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _down:=True;
  xa:=x;
  ya:=y;
end;

procedure Twnd2D.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If _down Then
    begin
      _center.x:=_center.x-Trunc(xa-x);
      _center.y:=_center.y-Trunc(ya-y);
      DrawGraphic;
    end;
  xa:=x;
  ya:=y;
end;

procedure Twnd2D.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _down:=False;
end;

procedure Twnd2D.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if WheelDelta>0 then
    _zoom:=_zoom+3
  else
    _zoom:=_zoom-3;
  DrawGraphic;
end;

end.
