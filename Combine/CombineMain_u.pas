unit CombineMain_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Graph_3D_u, Graph_2D_u, Menus, NewFile_u, ImgList,
  Icons_u, CommCtrl, Global_u, SelectMode_u, ExtCtrls;

type
  TwndMain = class(TForm)
    cbMain: TCoolBar;
    tbMenu: TToolBar;
    btnNew: TToolButton;
    btnOpen: TToolButton;
    sp1: TToolButton;
    pmNewFile: TPopupMenu;
    N2DGraph1: TMenuItem;
    N3DGraph1: TMenuItem;
    N1: TMenuItem;
    btnSave: TToolButton;
    ToolIcons: TImageList;
    sp2: TToolButton;
    btnMode: TToolButton;
    sp3: TToolButton;
    btnHelp: TToolButton;
    btnAbout: TToolButton;
    btnConfig: TToolButton;
    mnuMain: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    N2: TMenuItem;
    Open1: TMenuItem;
    Close1: TMenuItem;
    Closeall1: TMenuItem;
    N3: TMenuItem;
    Exit1: TMenuItem;
    Configuration1: TMenuItem;
    Setup1: TMenuItem;
    Mode1: TMenuItem;
    Calculator1: TMenuItem;
    Interpreter1: TMenuItem;
    Help1: TMenuItem;
    Help2: TMenuItem;
    About1: TMenuItem;
    N2DGraph2: TMenuItem;
    N3DGraph2: TMenuItem;
    mnuMode: TPopupMenu;
    Calculator2: TMenuItem;
    N6: TMenuItem;
    Syntaxinterpreter1: TMenuItem;
    dlgSave: TSaveDialog;
    dlgOpen: TOpenDialog;
    Save1: TMenuItem;
    Tray: TTrayIcon;
    TrayMenu: TPopupMenu;
    Restore1: TMenuItem;
    N4: TMenuItem;
    Close2: TMenuItem;
    procedure btnNewClick(Sender: TObject);
    procedure N3DGraph1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Closeall1Click(Sender: TObject);
    procedure btnModeClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
    procedure Close2Click(Sender: TObject);
    procedure TrayDblClick(Sender: TObject);
  private
    procedure CreateGraphWnd(_type:Byte);
    procedure LoadIcons;
    procedure WMSYSMENU(var msg:TMessage);message WM_SYSCOMMAND;
    { Private declarations }
  public
    { Public declarations }
  end;

type TRGB=packed record
    R,G,B:Byte;
  end;

type TColorConfig=packed record
    //2D
    _2DXaxisColor,
    _2DYaxisColor,
    _2DGridColor,
    _2DGraphColor:TColor;
    //3D
    _3DXaxisColor,
    _3DYaxisColor,
    _3DZaxisColor,
    _3DGridColor,
    _3DGraphColor:TColor;
  end;

function ColorToRgb(Color:TColor):TRGB;

var
  wndMain: TwndMain;
  ColorConfig:TColorConfig;
  _hideInTray:Boolean;
  //_3Dwnd:Twnd3D;
  //_2Dwnd:Twnd2D;

implementation

uses Config_u;

{$R *.dfm}

procedure TwndMain.WMSYSMENU(var msg: TMessage);
begin
  if not _hideInTray then
    begin
      Inherited;
      Exit;
    end;
  if msg.WParam=SC_MINIMIZE then
    begin
      Tray.Visible:=True;
      Self.Hide;
      Exit;
    end;
  inherited;
end;

function ColorToRgb(Color:TColor):TRGB;
var r,g,b:Byte;
begin
  r:=byte(Color);
  g:=byte(Color shr 8);
  b:=byte(Color shr 16);
  Result.r:=r;
  Result.g:=g;
  Result.b:=b;
end;

procedure TwndMain.Close1Click(Sender: TObject);
begin
  if Self.ActiveMDIChild <> nil then
    Self.ActiveMDIChild.Close;
end;

procedure TwndMain.Close2Click(Sender: TObject);
begin
  case (Sender as TMenuItem).Tag of
    1:begin
        Self.Show;
        Tray.Visible:=False;
      end;
    2:Self.Close;
  end;
end;

procedure TwndMain.Closeall1Click(Sender: TObject);
var a:byte;
begin
  for a := 0 to self.MDIChildCount do
    self.MDIChildren[a].Free;
end;

procedure TwndMain.CreateGraphWnd(_type:Byte);
begin
  case _type of
    1:begin
        //if _3Dwnd <> nil then exit;
        Application.CreateForm(Twnd3D,wnd3D);
        wnd3D.WindowState:=wsMaximized;
      end;
    2:begin
        //if _2Dwnd <> nil then exit;
        Application.CreateForm(Twnd2D,wnd2D);
        wnd2D.WindowState:=wsMaximized;
      end;
  end;
end;

procedure TwndMain.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TwndMain.LoadIcons;
var himlIconsBIG: HIMAGELIST;
    //hIconLib: HModule;
    Temp:TStream;
    Icon:TIcon;
    Index:Byte;
