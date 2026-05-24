unit DialogueHeaderEditor;

interface

uses
  Windows, Messages, strutils_, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ModuleLoader, ScriptedConfig, MesFileIO, arcanumscrlib, dlgfileio, dlgparser, Dialogs, StdCtrls;

type
  TForm13 = class(TForm)
    dlgheadertext: TMemo;
    Label1:        TLabel;
    Button1:       TButton;
    Button2:       TButton;
    Button3:       TButton;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13:         TForm13;
  STRGlobalFlags: TStringList;
  STRGlobalVars:  TStringList;
  InventoryItems: TStringList;
  Quests:         TStringList;
  Rumors:         TStringList;

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
  condstr  := str;
  numconds := WordCount(condstr, [',']);
  condstr  := StringReplace(condstr, 'lf', 'lf ', [rfReplaceAll]);
  condstr  := StringReplace(condstr, 'lc', 'lc ', [rfReplaceAll]);
  condstr  := StringReplace(condstr, 'in', 'in ', [rfReplaceAll]);
  condstr  := StringReplace(condstr, 'qu', 'qu ', [rfReplaceAll]);
  condstr  := StringReplace(condstr, 'ru', 'ru ', [rfReplaceAll]);
  condstr  := StringReplace(condstr, 'gf', 'gf ', [rfReplaceAll]);
  condstr  := StringReplace(condstr, 'gv', 'gv ', [rfReplaceAll]);
  condstr  := StringReplace(condstr, ', ', ',', [rfReplaceAll]);
  condstr  := StringReplace(condstr, '  ', ' ', [rfReplaceAll]);
  if condstr <> '' then
  begin
    //  consoledebug('Condition STR: ' + condstr);
    for z := 1 to numconds do
    begin
      currentcommand := ExtractWord(z, condstr, [',']);
      command := Extractword(1, currentcommand, [' ']);

      if command = 'in' then
      begin
        num1 := Extractword(2, currentcommand, [' ']);
        num1 := StringReplace(num1, '-', '', []);
        if InventoryItems.IndexOf(num1) = -1 then
          InventoryItems.add(num1);
      end;

      if command = 'gf' then
      begin
        num1 := Extractword(2, currentcommand, [' ']);
        if STRGlobalFlags.IndexOf(num1) = -1 then
          STRglobalflags.add(num1);
      end;
      if command = 'qu' then
      begin
        num1 := Extractword(2, currentcommand, [' ']);
        if quests.IndexOf(num1) = -1 then
          quests.add(num1);
      end;
      if command = 'ru' then
      begin
        num1 := Extractword(2, currentcommand, [' ']);
        if rumors.IndexOf(num1) = -1 then
          Rumors.add(num1);
      end;
      if command = 'gv' then
      begin
        num1 := Extractword(2, currentcommand, [' ']);
        if STRGlobalVars.IndexOf(num1) = -1 then
          STRglobalvars.add(num1);
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
  STRGlobalflags := TStringList.Create;
  STRGlobalvars := TStringList.Create;
  Quests := TStringList.Create;
  InventoryItems := TStringList.Create;
  Rumors := TStringList.Create;



  for t := 0 to CurDLG.nodecount - 1 do
  begin

    ParseDialogString(curdlg.nodes[t].nodeactions);

    for I := 0 to curdlg.nodes[t].PlayerOptioncnt - 1 do
    begin
      ParseDialogString(curdlg.nodes[t].playeroptions[i].conditions);
      ParseDialogString(curdlg.nodes[t].playeroptions[i].actions);
    end;

  end;
  strglobalflags.Sorted := True;
  strglobalvars.sorted := True;
  quests.Sorted := True;
  InventoryItems.Sorted := True;
  Rumors.Sorted := True;
  if pos(' --- Variable Information --- ', dlgheadertext.Text) <> 0 then
  begin
    dlgheadertext.SelStart := pos(' --- Variable Information --- ', dlgheadertext.Text) - 1;
    dlgheadertext.SelLength := length(dlgheadertext.Text);
    dlgheadertext.SelText := '';
    dlgheadertext.SetFocus;
  end;

  dlgheadertext.Lines.add(' --- Variable Information --- ');
  if strglobalvars.Count > 0 then
  begin
    dlgheadertext.Lines.add('');
    dlgheadertext.Lines.add('Global Variables');
    dlgheadertext.Lines.add('');
    for t := 0 to STRglobalvars.Count - 1 do
    begin
      id := StrToInt(STRglobalvars[t]);
      dlgheadertext.Lines.add(strglobalvars[t] + ' - ' + GetMesStringByID(id, ScriptGlobalVars));
    end;
  end;
  if strglobalflags.Count > 0 then
  begin
    dlgheadertext.Lines.add('');
    dlgheadertext.Lines.add('Global Flags');
    dlgheadertext.Lines.add('');
    for t := 0 to STRglobalflags.Count - 1 do
    begin
      id := StrToInt(STRglobalflags[t]);
      dlgheadertext.Lines.add(strglobalflags[t] + ' - ' + GetMesStringByID(id, ScriptGlobalFlags));
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
      dlgheadertext.Lines.add(InventoryItems[t] + ' - ' + GetMesStringByID(id, GameOName));
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

      wordwrapped := wraptext(wordwrapped, #13#10 + '       ', [' ', '-', ','], 63);

      wordwrapped := StringReplace(wordwrapped, '\sq', '''', [rfReplaceAll]);
      wordwrapped := StringReplace(wordwrapped, '\dq', '"', [rfReplaceAll]);

      dlgheadertext.Lines.add(Quests[t] + ' - ' + wordwrapped);
      if quests.Count > 1 then
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

      wordwrapped := wraptext(wordwrapped, #13#10 + '       ', [' ', '-', ','], 63);

      wordwrapped := StringReplace(wordwrapped, '\sq', '''', [rfReplaceAll]);
      wordwrapped := StringReplace(wordwrapped, '\dq', '"', [rfReplaceAll]);

      dlgheadertext.Lines.add(Rumors[t] + ' - ' + wordwrapped);
      if rumors.Count > 1 then
        dlgheadertext.Lines.add('');
    end;
  end;
  dlgheadertext.Lines.add('');

  if IncludeEntryPoints = True then
  begin
    dlgheadertext.Lines.add(' --- Dialogue entry points ---');



    for t := 0 to currentscript.linecount - 1 do
    begin

      if (CurrentScript.ScriptLines[t].thenPart.opcode = SA_DIALOG) or (CurrentScript.ScriptLines[t].elsePart.opcode = SA_DIALOG) or
        (CurrentScript.ScriptLines[t].thenPart.opcode = SA_FLOAT_LINE) or (CurrentScript.ScriptLines[t].elsePart.opcode = SA_FLOAT_LINE) then
      begin
        dlgheadertext.Lines.add('');
        dlgheadertext.Lines.add('<<SCRIPT>>: ' + decode_script_line(CurrentScript.ScriptLines[t]^));
      end;

      if CurrentScript.ScriptLines[t].elsePart.opcode = SA_FLOAT_LINE then
      begin

        if CurrentScript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
        begin
          dlgnum := currentscript.scriptlines[t].elsePart.varvalue[0];
          dlgheadertext.Lines.add('Line ' + IntToStr(t) + ' - float message ' + IntToStr(dlgnum));
        end;
      end;

      if CurrentScript.ScriptLines[t].thenPart.opcode = SA_FLOAT_LINE then
      begin
        if CurrentScript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
        begin
          dlgnum := currentscript.scriptlines[t].thenPart.varvalue[0];
          dlgheadertext.Lines.add('Line ' + IntToStr(t) + ' - float message ' + IntToStr(dlgnum));
        end;
      end;

      if CurrentScript.ScriptLines[t].elsePart.opcode = SA_DIALOG then
      begin

        if CurrentScript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
        begin
          dlgnum := currentscript.scriptlines[t].elsePart.varvalue[0];

          dlgheadertext.Lines.add('Line ' + IntToStr(t) + ' - dlg line ' + IntToStr(dlgnum));
        end;
      end;

      if CurrentScript.ScriptLines[t].thenPart.opcode = SA_DIALOG then
      begin
        if CurrentScript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
        begin
          dlgnum := currentscript.scriptlines[t].thenPart.varvalue[0];
          dlgheadertext.Lines.add('Line ' + IntToStr(t) + ' - dlg line ' + IntToStr(dlgnum));
        end;
      end;

    end;
  end;

  dlgheadertext.Lines.add('Last updated: ' + datetimetostr(now));

end;

end.
