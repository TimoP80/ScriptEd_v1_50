unit DLGFileIO;

interface

uses SysUtils, arcanumscrlib, DLGParser;

var
  dlgparser: TDLGParser;

type
  PDialogueFile = ^DialogueFile;

procedure LoadDialogue(filename: String);
procedure InsertNode(Name: String; ins_index: Integer);
procedure AddNode(Name: String);
procedure DeleteNode(ind: Integer);
function GetDLGNewNum(oldnum: Integer): Integer;

procedure AddPlayerOption(nodeindex: Integer; Text: String);
procedure DeletePlayerOption(nodeind: Integer; ind: Integer);
procedure InsertPlayerOption(Text: String; nodeindex: Integer; ins_index: Integer);
function GetNodeIndex(Name: String): Integer;
function GetNodeIndexWithDLGLine(Data: Integer): Integer;

implementation

uses
  Dialogs;

function GetNodeIndexWithDLGLine(Data: Integer): Integer;
var
  t: Integer;
begin
  Result := -1;
  for t := 0 to CurDLG.nodecount - 1 do
  begin
    if CurDLG.nodes[t].start_index = Data then
    begin
      Result := t;
      exit;
    end;
  end;
end;

function GetNodeIndex(Name: String): Integer;
var
  t: Integer;
begin
  Result := -1;
  for t := 0 to CurDLG.nodecount - 1 do
  begin
    if CurDLG.nodes[t].nodename = Name then
    begin
      Result := t;
      exit;
    end;
  end;
end;

function GetDLGNewNum(oldnum: Integer): Integer;
var
  t: Integer;
begin
  for t := 0 to CurDLG.nodecount - 1 do
  begin
    if CurDLG.nodes[t].old_index = oldnum then
    begin
      Result := CurDLG.nodes[t].start_index;
      exit;
    end;
  end;
end;

procedure DeleteNode(ind: Integer);
var
  t: Integer;
begin
  if ind = curdlg.nodecount - 1 then
  begin
    curdlg.nodecount := curdlg.nodecount - 1;
    exit;
  end;

  for T := ind to curdlg.nodecount - 1 do
  begin
    curdlg.nodes[t] := curdlg.nodes[t + 1];
  end;
  curdlg.nodecount := curdlg.nodecount - 1;

end;

procedure DeletePlayerOption(nodeind: Integer; ind: Integer);
var
  t: Integer;
begin
  if ind = curdlg.nodes[nodeind].PlayerOptioncnt - 1 then
  begin
    curdlg.nodes[nodeind].PlayerOptioncnt := curdlg.nodes[nodeind].PlayerOptioncnt - 1;
    exit;
  end;

  for T := ind to curdlg.nodes[nodeind].PlayerOptioncnt - 1 do
  begin
    curdlg.nodes[nodeind].playeroptions[t] := curdlg.nodes[nodeind].playeroptions[t + 1];
  end;
  curdlg.nodes[nodeind].PlayerOptioncnt := curdlg.nodes[nodeind].PlayerOptioncnt - 1;

end;

procedure AddNode(Name: String);
begin
  setlength(CurDLG.nodes, CurDLG.nodecount + 1);
  new(CurDLG.nodes[CurDLG.nodecount]);
  CurDLG.nodes[CurDLG.nodecount].nodename := Name;
  CurDLG.nodes[CurDLG.nodecount].start_index := 0;
  CurDLG.nodes[CurDLG.nodecount].npctextmale := '';
  CurDLG.nodes[CurDLG.nodecount].npctextfemale := '';
  CurDLG.nodes[CurDLG.nodecount].voicefield := '';
  CurDLG.nodes[CurDLG.nodecount].nodeactions := '';
  CurDLG.nodes[CurDLG.nodecount].isfloatmessage := False;
  CurDLG.nodes[CurDLG.nodecount].floatgroupstartmarker := False;
  CurDLG.nodes[CurDLG.nodecount].PlayerOptioncnt := 0;
  Inc(curdlg.nodecount);
end;

procedure InsertPlayerOption(Text: String; nodeindex: Integer; ins_index: Integer);
var
  temp: DialogueNode;
  t: Integer;
