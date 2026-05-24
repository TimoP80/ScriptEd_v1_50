program DLGMassCheck;

{$APPTYPE CONSOLE}

uses
  Classes,
  ScriptEdConfig,
  JclFileUtils,
  dlgfileio,
  dlgparser,
  arcdatlib,
  arcanumscrlib,
  SysUtils;

var
  lst: TStrings;
  t: Integer;
begin
  VerboseDebug := False;
  writeln('Arcanum DLGLib Tester');
  writeln('---------------------');
  writeln;
  writeln('used for testing which dlg files cause the parser to crash');
  writeln;
  writeln('current dir: ', getcurrentdir);
  lst := TStringList.Create;
  advbuildfilelist(getcurrentdir + '\*.dlg', faAnyfile, lst, amAny, [flFullNames]);
  writeln(lst.Count, ' files found.');
  writeln('Attempting to parse each of them...');
  for t := 0 to lst.Count - 1 do
  begin
 //   writeln(extractfilename(lst[t]));
    LoadDialogue(lst[t]);
  end;

  { TODO -oUser -cConsole Main : Insert code here }
end.
