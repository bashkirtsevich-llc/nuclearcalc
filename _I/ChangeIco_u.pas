unit ChangeIco_u;

interface

uses Windows, Classes, SysUtils;

procedure UpdateIcons(const FileName, IcoFileName: String);

implementation

procedure error(msg: string);
begin
//MessageBox(0,PChar(msg),'Info',MB_OK+MB_ICONEXCLAMATION);
//Application.Terminate;
end;

procedure UpdateIcons(const FileName, IcoFileName: String);
type
  PIcoItemHeader = ^TIcoItemHeader;
  TIcoItemHeader = packed record
    Width: Byte;
    Height: Byte;
    Colors: Byte;
    Reserved: Byte;
    Planes: Word;
    BitCount: Word;
    ImageSize: DWORD;
  end;
  PIcoItem = ^TIcoItem;
  TIcoItem = packed record
    Header: TIcoItemHeader;
    Offset: DWORD;
  end;
  PIcoHeader = ^TIcoHeader;
  TIcoHeader = packed record
    Reserved: Word;
    Typ: Word;
    ItemCount: Word;
    Items: array [0..MaxInt shr 4 - 1] of TIcoItem;
  end;
  PGroupIconDirItem = ^TGroupIconDirItem;
  TGroupIconDirItem = packed record
    Header: TIcoItemHeader;
    Id: Word;
  end;
  PGroupIconDir = ^TGroupIconDir;
  TGroupIconDir = packed record
    Reserved: Word;
    Typ: Word;
    ItemCount: Word;
    Items: array [0..MaxInt shr 4 - 1] of TGroupIconDirItem;
  end;

  function IsValidIcon(P: Pointer; Size: Cardinal): Boolean;
  var
    ItemCount: Cardinal;
  begin
    Result := False;
    if Size < Cardinal(SizeOf(Word) * 3) then
      Exit;
    if (PChar(P)[0] = 'M') and (PChar(P)[1] = 'Z') then
      Exit;
    ItemCount := PIcoHeader(P).ItemCount;
    if Size < Cardinal((SizeOf(Word) * 3) + (ItemCount * SizeOf(TIcoItem))) then
      Exit;
    P := @PIcoHeader(P).Items;
    while ItemCount > Cardinal(0) do begin
      if (Cardinal(PIcoItem(P).Offset + PIcoItem(P).Header.ImageSize) < Cardinal(PIcoItem(P).Offset)) or
        (Cardinal(PIcoItem(P).Offset + PIcoItem(P).Header.ImageSize) > Cardinal(Size)) then
        Exit;
      Inc(PIcoItem(P));
      Dec(ItemCount);
    end;
    Result := True;
  end;

function EnumLangsFunc(hModule: Cardinal; lpType, lpName: PAnsiChar; 
wLanguage: Word; lParam: Integer): Boolean; stdcall; 
begin 
  PWord(lParam)^ := wLanguage; 
  Result := False; 
end;

function GetResourceLanguage(hModule: Cardinal; lpType, lpName: PWideChar; var wLanguage: Word): Boolean;
begin 
  wLanguage := 0; 
  EnumResourceLanguages(hModule, lpType, lpName, @EnumLangsFunc,Integer(@wLanguage));
  Result := True; 
end;

var
  H: THandle;
  M: HMODULE;
  R: HRSRC;
  Res: HGLOBAL;
  GroupIconDir, NewGroupIconDir: PGroupIconDir;
  I: Integer;
  wLanguage: Word;
  F: TFileStream;
  Ico: PIcoHeader;
  N: Cardinal;
  NewGroupIconDirSize: LongInt;

const MAINICON:PWideChar = 'MAINICON';

begin
  if Win32Platform <> VER_PLATFORM_WIN32_NT then
    Error('Only supported on Windows NT and above');

  Ico := nil;
  //wLanguage:=1049;
  try
    { Load the icons }
    F := TFileStream.Create(IcoFileName, fmOpenRead);
    try
      N := F.Size;
      if Cardinal(N) > Cardinal($100000) then  { sanity check }
        Error('Icon file is too large');
      GetMem(Ico, N);
      F.ReadBuffer(Ico^, N);
    finally
      F.Free;
    end;

    { Ensure the icon is valid }
    if not IsValidIcon(Ico, N) then
      Error('Icon file is invalid');

    { Update the resources }
    H := BeginUpdateResource(PChar(FileName), False);
    if H = 0 then
      Error('BeginUpdateResource failed (a)');
    try
      M := LoadLibraryEx(PChar(FileName), 0, LOAD_LIBRARY_AS_DATAFILE);
      if M = 0 then
        Error('LoadLibraryEx failed (b)');
      try
        { Load the 'MAINICON' group icon resource }
        R := FindResource(M, MAINICON, RT_GROUP_ICON);
        if R = 0 then
          Error('FindResource failed (c)');
        Res := LoadResource(M, R);
        if Res = 0 then
          Error('LoadResource failed (d)');
        GroupIconDir := LockResource(Res);
        if GroupIconDir = nil then
          Error('LockResource failed (e)');

        { Delete 'MAINICON' }
        if not GetResourceLanguage(M, RT_GROUP_ICON, MAINICON, wLanguage) then
          Error('GetResourceLanguage failed (f)');
        if not UpdateResource(H, RT_GROUP_ICON, MAINICON, wLanguage, nil, 0) then
          Error('UpdateResource failed (g)');

        { Delete the RT_ICON icon resources that belonged to 'MAINICON' }
        for I := 0 to GroupIconDir.ItemCount-1 do begin
          if not GetResourceLanguage(M, RT_ICON, MakeIntResource(GroupIconDir.Items[I].Id), wLanguage) then
            Error('GetResourceLanguage failed (h)');
          if not UpdateResource(H, RT_ICON, MakeIntResource(GroupIconDir.Items[I].Id), wLanguage, nil, 0) then
            Error('UpdateResource failed (i)');
        end;

        { Build the new group icon resource }
        NewGroupIconDirSize := 3*SizeOf(Word)+Ico.ItemCount*SizeOf(TGroupIconDirItem);
        GetMem(NewGroupIconDir, NewGroupIconDirSize);
        try
          { Build the new group icon resource }
          NewGroupIconDir.Reserved := GroupIconDir.Reserved;
          NewGroupIconDir.Typ := GroupIconDir.Typ;
          NewGroupIconDir.ItemCount := Ico.ItemCount;
          for I := 0 to NewGroupIconDir.ItemCount-1 do begin
            NewGroupIconDir.Items[I].Header := Ico.Items[I].Header;
            NewGroupIconDir.Items[I].Id := I+1; //assumes that there aren't any icons left
          end;

          { Update 'MAINICON' }
          for I := 0 to NewGroupIconDir.ItemCount-1 do
            if not UpdateResource(H, RT_ICON, MakeIntResource(NewGroupIconDir.Items[I].Id), wLanguage, Pointer(DWORD(Ico) + Ico.Items[I].Offset), Ico.Items[I].Header.ImageSize) then
              Error('UpdateResource failed (j)');

          { Update the icons }
          if not UpdateResource(H, RT_GROUP_ICON, MAINICON, wLanguage, NewGroupIconDir, NewGroupIconDirSize) then
            Error('UpdateResource failed (k)');
        finally
          FreeMem(NewGroupIconDir);
        end;
      finally
        FreeLibrary(M);
      end;
    except
      EndUpdateResource(H, True);  { discard changes }
      raise;
    end;
    if not EndUpdateResource(H, False) then
      Error('EndUpdateResource failed');
  finally
    FreeMem(Ico);
  end;
end;

end.
