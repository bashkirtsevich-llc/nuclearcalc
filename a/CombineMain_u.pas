unit CombineMain_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Graph_3D_u, Graph_2D_u, Menus, NewFile_u, ImgList,
  Icons_u, CommCtrl, Global_u, {SelectMode_u,} ExtCtrls, About_u, Setup_u, Registry;

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
    IntegralComputer: TMenuItem;
    Help1: TMenuItem;
    Help2: TMenuItem;
    About1: TMenuItem;
    N2DGraph2: TMenuItem;
    N3DGraph2: TMenuItem;
    mnuMode: TPopupMenu;
    Calculator2: TMenuItem;
    N6: TMenuItem;
    IntegralComputer2: TMenuItem;
    dlgSave: TSaveDialog;
    dlgOpen: TOpenDialog;
    Save1: TMenuItem;
    Tray: TTrayIcon;
    TrayMenu: TPopupMenu;
    Restore1: TMenuItem;
    N4: TMenuItem;
    Close2: TMenuItem;
    N5: TMenuItem;
    mnuHelp: TPopupMenu;
    Help3: TMenuItem;
    N7: TMenuItem;
    About2: TMenuItem;
    N8: TMenuItem;
    Setup2: TMenuItem;
    Numercialrowcalculator1: TMenuItem;
    procedure btnNewClick(Sender: TObject);
    procedure N3DGraph1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Closeall1Click(Sender: TObject);
    procedure btnModeClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
    procedure Close2Click(Sender: TObject);
    procedure TrayDblClick(Sender: TObject);
    procedure Calculator2Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure IntegralComputerClick(Sender: TObject);
    procedure Setup2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Numercialrowcalculator1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    s_1,s_2:string;
    procedure CreateGraphWnd(_type:Byte);
    procedure LoadIcons;
    procedure WMSYSMENU(var msg:TMessage);message WM_SYSCOMMAND;
    procedure CreateSpeedMenu;
    procedure ReadWindowPos;
    procedure WriteWindowPos;
    procedure LoadLanguage(_fileName: string);
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
  _mode:Byte;
  _captions:array [0..23] of string;
  _captions2:array [0..10] of string;
  //_3Dwnd:Twnd3D;
  //_2Dwnd:Twnd2D;

implementation

uses Config_u, Main_u, Integral_u, Num_row_u;

{$R *.dfm}

procedure TwndMain.ReadWindowPos;
var reg:TRegistry;
begin
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.OpenKey(ConfigKey,True);
  try
    if reg.ReadBool('Remember_Pos') then
    begin
    Self.Left:=reg.ReadInteger('Plotter_Left');
    Self.Top:=reg.ReadInteger('Plotter_Top');
    end else
    begin
      Self.Left:=(Screen.Width div 2)-(Self.Width div 2);
      Self.Top:=(Screen.Height div 2)-(Self.Height div 2);
    end;
    Self.Height:=reg.ReadInteger('Plotter_Height');
    Self.Width:=reg.ReadInteger('Plotter_Width');
    Self.WindowState:=TWindowState(reg.ReadInteger('Plotter_State'));
    Self.cbMain.Visible:=reg.ReadBool('Plotter_ShowBar');
  except
    Self.Left:=(Screen.Width div 2)-(Self.Width div 2);
    Self.Top:=(Screen.Height div 2)-(Self.Height div 2);
    Self.WindowState:=wsNormal;
    Self.cbMain.Visible:=False;
  end;
  reg.CloseKey;
  reg.Free;
end;

procedure TwndMain.WriteWindowPos;
var reg:TRegistry;
begin
  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_CURRENT_USER;
  reg.OpenKey(ConfigKey,True);
  if (Self.WindowState=wsNormal) then
  begin
    reg.WriteInteger('Plotter_Left',Self.Left);
    reg.WriteInteger('Plotter_Top',Self.Top);
    reg.WriteInteger('Plotter_Height',Self.Height);
    reg.WriteInteger('Plotter_Width',Self.Width);
  end;
  reg.WriteInteger('Plotter_State',Integer(Self.WindowState));
  reg.WriteBool('Plotter_ShowBar',Self.cbMain.Visible);
  reg.CloseKey;
  reg.Free;
end;

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

procedure TwndMain.CreateSpeedMenu;
var _body:TPanel;
begin
  //_body:=
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

