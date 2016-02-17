unit Log_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ClipBrd, AppEvnts, ExtCtrls;

type
  TwndLog = class(TForm)
    memLog: TMemo;
    pmLog: TPopupMenu;
    Copylog1: TMenuItem;
    N1: TMenuItem;
    Clearlog1: TMenuItem;
    Refocuser: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Clearlog1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HideTitleBar;
    procedure ShowTitleBar;
    procedure RefocuserTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wndLog: TwndLog;

implementation

uses main_u;

var Config:TConfig;

{$R *.dfm}

function PointInRect(_p:TPoint; _r:TRect):boolean;
begin
  Result := (_p.X >= _r.Left)and(_p.X <= _r.Right)and
            (_p.Y >= _r.Top)and(_p.Y <= _r.Bottom);
end;

procedure TwndLog.Clearlog1Click(Sender: TObject);
begin
  case (Sender as TMenuItem).Tag of
    1:ClipBoard.AsText:=memLog.Text;
    2:memLog.Clear;
  end;
end;

procedure TwndLog.HideTitleBar;
var
  Style: Longint;
begin
  if BorderStyle = bsNone then Exit;
  Style := GetWindowLong(Handle, GWL_STYLE);
  if (Style and WS_CAPTION) = WS_CAPTION then
  begin
    case BorderStyle of
      bsSingle,
      bsSizeable: SetWindowLong(Handle, GWL_STYLE, Style and
          (not (WS_CAPTION)) or WS_BORDER);
      bsDialog: SetWindowLong(Handle, GWL_STYLE, Style and
          (not (WS_CAPTION)) or DS_MODALFRAME or WS_DLGFRAME);
    end;
    Height := Height - GetSystemMetrics(SM_CYCAPTION);
    Refresh;
  end;
end;

procedure TwndLog.ShowTitleBar;
var
  Style: Longint;
begin
  if BorderStyle = bsNone then Exit;
  Style := GetWindowLong(Handle, GWL_STYLE);
  if (Style and WS_CAPTION) <> WS_CAPTION then
  begin
    case BorderStyle of
      bsSingle,
      bsSizeable: SetWindowLong(Handle, GWL_STYLE, Style or WS_CAPTION or
          WS_BORDER);
      bsDialog: SetWindowLong(Handle, GWL_STYLE,
          Style or WS_CAPTION or DS_MODALFRAME or WS_DLGFRAME);
    end;
    Height := Height + GetSystemMetrics(SM_CYCAPTION);
    Refresh;
  end;
end;

procedure TwndLog.RefocuserTimer(Sender: TObject);
var _p:TPoint;
    _r:TRect;
begin
  if not Active then Exit;
  if not GetCursorPos(_p) then Exit;
  _r := Rect(Left,Top,Left + Width,Top + Height);
  if PointInRect(_p,_r) then Exit;
  BringWindowToTop(frmMain.Handle);
end;

procedure TwndLog.FormCreate(Sender: TObject);
begin
  Config:=ReadConfig;
  if Config._ShowLogMemo then
    Show;
end;

procedure TwndLog.FormShow(Sender: TObject);
begin
  Config:=ReadConfig;
  if Config._MoveLogWithMain then
    HideTitleBar
  else
    ShowTitleBar;
  Left:=frmMain.Left;
  Top:=frmMain.Top+363;
end;

end.
