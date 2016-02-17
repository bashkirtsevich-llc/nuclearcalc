unit Main_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, inifiles, ImgList;

type
  TwndMain = class(TForm)
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    procedure LoadIni(FName:String);
    { Public declarations }
  end;

type
  TExtendRect=packed record
    left,right,top,bottom:integer;
    index:integer;
    Name:string;
  end;

var
  wndMain: TwndMain;
  rectcount:integer;
  rects:array of TExtendRect;
  FGbmp,Mask:TBitmap;
  isMask:boolean;

implementation

{$R *.dfm}

function PointInRect(P:TPoint;rect:TExtendRect):boolean;
begin
  Result:=((p.X>rect.Left)and(p.x<rect.Right))and((p.Y>rect.Top)and(p.Y<rect.Bottom));
end;

procedure TwndMain.LoadIni(FName:string);
var ini:TIniFile;
    bmpName:string;
    index:integer;
    rectsection:string;
    btns:tbitmap;
const
    Section:string='Main';
begin
  if not FileExists(FName) then Exit;
  ini:=TIniFile.Create(FName);
  bmpName:=ini.ReadString(Section,'ForeGround','');
  FGbmp:=TBitmap.Create;
  if FileExists(bmpName) then
    FGbmp.LoadFromFile(bmpName);
  bmpName:=ini.ReadString(Section,'Mask','');
  Mask:=TBitmap.Create;
  isMask:= FileExists(bmpName);
  if isMask then
    Mask.LoadFromFile(bmpName);
  rectcount:=ini.ReadInteger(Section,'RectCount',0);
  Setlength(rects,rectcount);
  Self.Height:=ini.ReadInteger(section,'Height',Height);
  Self.Width:=ini.ReadInteger(section,'width',width);
  Self.BorderStyle:=bsNone;
  Self.Position:=poScreenCenter;
  self.ImageList1.Height:=ini.ReadInteger(section,'b_height',0);
  self.ImageList1.Width:=ini.ReadInteger(section,'b_width',0);
  {self.ImageList2.Height:=ini.ReadInteger(section,'b_height',0);
  self.ImageList2.Width:=ini.ReadInteger(section,'b_width',0);}
  btns:=TBitmap.Create;
  bmpName:=ini.ReadString(Section,'lightbuttons','');
  if fileexists(bmpName) then
    btns.LoadFromFile(bmpName);
  imagelist1.Add(btns,nil);
  //
  {bmpName:=ini.ReadString(Section,'lightbuttons','');
  if fileexists(bmpName) then
    btns.LoadFromFile(bmpName);
  imagelist2.Add(btns,nil);}
  for index:=0 to rectcount-1 do
  begin
    rectsection:=Format('Rect %d',[index]);
    rects[index].Left:=ini.ReadInteger(rectsection,'Left',0);
    rects[index].Top:=ini.ReadInteger(rectsection,'Top',0);
    rects[index].Right:=ini.ReadInteger(rectsection,'Right',0);
    rects[index].Bottom:=ini.ReadInteger(rectsection,'Bottom',0);
    rects[index].Name:=ini.ReadString(rectsection,'Name','');
    rects[index].index:=index;
  end;
  ini.Free;
end;

procedure TwndMain.FormCreate(Sender: TObject);
begin
  LoadIni(ExtractFileDir(ParamStr(0))+'\Simply.ini');
end;

procedure TwndMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var index:integer;
begin
  if rectcount<=0 then Exit;
  for index:=0 to rectcount-1 do
    if PointInRect(Point(X,Y),rects[index]) then
    begin
      if isMask then
        if Mask.Canvas.Pixels[x,y]<>clWhite then
          Exit;
      if Cursor=crHandPoint then Exit;
      Cursor:=crHandPoint;
      imagelist1.Draw(canvas,rects[index].left,rects[index].top,index-2);
      Exit;
    end else
      Cursor:=crDefault;
  if Cursor = crDefault then
    Self.Canvas.Draw(0,0,FGbmp);
end;

procedure TwndMain.FormPaint(Sender: TObject);
begin
  Self.Canvas.Draw(0,0,FGbmp);
end;

procedure TwndMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var index:integer;
const SC_DRAGMOVE=$F012;
begin
  if rectcount<=0 then Exit;
  for index:=0 to rectcount-1 do
    if PointInRect(Point(X,Y),rects[index]) then
    begin
      if isMask then
        if Mask.Canvas.Pixels[x,y]<>clWhite then Exit;
      if rects[index].index=0 then Halt;
      if rects[index].index=1 then begin application.Minimize; exit; end;
      ShowMessage(Format('Button=%s',[rects[index].Name]));
      Exit;
    end;
  ReleaseCapture;
  Perform(WM_SYSCOMMAND,SC_DRAGMOVE,0);
end;

end.
