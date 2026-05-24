unit MESFileIO;


interface

uses Classes, CocoBase, arcdatlib, SysUtils, MesParser;

function GetMesStringByID(id: Integer; MesFILE: MessageFile): AnsiString;
function GetMesIDByString(id: AnsiString; MesFILE: MessageFile): Integer;
function ParseMES(filename: AnsiString): MessageFile;
function ParseMESFromModuleDAT(filename: AnsiString): MessageFile;
procedure AddMesEntry(id: Integer; messagestr: AnsiString; var mes: MessageFile);
procedure DeleteMesEntry(index: Integer; var mes: MessageFile);
procedure SaveMesFile(filename: AnsiString; mes: MessageFile);
function GetMesIDByStringLowerCase(id: AnsiString; MesFILE: MessageFile): Integer;
procedure InsertMesEntry(id: Integer; ins_index: Integer; var msg: MessageFile);
function GetMesIndexByID(id: Integer; MesFILE: MessageFile): Integer;
function ParseMESFromDAT(filename: AnsiString; var thehandle: file; datfile: AnsiString; dathandle: datfileheader): MessageFile;

var
  arcanum3hnd: file;
  arcanum3dat: datfileheader;
  arcanum4hnd: file;
  arcanum4dat: datfileheader;


implementation

uses ModuleLoader, ScriptEdWindow, ArcanumSCRLib;

procedure InsertMesEntry(id: Integer; ins_index: Integer; var msg: MessageFile);
var
  t: Integer;
begin
  setlength(msg.entries, msg.entrycnt + 1);
  new(msg.entries[msg.entrycnt]);
  for t := msg.entrycnt downto ins_index + 1 do
  begin
    msg.entries[t]^ := msg.entries[t - 1]^;
  end;
  setlength(msg.entries, msg.entrycnt + 1);
  new(msg.entries[ins_index]);
  msg.entries[ins_index].index := id;
  msg.entries[ins_index].beforeline_comments := TCommentList.Create;
  msg.entries[ins_index].add_linebreak := False;
  msg.entries[ins_index].messagestr := '';


  Inc(msg.entrycnt);
end;

procedure DeleteMesEntry(index: Integer; var mes: MessageFile);
var
  y: Integer;
begin
  consoledebug('Delete mes entry ' + IntToStr(index) + ' from ' + mes.msgfilename);
  if index = mes.entrycnt - 1 then
  begin
    mes.entrycnt := mes.entrycnt - 1;
    exit;
  end;

  for y := index to mes.entrycnt - 1 do
  begin

    mes.entries[y] := mes.entries[y + 1];
  end;
  mes.entrycnt := mes.entrycnt - 1;

end;


procedure AddMesEntry(id: Integer; messagestr: AnsiString; var mes: MessageFile);
begin
  setlength(mes.entries, mes.entrycnt + 1);
  new(mes.entries[mes.entrycnt]);
  mes.entries[mes.entrycnt].beforeline_comments := TCommentList.Create;
  mes.entries[mes.entrycnt].index := id;
  mes.entries[mes.entrycnt].add_linebreak := False;
  mes.entries[mes.entrycnt].messagestr := messagestr;
  Inc(mes.entrycnt);
end;


function GetMesIDByStringLowerCase(id: AnsiString; MesFILE: MessageFile): Integer;
var
  t: Integer;
begin
  Result := -1;
  for t := 0 to mesfile.entrycnt - 1 do
  begin
    if lowercase(id) = lowercase(mesfile.entries[t].messagestr) then
    begin
      Result := mesfile.entries[t].index;
      exit;
    end;
  end;

end;

function GetMesIndexByID(id: Integer; MesFILE: MessageFile): Integer;
var
  t: Integer;
begin
  Result := -1;
  for t := 0 to mesfile.entrycnt - 1 do
  begin
    if id = mesfile.entries[t].index then
    begin
      Result := t;
      exit;
    end;
  end;

end;

function GetMesIDByString(id: AnsiString; MesFILE: MessageFile): Integer;
var
  t: Integer;
begin
  Result := -1;
  for t := 0 to mesfile.entrycnt - 1 do
  begin
    if id = mesfile.entries[t].messagestr then
    begin
      Result := mesfile.entries[t].index;
      exit;
    end;
  end;

end;

function GetMesStringByID(id: Integer; MesFILE: MessageFile): AnsiString;
var
  t: Integer;
begin
  for t := 0 to mesfile.entrycnt - 1 do
  begin
    if id = mesfile.entries[t].index then
    begin
      Result := mesfile.entries[t].messagestr;
      exit;
    end;

  end;

end;

function ParseMESFromDAT(filename: AnsiString; var thehandle: file; datfile: AnsiString; dathandle: datfileheader): MessageFile;
var
  mesparser: TMESParser;
