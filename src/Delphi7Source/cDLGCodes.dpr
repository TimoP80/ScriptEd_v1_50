program cDLGCodes;
{$APPTYPE CONSOLE}

uses
  SysUtils,
  DLGCodes;

const
  ResultStr = 'Results can be found in ';

type
  TDisplayObj = class(TObject)
  private
    function CustomErrorEvent(Sender : TObject; const ErrorCode : integer;
      const Data : string) : string;
    procedure OnSuccess(Sender : TObject);
    procedure OnFailure(Sender : TObject; NumErrors : integer);
  end; // DisplayObj

var
  DLGCodes1 : TDLGCodes;
  DisplayObj : TDisplayObj;

{ TDisplayObj }

function TDisplayObj.CustomErrorEvent(Sender: TObject;
  const ErrorCode: integer; const Data : string): string;
begin
  Result := 'Error: ' + IntToStr(ErrorCode);
end;

procedure TDisplayObj.OnSuccess(Sender : TObject);
begin
  Writeln('Compile sucessful');
  Writeln(ResultStr + ChangeFileExt(ParamStr(1),'.lst'));
end;

procedure TDisplayObj.OnFailure(Sender : TObject; NumErrors : integer);
begin
  Write('Compile completed with ' + IntToStr(NumErrors) + ' error');
  if NumErrors <> 1 then
    Writeln('s')
  else
    Writeln;
  Writeln(ResultStr + ChangeFileExt(ParamStr(1),'.lst'));
end;

procedure ShowVersion;
begin
  Write('DLGCodes');
  Writeln('  - ' + DLGCodes1.Version
    + FormatDateTime(' (ddddd t)',DLGCodes1.BuildDate));
  Writeln('    ' + DLGCodes1.VersionComment);
  Writeln('    Author: ' + DLGCodes1.GrammarAuthor);
  Writeln('    ' + DLGCodes1.GrammarCopyright);
  Writeln;
end;

procedure ShowHelp;
begin
  Writeln('Usage: cDLGCodes [filename]');
  Writeln('Example: cDLGCodes Test.txt');
end;

begin
  ShowVersion;
  if ParamCount = 0 then
  begin
    ShowHelp;
    Exit;
  end;
  DLGCodes1 := TDLGCodes.Create(nil);
  try
    DisplayObj := TDisplayObj.Create;
    try
      if NOT FileExists(ParamStr(1)) then
      begin
        Writeln('File: ' + ParamStr(1) + ' not found.');
        Exit;
      end;
      DLGCodes1.OnCustomError := DisplayObj.CustomErrorEvent;
      DLGCodes1.OnSuccess := DisplayObj.OnSuccess;
      DLGCodes1.OnFailure := DisplayObj.OnFailure;

      DLGCodes1.SourceFileName := ParamStr(1);
      DLGCodes1.Execute;
      DLGCodes1.ListStream.SaveToFile(ChangeFileExt(ParamStr(1),'.lst'));
    finally
      DisplayObj.Free;
    end;
  finally
    DLGCodes1.Free;
  end;

end.    
