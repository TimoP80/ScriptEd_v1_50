unit PlayerOptionEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 ScriptEdConfig, DLGParser, DLGFileIO, OllamaGenericDialog, Dialogs, StdCtrls, Mask, ArcanumSCRLib, JvExMask,
  JvSpin, JvPageList, JvExControls,
  JvExStdCtrls, JvHtControls, ActionsEditor;

type
  TForm12 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    conditionsline: TEdit;
    Button1: TButton;
    Label4: TLabel;
    iqdata1: TJvSpinEdit;
    Label5: TLabel;
    actionsline: TEdit;
    Button2: TButton;
    Label6: TLabel;
    LinkPages: TJvPageList;
    CallScriptPage: TJvStandardPage;
    LinkToNodePage: TJvStandardPage;
    nodelist: TListBOx;
    Label7: TLabel;
    Button3: TButton;
    Button4: TButton;
    ComboBox2: TComboBox;
    ExitDLGNullPage: TJvStandardPage;
    Label8: TLabel;
    Label9: TLabel;
    scriptlinelist: TListBOx;
    Label10: TLabel;
    JvHTListBox1: TJvHTListBox;
    Label11: TLabel;
    finaldata: TLabel;
    Label12: TLabel;
    nodetext: TLabel;
    playertextline: TMemo;
    Button5: TButton;
    malerestr: TCheckBox;
    femalerestr: TCheckBox;
    normalint: TRadioButton;
    dumbint: TRadioButton;
    otherint: TRadioButton;
    Label13: TLabel;
    extcomments: TMemo;
    LinkToNewNodePage: TJvStandardPage;
    Label14: TLabel;
    Label15: TLabel;
    newnodename: TEdit;
    Label16: TLabel;
    newnodetext: TMemo;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    procedure ComboBox2Click(Sender: TObject);
    procedure scriptlinelistClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nodelistClick(Sender: TObject);
    procedure playertextlineKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure conditionslineKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actionslineKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure iqdata1Click(Sender: TObject);
    procedure malerestrClick(Sender: TObject);
    procedure femalerestrClick(Sender: TObject);
    procedure otherintClick(Sender: TObject);
    procedure dumbintClick(Sender: TObject);
    procedure normalintClick(Sender: TObject);
    procedure JvHTListBox1Click(Sender: TObject);
    procedure extcommentsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ConditionsHelpBtnClick(Sender: TObject);
    procedure ActionsHelpBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;
  playertextdata: String;
  conditiondata: String;
  actiondata: String;
  iqdata: Integer;
  commentdata: String;
  genderdata: Integer;
  linkdata: Integer;

procedure RefreshData;
procedure PlaceDataOnForm;
procedure SetData(conds, actions, playertext: String; iqtest, gender: Integer;
  link: Integer; comments: String);
procedure GetData(var conds, actions, playertext: String;
  var iqtest, gender: Integer; var link: Integer; var comments: String);
procedure ClearForm;
procedure ClearData;

implementation

{$R *.dfm}

procedure SetData(conds, actions, playertext: String; iqtest, gender: Integer;
  link: Integer; comments: String);
begin
  conditiondata := conds;
  actiondata := actions;
  playertextdata := playertext;
  iqdata := iqtest;
  genderdata := gender;
  linkdata := link;
  commentdata := comments;
end;

procedure ClearData;
begin
  conditiondata := '';
  actiondata := '';
  playertextdata := '';
  iqdata := 0;
  genderdata := NO_GENDER;
  linkdata := 0;
  commentdata := '';
end;

procedure GetData(var conds, actions, playertext: String;
  var iqtest, gender: Integer; var link: Integer; var comments: String);
begin

  if (Form12.femalerestr.Checked = True) and (Form12.malerestr.Checked = False)
  then
    genderdata := GENDER_FEMALE
  else if (Form12.femalerestr.Checked = False) and
    (Form12.malerestr.Checked = True) then
    genderdata := GENDER_MALE
  else if (Form12.femalerestr.Checked = False) and
    (Form12.malerestr.Checked = False) then
    genderdata := NO_GENDER;

  if Form12.normalint.Checked = True then
    iqdata := 5
  else if Form12.dumbint.Checked = True then
    iqdata := -4
  else if Form12.otherint.Checked = True then
    iqdata := Form12.iqdata1.AsInteger;
  conds := conditiondata;
  actions := actiondata;
  playertext := playertextdata;
  iqtest := iqdata;
  gender := genderdata;
  link := linkdata;
  comments := commentdata;
  // ShowMessage('iq data = ' + IntToStr(iqdata));
