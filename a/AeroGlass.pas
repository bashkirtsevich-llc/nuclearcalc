// TAeroGlass
// Aero Glass Effekt für Delphi-Forms
//
// Parameter:
// BlurColorKey ... Ist der Farbwert, bei dem der Blur-Glass-Effekt angewendet
//                  wird. Wenn SheetOfGlass aktiviert ist sollte nicht auf der
//                  Form die Farbe nochmal verwendet werden. Damit wird ein
//                  ungewollter Effekt verhindert.
// MarginLeft   ... Linker Rand für den Blur-Glass-Effekt.
// MarginTop    ... Oberer Rand für den Blur-Glass-Effekt.
// MarginRight  ... Rechter Rand für den Blur-Glass-Effekt.
// MarginBottom ... Unterer Rand für den Blur-Glass-Effekt.
// SheetOfGlass ... Unabhängig von den Rändern, wird hier für die ganze Form
//                  Blur-Glass-Effekt aktiviert.
// DragGlass    ... dgNone  Das ziehen der Form ist deaktiviert.
//                  dgGlass Das ziehen der Form ist nur auf "Glass" möglich.
//                  dgForm  Das ziehen der Form ist auf der selbigen möglich.
//
// Hinweis: Für die Aktivierung wird zusätzlich TXPManifest bzw. eine RES-Datei
//          die die Manifest-Daten enthält benötigt.
//
//
// TAeroGlass von Daniel Mitte (C) 2006
//
// Revision:
// 1.1 Neue TAeroGlass Komponente
// 1.0 glass.pas Delphi-Unit

unit AeroGlass;

interface

uses Windows, Classes, Controls, Forms, Graphics, Messages;

type
  TDragGlassMode = (dgNone, dgGlass, dgForm);

  TDoBlurThread = class(TThread)
  private
    FOnExecute: TNotifyEvent;
  public
    constructor Create;
    property OnExecute: TNotifyEvent read FOnExecute write FOnExecute;
  protected
    procedure Execute; override;
  end;

  TAeroGlass = class(TComponent)
  private
    FForm: TForm;
    FDoBlur: TDoBlurThread;
    FActive: Boolean;
    FOldExStyle: Integer;
    FOldOnPaint: TNotifyEvent;
    FOldWndProc: TWndMethod;
    FBlurColorKey: TColor;
    FMarginLeft: Integer;
    FMarginTop: Integer;
    FMarginRight: Integer;
    FMarginBottom: Integer;
    FSheetOfGlass: Boolean;
    FDragGlass: TDragGlassMode;
    procedure SetBlurColorKey(NewBlurColorKey: TColor);
    procedure SetMarginLeft(NewMarginLeft: Integer);
    procedure SetMarginTop(NewMarginTop: Integer);
    procedure SetMarginRight(NewMarginRight: Integer);
    procedure SetMarginBottom(NewMarginBottom: Integer);
    procedure SetSheetOfGlass(NewSheetOfGlass: Boolean);
    procedure NewOnPaint(Sender: TObject);
    procedure NewWndProc(var Msg: TMessage);
    procedure EnableAeroGlass(Sender: TObject);
    procedure SetTransparentKey(cKey: TColor);
    procedure SetAeroGlass(left, top, right, bottom: Integer);
    procedure UpdateForm;
    function IsOnGlass: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BlurColorKey: TColor read FBlurColorKey write SetBlurColorKey;
    property MarginLeft: Integer read FMarginLeft write SetMarginLeft;
    property MarginTop: Integer read FMarginTop write SetMarginTop;
    property MarginRight: Integer read FMarginRight write SetMarginRight;
    property MarginBottom: Integer read FMarginBottom write SetMarginBottom;
    property SheetOfGlass: Boolean read FSheetOfGlass write SetSheetOfGlass;
    property DragGlass: TDragGlassMode read FDragGlass write FDragGlass;
  end;

procedure Register;

implementation

const
  WS_EX_LAYERED = $80000;
  LWA_COLORKEY = 1;
  SC_DRAGMOVE = $F012;
  WM_THEMECHANGED = $31A;
  WM_DWMCOMPOSITIONCHANGED = $31E;
  WM_DWMNCRENDERINGCHANGED = $31F;

type
  _MARGINS = packed record
    cxLeftWidth: Integer;
    cxRightWidth: Integer;
    cyTopHeight: Integer;
    cyBottomHeight: Integer;
  end;
  PMargins = ^_MARGINS;
  TMargins = _MARGINS;

  DwmIsCompositionEnabledFunc = function(pfEnabled: PBOOL): HRESULT; stdcall;
  DwmExtendFrameIntoClientAreaFunc = function(hWnd: HWND; const pMarInset: PMargins): HRESULT; stdcall;
  SetLayeredWindowAttributesFunc = function(hWnd: HWND; cKey: TColor; bAlpha: Byte; dwFlags: DWord): BOOL; stdcall;