begin

  consoledebug('DAT_ParseMES src=' + datfile + ' => ' + filename, False);
  currentmessagefile.entrycnt := 0;
  opendatfile(thehandle, dathandle, datfile);
  openfilefromdat(thehandle, DATHandle, filename, GetEnvironmentVariable('TEMP') + '\' + extractfilename(filename));
  mesparser := TMESParser.Create(nil);
  mesparser.sourcefilename := GetEnvironmentVariable('TEMP') + '\' + extractfilename(filename);
  mesparser.Execute;
  if mesparser.successful then
  begin
    Result := CurrentMessageFile;
    Result.msgfilename := extractfilename(filename);
    consoledebug('success - got ' + IntToStr(Result.entrycnt) + ' entries.');
  end else
  begin
    consoledebug('PARSE FAILED!');

  end;

  closedathandle(thehandle);
  mesparser.Free;
  cleanuptempfiles(dathandle, GetEnvironmentVariable('TEMP') + '\');
end;

function ParseMESFromModuleDAT(filename: AnsiString): MessageFile;
var
  mesparser: TMESParser;
begin
  consoledebug('DAT_ParseMES (' + moduleDATHandle.dat_filename + ') => ' + filename, False);
  currentmessagefile.entrycnt := 0;
  openfilefromdat(modulefile, moduleDATHandle, filename, GetEnvironmentVariable('TEMP') + '\' + extractfilename(filename));
  mesparser := TMESParser.Create(nil);
  mesparser.sourcefilename := GetEnvironmentVariable('TEMP') + '\' + extractfilename(filename);
  mesparser.Execute;
  if mesparser.successful then
  begin
    Result := CurrentMessageFile;
    Result.msgfilename := extractfilename(filename);
  end;
  mesparser.Free;
  // cleanuptempfiles(moduledathandle, GetEnvironmentVariable('TEMP') + '\');
end;

procedure SaveMesFile(filename: AnsiString; mes: MessageFile);
var
  saver: TStrings;
  headertemp: string;
  lines: tstrings;
  x, s:  Integer;
begin

  ConsoleDebug('Saving message file "' + extractfilename(mes.msgfilename) + '" to folder ' + extractfiledir(filename));
  saver := TStringList.Create;
  lines:=TSTringlist.create;
  lines.Text := mes.header;
  for s := 0 to lines.Count-1 do
  begin
  lines[s] := '// '+lines[s];
  end;
  saver.Add(lines.text);

  for s := 0 to mes.entrycnt - 1 do
  begin
    if (mes.entries[s].beforeline_comments <> nil) and (mes.entries[s].beforeline_comments.Count > 0) then
    begin
      for x := 0 to mes.entries[s].beforeline_comments.Count - 1 do
      begin
        if pos('//', mes.entries[s].beforeline_comments.Comments[x]) = 0 then

          saver.add('// ' + mes.entries[s].beforeline_comments.Comments[x])
        else
          saver.add(mes.entries[s].beforeline_comments.Comments[x]);
      end;

    end;
    saver.Add('{' + IntToStr(mes.entries[s].index) + '}{' + mes.entries[s].messagestr + '}');
    if mes.entries[s].add_linebreak = True then
      saver.Add('');
  end;
  saver.SaveToFile(filename);
  saver.Free;
end;


function ParseMES(filename: AnsiString): MessageFile;
var
  mesparser: TMESParser;
  z, t: Integer;
begin
  currentmessagefile.entrycnt := 0;
  mesparser := TMESParser.Create(nil);
  if fileexists(filename) = False then
  begin
    consoledebug('Warning: MES file ' + filename + ' does not exist You can still edit this mes file, it will be created when you save it.');
    Result.entrycnt := 0;
    Result.msgfilename := filename;
    exit;
  end;

  mesparser.sourcefilename := filename;
  mesparser.Execute;
  if mesparser.successful then
  begin
    for t := 0 to currentmessagefile.entrycnt - 1 do
    begin
      if currentmessagefile.entries[t].beforeline_comments.Count > 0 then
      begin
        //      Consoledebug('Cleaning up comments for entry ' + IntToStr(t) + ' of ' + filename);
        for z := 0 to currentmessagefile.entries[t].beforeline_comments.Count - 1 do
        begin
          currentmessagefile.entries[t].beforeline_comments.Comments[z] :=
            stringreplace(currentmessagefile.entries[t].beforeline_comments.Comments[z], '// ', '', [rfReplaceAll]);
          currentmessagefile.entries[t].beforeline_comments.Comments[z] :=
            stringreplace(currentmessagefile.entries[t].beforeline_comments.Comments[z], '//', '', [rfReplaceAll]);

        end;
      end;
    end;
    currentmessagefile.header := CurrentMessageFile.entries[0].beforeline_comments.Text;
   CurrentMessageFile.entries[0].beforeline_comments.Clear;

    Result := CurrentMessageFile;

    Result.msgfilename := filename;

    consoledebug('Loaded mes file ' + extractfilename(filename) + ' (' + IntToStr(Result.entrycnt) + ' entries)', False);
  end else
  begin
    ConsoleDebug('Error while parsing: ' + extractfilename(filename) + '. Check the file for uncommented text outside the brackets.');
  end;

  mesparser.Free;

end;


end.