end;

procedure ClearForm;
begin
  Form12.conditionsline.Text := '';
  Form12.actionsline.Text := '';
  Form12.playertextline.Text := '';
  Form12.iqdata1.Value := 1;
  Form12.femalerestr.Checked := False;
  Form12.malerestr.Checked := False;
  Form12.extcomments.Clear;
  Form12.ComboBox2.ItemIndex := 0;
  Form12.LinkPages.ActivePage := Form12.ExitDLGNullPage;
end;

procedure PlaceDataOnForm;
var
  theint: Integer;
  thestr: String;
begin
  Form12.conditionsline.Text := conditiondata;
  Form12.actionsline.Text := actiondata;
  Form12.playertextline.Text := playertextdata;
  if iqdata = 5 then
  begin
    Form12.iqdata1.Enabled := False;
    Form12.normalint.Checked := True;
  end
  else if iqdata = -4 then
  begin
    Form12.iqdata1.Enabled := False;
    Form12.dumbint.Checked := True;
  end
  else
  begin
    Form12.iqdata1.Enabled := True;
    Form12.otherint.Checked := True;
  end;

  Form12.iqdata1.Value := iqdata;

  case genderdata of
    GENDER_FEMALE:
      begin
        Form12.femalerestr.Checked := True;
        Form12.malerestr.Checked := False;
      end;
    GENDER_MALE:
      begin
        Form12.femalerestr.Checked := False;
        Form12.malerestr.Checked := True;
      end;
    NO_GENDER:
      begin
        Form12.femalerestr.Checked := False;
        Form12.malerestr.Checked := False;
      end;

  end;
  if linkdata < 0 then
  begin
    Form12.ComboBox2.ItemIndex := 1;
    Form12.LinkPages.ActivePage := Form12.CallScriptPage;
    thestr := IntToStr(linkdata);
    thestr := stringreplace(thestr, '-', '', [rfReplaceAll]);
    theint := StrToInt(thestr);
    Form12.scriptlinelist.ItemIndex := theint;
    Form12.JvHTListBox1.ItemIndex := theint;
    Form12.scriptlinelistClick(nil);
  end
  else if linkdata > 0 then
  begin
    Form12.ComboBox2.ItemIndex := 2;
    Form12.LinkPages.ActivePage := Form12.LinkToNodePage;
    Form12.nodelist.ItemIndex := GetNodeIndexWithDLGLine(linkdata);
    Form12.nodelistClick(nil);
  end
  else if linkdata = 0 then
  begin
    Form12.ComboBox2.ItemIndex := 0;
    Form12.LinkPages.ActivePage := Form12.ExitDLGNullPage;
  end;
  Form12.extcomments.Text := commentdata;
end;

procedure RefreshData;
var
  t: Integer;
begin
  Form12.nodelist.Items.Clear;
  for t := 0 to curdlg.nodecount - 1 do
  begin
    Form12.nodelist.Items.add(curdlg.nodes[t].nodename);
  end;
  Form12.scriptlinelist.Clear;
  for t := 0 to CurrentScript.LineCount - 1 do
  begin
    Form12.scriptlinelist.Items.add('Line ' + IntToStr(t));
  end;

end;

procedure TForm12.Button6Click(Sender: TObject);
begin
AddNode(newnodename.text);
CurDLG.nodes[curdlg.nodecount-1].npctextmale := newnodetext.Text;
CurDLG.nodes[curdlg.nodecount-1].npctextfemale := newnodetext.Text;
CurDLG.nodes[CurDLG.nodecount-1].start_index := CurDLG.nodes[CurDLG.nodecount-2].start_index + LineNumberStep ;
linkdata := CurDLG.nodes[CurDLG.nodecount-1].start_index;
 Form12.LinkPages.ActivePage := Form12.LinkToNodePage;
    Form12.nodelist.ItemIndex := GetNodeIndexWithDLGLine(linkdata);
    Form12.nodelistClick(nil);
