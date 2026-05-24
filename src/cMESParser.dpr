program cMESParser;
{$APPTYPE CONSOLE}

uses
  SysUtils,
  MESParser;

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
  MESParser1 : TMESParser;
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
  Write('MESParser');
  Writeln('  - ' + MESParser1.Version
    + FormatDateTime(' (ddddd t)',MESParser1.BuildDate));
  Writeln('    ' + MESParser1.VersionComment);
  Writeln('    Author: ' + MESParser1.GrammarAuthor);
  Writeln('    ' + MESParser1.GrammarCopyright);
  Writeln;
end;

procedure ShowHelp;
begin
  Writeln('Usage: cMESParser [filename]');
  Writeln('Example: cMESParser Test.txt');
end;

begin
  ShowVersion;
  if ParamCount = 0 then
  begin
    ShowHelp;
    Exit;
  end;
  MESParser1 := TMESParser.Create(nil);
  try
    DisplayObj := TDisplayObj.Create;
    try
      if NOT FileExists(ParamStr(1)) then
      begin
        Writeln('File: ' + ParamStr(1) + ' not found.');
        Exit;
      end;
      MESParser1.OnCustomError := DisplayObj.CustomErrorEvent;
      MESParser1.OnSuccess := DisplayObj.OnSuccess;
      MESParser1.OnFailure := DisplayObj.OnFailure;

      MESParser1.SourceFileName := ParamStr(1);
      MESParser1.Execute;
      MESParser1.ListStream.SaveToFile(ChangeFileExt(ParamStr(1),'.lst'));
    finally
      DisplayObj.Free;
    end;
  finally
    MESParser1.Free;
  end;

end.    
