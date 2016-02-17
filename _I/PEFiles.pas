{************************************************************}
{                                                            }
{                 Модуль PE Files                            }
{       Copyright (c) 2008 Виктор Вязницев  aka Thrasher     }
{                                                            }
{                                                            }
{  Модифицирован: 05 июня 2008                               }
{                                                            }
{************************************************************}
unit PEFiles;
interface
Uses Classes,Windows,SysUtils,Dialogs;

Const PESignature=$00004550;

type TSection = record
     ObjectName:array [0..7] of byte;
     ObjectNameStr:string[8];
     VirtualSize:dword;
     SectionRVA:dword;
     PhysicalSize:dword;
     PhysicalOffset:dword;
     ObjectFlags:dword;
     end;
type
 TPEFile = class(TObject)
 F:TMemoryStream;
 private
 FFilename:string;
 FFSize:dword;
 FFPEHeaderOffset:integer;
 FFNTHeaderSize:word;
 FFNumObject:word;
 FFCodeSize:dword;
 FFInitDataSize:dword;
 FFUnInitDataSize:dword;
 FFRVAEntryPoint:dword;
 FFDataBase:dword;
 FFCodeBase:dword;
 FFImageBase:Dword;
 FFObjectAlign:dword;
 FFFileAlign:Dword;
 FFImageSize:dword;
 FFHeaderSize:Dword;
 FFRVAExportTable:dword;
 FFSizeExportTable:dword;
 FFRVAImportTable:Dword;
 FFSizeImportTable:Dword;
 FFRVAResources:dword;
 FFSizeResources:dword;
 FFRVAExceptionTable:dword;
 FFSizeExceptionTable:dword;

 FFImportTableOffset:dword;
 FFImportTableSection:string;

 FFSections:array[1..255] of TSection;

 FFPESignature:Dword;

 function GetSectionInfo(Index:byte):TSection;
 function GetEntryPointPhysicalOffset:Dword;
 public

 constructor Create(_File:TStream);
 Function AddSection(const Name:string;PhysicalSize,VirtualSize,ObjectFlags:DWord;FillRandom:boolean):boolean;
 Function ChangeSectionFlags(NewFlags:Dword;SectionNum:byte):boolean;
 function ChangeSectionPhysicalOffset(NewPhysicalOffset:Dword;SectionNum:byte):boolean;
 function ChangeSectionPhysicalSize(NewPhysicalSize:Dword;SectionNum:byte):boolean;
 function ChangeSectionRVA(NewSectionRVA:Dword;SectionNum:byte):boolean;
 function ChangeSectionVirtualSize(NewVirtualSize:Dword;SectionNum:byte):boolean;
 function ChangeEntryPoint(NewEntryPointRVA:Dword):boolean;
 Function ChangeImageSize(NewImageSize:Dword):boolean;
 Function ChangeImageBase(NewImageBase:Dword):boolean;
 Function ChangeCodeSize(NewCodeSize:Dword):boolean;
 Function ChangeCodeBase(NewCodeBase:Dword):boolean;
 Function ChangeDataBase(NewDataBase:Dword):boolean;
 Function ChangeFileAlignment(NewFileAlignment:Dword):boolean;
 Function ChangeObjectAlignment(NewObjectAlignment:Dword):boolean;
 Function ChangeResourcesRVA(NewResourcesRVA:Dword):boolean;
 Function ChangeResourcesSize(NewResourcesSize:Dword):boolean;
 destructor Free;

 property FileName: string read FFilename;
 property Size: dword read FFSize;
 property PEHeaderOffset: integer read FFPEHeaderOffset;
 property NTHeaderSize: word read FFNTHeaderSize;

 property NumObject:word read FFNumObject;
 property CodeSize:dword read FFCodeSize;
 property InitDataSize: dword read FFInitDataSize;
 property UnInitDataSize:dword read FFUnInitDataSize;
 property RVAEntryPoint:dword read FFRVAEntryPoint;
 property DataBase:dword read FFDataBase;
 property CodeBase:dword read FFCodeBase;
 property ImageBase:dword read FFImageBase;
 property ObjectAlign:dword read FFObjectAlign;
 property FileAlign:Dword read FFFileAlign;
 property ImageSize:dword read FFImageSize;
 property HeaderSize:Dword read FFHeaderSize;
 property RVAExportTable:dword read FFRVAExportTable;
 property SizeExportTable:dword read FFSizeExportTable;
 property RVAImportTable:Dword read FFRVAImportTable;
 property SizeImportTable:Dword read FFSizeImportTable;
 property RVAResources:dword read FFRVAResources;
 property SizeResources:dword read FFSizeResources;
 property RVAExceptionTable:dword read FFRVAExceptionTable;
 property SizeExceptionTable:dword read FFSizeExceptionTable;
 property Section[Index:byte]:TSection read GetSectionInfo;
 property ImportTableSection:string read FFImportTableSection;
 property ImportTableOffset:dword read FFImportTableOffset;
 property EntryPointPhysicalOffset:Dword read GetEntryPointPhysicalOffset;

 end;

 Function GetSectionName(Name:array of byte):String;
 implementation


