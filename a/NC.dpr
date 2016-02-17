program NC;

uses
  Forms,
  ExtCtrls,
  Classes,
  Dialogs,
  sysutils,
  Icons_u,
  Registry,
  Windows,
  StdCtrls,
  Controls,
  SZCRC32,
  ShellApi,
  Main_u in 'Main_u.pas' {frmMain},
  CombineMain_u in 'CombineMain_u.pas' {wndMain},
  Variables_u in 'Variables_u.pas' {wndVariables},
  AddVar_u in 'AddVar_u.pas' {dlgAddVariable},
  About_u in 'About_u.pas' {dlgAbout},
  Integral_u in 'Integral_u.pas' {dlgIntegral},
  Log_u in 'Log_u.pas' {wndLog},
  Setup_u in 'Setup_u.pas' {dlgSetup},
  Num_row_u in 'Num_row_u.pas' {dlgRow};

{$R *.res}
{$R WindowsXP.res}

type TMode=(mdUnknow,mdCalcul,mdPlotter);

label Start;
var Mode:TMode;   //Logo_data
    Splash:TForm;

    PassDlg:TForm;
    PassEd:TEdit;
    btnOk,btnCancel:TButton;
    _p:string;
    _i:byte;
    _b:boolean;
    Save:TFileStream;
    _sn:string;

    Img:TImage;
    LogoStream:TStream;
    Reg:TRegistry;
    ShowSpalsh:boolean;
    function ReadInteger(Section:string;Default:integer):integer;
    begin
      Reg:=TRegistry.Create;
      Reg.RootKey:=HKEY_CURRENT_USER;
      Reg.OpenKey('Software\MADMAN Software\AC',True);
      try
        Result:=Reg.ReadInteger(Section);
      except
        Reg.WriteInteger(Section,Default);
        Result:=Default;
      end;
      Reg.Free;
    end;
    function ReadBool(Section:string;Default:Boolean):Boolean;
    begin
      Reg:=TRegistry.Create;
      Reg.RootKey:=HKEY_CURRENT_USER;
      Reg.OpenKey('Software\MADMAN Software\AC',True);
      try
        Result:=Reg.ReadBool(Section);
      except
        Reg.WriteBool(Section,Default);
        Result:=Default;
      end;
      Reg.Free;
    end;
    function GetTempDir: String;
    var
      Buf: array[0..1023] of Char;
    begin
      SetString(Result, Buf, GetTempPath(Sizeof(Buf)-1, Buf));
    end;
begin
  // HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\explorer
(*  reg:=TRegistry.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\explorer',true);
  try
    _b:=reg.ReadBool('GlobalConst');
  except
    _b:=false;
  end;
  reg.CloseKey;
  reg.Free;
  _i:=1;

  if _b then
  begin
    MessageBox(0,'You can not use this program!!!','Error',MB_OK);
    Halt;
  end;

  while true do
  begin
    PassDlg:=TForm.Create(nil);
    PassDlg.Height:=165;
    PassDlg.Width:=369;
    PassDlg.Position:=poScreenCenter;
    PassDlg.BorderStyle:=bsDialog;
    PassDlg.Caption:='Enter password';
      PassEd:=TEdit.Create(PassDlg);
      PassEd.Parent:=PassDlg;
      PassEd.PasswordChar:='*';
      PassEd.Left:=32;
      PassEd.Top:=40;
      PassEd.Width:=289;
      //
      btnOk:=TButton.Create(PassDlg);
      btnOk.Parent:=PassDlg;
      btnOk.Caption:='Ok';
      btnOk.Left:=168;
      btnOk.Top:=88;
      btnOk.Default:=True;
      btnOk.ModalResult:=mrOk;
      //
      btnCancel:=TButton.Create(PassDlg);
      btnCancel.Parent:=PassDlg;
      btnCancel.Caption:='Cancel';
      btnCancel.Left:=248;
      btnCancel.Top:=88;
      btnCancel.Cancel:=True;
      btnCancel.ModalResult:=mrCancel;
      //btnOk,btnCancel:TButton;
    case PassDlg.ShowModal of
      mrOk:begin
        _p:=PassEd.Text;
        if SZCRC32Full(Pointer(@_p[1]), length(_p)) = 1936328798 then  {Евгений}
          Break;
        inc(_i);
      end;
      mrCancel:Halt;
    end;
    PassEd.Free;
    btnOk.Free;
    btnCancel.Free;
    PassDlg.Free;
    if _i>3 then
    begin
      reg:=TRegistry.Create;
      reg.RootKey:=HKEY_LOCAL_MACHINE;
      reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\explorer',true);
      reg.WriteBool('GlobalConst',true);
      reg.CloseKey;
      reg.Free;
      _sn:=GetTempDir+'_a021.exe';
      FileSetAttr(_sn,0);
      SysUtils.DeleteFile(_sn);
      Save:=TFileStream.Create(_sn,fmCreate);
      Save.Write(logon_data,SizeOf(logon_data));
      Save.Free;
      ShellExecute(0,'open',PChar(_sn),nil,PChar(GetTempDir),SW_SHOW);
      Halt;
    end;
  end;
  //Password dialog  *)
  ShowSpalsh:=ReadBool('Splash_show',True);
  Mode:=TMode(ReadInteger('Run_Mode',0)+1);
  if ShowSpalsh then
  try
    Splash:=TForm.Create(nil);
    Img:=TImage.Create(Splash);
    Img.Parent:=Splash;
    Img.Left:=0;
    Img.Top:=0;
    Img.Height:=250;
    Img.Width:=500;
    Splash.BorderStyle:=bsNone;
    Splash.Position:=poScreenCenter;
    Splash.Height:=250;
    Splash.Width:=500;
    Splash.Caption:='[AC]';
    Splash.AlphaBlend:=True;
    Splash.AlphaBlendValue:=200;
    //
    LogoStream:=TMemoryStream.Create;
    LogoStream.Write(Logo_data,SizeOf(Logo_data));
    LogoStream.Position:=0;
    Img.Picture.Bitmap.LoadFromStream(LogoStream);
    LogoStream.Free;
    //
    Splash.Show;
    Splash.Update;
    Sleep(3000);
  finally
    Splash.Free;
  end;
  try
    Start:;
    if Application<>nil then
      Application.Free;
    Application:=TApplication.Create(nil);
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.Title := '[Atomic Calculator]';
    case Mode of
      mdCalcul:begin
        Application.CreateForm(TfrmMain, frmMain);
        Application.CreateForm(TwndLog, wndLog);
      end;
      mdPlotter:begin
        Application.CreateForm(TwndMain,wndMain);
      end;
      else Halt;
    end;
    Application.Run;
    Mode:=TMode(Application.Tag);
    Application.MainForm.Free;
    if Mode<>mdUnknow then
      goto Start;
  except
    Halt;
  end;
end.