begin
  setlength(CurDLG.nodes[nodeindex].PlayerOptions, CurDLG.nodes[nodeindex].PlayerOptioncnt + 1);
  new(CurDLG.nodes[nodeindex].playeroptions[CurDLG.nodes[nodeindex].PlayerOptioncnt]);
  for t := curdlg.nodes[nodeindex].PlayerOptioncnt downto ins_index + 1 do
  begin
    curdlg.nodes[nodeindex]^.PlayerOptions[t]^ := CurDLG.nodes[nodeindex].PlayerOptions[t - 1]^;
  end;
  setlength(CurDLG.nodes[nodeindex].PlayerOptions, CurDLG.nodes[nodeindex].PlayerOptioncnt + 1);
  new(CurDLG.nodes[nodeindex].playeroptions[ins_index]);
  CurDLG.nodes[nodeindex]^.PlayerOptions[ins_index].Text := Text;
  CurDLG.nodes[nodeindex]^.PlayerOptions[ins_index].gendertest := NO_GENDER;
  CurDLG.nodes[nodeindex]^.PlayerOptions[ins_index].iqtest := 5;
  CurDLG.nodes[nodeindex]^.PlayerOptions[ins_index].conditions := '';
  CurDLG.nodes[nodeindex]^.PlayerOptions[ins_index].linktonode := 0;
  CurDLG.nodes[nodeindex]^.PlayerOptions[ins_index].actions := '';
  Inc(CurDLG.nodes[nodeindex].PlayerOptioncnt);
end;

procedure AddPlayerOption(nodeindex: Integer; Text: String);
begin
  setlength(CurDLG.nodes[nodeindex].PlayerOptions, CurDLG.nodes[nodeindex].PlayerOptioncnt + 1);
  new(CurDLG.nodes[nodeindex].PlayerOptions[CurDLG.nodes[nodeindex].PlayerOptioncnt]);
  CurDLG.nodes[nodeindex].PlayerOptions[CurDLG.nodes[nodeindex].PlayerOptioncnt].lineindex := 0;
  CurDLG.nodes[nodeindex].PlayerOptions[CurDLG.nodes[nodeindex].PlayerOptioncnt].Text := Text;
  CurDLG.nodes[nodeindex].PlayerOptions[CurDLG.nodes[nodeindex].PlayerOptioncnt].gendertest := NO_GENDER;
  CurDLG.nodes[nodeindex].PlayerOptions[CurDLG.nodes[nodeindex].PlayerOptioncnt].iqtest := 5;
  CurDLG.nodes[nodeindex].PlayerOptions[CurDLG.nodes[nodeindex].PlayerOptioncnt].conditions := '';
  CurDLG.nodes[nodeindex].PlayerOptions[CurDLG.nodes[nodeindex].PlayerOptioncnt].linktonode := 0;
  CurDLG.nodes[nodeindex].PlayerOptions[CurDLG.nodes[nodeindex].PlayerOptioncnt].actions := '';
  Inc(CurDLG.nodes[nodeindex].PlayerOptioncnt);
end;

procedure InsertNode(Name: String; ins_index: Integer);
var
  temp: DialogueNode;
  t: Integer;
begin
  setlength(CurDLG.nodes, CurDLG.nodecount + 1);
  new(CurDLG.nodes[CurDLG.nodecount]);
  for t := curdlg.nodecount downto ins_index + 1 do
  begin
    curdlg.nodes[t]^ := curdlg.nodes[t - 1]^;
  end;
  setlength(CurDLG.nodes, CurDLG.nodecount + 1);
  new(CurDLG.nodes[ins_index]);
  CurDLG.nodes[ins_index]^.nodename := Name;
  CurDLG.nodes[ins_index]^.start_index := 0;
  CurDLG.nodes[ins_index]^.npctextmale := '';
  CurDLG.nodes[ins_index]^.npctextfemale := '';
  CurDLG.nodes[ins_index]^.isfloatmessage := False;
  CurDLG.nodes[ins_index]^.floatgroupstartmarker := False;
  CurDLG.nodes[ins_index]^.voicefield := '';
  CurDLG.nodes[ins_index]^.nodeactions := '';
  CurDLG.nodes[ins_index]^.PlayerOptioncnt := 0;
  Inc(curdlg.nodecount);
end;


procedure LoadDialogue(filename: String);
var
  t: Integer;
begin

  if (curdlg.nodecount > 0) then
  begin
    for t := 0 to curdlg.nodecount - 1 do
    begin
      if curdlg.nodes[t] <> nil then
      begin
        dispose(curdlg.nodes[t]);
      end;
    end;
  end;

  curdlg.nodecount := 0;

  dlgparser := TDLGParser.Create(nil);

  dlgparser.SourceFileName := filename;
  dlgparser.Execute;
  if dlgparser.Successful = True then
  begin
    Inc(curdlg.nodecount);
    if isconsole = False then
      ConsoleDebug('Successfully loaded dialogue file "' + filename + '" with ' + IntToStr(CurDLG.nodecount) + ' nodes.', False);
    curdlg.dlgfilename := extractfilename(filename);
  end else
  begin
    ConsoleDebug('There was an error parsing the dialogue file!');
    dlgparser.ListStream.SaveToFile('ERRORLOG_' + changefileext(extractfilename(dlgparser.sourcefilename), '.lst'));
    if isconsole = False then
      MessageDlg(format('An error has occured parsing the dialogue file %s', [filename]), mtError, [mbOK], 0);
  end;

  dlgparser.Free;
end;

begin
new(curdlg);
end.