Function GetSectionName(Name:array of byte):String;
 Var I:byte;
 begin
  Result:='';
  For I:=0 to 7 do
   begin
    If Name[i]=0 then break;
    Result:=Result+Chr(Name[i]);
    end;
 end;


 Function TPEFile.GetSectionInfo(Index:byte):TSection;
  begin
  Result:=FFSections[Index];
  end;

 constructor TPEFile.Create(_File:TStream);
 var I:byte;

 begin
 FFileName:=FileName;
 F:=TMemoryStream.Create();
 _File.Position:=0;
 F.CopyFrom(_File,_File.Size);
 F.Seek($3C,soFromBeginning);
 F.Read(FFPEHeaderOffset,2);

 F.Seek(FFPEHeaderOffset,soFromBeginning);

 F.Read(FFPESignature,4);
 IF FFPESignature<>PESignature then
  raise EExternal.CreateFmt('Error! It is not PE File!',[]);
 FFSize:=F.Size;

 F.Seek(FFPEHeaderOffset+$06,soFromBeginning);
 F.Read(FFNumObject,2);

 F.Seek(FFPEHeaderOffset+$14,soFromBeginning);
 F.Read(FFNTHeaderSize,2);


 F.Seek(FFPEHeaderOffset+$1C,soFromBeginning);
 F.Read(FFCodeSize,4);

 F.Seek(FFPEHeaderOffset+$20,soFromBeginning);
 F.Read(FFInitDataSize,4);

 F.Seek(FFPEHeaderOffset+$24,soFromBeginning);
 F.Read(FFUnInitDataSize,4);

 F.Seek(FFPEHeaderOffset+$28,soFromBeginning);
 F.Read(FFRVAEntryPoint,4);

  F.Seek(FFPEHeaderOffset+$2C,soFromBeginning);
  F.Read(FFCodeBase,4);

 F.Seek(FFPEHeaderOffset+$30,soFromBeginning);
 F.Read(FFDataBase,4);

 F.Seek(FFPEHeaderOffset+$34,soFromBeginning);
 F.Read(FFImageBase,4);

 F.Seek(FFPEHeaderOffset+$38,soFromBeginning);
 F.Read(FFObjectAlign,4);

 F.Seek(FFPEHeaderOffset+$3C,soFromBeginning);
 F.Read(FFFileAlign,4);

 F.Seek(FFPEHeaderOffset+$50,soFromBeginning);
 F.Read(FFimageSize,4);

 F.Seek(FFPEHeaderOffset+$54,soFromBeginning);
 F.Read(FFHeaderSize,4);

 F.Seek(FFPEHeaderOffset+$78,soFromBeginning);
 F.Read(FFRVAExportTable,4);

 F.Seek(FFPEHeaderOffset+$7C,soFromBeginning);
 F.Read(FFSizeExportTable,4);

 F.Seek(FFPEHeaderOffset+$80,soFromBeginning);
 F.Read(FFRVAImportTable,4);

 F.Seek(FFPEHeaderOffset+$84,soFromBeginning);
 F.Read(FFSizeImportTable,4);

 F.Seek(FFPEHeaderOffset+$88,soFromBeginning);
 F.Read(FFRVAResources,4);

 F.Seek(FFPEHeaderOffset+$8C,soFromBeginning);
 F.Read(FFSizeResources,4);

 F.Seek(FFPEHeaderOffset+$90,soFromBeginning);
 F.Read(FFRVAExceptionTable,4);

 F.Seek(FFPEHeaderOffset+$94,soFromBeginning);
 F.Read(FFSizeExceptionTable,4);

 F.Seek(FFPEHeaderOffset+$F8,soFromBeginning);

 for I:=1 to FFNumObject do
  begin
  F.Read(FFSections[i].ObjectName,8);
  F.Read(FFSections[i].VirtualSize,4);
  F.Read(FFSections[i].SectionRVA,4);
  F.Read(FFSections[i].PhysicalSize,4);
  F.Read(FFSections[i].PhysicalOffset,4);
  F.Seek($0C,soFromCurrent);
  F.Read(FFSections[i].ObjectFlags,4);
  FFSections[i].ObjectNameStr:=GetSectionName(FFSections[i].ObjectName);
  if FFSections[i].SectionRVA=FFRVAImportTable then
      begin
      FFImportTableOffset:=FFSections[i].PhysicalOffset;
      FFImportTableSection:=FFSections[i].ObjectNameStr;
      end;
  end;