RefreshData;
  Form12.ComboBox2.ItemIndex := 2;
    Form12.LinkPages.ActivePage := Form12.LinkToNodePage;
    Form12.nodelist.ItemIndex := GetNodeIndexWithDLGLine(linkdata);
    Form12.nodelistClick(nil);
end;

procedure TForm12.Button7Click(Sender: TObject);
var i: integer;
var nodeindex: integer;
begin
nodeindex:=0;
for i := 0 to curdlg.nodecount-1 do
  begin
   inc(nodeindex);
  end;

newnodename.Text := 'Node'+format('%0.3d',[nodeindex+1]);
end;

procedure TForm12.Button8Click(Sender: TObject);
begin
form30.ShowModal;

if form30.ModalResult=mrOk then
begin
  playertextline.Text := form30.ollamaresult.Text;
  playertextdata := playertextline.Text;
end;
end;

procedure TForm12.ComboBox2Click(Sender: TObject);
begin
  case ComboBox2.ItemIndex of
    0:
      begin
        linkdata := 0;
        LinkPages.ActivePage := ExitDLGNullPage;
        finaldata.Caption := IntToStr(linkdata);
      end;

    1:
      LinkPages.ActivePage := CallScriptPage;
    2:
      LinkPages.ActivePage := LinkToNodePage;
    3:
     linkpages.ActivePage := LinkToNewNodePage;
  end;

end;

procedure TForm12.scriptlinelistClick(Sender: TObject);
var
  str: String;
  s, id: Integer;
