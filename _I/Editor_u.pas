unit Editor_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Tabs, Menus, ClipBrd, ImgList, Project_struct_u;

type
  TwndCode = class(TForm)
    lbLog: TListBox;
    spl1: TSplitter;
    sbStatus: TStatusBar;
    tsProjects: TTabSet;
    pmEditorContext: TPopupMenu;
    Copy1: TMenuItem;
    Undo1: TMenuItem;
    N1: TMenuItem;
    Cut1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    N2: TMenuItem;
    Selectall1: TMenuItem;
    N3: TMenuItem;
    Readonly1: TMenuItem;
    Find1: TMenuItem;
    dlgFind: TFindDialog;
    reCode: TRichEdit;
    pmTabs: TPopupMenu;
    Newtab1: TMenuItem;
    N4: TMenuItem;
    Closetab1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure tsProjectsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tsProjectsChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure Find1Click(Sender: TObject);
    procedure dlgFindFind(Sender: TObject);
    procedure pmEditorContextPopup(Sender: TObject);
    procedure reCodeKeyPress(Sender: TObject; var Key: Char);
    procedure Closetab1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AddTab(_caption:string);
    procedure FindCode(Text:String; CaseRegister:Boolean);
    procedure LightSyntax(_startPos:Integer;Light:Boolean);
    procedure SelectString(_startPos,_length:Integer);
    procedure CloseAllTabs;
    procedure DeleteTab(tabIndex:Integer);
    { Public declarations }
  end;

var
  wndCode: TwndCode;
  KeyWord:String;
  mark:boolean;

implementation

uses Vars_u,Main_unit;

var Projects:Array of TPEConfig;

{$R *.dfm}

procedure LightLex(_startPos,_Length,x:integer;Style:TFontStyles; _Color:TColor);
var _def:integer;
begin
  _def:=wndCode.reCode.SelStart;
  wndCode.reCode.CaretPos:=Point(x,_startPos);
  wndCode.reCode.SelLength:=_length;
  wndCode.reCode.SelAttributes.Color:=_Color;
  wndCode.reCode.SelAttributes.Style:=Style;
  wndCode.reCode.SelStart:=_def;
  wndCode.reCode.SelLength:=0;
  if not mark then
  begin
    wndCode.reCode.SelAttributes.Color:=clBlack;
    wndCode.reCode.SelAttributes.Style:=[];
  end else
  begin
    wndCode.reCode.SelAttributes.Color:=clBlue;
    wndCode.reCode.SelAttributes.Style:=[];
  end;
end;

