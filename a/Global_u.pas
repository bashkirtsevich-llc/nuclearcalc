unit Global_u;

interface

uses Classes, Dialogs, SysUtils;

type TDrawType=(dtLinear,dtCylinder,dtSphere);
type TFileType=(ft2D,ft3D);

type TFileStruct=packed record
  FileType:TFileType;
  Formule:ShortString;
  XMin,XMax:ShortString;
  YMin,YMax:ShortString;
  XDiv,YDiv:Single;                       
  Zoom:Single;
  OutOfTheLimit:Boolean;
  DrawXaxis,DrawYaxis,DrawZaxis:Boolean;
  DrawXgrid,DrawYgrid,DrawZgrid:Boolean;
  GridX,GridY:Word;
  DrawType:TDrawType;
end;

procedure SaveToFile(FileName:String;FileStruct:TFileStruct);
function LoadFromFile(FileName:String):TFileStruct;

implementation

const Sign:array [0..2] of char=('A','C','F');

resourcestring
  _cantsave='Coud not save file';
  _cantopen='Coud not open file';

procedure SaveToFile(FileName:String;FileStruct:TFileStruct);
var SaveStream:TMemoryStream;
begin
  SaveStream:=TMemoryStream.Create;
  try
    SaveStream.Write(Sign,SizeOf(Sign));
    SaveStream.Write(FileStruct,SizeOf(TFileStruct));
    SaveStream.SaveToFile(FileName);
  except
    MessageDlg(_cantsave,mtWarning,[mbOK],0);
  end;
  SaveStream.Free;
end;

function LoadFromFile(FileName:String):TFileStruct;
var Temp:TFileStruct;
    FileStream:TFileStream;
    _sign:array [0..2] of char;
begin
  try
    FileStream:=TFileStream.Create(FileName,fmOpenRead);
    FileStream.Read(_sign,SizeOf(_sign));
    if _Sign<>Sign then raise exception.Create('There is not ACF file');
    FileStream.Read(Temp,SizeOf(TFileStruct));
    Result:=Temp;
  except
    MessageDlg(_cantOpen,mtWarning,[mbOk],0);
  end;
  FileStream.Free;
end;

end.