procedure TwndMain.Calculator2Click(Sender: TObject);
begin
  Application.Tag:=1; 
  Close;
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
        Graph_3D_u._lng := Config._language;
        Application.CreateForm(Twnd3D,wnd3D);
        wnd3D.WindowState:=wsMaximized;
      end;
    2:begin
        //if _2Dwnd <> nil then exit;
        Graph_2D_u._lng := Config._language;
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
  for Index:=0 to 5 do
    begin
      Temp:=TMemoryStream.Create;
      case Index of
        0:Temp.Write(icon_newdata,SizeOf(icon_newdata));
        1:Temp.Write(icon_opendata,SizeOf(icon_opendata));
        2:Temp.Write(icon_savedata,SizeOf(icon_savedata));
        3:Temp.Write(icon_modedata,SizeOf(icon_modedata));
        4:Temp.Write(icon_configdata,SizeOf(icon_configdata));
        5:Temp.Write(icon_helpdata,SizeOf(icon_helpdata));
        //6:Temp.Write(icon_aboutdata,SIzeOf(icon_aboutdata));
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

procedure TwndMain.About1Click(Sender: TObject);
begin
  Application.CreateForm(TdlgAbout,dlgAbout);
  dlgAbout.ShowModal;
  dlgAbout.Free;
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
  dlgConfig.btnOk.Caption := s_1;
  dlgConfig.btnCancel.Caption := s_2;
  //
  dlgConfig.Caption := _captions2[0];
  dlgConfig.tsInterface.Caption := _captions2[1];
  dlgConfig.tsColors.Caption := _captions2[2];
  dlgConfig.gbToolBar.Caption := _captions2[3];
  dlgConfig.cbShowCaptions.Caption := _captions2[4];
  dlgConfig.cbShowHints.Caption := _captions2[5];
  dlgConfig.cbShowToolBar.Caption := _captions2[6];
  //dlgConfig.lbLanguage.Caption := _captions2[7];
  dlgConfig.cbHideInTray.Caption := _captions2[8];
  dlgConfig.gb2Dplotter.Caption := _captions2[9];
  dlgConfig.gb3Dplotter.Caption := _captions2[10];
  //
  dlgConfig.cbHideInTray.Checked:=_hideInTray;
  //
  dlgConfig.cbShowCaptions.Checked:=tbMenu.ShowCaptions;
  dlgConfig.cbShowToolBar.Checked:=cbMain.Visible;
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
      cbMain.Visible:=dlgConfig.cbShowToolBar.Checked;       
      //
      _hideInTray:=dlgConfig.cbHideInTray.Checked;
    end;
  dlgConfig.Free;
end;

procedure TwndMain.btnModeClick(Sender: TObject);
begin
  {Application.CreateForm(TwndMode, wndMode);
  if wndMode.SHowModal=mrOk then
    case wndMode.cbMode.ItemIndex of
      0:}Calculator2Click(Sender);
      {1:;
    end;
  wndMode.Free; }
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
  LoadLanguage(Config._language);
end;

procedure TwndMain.FormDestroy(Sender: TObject);
var a:byte;
begin
  if Config._RememberPos then
    Self.WriteWindowPos;
  for a := 0 to self.MDIChildCount do
    self.MDIChildren[a].Free;
end;

procedure TwndMain.FormShow(Sender: TObject);
var Config:TConfig;
begin
  Config:=ReadConfig;
  Self.ReadWindowPos;
end;

procedure TwndMain.IntegralComputerClick(Sender: TObject);
begin
  if dlgIntegral = nil then
    Application.CreateForm(TdlgIntegral,dlgIntegral);
  dlgIntegral.Show{Modal};
  {dlgIntegral.Free;}
end;

procedure TwndMain.N3DGraph1Click(Sender: TObject);
begin
  CreateGraphWnd((Sender as TMenuItem).Tag);
end;

procedure TwndMain.N5Click(Sender: TObject);
begin
  cbMain.Visible:= not cbMain.Visible;
  if Self.WindowState <> wsNormal then Exit;
  if cbMain.Visible then
    Self.Height:=Self.Height + cbMain.Height
  else
    Self.Height:=Self.Height - cbMain.Height;
end;

procedure TwndMain.Numercialrowcalculator1Click(Sender: TObject);
begin
  if dlgRow = nil then
    Application.CreateForm(TdlgRow,dlgRow);
  dlgRow.Show{Modal};
  //dlgRow
end;

