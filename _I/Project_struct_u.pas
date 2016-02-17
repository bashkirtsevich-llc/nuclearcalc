unit Project_struct_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Vars_u, ComCtrls, ImgList, ShellApi;

type
  TdlgProjectStruct = class(TForm)
    tvStruct: TTreeView;
    imgs: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure tvStructDblClick(Sender: TObject);
    procedure tvStructMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgProjectStruct: TdlgProjectStruct;
  _x,_y:integer;

implementation

uses Main_unit;

{$R *.dfm}

procedure TdlgProjectStruct.FormCreate(Sender: TObject);
begin
  Self.Left:=wndVariables.Left;
  Self.Top:=wndVariables.Top+wndVariables.Height;
  Self.Width:=wndVariables.Width;
  Self.Height:=Screen.WorkAreaHeight-Self.Top;
  Self.Show;
end;

procedure TdlgProjectStruct.tvStructDblClick(Sender: TObject);
var Node:TTreeNode;
    Pach:String;
begin
  Node:=tvStruct.GetNodeAt(_x,_y);
  Pach:='';
  if Node = nil then Exit;
  while Node <> nil do
  begin
    Pach:=Node.Text+'\'+Pach;
    Node:=Node.Parent;
  end;
  Delete(Pach,Length(Pach),1);
  if ExtractFileName(Pach) = ExtractFileName(frmMain.OutPEConfig.Icon) then
    if FileExists(frmMain.OutPEConfig.OutDir+'\'+frmMain.OutPEConfig.Icon) then
      ShellExecute(Application.Handle,'open',PChar(frmMain.OutPEConfig.OutDir+'\'+frmMain.OutPEConfig.Icon),nil,PChar(frmMain.OutPEConfig.OutDir+'\'),SW_SHOW);
end;

procedure TdlgProjectStruct.tvStructMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  _x:=X;
  _y:=Y;
end;

end.