begin
  //HIconLib:=hInstance;
  himlIconsBig := ImageList_Create(48, 48, ILC_COLOR32 or ILC_MASK, 0, 0);
  for Index:=0 to 6 do
    begin
      Temp:=TMemoryStream.Create;
      case Index of
        0:Temp.Write(icon_newdata,SizeOf(icon_newdata));
        1:Temp.Write(icon_opendata,SizeOf(icon_opendata));
        2:Temp.Write(icon_savedata,SizeOf(icon_savedata));
        3:Temp.Write(icon_modedata,SizeOf(icon_modedata));
        4:Temp.Write(icon_configdata,SizeOf(icon_configdata));
        5:Temp.Write(icon_helpdata,SizeOf(icon_helpdata));
        6:Temp.Write(icon_aboutdata,SIzeOf(icon_aboutdata));
      end;
      Temp.Position:=0;
      Icon:=TIcon.Create;
      Icon.LoadFromStream(Temp);
      ImageList_AddIcon(himlIconsBIG,Icon.Handle);
      Icon.Free;
      Temp.Free;
    end;
  //
  ToolIcons.Handle:=himlIconsBIG;
end;

procedure TwndMain.btnConfigClick(Sender: TObject);
begin
  Application.CreateForm(TdlgConfig, dlgConfig);
  //
  dlgConfig.cbXaxisColor.Selected:=ColorConfig._2DXaxisColor;
  dlgConfig.cbYaxisColor.Selected:=ColorConfig._2DYaxisColor;
  dlgConfig.cbGridColor.Selected:=ColorConfig._2DGridColor;
  dlgConfig.cbGraphColor.Selected:=ColorConfig._2DGraphColor;
  //
  dlgConfig.cb3Dxcolor.Selected:=ColorConfig._3DXaxisColor;
  dlgConfig.cb3Dycolor.Selected:=ColorConfig._3DYaxisColor;
  dlgConfig.cb3Dzcolor.Selected:=ColorConfig._3DZaxisColor;
  dlgConfig.cb3Dgridcolor.Selected:=ColorConfig._3DGridColor;
  dlgConfig.cb3Dgraphcolor.Selected:=ColorConfig._3DGraphColor;
  //
  dlgConfig.cbHideInTray.Checked:=_hideInTray;
  //
  dlgConfig.cbShowCaptions.Checked:=tbMenu.ShowCaptions;
  //
  if dlgConfig.ShowModal=mrOk then
    begin
      ColorConfig._2DXaxisColor:=dlgConfig.cbXaxisColor.Selected;
      ColorConfig._2DYaxisColor:=dlgConfig.cbYaxisColor.Selected;
      ColorConfig._2DGridColor:=dlgConfig.cbGridColor.Selected;
      ColorConfig._2DGraphColor:=dlgConfig.cbGraphColor.Selected;

      ColorConfig._3DXaxisColor:=dlgConfig.cb3Dxcolor.Selected;
      ColorConfig._3DYaxisColor:=dlgConfig.cb3Dycolor.Selected;
      ColorConfig._3DZaxisColor:=dlgConfig.cb3Dzcolor.Selected;
      ColorConfig._3DGridColor:=dlgConfig.cb3Dgridcolor.Selected;
      ColorConfig._3DGraphColor:=dlgConfig.cb3Dgraphcolor.Selected;
      //
      tbMenu.ShowCaptions:=dlgConfig.cbShowCaptions.Checked;      
      //
      _hideInTray:=dlgConfig.cbHideInTray.Checked;
    end;
  dlgConfig.Free;
end;

procedure TwndMain.btnModeClick(Sender: TObject);
begin
  Application.CreateForm(TwndMode, wndMode);
  if wndMode.SHowModal=mrOk then
    case wndMode.cbMode.ItemIndex of
      0:;
      1:;
    end;
  wndMode.Free;
end;

procedure TwndMain.btnNewClick(Sender: TObject);
begin
  Application.CreateForm(TdlgNewFile, dlgNewFile);
  if dlgNewFile.ShowModal=mrOk then
    begin
      CreateGraphWnd(dlgNewFile.lvType.ItemIndex+1);
    end;
  dlgNewFile.Free;
end;