var
  hDWMDLL: Cardinal;
  fDwmIsCompositionEnabled: DwmIsCompositionEnabledFunc;
  fDwmExtendFrameIntoClientArea: DwmExtendFrameIntoClientAreaFunc;
  fSetLayeredWindowAttributesFunc: SetLayeredWindowAttributesFunc;

constructor TAeroGlass.Create(AOwner: TComponent);
var
  osVinfo: TOSVersionInfo;

begin
  inherited Create(AOwner);

  FForm := TForm(GetParentForm(TControl(AOwner)));
  FActive := False;
  FOldExStyle := GetWindowLong(FForm.Handle, GWL_EXSTYLE);
  FDoBlur := nil;

  FBlurColorKey := $00DCDBDA;
  FMarginLeft := 0;
  FMarginTop := 32;
  FMarginRight := 0;
  FMarginBottom := 0;
  FSheetOfGlass := False;
  FDragGlass := dgNone;

  hDWMDLL := 0;

  ZeroMemory(@osVinfo, SizeOf(osVinfo));
  OsVinfo.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFO);

  if ((GetVersionEx(osVInfo) = True) and (osVinfo.dwPlatformId = VER_PLATFORM_WIN32_NT) and (osVinfo.dwMajorVersion >= 5)) then
  begin
    hDWMDLL := LoadLibrary('dwmapi.dll');

    if hDWMDLL <> 0 then
    begin
      @fDwmIsCompositionEnabled := GetProcAddress(hDWMDLL, 'DwmIsCompositionEnabled');
      @fDwmExtendFrameIntoClientArea := GetProcAddress(hDWMDLL, 'DwmExtendFrameIntoClientArea');
      @fSetLayeredWindowAttributesFunc := GetProcAddress(GetModulehandle(user32), 'SetLayeredWindowAttributes');

      FDoBlur := TDoBlurThread.Create;
      FDoBlur.OnExecute := EnableAeroGlass;
      FDoBlur.Resume;
    end;
  end;
end;

destructor TAeroGlass.Destroy;
begin
  if FDoBlur <> nil then FDoBlur.Terminate;

  if FActive = True then
  begin
    FForm.OnPaint := FOldOnPaint;
    FForm.WindowProc := FOldWndProc;
  end;

  if hDWMDLL <> 0 then FreeLibrary(hDWMDLL);

  inherited Destroy;
end;

procedure TAeroGlass.SetBlurColorKey(NewBlurColorKey: TColor);
begin
  FBlurColorKey := NewBlurColorKey;

  if FActive = True then
  begin
    SetTransparentKey(NewBlurColorKey);
    UpdateForm;
  end;
end;

procedure TAeroGlass.SetMarginLeft(NewMarginLeft: Integer);
begin
  if NewMarginLeft < 0 then NewMarginLeft := 0;

  FMarginLeft := NewMarginLeft;

  if ((FActive = True) and (SheetOfGlass = False)) then
  begin
    SetAeroGlass(FMarginLeft, MarginTop, MarginRight, MarginBottom);
    UpdateForm;
  end;
end;

procedure TAeroGlass.SetMarginTop(NewMarginTop: Integer);
begin
  if NewMarginTop < 0 then NewMarginTop := 0;

  FMarginTop := NewMarginTop;

  if ((FActive = True) and (SheetOfGlass = False)) then
  begin
    SetAeroGlass(MarginLeft, FMarginTop, MarginRight, MarginBottom);
    UpdateForm;
  end;
end;

procedure TAeroGlass.SetMarginRight(NewMarginRight: Integer);
begin
  if NewMarginRight < 0 then NewMarginRight := 0;

  FMarginRight := NewMarginRight;

  if ((FActive = True) and (SheetOfGlass = False)) then
  begin
    SetAeroGlass(MarginLeft, MarginTop, FMarginRight, MarginBottom);
    UpdateForm;
  end;
end;

procedure TAeroGlass.SetMarginBottom(NewMarginBottom: Integer);
begin
  if NewMarginBottom < 0 then NewMarginBottom := 0;

  FMarginBottom := NewMarginBottom;

  if ((FActive = True) and (SheetOfGlass = False)) then
  begin
    SetAeroGlass(MarginLeft, MarginTop, MarginRight, FMarginBottom);
    UpdateForm;
  end;
end;

procedure TAeroGlass.SetSheetOfGlass(NewSheetOfGlass: Boolean);
begin
  FSheetOfGlass := NewSheetOfGlass;

  if FActive = True then
  begin
    if NewSheetOfGlass = True then SetAeroGlass(-1, -1, -1, -1)
    else SetAeroGlass(MarginLeft, MarginTop, MarginRight, MarginBottom);

    UpdateForm;
  end;
