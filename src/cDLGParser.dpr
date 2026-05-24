program cDLGParser;
{$APPTYPE CONSOLE}

uses
  SysUtils,
  DLGParser;

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
  DLGParser1 : TDLGParser;
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
  Write('DLGParser');
  Writeln('  - ' + DLGParser1.Version
    + FormatDateTime(' (ddddd t)',DLGParser1.BuildDate));
  Writeln('    ' + DLGParser1.VersionComment);
  Writeln('    Author: ' + DLGParser1.GrammarAuthor);
  Writeln('    ' + DLGParser1.GrammarCopyright);
  Writeln;
end;

procedure ShowHelp;
begin
  Writeln('Usage: cDLGParser [filename]');
  Writeln('Example: cDLGParser Test.txt');
end;

begin
  ShowVersion;
  if ParamCount = 0 then
  begin
    ShowHelp;
    Exit;
  end;
  DLGParser1 := TDLGParser.Create(nil);
  try
    DisplayObj := TDisplayObj.Create;
    try
      if NOT FileExists(ParamStr(1)) then
      begin
        Writeln('File: ' + ParamStr(1) + ' not found.');
        Exit;
      end;
      DLGParser1.OnCustomError := DisplayObj.CustomErrorEvent;
      DLGParser1.OnSuccess := DisplayObj.OnSuccess;
      DLGParser1.OnFailure := DisplayObj.OnFailure;

      DLGParser1.SourceFileName := ParamStr(1);
      DLGParser1.Execute;
      DLGParser1.ListStream.SaveToFile(ChangeFileExt(ParamStr(1),'.lst'));
    finally
      DisplayObj.Free;
    end;
  finally
    DLGParser1.Free;
  end;

end.    