//  inherited Create;
 end;

Function TPEFile.GetEntryPointPhysicalOffset:dword;
 Var I:byte;
   begin
    For I:=1 to FFNumObject do
     begin
      If FFRVAEntryPoint>=FFSections[i].SectionRVA then
         begin
          Result:=FFSections[i].PhysicalOffset+(FFRVAEntryPoint-FFSections[i].SectionRVA);
          Exit;
         end;
     end;
   Result:=0;
   end;

  Function TPEFile.AddSection(const Name:string;PhysicalSize,VirtualSize,ObjectFlags:DWord;FillRandom:boolean):boolean;
   Var I:byte;
   ImSize:Cardinal;
   L:Cardinal;
   NewSection:TSection;
   NewRVA:Dword;
   PS:DWORD;
   begin
   if Name='' then
     begin
     Result:=False;
     Exit;
     end;

   If VirtualSize<PhysicalSize then
    begin
     Result:=False;
     Exit;
     end;

   PS:=PhysicalSize mod FFFileAlign;
   if PS>0 then
      begin
      PS:=PhysicalSize div FFFileAlign;
      Inc(PS);
      PS:=PS*FFFileAlign;
      PhysicalSize:=PS;
      end;



    For I:=1 to 8 do
     NewSection.ObjectName[i-1]:=0;

    For I:=1 to Length(Name) do
     NewSection.ObjectName[i-1]:=Ord(Name[i]);



    NewSection.VirtualSize:=VirtualSize;
    NewSection.PhysicalSize:=PhysicalSize;
    NewRVA:=FFSections[FFNumObject].SectionRVA+FFSections[FFNumObject].VirtualSize;
if (NewRVA mod FFObjectAlign)<>0 then
   begin
    NewRVA:=(NewRVA div FFObjectAlign)+1;
    NewRVA:=NewRVA * FFObjectAlign;
   end; 
    NewSection.SectionRVA:=NewRVA;
    NewSection.PhysicalOffset:=FFSections[FFNumObject].PhysicalOffset+FFSections[FFNumObject].PhysicalSize;
    NewSection.ObjectFlags:=ObjectFlags;

    Inc(FFNumObject);
    FFSections[FFNumObject]:=NewSection;
    F.Seek(FFPEHeaderOffset+$F8,soFromBeginning);
    For I:=1 to FFNumObject do
       begin
       F.Write(FFSections[i].ObjectName,8);
       F.Write(FFSections[i].VirtualSize,4);
       F.Write(FFSections[i].SectionRVA,4);
       F.Write(FFSections[i].PhysicalSize,4);
       F.Write(FFSections[i].PhysicalOffset,4);
       F.Seek($0C,soFromCurrent);
       F.Write(FFSections[i].ObjectFlags,4);
       end;
   F.Seek(FFSections[FFNumObject-1].PhysicalOffset+FFSections[FFNumObject-1].PhysicalSize,soFromBeginning);
