unit Main_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math, MathematicsFunc;

type
  TForm1 = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
    procedure WMMOUSEWHEEL(var msg:TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TVect = packed record
    x,y:Extended;
  end;
  TCenter = packed record
    x,y:Integer;
  end;

var
  Form1: TForm1;
  zoom:Integer = 20;
  center:TCenter;
  _dwn:Boolean;
  
implementation

{$R *.dfm}

function Circle(fi,r:Single):tvect;
begin
  Circle.x:=r*cos(fi);
  Circle.y:=r*sin(fi);
end;

function MoveToYPolar(y,Fi:Single):bool;
var vect:TVect;
begin
 vect := Circle(Fi,y);
 form1.Canvas.MoveTo(Round(vect.x*zoom)+center.x,Round(vect.y*zoom)+center.y);
 Result := True;
end;

function LineToYPolar(y,Fi:Single):bool;
var vect:TVect;
begin
 vect := Circle(Fi,y);
 form1.Canvas.LineTo(Round(vect.x*zoom)+center.x,Round(vect.y*zoom)+center.y);
 Result := True;
end;

function TextToYPolar(y,Fi:Single; Text:string):bool;
var vect:TVect;
begin
 vect := Circle(Fi,y);
 form1.Canvas.TextOut(Round(vect.x*zoom)+center.x,Round(vect.y*zoom)+center.y,Text);
 Result := True;
end;

function Calulate(formula:string; x,y,z,fi:Extended):Extended;
var R:TE;
begin
 Result := NaN;  
 if Parse_Line(formula,R) then
  Count_Func(True,R,x,y,z,0,fi,Result);
end;

function DrawPolarSystem():BOOL;
var fi:Single;
    vect:tvect;
    i:Integer;
    step:Single;
begin
 form1.Canvas.Brush.Color := clWhite;
 form1.Canvas.FillRect(Form1.ClientRect);
 step := (15 * (PI / 180));
 fi := 0;
 Form1.Canvas.Pen.Color := clLime;
 while fi <= 2*Pi do
 begin
  MoveToYPolar(0,0);
  vect := Circle(fi, zoom);
  //Form1.Canvas.LineTo(Round(vect.x*zoom)+center.x,Round(vect.y*zoom)+center.y);
  LineToYPolar(10,fi);
  //TextToYPolar(zoom,fi,FloatToStr(Fi));
  fi := fi + step;
 end;
 Form1.Canvas.Pen.Color := clRed;
 for i := 1 to 10 do
 begin
  fi := 0;
  while fi <= (pi*2) do
  begin
   MoveToYPolar(i,fi-0.01);
   LineToYPolar(i,fi+0.01);
   //TextToYPolar(i*(zoom/5)+1,fi,FloatToStr(i));
   fi := fi + 0.04; {step}
  end;
 end;
 Result := True;
end;

procedure TForm1.btn1Click(Sender: TObject);
var fi:Single; i:Integer;
begin
 DrawPolarSystem();
 fi := 0;
 Canvas.Pen.Color := clGray;
 MoveToYPolar(1+cos(fi*8)/8,fi);
 while fi <= 2*pi do
 begin
  LineToYPolar(1+cos(fi*8)/8,fi);
  fi := fi + 0.01;
 end;
end;

procedure TForm1.WMMOUSEWHEEL(var msg:TWMMouseWheel);
begin
 if msg.WheelDelta >0 then Inc(zoom,5);
 if msg.WheelDelta <0 then Dec(zoom,5);
 btn1Click(btn1);
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _dwn := True;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  _dwn := False;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if _dwn then
begin
  center.x := x;
  center.y := y;
  btn1Click(btn1);
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 center.x:=Width div 2;
 center.y:=Height div 2;
end;

end.
