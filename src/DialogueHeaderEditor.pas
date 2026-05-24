unit DialogueHeaderEditor;

interface

uses
  Windows, Messages, rxstrutils, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  ModuleLoader, ScriptedConfig, MesFileIO, arcanumscrlib, dlgfileio, dlgparser,
  Dialogs, StdCtrls;

type
  TForm13 = class(TForm)
    dlgheadertext: TMemo;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;
  STRGlobalFlags: TStringList;
  STRGlobalVars: TStringList;
  InventoryItems: TStringList;
  Quests: TStringList;
  Rumors: TStringList;

implementation

{$R *.dfm}

procedure ParseDialogString(str: String);
var
  z, id, numconds: Integer;
  currentcommand: String;
  params: Integer;
  command, num1, num2: String;
  actionstr, condstr: String;
begin
  condstr := str;
  numconds := WordCount(condstr, [',']);
  condstr := StringReplace(condstr, 'lf', 'lf ', [rfReplaceAll]);
  condstr := StringReplace(condstr, 'lc', 'lc ', [rfReplaceAll]);
  condstr := StringReplace(condstr, 'in', 'in ', [rfReplaceAll]);
  condstr := StringReplace(condstr, 'qu', 'qu ', [rfReplaceAll]);
  condstr := StringReplace(condstr, 'ru', 'ru ', [rfReplaceAll]);
  condstr := StringReplace(condstr, 'gf', 'gf ', [rfReplaceAll]);
  condstr := StringReplace(condstr, 'gv', 'gv ', [rfReplaceAll]);
  condstr := StringReplace(condstr, ', ', ',', [rfReplaceAll]);
  condstr := StringReplace(condstr, '  ', ' ', [rfReplaceAll]);
  if condstr <> '' then
  begin
    // consoledebug('Condition STR: ' + condstr);
    for z := 1 to numconds do
    begin
      currentcommand := ExtractWord(z, condstr, [',']);
      command := ExtractWord(1, currentcommand, [' ']);

      if command = 'in' then
      begin
        num1 := ExtractWord(2, currentcommand, [' ']);
        num1 := StringReplace(num1, '-', '', []);
        if InventoryItems.IndexOf(num1) = -1 then
          InventoryItems.add(num1);
      end;

      if command = 'gf' then
      begin
        num1 := ExtractWord(2, currentcommand, [' ']);
        if STRGlobalFlags.IndexOf(num1) = -1 then
          STRGlobalFlags.add(num1);
      end;
      if command = 'qu' then
      begin
        num1 := ExtractWord(2, currentcommand, [' ']);
        if Quests.IndexOf(num1) = -1 then
          Quests.add(num1);
      end;
      if command = 'ru' then
      begin
        num1 := ExtractWord(2, currentcommand, [' ']);
        if Rumors.IndexOf(num1) = -1 then
          Rumors.add(num1);
      end;
      if command = 'gv' then
      begin
        num1 := ExtractWord(2, currentcommand, [' ']);
        if STRGlobalVars.IndexOf(num1) = -1 then
          STRGlobalVars.add(num1);
      end;

    end;
  end;

end;

procedure TForm13.Button3Click(Sender: TObject);
var
  z, i, t: Integer;
  id, numconds: Integer;
  currentcommand: String;
  dlgnum, params: Integer;
  wordwrapped, command, num1, num2: String;
  actionstr, condstr: String;