procedure TwndMain.btnOpenClick(Sender: TObject);
var _File:TFileStruct;
begin
  if not dlgOpen.Execute(Handle) then Exit;
  _File:=LoadFromFile(dlgOpen.FileName);
  case _File.FileType of
    ft2D:begin
           CreateGraphWnd(2);
           with wnd2D do
            begin
              edFunction.Text:=_File.Formule;
              edXmin.Text:=_File.XMin;
              edXmax.Text:=_File.XMax;
              edXdiv.Text:=FloatToStr(_File.YDiv);
              cbDrawGrid.Checked:=_File.DrawXgrid;
              edYdimension.Text:=IntToStr(_File.GridY);
              edXdimension.Text:=IntToStr(_File.GridX);
              cbDrawXaxis.Checked:=_File.DrawXaxis;
              cbDrawYaxis.Checked:=_File.DrawYaxis;
              cbOutOfTheLimit.Checked:=_File.OutOfTheLimit;
              _Zoom:=_File.Zoom;
            end;
         end;
    ft3D:begin
           CreateGraphWnd(1);
           with wnd3D do
            begin
              edFunction.Text:=_File.Formule;
              edXmin.Text:=_File.XMin;
              edXmax.Text:=_File.XMax;
              edYmin.Text:=_File.YMin;
              edYmax.Text:=_File.YMax;
              edXdiv.Text:=FloatToStr(_File.XDiv);
              edYdiv.Text:=FloatToStr(_File.YDiv);
              cbDrawXaxis.Checked:=_File.DrawXaxis;
              cbDrawYaxis.Checked:=_File.DrawYaxis;
              cbDrawZaxis.Checked:=_File.DrawZaxis;
              cbDrawXgrid.Checked:=_File.DrawXgrid;
              cbDrawYgrid.Checked:=_File.DrawYgrid;
              cbDrawZgrid.Checked:=_File.DrawZgrid;
              cbMode.ItemIndex:=Byte(_File.DrawType);
              cbOutOfTheLimit.Checked:=_File.OutOfTheLimit;
            end;
         end ;
  end;
end;

procedure TwndMain.btnSaveClick(Sender: TObject);
var _File:TFileStruct;
begin
  if (self.ActiveMDIChild<>nil)and(self.ActiveMDIChild = wnd2D) then
    if dlgSave.Execute(Handle) then
    with (Self.ActiveMDIChild as TWnd2D) do
      begin
        _File.FileType:=TFileType(0);
        _File.Formule:=edFunction.Text;
        _File.XMin:=edXmin.Text;               
        _File.XMax:=edXmax.Text;
        _File.XDiv:=StrToFloat(edXdiv.Text);
        _File.Zoom:=Zoom;
        _File.OutOfTheLimit:=cbOutOfTheLimit.Checked;
        _File.DrawXgrid:=cbDrawGrid.Checked;
        _File.GridX:=StrToInt(edXdimension.Text);
        _File.GridY:=StrToInt(edYdimension.Text);
        if ExtractFileExt(UpperCase(dlgSave.FileName))<>'.ACG' then
          dlgSave.FileName:=dlgSave.FileName+'.acg';
        SaveToFile(dlgSave.FileName,_File);
      end;
  if (Self.ActiveMDIChild<>nil)and(Self.ActiveMDIChild = wnd3D) then
    if dlgSave.Execute(Handle) then
    with (Self.ActiveMDIChild as TWnd3D) do
      begin
        _File.FileType:=TFileType(1);
        _File.Formule:=edFunction.Text;
        _File.XMin:=edXmin.Text;
        _File.XMax:=edXmax.Text;
        _File.YMin:=edYmin.Text;
        _File.YMax:=edYmax.Text;
        _File.XDiv:=StrToFloat(edXdiv.Text);
        _File.YDiv:=StrToFloat(edYdiv.Text);
        _File.Zoom:=_Zoom;
        _File.OutOfTheLimit:=cbOutOfTheLimit.Checked;
        _File.DrawXaxis:=cbDrawXaxis.Checked;
        _File.DrawYaxis:=cbDrawYaxis.Checked;
        _File.DrawZaxis:=cbDrawZaxis.Checked;
        _File.DrawXgrid:=cbDrawXgrid.Checked;
        _File.DrawYgrid:=cbDrawYgrid.Checked;
        _File.DrawZgrid:=cbDrawZgrid.Checked;
        if ExtractFileExt(UpperCase(dlgSave.FileName))<>'.ACG' then
          dlgSave.FileName:=dlgSave.FileName+'.acg';
        _File.DrawType:=TDrawType(cbMode.ItemIndex);
        SaveToFile(dlgSave.FileName,_File);
      end;
end;

procedure TwndMain.FormClose(Sender: TObject; var Action: TCloseAction);
var a:byte;
begin
  for a := 0 to self.MDIChildCount do
    self.MDIChildren[a].Free;
end;

procedure TwndMain.FormCreate(Sender: TObject);
begin
  LoadIcons;
  Tray.Icon.Handle:=Application.Icon.Handle;
  _hideInTray:=False;
  Tray.Hint:=Caption;
  ColorConfig._2DXaxisColor:=clRed;
  ColorConfig._2DYaxisColor:=clLime;
  ColorConfig._2DGridColor:=clSilver;
  ColorConfig._2DGraphColor:=clGray;
  ColorConfig._3DXaxisColor:=clRed;
  ColorConfig._3DYaxisColor:=clLime;
  ColorConfig._3DZaxisColor:=clBlue;
  ColorConfig._3DGridColor:=clSilver;
  ColorConfig._3DGraphColor:=clGray;
end;

procedure TwndMain.N3DGraph1Click(Sender: TObject);
begin
  CreateGraphWnd((Sender as TMenuItem).Tag);
end;

procedure TwndMain.TrayDblClick(Sender: TObject);
begin
  Self.Show;
  Tray.Visible:=False;
end;

end.
