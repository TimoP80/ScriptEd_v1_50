program CreateConstants;

{$APPTYPE CONSOLE}

uses
  Classes,
  mesparser,
  mesfileio,
  SysUtils;

var
  actionconstants: MessageFile;
  t: Integer;
  dataoutput: TStrings;
begin
  dataoutput := TStringList.Create;
  actionconstants := ParseMES('condition_constants.mes');

  for t := 0 to actionconstants.entrycnt - 1 do
  begin
    writeln('processing ' + IntToStr(t));
    dataoutput.add(format('const SC_%s = %d;', [actionconstants.entries[t].messagestr, actionconstants.entries[t].index]));
  end;
  dataoutput.add('');
  dataoutput.add('function OpcodeConstantValueToString(id: integer): string;');
  dataoutput.add('begin');
  dataoutput.add('     case id of');
  for t := 0 to actionconstants.entrycnt - 1 do
  begin
    dataoutput.add(format('%d: ', [actionconstants.entries[t].index]));
    dataoutput.add(format('result:=''%s'';', [actionconstants.entries[t].messagestr]));

  end;

  dataoutput.add('  end');
  dataoutput.add('end');
  dataoutput.savetofile('constants.pas');
  dataoutput.Free;

end.