procedure ParseText(_start,_index:integer;_attachDigit:Boolean;_text:string);
var _textInd,_textLength,a:Integer;
begin
  _textLength:=Length(_text);
  _textInd:=_start;
  repeat
    if _textInd > _textlength then break;
    case _text[_textInd] of
      '0'..'9','.':
      begin
        if _attachDigit then LightLex(_index,1,_textInd-1,[],clBlue);
        inc(_textInd,1);
        continue;
      end;
      '{','}':
      begin
        if _attachDigit then LightLex(_index,1,_textInd-1,[],clGreen);
        inc(_textInd,1);
        continue;
      end;
      '"':
      begin
        if _attachDigit then
        begin
          a:=_textInd+1;
          while _text[a]<>'"' do
          begin
            if a>=_textLength then Break;
            inc(a);
          end;
          LightLex(_index,a-_textInd,_textInd-1,[],clBlue);
          inc(_textInd,a);
          continue;
        end;
        inc(_textInd,1);
        continue;
      end;
      'a':
      begin
        if copy(_text,_textInd,3)='and' then
        begin
          LightLex(_index,3,_textInd-1,[fsBold],clNavy);
          inc(_textInd,3);
          continue;
        end;
      end;
      'd':
      begin
        if copy(_text,_textInd,2)='do' then
        begin
          LightLex(_index,2,_textInd-1,[fsBold],clNavy);
          inc(_textInd,2);
          continue;
        end;
        if copy(_text,_textInd,3)='div' then
        begin
          LightLex(_index,3,_textInd-1,[fsBold],clNavy);
          inc(_textInd,3);
          continue;
        end;
      end;
      'e':
      begin
        if copy(_text,_textInd,4)='exec' then
        begin
          LightLex(_index,4,_textInd-1,[fsBold],clNavy);
          inc(_textInd,4);
          continue;
        end;
        if copy(_text,_textInd,4)='else' then
        begin
          LightLex(_index,4,_textInd-1,[fsBold],clNavy);
          inc(_textInd,4);
          continue;
        end;
        if copy(_text,_textInd,4)='end.' then
        begin
          LightLex(_index,4,_textInd-1,[fsBold],clNavy);
          inc(_textInd,4);
          continue;
        end;
      end;
      'i':
      begin
        if copy(_text,_textInd,2)='if' then
        begin
          LightLex(_index,2,_textInd-1,[fsBold],clNavy);
          inc(_textInd,2);
          continue;
        end;
        if copy(_text,_textInd,2)='in' then
        begin
          LightLex(_index,2,_textInd-1,[fsBold],clNavy);
          inc(_textInd,2);
          continue;
        end;
      end;
      'n':
      begin
        if copy(_text,_textInd,3)='not' then
        begin
          LightLex(_index,3,_textInd-1,[fsBold],clNavy);
          inc(_textInd,3);
          continue;
        end;
      end;
      'o':
      begin
        if copy(_text,_textInd,2)='or' then
        begin
          LightLex(_index,2,_textInd-1,[fsBold],clNavy);
          inc(_textInd,2);
          continue;
        end;
      end;
      'p':if copy(_text,_textInd,9)='procedure' then
      begin
        LightLex(_index,9,_textInd-1,[fsBold],clNavy);
        inc(_textInd,9);
        continue;
      end;
      't':
      begin
        if copy(_text,_textInd,4)='then' then
        begin
          LightLex(_index,4,_textInd-1,[fsBold],clNavy);
          inc(_textInd,4);
          continue;
        end;
      end;
      'v':
      begin
        if copy(_text,_textInd,4)='void' then
        begin
          LightLex(_index,4,_textInd-1,[fsBold],clNavy);
          inc(_textInd,4);
          continue;
        end;
      end;
      'w':
      begin
        if copy(_text,_textInd,5)='while' then
        begin
          LightLex(_index,5,_textInd-1,[fsBold],clNavy);
          inc(_textInd,5);
          continue;
        end;
      end;
      'x':
      begin
        if copy(_text,_textInd,3)='xor' then
        begin
          LightLex(_index,3,_textInd-1,[fsBold],clNavy);
          inc(_textInd,3);
          continue;
        end;
      end;
    end;
    inc(_textInd);
  until _textInd > _textlength;
end;

procedure TwndCode.LightSyntax(_startPos: Integer; Light: Boolean);
var _index:integer;
    _pos:integer;
    _temp:String;

begin
  reCode.SetFocus;
  if not Light then
  begin
    _pos:=reCode.SelStart;
    reCode.SelStart:=0;
    reCode.SelLength:=Length(reCode.Text);
    reCode.SelStart:=_pos;
    reCode.SelLength:=0;
    Exit;
  end;
  for _index:=0 to reCode.Lines.Count-1 do
  begin
    _temp:=reCode.Lines[_index];
    ParseText(1,_index,True,LowerCase(_temp));
  end;
end;

procedure TwndCode.FindCode(Text: string; CaseRegister:Boolean);
var _index,_pos:integer;
    _text:string;
    function UpperText(_in:string;IsUp:Boolean):string;
    begin
      if IsUp then
        Result:=UpperCase(_in)
      else
        Result:=_in;
    end;
begin
  for _index:=reCode.CaretPos.Y to reCode.Lines.Count-1 do
  begin
    _text:=reCode.Lines[_index];
    for _pos:=1 to Length(_text)do
    begin
      if UpperText(Copy(_text,_pos,Length(Text)),CaseRegister)=UpperText(Text,CaseRegister) then
      begin
        reCode.CaretPos:=Point(_pos-1,_index);
        reCode.SelLength:=Length(Text);
        reCode.SetFocus;
        Exit;
      end;
    end;
  end;
  MessageBox(dlgFind.Handle,PChar(Format('Search string "%s" not found',[Text])),'Find',MB_OK+MB_ICONINFORMATION);