begin
  STRGlobalFlags := TStringList.Create;
  STRGlobalVars := TStringList.Create;
  Quests := TStringList.Create;
  InventoryItems := TStringList.Create;
  Rumors := TStringList.Create;

  for t := 0 to CurDLG.nodecount - 1 do
  begin

    ParseDialogString(CurDLG.nodes[t].nodeactions);

    for i := 0 to CurDLG.nodes[t].PlayerOptioncnt - 1 do
    begin
      ParseDialogString(CurDLG.nodes[t].playeroptions[i].conditions);
      ParseDialogString(CurDLG.nodes[t].playeroptions[i].actions);
    end;

  end;
  STRGlobalFlags.Sorted := True;
  STRGlobalVars.Sorted := True;
  Quests.Sorted := True;
  InventoryItems.Sorted := True;
  Rumors.Sorted := True;
  if pos(' --- Variable Information --- ', dlgheadertext.Text) <> 0 then
  begin
    dlgheadertext.SelStart := pos(' --- Variable Information --- ',
      dlgheadertext.Text) - 1;
    dlgheadertext.SelLength := length(dlgheadertext.Text);
    dlgheadertext.SelText := '';
    dlgheadertext.SetFocus;
  end;

  dlgheadertext.Lines.add(' --- Variable Information --- ');
  if STRGlobalVars.Count > 0 then
  begin
    dlgheadertext.Lines.add('');
    dlgheadertext.Lines.add('Global Variables');
    dlgheadertext.Lines.add('');
    for t := 0 to STRGlobalVars.Count - 1 do
    begin
      id := StrToInt(STRGlobalVars[t]);
      dlgheadertext.Lines.add(STRGlobalVars[t] + ' - ' + GetMesStringByID(id,
        ScriptGlobalVars));
    end;
  end;
  if STRGlobalFlags.Count > 0 then
  begin
    dlgheadertext.Lines.add('');
    dlgheadertext.Lines.add('Global Flags');
    dlgheadertext.Lines.add('');
    for t := 0 to STRGlobalFlags.Count - 1 do
    begin
      id := StrToInt(STRGlobalFlags[t]);
      dlgheadertext.Lines.add(STRGlobalFlags[t] + ' - ' + GetMesStringByID(id,
        ScriptGlobalFlags));
    end;
  end;

  if InventoryItems.Count > 0 then
  begin
    dlgheadertext.Lines.add('');
    dlgheadertext.Lines.add('Inventory Items');
    dlgheadertext.Lines.add('');
    for t := 0 to InventoryItems.Count - 1 do
    begin
      id := StrToInt(InventoryItems[t]);
      dlgheadertext.Lines.add(InventoryItems[t] + ' - ' + GetMesStringByID(id,
        GameOName));
    end;
  end;

  if Quests.Count > 0 then
  begin
    dlgheadertext.Lines.add('');
    dlgheadertext.Lines.add('Quests');
    dlgheadertext.Lines.add('');
    for t := 0 to Quests.Count - 1 do
    begin
      id := StrToInt(Quests[t]);
      wordwrapped := GetMesStringByID(id, GameQuestLog);
      wordwrapped := StringReplace(wordwrapped, '''', '\sq', [rfReplaceAll]);
      wordwrapped := StringReplace(wordwrapped, '"', '\dq', [rfReplaceAll]);

      wordwrapped := wraptext(wordwrapped, #13#10 + '       ',
        [' ', '-', ','], 63);

      wordwrapped := StringReplace(wordwrapped, '\sq', '''', [rfReplaceAll]);
      wordwrapped := StringReplace(wordwrapped, '\dq', '"', [rfReplaceAll]);

      dlgheadertext.Lines.add(Quests[t] + ' - ' + wordwrapped);
      if Quests.Count > 1 then
        dlgheadertext.Lines.add('');
    end;
  end;

  if Rumors.Count > 0 then
  begin
    dlgheadertext.Lines.add('');
    dlgheadertext.Lines.add('Rumors / Journal Entries');
    dlgheadertext.Lines.add('');
    for t := 0 to Rumors.Count - 1 do
    begin
      id := StrToInt(Rumors[t]);

      wordwrapped := GetMesStringByID(id * 20, GameRD_npc_m2m);
      wordwrapped := StringReplace(wordwrapped, '''', '\sq', [rfReplaceAll]);
      wordwrapped := StringReplace(wordwrapped, '"', '\dq', [rfReplaceAll]);

      wordwrapped := wraptext(wordwrapped, #13#10 + '       ',
        [' ', '-', ','], 63);

      wordwrapped := StringReplace(wordwrapped, '\sq', '''', [rfReplaceAll]);
      wordwrapped := StringReplace(wordwrapped, '\dq', '"', [rfReplaceAll]);

      dlgheadertext.Lines.add(Rumors[t] + ' - ' + wordwrapped);
      if Rumors.Count > 1 then
        dlgheadertext.Lines.add('');
    end;
  end;
  dlgheadertext.Lines.add('');

  if IncludeEntryPoints = True then
  begin
    dlgheadertext.Lines.add(' --- Dialogue entry points ---');

    for t := 0 to currentscript.linecount - 1 do
    begin

      if (currentscript.ScriptLines[t].thenPart.opcode = SA_DIALOG) or
        (currentscript.ScriptLines[t].elsePart.opcode = SA_DIALOG) or
        (currentscript.ScriptLines[t].thenPart.opcode = SA_FLOAT_LINE) or
        (currentscript.ScriptLines[t].elsePart.opcode = SA_FLOAT_LINE) then
      begin
        dlgheadertext.Lines.add('');
        dlgheadertext.Lines.add('<<SCRIPT>>: ' +
          decode_script_line(currentscript.ScriptLines[t]^));
      end;

      if currentscript.ScriptLines[t].elsePart.opcode = SA_FLOAT_LINE then
      begin

        if currentscript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
        begin
          dlgnum := currentscript.ScriptLines[t].elsePart.varvalue[0];
          dlgheadertext.Lines.add('Line ' + IntToStr(t) + ' - float message ' +
            IntToStr(dlgnum));
        end;
      end;

      if currentscript.ScriptLines[t].thenPart.opcode = SA_FLOAT_LINE then
      begin
        if currentscript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
        begin
          dlgnum := currentscript.ScriptLines[t].thenPart.varvalue[0];
          dlgheadertext.Lines.add('Line ' + IntToStr(t) + ' - float message ' +
            IntToStr(dlgnum));
        end;
      end;

      if currentscript.ScriptLines[t].elsePart.opcode = SA_DIALOG then
      begin

        if currentscript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
        begin
          dlgnum := currentscript.ScriptLines[t].elsePart.varvalue[0];

          dlgheadertext.Lines.add('Line ' + IntToStr(t) + ' - dlg line ' +
            IntToStr(dlgnum));
        end;
      end;

      if currentscript.ScriptLines[t].thenPart.opcode = SA_DIALOG then
      begin
        if currentscript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
        begin
          dlgnum := currentscript.ScriptLines[t].thenPart.varvalue[0];
          dlgheadertext.Lines.add('Line ' + IntToStr(t) + ' - dlg line ' +
            IntToStr(dlgnum));
        end;
      end;

    end;
  end;

  dlgheadertext.Lines.add('Last updated: ' + datetimetostr(now));

end;

end.
