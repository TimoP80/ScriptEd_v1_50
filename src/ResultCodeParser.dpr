program ParseResultCode;

uses
  SysUtils, Classes;

type
  TResultCode = record
    Code: string;
    Usage: string;
    Description: string;
    Params: Integer;
    Format: string;
  end;

function ParseResultCodeLine(const Line: string): TResultCode;
var
  UsageStart, UsageEnd, DescStart, DescEnd, ParamsStart, FormatStart: Integer;
begin
  // Extract the code
  Result.Code := Copy(Line, Pos('"', Line) + 1, Pos('"', Line, Pos('"', Line) + 1) - Pos('"', Line) - 1);

  // Extract usage
  UsageStart := Pos('usage=(', Line) + Length('usage=(');
  UsageEnd := Pos(')', Line, UsageStart);
  Result.Usage := Copy(Line, UsageStart, UsageEnd - UsageStart);

  // Extract description
  DescStart := Pos('description="', Line) + Length('description="');
  DescEnd := Pos('"', Line, DescStart);
  Result.Description := Copy(Line, DescStart, DescEnd - DescStart);

  // Extract params
  ParamsStart := Pos('params=', Line) + Length('params=');
  Result.Params := StrToIntDef(Copy(Line, ParamsStart, Pos(' ', Line, ParamsStart) - ParamsStart), 0);

  // Extract format
  FormatStart := Pos('format=(', Line) + Length('format=(');
  Result.Format := Copy(Line, FormatStart, Pos(')', Line, FormatStart) - FormatStart);
end;

procedure ParseLines(const Lines: TStrings; out ResultCodes: TArray<TResultCode>);
var
  I: Integer;
  InBlockComment: Boolean;
begin
  SetLength(ResultCodes, 0);
  InBlockComment := False;
  for I := 0 to Lines.Count - 1 do
  begin
    if Trim(Lines[I]).StartsWith('//') then
      Continue;

    if Trim(Lines[I]).Contains('/*') then
    begin
      InBlockComment := True;
      Continue;
    end;

    if InBlockComment then
    begin
      if Trim(Lines[I]).Contains('*/') then
        InBlockComment := False;
      Continue;
    end;

    SetLength(ResultCodes, Length(ResultCodes) + 1);
    ResultCodes[High(ResultCodes)] := ParseResultCodeLine(Lines[I]);
  end;
end;

procedure DisplayResultCodes(const ResultCodes: TArray<TResultCode>);
var
  ResultCode: TResultCode;
begin
  for ResultCode in ResultCodes do
  begin
    Writeln('Code: ', ResultCode.Code);
    Writeln('Usage: ', ResultCode.Usage);
    Writeln('Description: ', ResultCode.Description);
    Writeln('Params: ', ResultCode.Params);
    Writeln('Format: ', ResultCode.Format);
    Writeln;
  end;
end;

var
  Lines: TStringList;
  ResultCodes: TArray<TResultCode>;
begin
  Lines := TStringList.Create;
  try
    Lines.LoadFromFile(paramstr(1));

    ParseLines(Lines, ResultCodes);
    DisplayResultCodes(ResultCodes);
  finally
    Lines.Free;
  end;
end.

