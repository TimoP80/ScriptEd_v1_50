program DAT_Tester;

{$APPTYPE CONSOLE}

uses
  arcdatlib,
  JclMath,
  SysUtils;

var
  datfile: datfileheader;
  totalcompressed: Integer;
  totaluncompressed: Integer;
  s: Integer;
  dathnd: file;

begin
  writeln('--------------------------------------------------');
  writeln('DAT File information viewer for debugging purposes');
  writeln('--------------------------------------------------');
  writeln;

  if paramcount = 0 then
  begin
    writeln('Usage: DAT_Tester.exe <filename>');
    exit;
  end;
  Write('Opening dat file...');
  opendatfile(dathnd, datfile, ParamStr(1));
  writeln('done!');
  writeln;
  writeln('Information:');
  writeln;
  writeln('Number of files ', datfile.filecount);
  writeln('Unknown1:        ', datfile.unknown1, ' (HEX: ', inttohex(datfile.unknown1, 16), ')');
  writeln('JUNK1:        ', datfile.junk1, ' (HEX: ', inttohex(datfile.junk1, 16), ')');
  writeln('JUNK2:        ', datfile.junk2, ' (HEX: ', inttohex(datfile.junk2, 16), ')');
  writeln('Signature:    ', datfile.signature, ' (HEX: ', inttohex(datfile.signature, 16), ')');
  totaluncompressed:=0;
  totalcompressed:=0;

  for s := 0 to datfile.filecount - 1 do
  begin
  inc(totaluncompressed, datfile.files[s].realsize);
  inc(totalcompressed, datfile.files[s].packedsize);
  end;
    writeln('total compressed ',totalcompressed);
    writeln('total uncompressed ',totaluncompressed);

  { TODO -oUser -cConsole Main : Insert code here }
end.