end;

procedure TwndCode.CloseAllTabs;
begin
  while tsProjects.Tabs.Count<>0 do
    DeleteTab(tsProjects.Tabs.Count-1);
end;

procedure TwndCode.DeleteTab(tabIndex: Integer);
var index:integer;
    //_temp:string;
begin
  if Projects[tabIndex].Programm<>'' then
    case MessageBox(Handle,PChar(Format('Save changes in file "%s"?',[tsProjects.Tabs[tabIndex]])),
                 'Question',MB_YESNOCANCEL+MB_ICONQUESTION)
    of
      ID_YES:if not frmMain.SaveToFile then Exit;
      ID_CANCEL:Exit;
    end;
  for index:=tabIndex to tsProjects.Tabs.Count-1 do
    Projects[index]:=Projects[index+1];
  tsProjects.Tabs.Delete(tabIndex);
  frmMain.OutPEConfig:=Projects[tabIndex];
  reCode.Text:=Projects[tabIndex].Programm;
end;

procedure TwndCode.Closetab1Click(Sender: TObject);
begin
  case (Sender as TMenuItem).Tag of
    1:AddTab('');
    2:DeleteTab(tsProjects.TabIndex);
  end;
end;

procedure TwndCode.dlgFindFind(Sender: TObject);
var CaseRegister:boolean;
begin
  CaseRegister:=frMatchCase in dlgFind.Options;
  FindCode(dlgFind.FindText,not CaseRegister);
end;

procedure TwndCode.Find1Click(Sender: TObject);
begin
  case (Sender as TMenuItem).Tag of
    1:reCode.Undo;//Undo
    2:reCode.CutToClipboard;//Cut
    3:reCode.CopyToClipboard;//Copy
    4:reCode.PasteFromClipboard;//Paste
    5:begin
      reCode.CutToClipboard;
      Clipboard.Clear;
    end;//Delete
    6:reCode.SelectAll;//Select all
    7:begin
      reCode.ReadOnly:=not reCode.ReadOnly;
      (Sender as TMenuItem).Checked:=reCode.ReadOnly;
      sbStatus.Panels[1].Text:=Format('Hash code: %x',[reCode.GetHashCode]);
    end;//ReadOnly
    8:dlgFind.Execute(Handle);//Find text
  end;
end;

procedure TwndCode.SelectString(_startPos,_length: Integer);
var _itemIndex:Integer;
    _count:Integer;
    _temp:String;
    _tempLength:Integer;
    _tempIndex:Integer;
    _total:Integer;
begin
  _count:=reCOde.Lines.Count;
  _total:=0;
  for _itemIndex:=0 to _count-1 do
  begin
    _temp:=reCode.Lines[_itemIndex];
    _tempLength:=Length(_temp);
    for _tempIndex:=1 to _tempLength do
      if _startPos=_total+_tempIndex then
      begin
        reCode.SelStart:=(_total+_tempIndex)-_itemIndex;
        reCode.SelLength:=_length;
        Exit;
      end;
    inc(_total,_tempLength+1);
  end;
end;

procedure TwndCode.FormCreate(Sender: TObject);
begin
  SetLength(Projects,150);
  Self.Left:=wndVariables.Width+50;
  Self.Top:=frmMain.Top+frmMain.Height+50;
  Self.Show;
  KeyWord:='';
end;

procedure TwndCode.pmEditorContextPopup(Sender: TObject);
begin
  Cut1.Enabled:=True;
  Copy1.Enabled:=True;
  Delete1.Enabled:=True;
  SelectAll1.Enabled:=True;
  if reCode.SelLength=0 then
  begin
    Cut1.Enabled:=False;
    Copy1.Enabled:=False;
    Delete1.Enabled:=False;
  end;
  if reCode.SelLength=Length(reCode.Text) then
    SelectAll1.Enabled:=False;  
end;