begin
  id := scriptlinelist.ItemIndex;
  if id <> -1 then
  begin
    JvHTListBox1.Clear;
    for s := 0 to CurrentScript.LineCount - 1 do
    begin
      str := IntToStr(s) + '. ' + decode_script_line
        (CurrentScript.scriptlines[s]^);
      str := stringreplace(str, #13#10, '<br>', [rfReplaceAll]);
      if s = id then
        str := '<b>' + str + '</b>';
      JvHTListBox1.Items.add(str);

    end;
    JvHTListBox1.ItemIndex := id;
    linkdata := StrToInt('-' + IntToStr(id));
    finaldata.Caption := IntToStr(linkdata);
    // decodedline.Caption := inttostr(id)+'. '+decode_script_line(currentscript.scriptlines[id]^);
  end;

end;

procedure TForm12.FormShow(Sender: TObject);
begin
  ComboBox2Click(nil);
end;

procedure TForm12.nodelistClick(Sender: TObject);
var
  i: Integer;
  Name: String;
  ind: Integer;
begin

  i := nodelist.ItemIndex;
  if i <> -1 then
  begin
    Name := nodelist.Items[nodelist.ItemIndex];
    ind := GetNodeIndex(Name);
    if ind <> -1 then
    begin
      nodetext.Caption := curdlg.nodes[ind].npctextmale;
      linkdata := curdlg.nodes[ind].start_index;
      finaldata.Caption := IntToStr(linkdata);
    end;
  end;

end;

procedure TForm12.playertextlineKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  playertextdata := playertextline.Text;
end;

procedure TForm12.conditionslineKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  conditiondata := conditionsline.Text;
end;

procedure TForm12.actionslineKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  actiondata := actionsline.Text;
end;

procedure TForm12.iqdata1Click(Sender: TObject);
begin
  iqdata := iqdata1.AsInteger;
end;

procedure TForm12.malerestrClick(Sender: TObject);
begin
  if femalerestr.Checked = True then
    femalerestr.Checked := False;

end;

procedure TForm12.femalerestrClick(Sender: TObject);
begin
  if malerestr.Checked = True then
    malerestr.Checked := False;

end;

procedure TForm12.otherintClick(Sender: TObject);
begin
  iqdata1.Enabled := True;
end;

procedure TForm12.dumbintClick(Sender: TObject);
begin
  iqdata1.Enabled := False;

end;

procedure TForm12.normalintClick(Sender: TObject);
begin
  iqdata1.Enabled := False;
end;

procedure TForm12.JvHTListBox1Click(Sender: TObject);
begin
  scriptlinelist.ItemIndex := JvHTListBox1.ItemIndex;
  scriptlinelistClick(nil);
end;

procedure TForm12.Button1Click(Sender: TObject);
var
  S: string;
begin
  // Open the dialogue code editor in Test mode for the {Test} field
  // (rendered as the "Conditions" entry on PC dialog lines).
  S := conditionsline.Text;
  EditDialogueField(S, demTest);
  conditionsline.Text := S;
  conditiondata := S;
end;

procedure TForm12.Button2Click(Sender: TObject);
var
  S: string;
begin
  // Open the dialogue code editor in Result mode for the {Result}
  // field (rendered as the "Actions" entry on PC and NPC lines).
  S := actionsline.Text;
  EditDialogueField(S, demResult);
  actionsline.Text := S;
  actiondata := S;
end;

procedure TForm12.ConditionsHelpBtnClick(Sender: TObject);
const
  HelpText =
    'Syntax for the {Test} field (Conditions)' + #13#10 +
    '=========================================' + #13#10 + #13#10 +
    'A blank field means the option is always shown.' + #13#10 +
    'Otherwise the field is a list of one or more codes, each' + #13#10 +
    'followed by 1 or 2 numbers, separated by commas. All codes' + #13#10 +
    'must pass (their restrictions are AND-ed together) for the' + #13#10 +
    'option to be visible.' + #13#10 +
    #13#10 +
    'Format:' + #13#10 +
    '  code              - no numbers' + #13#10 +
    '  code num1         - one number' + #13#10 +
    '  code num1 num2    - two numbers' + #13#10 +
    #13#10 +
    'Examples:' + #13#10 +
    '  qu 1001 2              (quest 1001 must be active)' + #13#10 +
    '  ps 5, gf 2000 1        (persuasion >= 5 AND flag 2000 set)' + #13#10 +
    #13#10 +
    'Common codes:' + #13#10 +
    '  ps  persuasion  ch  charisma  pe  perception' + #13#10 +
    '  al  alignment   le  PC level  in  item held' + #13#10 +
    '  ni  item not held  qu  quest state  ra  race' + #13#10 +
    '  ru  rumor in log  gf/gv  global flag/variable' + #13#10 +
    '  lf/lc  local flag/counter  pf/pv  PC flag/variable' + #13#10 +
    #13#10 +
    'Click the "Edit" button to open the full reference list' + #13#10 +
    'and insert codes by picking them from a list.';
begin
  ShowMessage(HelpText);
end;

procedure TForm12.ActionsHelpBtnClick(Sender: TObject);
const
  HelpText =
    'Syntax for the {Result} field (Actions)' + #13#10 +
    '=========================================' + #13#10 + #13#10 +
    'A blank field means no side effects.' + #13#10 +
    'Otherwise the field is a list of one or more codes, each' + #13#10 +
    'followed by 1 or 2 numbers, separated by commas. All codes' + #13#10 +
    'are triggered in order when the line is spoken (or, for a' + #13#10 +
    'PC line, when the option is picked).' + #13#10 +
    #13#10 +
    'Format:' + #13#10 +
    '  code              - no numbers' + #13#10 +
    '  code num1         - one number' + #13#10 +
    '  code num1 num2    - two numbers' + #13#10 +
    #13#10 +
    'Examples:' + #13#10 +
    '  $$ 50                  (give PC 50 gold)' + #13#10 +
    '  qu 1001 4, rp 1003     (complete quest, gain reputation)' + #13#10 +
    '  jo 0 9999, tr 7 2      (NPC joins party, train skill 7 to 2)' + #13#10 +
    #13#10 +
    'Common codes:' + #13#10 +
    '  $$  gold     al  alignment  qu  quest state  ru  rumor' + #13#10 +
    '  gf/gv  global flag/variable  pf/pv  PC flag/variable' + #13#10 +
    '  lf/lc  local flag/counter  in  transfer item' + #13#10 +
    '  jo  NPC joins  uw  unwait  wa  wait  nk  kill NPC' + #13#10 +
    '  mm  mark map   xp  XP      fp  fate point  re  reaction' + #13#10 +
    #13#10 +
    'Click the "Edit" button to open the full reference list' + #13#10 +
    'and insert codes by picking them from a list.';
begin
  ShowMessage(HelpText);
end;

procedure TForm12.extcommentsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  commentdata := extcomments.Text;
end;

end.