end;

procedure TAeroGlass.NewOnPaint(Sender: TObject);
var
  oldBrush, newBrush: TBrush;
  oldPen, newPen: TPen;
  bCmpEnable: BOOL;

begin
  if Assigned(FOldOnPaint) then FOldOnPaint(Sender);

  if ((FActive = True) and (hDWMDLL <> 0) and (Assigned(fDwmIsCompositionEnabled) = True)) then
  begin
    fDwmIsCompositionEnabled(@bCmpEnable);

    if ((bCmpEnable = True) and ((MarginLeft <> 0) or (MarginTop <> 0) or (MarginRight <> 0) or (MarginBottom <> 0) or (SheetOfGlass = True))) then
    begin
      oldBrush := FForm.Canvas.Brush;
      oldPen := FForm.Canvas.Pen;

      newBrush := TBrush.Create;
      newPen := TPen.Create;

      newBrush.Style := bsSolid;
      newPen.Style := psSolid;

      newBrush.Color := BlurColorKey;
      newPen.Color := BlurColorKey;

      FForm.Canvas.Brush := newBrush;
      FForm.Canvas.Pen := newPen;

      if SheetOfGlass = True then FForm.Canvas.Rectangle(0, 0, FForm.ClientWidth, FForm.ClientHeight)
      else
      begin
        if MarginLeft > 0 then FForm.Canvas.Rectangle(0, 0, MarginLeft, FForm.ClientHeight);
        if MarginTop > 0 then FForm.Canvas.Rectangle(0, 0, FForm.ClientWidth, MarginTop);
        if MarginRight > 0 then FForm.Canvas.Rectangle(FForm.ClientWidth - MarginRight, 0, FForm.ClientWidth, FForm.ClientHeight);
        if MarginBottom > 0 then FForm.Canvas.Rectangle(0, FForm.ClientHeight - MarginBottom, FForm.ClientWidth, FForm.ClientHeight);
      end;

      FForm.Canvas.Brush := oldBrush;
      FForm.Canvas.Pen := oldPen;

      newBrush.Free;
      newPen.Free;
    end;
  end;
end;

procedure TAeroGlass.NewWndProc(var Msg: TMessage);
var
  wp: TWindowPlacement;
  bCmpEnable: BOOL;

begin
  if Assigned(FOldWndProc) then FOldWndProc(Msg);

  if FActive = True then
  begin
    case Msg.Msg of
      WM_SIZE: UpdateForm;
      WM_NCHITTEST: begin
        if ((FActive = True) and (hDWMDLL <> 0) and (Assigned(fDwmIsCompositionEnabled) = True) and (DragGlass <> dgNone) and (Msg.Result = HTCLIENT) and (IsIconic(FForm.Handle) = False) and (IsOnGlass = True)) then
        begin
          fDwmIsCompositionEnabled(@bCmpEnable);

          ZeroMemory(@wp, SizeOf(wp));
          wp.length := SizeOf(wp);

          GetWindowPlacement(FForm.Handle, @wp);

          if ((bCmpEnable = True) and (wp.showCmd <> SW_HIDE) and (wp.showCmd <> SW_MAXIMIZE) and (wp.showCmd <> SW_MINIMIZE)) then
          begin
            ReleaseCapture;
            FForm.Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
          end;
        end;
      end;
      WM_DWMCOMPOSITIONCHANGED, WM_DWMNCRENDERINGCHANGED, WM_THEMECHANGED: begin
        SetWindowLong(FForm.Handle, GWL_EXSTYLE, FOldExStyle);

        SetTransparentKey(BlurColorKey);

        SetAeroGlass(0, 0, 0, 0);

        if SheetOfGlass = True then SetAeroGlass(-1, -1, -1, -1)
        else SetAeroGlass(MarginLeft, MarginTop, MarginRight, MarginBottom);

        UpdateForm;
      end;
    end;
  end;
end;

procedure TAeroGlass.EnableAeroGlass(Sender: TObject);
begin
  if SheetOfGlass = True then SetAeroGlass(-1, -1, -1, -1)
  else SetAeroGlass(MarginLeft, MarginTop, MarginRight, MarginBottom);

  SetTransparentKey(BlurColorKey);

  FOldOnPaint := FForm.OnPaint;
  FForm.OnPaint := NewOnPaint;

  FOldWndProc := FForm.WindowProc;
  FForm.WindowProc := NewWndProc;

  FActive := True;

  UpdateForm;
end;

procedure TAeroGlass.SetTransparentKey(cKey: TColor);
var
  bCmpEnable: BOOL;
  bActiveLayer: Boolean;