procedure TwndCode.reCodeKeyPress(Sender: TObject; var Key: Char);
var _tmp:string;
begin
  if not frmMain.Lightsyntax1.Checked then exit;
  inherited;
  _tmp:=reCode.Lines[reCode.CaretPos.Y];
  reCode.SelAttributes.Color:=clBlack;
  reCode.SelAttributes.Style:=[];
  case key of
    '0'..'9':reCode.SelAttributes.Color:=clBlue;
    '{','}':reCode.SelAttributes.Color:=clGreen;
    'a'..'z','A'..'Z',' ':
    begin
      ParseText(1,reCode.CaretPos.Y,True,LowerCase(_tmp));
      if mark then reCode.SelAttributes.Color:=clBlue;
    end;
    '"':
    begin
      mark:= not mark;
      if mark then
        reCode.SelAttributes.Color:=clBlue
      else
        reCode.SelAttributes.Color:=clBlack;
    end;
    else if mark then reCode.SelAttributes.Color:=clBlue;
  end;
end;

procedure TwndCode.tsProjectsChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var ParentNode,ChildNode:TTreeNode;
    _temp,module:string;
begin
  frmMain.OutPEConfig.Programm:=reCode.Text;
  frmMain.OutPEConfig.Variables:=wndVariables.VarsAsText;
  frmMain.OutPEConfig.SelStart:=reCode.SelStart;
  frmMain.OutPEConfig.SelLength:=reCode.SelLength;
  //wndVariables.TextAsVars('');
  Projects[tsProjects.TabIndex]:=frmMain.OutPEConfig;
  reCode.Text:=Projects[NewTab].Programm;
  wndVariables.TextAsVars(Projects[NewTab].Variables);
  frmMain.OutPEConfig:=Projects[NewTab];
  reCode.SelStart:=Projects[NewTab].SelStart;
  reCode.SelLength:=Projects[NewTab].SelLength;
  //
  dlgProjectStruct.tvStruct.Items.Clear;
  ParentNode:=dlgProjectStruct.tvStruct.Items.Add(nil,Projects[NewTab].ExeName);
  ParentNode.ImageIndex:=0;
  ParentNode.SelectedIndex:=0;
  ParentNode.StateIndex:=0;
  ChildNode:=dlgProjectStruct.tvStruct.Items.AddChild(ParentNode,tsProjects.Tabs[NewTab]);
  ChildNode.ImageIndex:=1;
  ChildNode.SelectedIndex:=1;
  ChildNode.StateIndex:=1;
  if Projects[NewTab].Modules<>'' then
  begin
  _temp:=Projects[NewTab].Modules;
  while Length(_temp)>1 do
  begin
    Module:=Copy(_temp,1,Pos(';',_temp)-1);
    ChildNode:=dlgProjectStruct.tvStruct.Items.AddChild(ParentNode,Module);
    ChildNode.ImageIndex:=3;
    ChildNode.SelectedIndex:=3;
    ChildNode.StateIndex:=3;
    Delete(_temp,1,Pos(';',_temp));
  end;
  end;
  if Projects[NewTab].Icon<>'' then
  begin
    ChildNode:=dlgProjectStruct.tvStruct.Items.AddChild(ParentNode,ExtractFileName(Projects[NewTab].Icon));
    ChildNode.ImageIndex:=2;
    ChildNode.SelectedIndex:=2;
    ChildNode.StateIndex:=2;
  end;
end;

procedure TwndCode.AddTab(_caption:String);
begin
  if _caption='' then
  begin
    tsProjects.Tag:=tsProjects.Tag+1;
    tsProjects.Tabs.Add(Format('Unit%d.acs',[tsProjects.Tag]))
  end
  else
  begin
    tsProjects.Tabs.Add(_caption);
  end;
  Projects[tsProjects.Tabs.Count-1]:=frmmain.OutPEConfig;
  frmMain.OutPEConfig.Programm:=reCode.Text;
  tsProjects.TabIndex:=tsProjects.Tabs.Count-1;
end;

procedure TwndCode.tsProjectsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var _tabPos:integer;
    a:boolean;
begin
  _tabPos:=tsProjects.ItemAtPos(Point(X,Y));
  if Button=mbMiddle then
  begin
    if _tabPos<>-1 then
    begin
      if tsProjects.Tabs.Count>1 then
      begin
        tsProjects.TabIndex:=_tabPos;
        a:=true;
        tsProjectsChange(Sender,_tabPos,a);
        DeleteTab(_tabPos);
      end;
    end
    else
      AddTab('');
  end;
end;

end.
