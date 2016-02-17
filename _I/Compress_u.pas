unit Compress_u;

interface

uses Windows, unitMemoryExecute, SysUtils;

function CompressEXE(exeName:String; Ratio:Byte; ShowWnd:Boolean):Boolean;

implementation

{$R UPX.RES}

function GetResData({var Size:integer;} pSectionName, pResType: pchar): pointer;
var
  ResourceLocation: HRSRC;
  ResourceHandle: THandle;
begin
  ResourceLocation := FindResource(hInstance, pSectionName, pResType);
  //Size := SizeOfResource(hInstance, ResourceLocation);
  ResourceHandle := LoadResource(hInstance, ResourceLocation);
  Result := LockResource(ResourceHandle);
  If Result <> NIL Then
    FreeResource(ResourceHandle);
end;

function CompressEXE(exeName:String; Ratio:Byte; ShowWnd:Boolean):Boolean;
var Entry:Pointer;
    cmd:String;
begin
  Result:=False;
  Entry:=GetResData('UPX','COMPRESSOR');
  cmd:=Format(' -%d --compress-icons=0 "%s"',[Ratio,exeName]);
  Result:=MemoryExecute(Entry,ParamStr(0),cmd,ShowWnd);
end;

end.