begin
  bActiveLayer := False;

  if ((hDWMDLL <> 0) and (Assigned(fDwmIsCompositionEnabled) = True) and (Assigned(fSetLayeredWindowAttributesFunc) = True)) then
  begin
    fDwmIsCompositionEnabled(@bCmpEnable);

    if bCmpEnable = True then
    begin
      SetWindowLong(FForm.Handle, GWL_EXSTYLE, FOldExStyle or WS_EX_LAYERED);
      fSetLayeredWindowAttributesFunc(FForm.Handle, cKey, 0, LWA_COLORKEY);
      bActiveLayer := True;
    end;
  end;

  if bActiveLayer = False then SetWindowLong(FForm.Handle, GWL_EXSTYLE, FOldExStyle);
end;

procedure TAeroGlass.SetAeroGlass(left, top, right, bottom: Integer);
var
  bCmpEnable: BOOL;
  mgn: TMargins;

begin
  if ((hDWMDLL <> 0) and (Assigned(fDwmIsCompositionEnabled) = True) and (Assigned(fDwmExtendFrameIntoClientArea) = True)) then
  begin
    fDwmIsCompositionEnabled(@bCmpEnable);

    if bCmpEnable = True then
    begin
      ZeroMemory(@mgn, SizeOf(mgn));
      mgn.cxLeftWidth := left;
      mgn.cxRightWidth := right;
      mgn.cyTopHeight := top;
      mgn.cyBottomHeight := bottom;

      fDwmExtendFrameIntoClientArea(FForm.Handle, @mgn);
    end;
  end;
end;

procedure TAeroGlass.UpdateForm;
begin
  RedrawWindow(FForm.Handle, nil, 0, RDW_ERASE or RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
end;

function TAeroGlass.IsOnGlass: Boolean;
var
  cp: TPoint;
  wr, cr: TRect;

begin
  Result := False;

  if ((DragGlass = dgForm) or (SheetOfGlass = True)) then Result := True
  else
  begin
    GetCursorPos(cp);
    GetWindowRect(FForm.Handle, wr);
    GetClientRect(FForm.Handle, cr);

    cp.X := cp.X - wr.Left - cr.Left;
    cp.Y := cp.Y - wr.Top - cr.Top;

    case FForm.BorderStyle of
      bsSizeable: begin
        cp.X := cp.X - GetSystemMetrics(SM_CXSIZEFRAME);
        cp.Y := cp.Y - GetSystemMetrics(SM_CYCAPTION) - GetSystemMetrics(SM_CYSIZEFRAME);
      end;
      bsDialog: begin
        cp.X := cp.X - GetSystemMetrics(SM_CXFIXEDFRAME);
        cp.Y := cp.Y - GetSystemMetrics(SM_CYCAPTION) - GetSystemMetrics(SM_CYFIXEDFRAME);
      end;
      bsSingle: begin
        cp.X := cp.X - 1;
        cp.Y := cp.Y - GetSystemMetrics(SM_CYCAPTION) - 1;
      end;
      bsToolWindow: begin
        cp.X := cp.X - 1;
        cp.Y := cp.Y - GetSystemMetrics(SM_CYSMCAPTION) - 1;
      end;
      bsSizeToolWin: begin
        cp.X := cp.X - GetSystemMetrics(SM_CXSIZEFRAME);
        cp.Y := cp.Y - GetSystemMetrics(SM_CYSMCAPTION) - GetSystemMetrics(SM_CYSIZEFRAME);
      end;
    end;

    if (((MarginLeft > 0) and (cp.X >= 0) and (cp.X <= MarginLeft) and (cp.Y >= 0) and (cp.Y <= (cr.Bottom - cr.Top))) or
        ((MarginTop > 0) and (cp.X >= 0) and (cp.X <= (cr.Right - cr.Left)) and (cp.Y >= 0) and (cp.Y <= MarginTop)) or
        ((MarginRight > 0) and (cp.X >= (cr.Right - cr.Left - MarginRight)) and (cp.X <= (cr.Right - cr.Left)) and (cp.Y >= 0) and (cp.Y <= (cr.Bottom - cr.Top))) or
        ((MarginBottom > 0) and (cp.X >= 0) and (cp.X <= (cr.Right - cr.Left)) and (cp.Y >= (cr.Bottom - cr.Top - MarginBottom)) and (cp.Y <= (cr.Bottom - cr.Top)))) then Result := True;
  end;
end;

constructor TDoBlurThread.Create;
begin
  inherited Create(True);

  FOnExecute := nil;
  FreeOnTerminate := True;
end;

procedure TDoBlurThread.Execute;
begin
  if ((Terminated = False) and (Assigned(FOnExecute) = True)) then FOnExecute(Self);

  Terminate;
end;

procedure Register;
begin
  RegisterComponents('VistaStyle', [TAeroGlass]);
end;

end.