procedure TwndMain.Setup2Click(Sender: TObject);
var Config:TConfig;
begin
  Application.CreateForm(TdlgSetup,dlgSetup);
  Config:=ReadConfig;
  //
  dlgSetup.Caption := _captions[0];
  dlgSetup.tsStartup.Caption := _captions[1];
  dlgSetup.tsLog.Caption := _captions[2];
  dlgSetup.tsKeys.Caption := _captions[3];
  dlgSetup.tsAliases.Caption := _captions[4];
  dlgSetup.gbStartupMode.Caption := _captions[5];
  dlgSetup.lbMode.Caption := _captions[6];
  dlgSetup.cbRunMode.Items[0] := _captions[7];
  dlgSetup.cbRunMode.Items[1] := _captions[8];
  dlgSetup.cbSplash.Caption := _captions[9];
  dlgSetup.cbDisplayLogMemo.Caption := _captions[10];
  dlgSetup.cbRememberRestoreWindowsPos.Caption := _captions[11];
  dlgSetup.gbLogConfig.Caption := _captions[12];
  dlgSetup.cbSaveLogData.Caption := _captions[13];
  dlgSetup.lbSaveDir.Caption := _captions[14];
  dlgSetup.cbMoveLog.Caption := _captions[15];
  dlgSetup.gbKeys.Caption := _captions[16];
  dlgSetup.lbCalculate.Caption := _captions[17];
  dlgSetup.lbReturnAction.Caption := _captions[18];
  dlgSetup.cbClearAfterCompute.Caption := _captions[19];
  dlgSetup.cbReturnAfterCompute.Caption := _captions[20];
  dlgSetup.gbAliases.Caption := _captions[21];
  dlgSetup.cbEnableAliases.Caption := _captions[22];
  dlgSetup.lbAliaseName.Caption := _captions[23];
  dlgSetup.btnOk.Caption := s_1;
  dlgSetup.btnCancel.Caption := s_2;
  //
  dlgSetup.cbRunMode.ItemIndex:=Config._startupMode;
  dlgSetup.cbSplash.Checked:=Config._ShowSplash;
  dlgSetup.cbDisplayLogMemo.Checked:=Config._ShowLogMemo;
  dlgSetup.cbRememberRestoreWindowsPos.Checked:=Config._RememberPos;
  dlgSetup.cbSaveLogData.Checked:=Config._SaveLogData;
  dlgSetup.edSaveFolder.Text:=Config._LogDir;
  if dlgSetup.ShowModal=mrOk then
  begin
    Config._startupMode:=dlgSetup.cbRunMode.ItemIndex;
    Config._ShowSplash:=dlgSetup.cbSplash.Checked;
    Config._ShowLogMemo:=dlgSetup.cbDisplayLogMemo.Checked;
    Config._RememberPos:=dlgSetup.cbRememberRestoreWindowsPos.Checked;
    Config._SaveLogData:=dlgSetup.cbSaveLogData.Checked;
    Config._LogDir:=dlgSetup.edSaveFolder.Text;
    WriteConfig(Config);
  end;
  dlgSetup.Free;
end;

procedure TwndMain.TrayDblClick(Sender: TObject);
begin
  Self.Show;
  Tray.Visible:=False;
end;

procedure TwndMain.LoadLanguage(_fileName: string);
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
  for index := 72 to 95 do
    _captions[index-72] := GetCaption(index);
  btnNew.Caption := GetCaption(96);
  btnOpen.Caption := GetCaption(97);
  btnSave.Caption := GetCaption(98);
  btnMode.Caption := GetCaption(99);
  btnConfig.Caption := GetCaption(100);
  btnHelp.Caption := GetCaption(101);
  //
  N2DGraph1.Caption := GetCaption(102);
  N3DGraph1.Caption := GetCaption(103);
  Calculator2.Caption := GetCaption(104);
  IntegralComputer2.Caption := GetCaption(105);
  Restore1.Caption := GetCaption(106);
  Close2.Caption := GetCaption(107);
  Help3.Caption := GetCaption(108);
  About2.Caption := GetCaption(109);
  //*****
  File1.Caption := GetCaption(110);
  New1.Caption := GetCaption(111);
  N2DGraph2.Caption := GetCaption(112);
  N3DGraph2.Caption := GetCaption(113);
  Save1.Caption := GetCaption(114);
  Open1.Caption := GetCaption(115);
  Close1.Caption := GetCaption(116);
  Closeall1.Caption := GetCaption(117);
  Exit1.Caption := GetCaption(118);
  Configuration1.Caption := GetCaption(119);
  Setup2.Caption := GetCaption(120);
  Setup1.Caption := GetCaption(121);
  Mode1.Caption := GetCaption(122);
  Calculator1.Caption := GetCaption(123);
  IntegralComputer.Caption := GetCaption(124);
  Numercialrowcalculator1.Caption := GetCaption(125);
  Help1.Caption := GetCaption(126);
  Help2.Caption := GetCaption(127);
  About1.Caption := GetCaption(128);
  s_1 := GetCaption(59);
  s_2 := GetCaption(60);
  for index := 166 to 176 do
    _captions2[index-166] := GetCaption(index);
  //
  FreeLibrary(_dllHandle);
end;

end.