//   F.seek(3,soFromBeginning);
  If FillRandom=False then
   begin
  I:=$00;
   For L:=1 to PhysicalSize do
   F.Write(I,1);
   end
 else
   For L:=1 to PhysicalSize do
   begin
     I:=Random(255);
    F.Write(I,1);
   end;

   F.Seek(FFPEHeaderOffset+$06,soFromBeginning);
   F.Write(FFNumObject,2);

   ImSize:=(NewSection.VirtualSize div FFObjectAlign)+1;
   ImSize:=ImSize*FFObjectAlign;

//   FFimageSize:=FFimageSize+ImSize;
   FFImageSize:=FFimageSize+NewSection.VirtualSize;
   F.Seek(FFPEHeaderOffset+$50,soFromBeginning);
   F.Write(FFimageSize,4);
   Result:=True;
  end;

  function TPEFile.ChangeSectionFlags(NewFlags:Dword;SectionNum:byte):boolean;
   begin
   FFSections[SectionNum].ObjectFlags:=NewFlags;
   F.Seek(FFPEHeaderOffset+$F8+(SectionNum-1)*$28,soFromBeginning);
       F.Write(FFSections[SectionNum].ObjectName,8);
       F.Write(FFSections[SectionNum].VirtualSize,4);
       F.Write(FFSections[SectionNum].SectionRVA,4);
       F.Write(FFSections[SectionNum].PhysicalSize,4);
       F.Write(FFSections[SectionNum].PhysicalOffset,4);
       F.Seek($0C,soFromCurrent);
       F.Write(FFSections[SectionNum].ObjectFlags,4);
   Result:=True;
   end;

  function TPEFile.ChangeSectionVirtualSize(NewVirtualSize:Dword;SectionNum:byte):boolean;
   begin
   FFSections[SectionNum].VirtualSize:=NewVirtualSize;
   F.Seek(FFPEHeaderOffset+$F8+(SectionNum-1)*$28,soFromBeginning);
       F.Write(FFSections[SectionNum].ObjectName,8);
       F.Write(FFSections[SectionNum].VirtualSize,4);
       F.Write(FFSections[SectionNum].SectionRVA,4);
       F.Write(FFSections[SectionNum].PhysicalSize,4);
       F.Write(FFSections[SectionNum].PhysicalOffset,4);
       F.Seek($0C,soFromCurrent);
       F.Write(FFSections[SectionNum].ObjectFlags,4);
   Result:=True;
   end;

  function TPEFile.ChangeSectionRVA(NewSectionRVA:Dword;SectionNum:byte):boolean;
   begin
   FFSections[SectionNum].SectionRVA:=NewSectionRVA;
   F.Seek(FFPEHeaderOffset+$F8+(SectionNum-1)*$28,soFromBeginning);
       F.Write(FFSections[SectionNum].ObjectName,8);
       F.Write(FFSections[SectionNum].VirtualSize,4);
       F.Write(FFSections[SectionNum].SectionRVA,4);
       F.Write(FFSections[SectionNum].PhysicalSize,4);
       F.Write(FFSections[SectionNum].PhysicalOffset,4);
       F.Seek($0C,soFromCurrent);
       F.Write(FFSections[SectionNum].ObjectFlags,4);
   Result:=True;
   end;

  function TPEFile.ChangeSectionPhysicalSize(NewPhysicalSize:Dword;SectionNum:byte):boolean;
   begin
   FFSections[SectionNum].PhysicalSize:=NewPhysicalSize;
   F.Seek(FFPEHeaderOffset+$F8+(SectionNum-1)*$28,soFromBeginning);
       F.Write(FFSections[SectionNum].ObjectName,8);
       F.Write(FFSections[SectionNum].VirtualSize,4);
       F.Write(FFSections[SectionNum].SectionRVA,4);
       F.Write(FFSections[SectionNum].PhysicalSize,4);
       F.Write(FFSections[SectionNum].PhysicalOffset,4);
       F.Seek($0C,soFromCurrent);
       F.Write(FFSections[SectionNum].ObjectFlags,4);
   Result:=True;
   end;

  function TPEFile.ChangeSectionPhysicalOffset(NewPhysicalOffset:Dword;SectionNum:byte):boolean;
   begin
   FFSections[SectionNum].PhysicalOffset:=NewPhysicalOffset;
   F.Seek(FFPEHeaderOffset+$F8+(SectionNum-1)*$28,soFromBeginning);
       F.Write(FFSections[SectionNum].ObjectName,8);
       F.Write(FFSections[SectionNum].VirtualSize,4);
       F.Write(FFSections[SectionNum].SectionRVA,4);
       F.Write(FFSections[SectionNum].PhysicalSize,4);
       F.Write(FFSections[SectionNum].PhysicalOffset,4);
       F.Seek($0C,soFromCurrent);
       F.Write(FFSections[SectionNum].ObjectFlags,4);
   Result:=True;
   end;


    function TPEFile.ChangeEntryPoint(NewEntryPointRVA:Dword):boolean;
     begin
      FFRVAEntryPoint:=NewEntryPointRVA;
      F.Seek(FFPEHeaderOffset+$28,soFromBeginning);
      F.Write(FFRVAEntryPoint,4);
      Result:=true;
     end;

    function TPEFile.ChangeImageSize(NewImageSize:Dword):boolean;
     begin
      FFImageSize:=NewImageSize;
      F.Seek(FFPEHeaderOffset+$50,soFromBeginning);
      F.Write(FFImageSize,4);
      Result:=true;
     end;

     function TPEFile.ChangeImageBase(NewImageBase:Dword):boolean;
     begin
      FFImageBase:=NewImageBase;
      F.Seek(FFPEHeaderOffset+$34,soFromBeginning);
      F.Write(FFImageBase,4);
      Result:=true;
     end;

     function TPEFile.ChangeCodeSize(NewCodeSize:Dword):boolean;
     begin
      FFCodeSize:=NewCodeSize;
      F.Seek(FFPEHeaderOffset+$1C,soFromBeginning);
      F.Write(FFCodeSize,4);
      Result:=true;
     end;

     function TPEFile.ChangeCodeBase(NewCodeBase:Dword):boolean;
     begin
      FFCodeBase:=NewCodeBase;
      F.Seek(FFPEHeaderOffset+$2C,soFromBeginning);
      F.Write(FFCodebase,4);
      Result:=true;
     end;

     function TPEFile.ChangeDataBase(NewDataBase:Dword):boolean;
     begin
      FFDataBase:=NewDataBase;
      F.Seek(FFPEHeaderOffset+$30,soFromBeginning);
      F.Write(FFDataBase,4);
      Result:=true;
     end;

     Function TPEFile.ChangeFileAlignment(NewFileAlignment:Dword):boolean;
     begin
      FFFileAlign:=NewFileAlignment;
      F.Seek(FFPEHeaderOffset+$3C,soFromBeginning);
      F.Write(FFFileAlign,4);
      Result:=true;
     end;

     function TPEFile.ChangeObjectAlignment(NewObjectAlignment:dword):boolean;
     begin
      FFObjectAlign:=NewObjectAlignment;
      F.Seek(FFPEHeaderOffset+$38,soFromBeginning);
      F.Write(FFObjectAlign,4);
      Result:=true;
     end;

     function TPEFile.ChangeResourcesRVA(NewResourcesRVA:dword):boolean;
      begin
      FFRVAResources:=NewResourcesRVA;
      F.Seek(FFPEHeaderOffset+$88,soFromBeginning);
      F.Write(FFRVAResources,4);
      Result:=true;
     end;

     function TPEFile.ChangeResourcesSize(NewResourcesSize:dword):boolean;
      begin
      FFSizeResources:=NewResourcesSize;
      F.Seek(FFPEHeaderOffset+$8C,soFromBeginning);
      F.Write(FFSizeResources,4);
      Result:=true;
     end;



 destructor TPEFile.Free;
 begin
 F.Free;
 end;

end.
