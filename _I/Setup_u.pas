unit Setup_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, CheckLst, ExtCtrls;

type
  TdlgSetup = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    S: TPageControl;
    tvCategories: TTreeView;
    tsGeneral: TTabSheet;
    tsApplication: TTabSheet;
    tsProtection: TTabSheet;
    lbModules: TLabel;
    clbModulesList: TCheckListBox;
    gbAppConfig: TGroupBox;
    lbAppTitle: TLabel;
    edAppTitle: TEdit;
    lbAppIcon: TLabel;
    edAppIcon: TEdit;
    gbOutputName: TGroupBox;
    edOutName: TEdit;
    cbEnableProtection: TCheckBox;
    btnBrowsIco: TButton;
    dlgOpen: TOpenDialog;
    cbUsePassword: TCheckBox;
    lePassword: TLabeledEdit;
    leConfirm: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure tvCategoriesClick(Sender: TObject);
    procedure btnBrowsIcoClick(Sender: TObject);
    procedure cbUsePasswordClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgSetup: TdlgSetup;

implementation

{$R *.dfm}

function FileMaskEquate(F, M: string): boolean;
var
  Fl, Ml: integer; // length of file name and mask
  Fp, Mp: integer; // pointers
begin
  F := UpperCase(F);
  M := UpperCase(M);
  result := true;
  Fl := length(F);
  Ml := length(M);
  Fp := 1;
  Mp := 1;
  while Mp <= Ml do
  begin // wildcard
    case M[Mp] of //
      '?':
        begin // if one any char
          inc(Mp); // next char of mask
          inc(Fp); // next char of file name
        end; //
      '*':
        begin // if any chars
          if Mp = Ml then
            exit; // if last char in mask then exit
          if M[Mp + 1] = F[Fp] then
          begin // if next char in mask equate char in
            Inc(Mp); // file name then next char in mask and
          end
          else
          begin // else
            if Fp = Fl then
            begin // if last char in file name then
              result := false; // function return false
              exit; //
            end; // else, if not previous, then
            inc(Fp); // next char in file name
          end; //
        end; //
    else
      begin // other char in mask
        if M[Mp] <> F[Fp] then
        begin // if char in mask not equate char in
          result := false; // file name then function return
          exit; // false
        end; // else
        if (Mp=Ml) and (Fp<>Fl) then begin
        Result:=false;
        exit;
       end;
        inc(Fp); // next char of mask
        inc(Mp); // next char of file name
      end //
    end;
  end;
end;

procedure SearchDir(Dir,Ext: string);
var
  SR: TSearchRec;
  FindRes: Integer;
begin
  FindRes := FindFirst(Dir + '*.*', faAnyFile, SR);
  while FindRes = 0 do
  begin
    if ((SR.Attr and faDirectory) = faDirectory) and
       ((SR.Name = '.') or (SR.Name = '..')) then
       begin
        FindRes := FindNext(SR);
        Continue;
       end;
       {if ((SR.Attr and faDirectory) = faDirectory) then
       begin
         SearchDir(Dir + SR.Name + '\',Ext);
         FindRes := FindNext(SR);
         Continue;
       end; }
      //Files.Add(Dir + SR.Name);//Add to list
    if FileMaskEquate(SR.Name, Ext) then
      dlgSetup.clbModulesList.Items.Add(SR.Name);
    FindRes := FindNext(SR);
  end;
  Windows.FindClose(FindRes);
end;

procedure TdlgSetup.btnBrowsIcoClick(Sender: TObject);
begin
  dlgOpen.Filter:='Icon files (*.ico)|*.ICO';
  if dlgOpen.Execute(Handle) then
    edAppIcon.Text:=dlgOpen.FileName;
end;

procedure TdlgSetup.btnOkClick(Sender: TObject);
begin
  if (cbUsePassword.Checked)then
    if(lePassword.Text<>leConfirm.Text)or((leConfirm.Text='')or(lePassword.Text='')) then
    begin
      MessageBox(Handle,'Incorrect password, please try again','Attention',MB_OK+MB_ICONEXCLAMATION);
      Exit;
    end;
  ModalResult:=mrOk;
end;

procedure TdlgSetup.cbUsePasswordClick(Sender: TObject);
begin
  lePassword.Enabled:=cbUsePassword.Checked;
  leConfirm.Enabled:=cbUsePassword.Checked;
end;

procedure TdlgSetup.FormCreate(Sender: TObject);
begin  
  SearchDir(ExtractFileDir(ParamStr(0))+'\..\MODULES\','*.ACM');
end;

procedure TdlgSetup.tvCategoriesClick(Sender: TObject);
begin
  case tvCategories.Selected.Text[1] of
    'G':if tvCategories.Selected.Text='General'     then S.TabIndex:=0;
    'A':if tvCategories.Selected.Text='Application' then S.TabIndex:=1;
    'P':if tvCategories.Selected.Text='Protection'  then S.TabIndex:=2;
  end;
end;

end.
