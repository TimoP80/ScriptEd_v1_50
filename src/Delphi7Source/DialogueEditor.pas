unit DialogueEditor;

interface

uses
  Windows, Messages, dlgfileio, dlgparser, arcanumscrlib, SysUtils,
  Variants, Classes, Graphics, Controls, Forms,
  pluginapi, ScriptEdCOnfig, Moduleloader, Dialogs, StdCtrls, ComCtrls,
  JvDotNetControls, JvExComCtrls, JvComCtrls, JvJanTreeView, Menus,
  JvPageList, JvExControls;

type
  TForm3 = class(TForm)
    Button1:      TButton;
    TreeView1:    TJvJanTreeView;
    Label3:       TLabel;
    Button2:      TButton;
    Button3:      TButton;
    Label7:       TLabel;
    nodename:     TEdit;
    Button4:      TButton;
    Button5:      TButton;
    Label8:       TLabel;
    linenumstart: TEdit;
    Button6:      TButton;
    Button11:     TButton;
    fltflag:      TCheckBox;
    fltgrpstart:  TCheckBox;
    JvPageList1:  TJvPageList;
    PopupMenu1:   TPopupMenu;
    Editplayeroptionregularmode1: TMenuItem;
    Editallplayeroptionslistmode1: TMenuItem;
    DialogueEditorPage: TJvStandardPage;
    Label1:       TLabel;
    Label2:       TLabel;
    Label4:       TLabel;
    Label5:       TLabel;
    Label6:       TLabel;
    Label9:       TLabel;
    npctextmale:  TMemo;
    npctextfemale: TMemo;
    nodeactions:  TEdit;
    nogenderspecific: TCheckBox;
    useVO:        TCheckBox;
    vofield:      TEdit;
    ListView1:    TListView;
    Button7:      TButton;
    insbutton:    TButton;
    delbutton:    TButton;
    Button10:     TButton;
    nodedesc:     TMemo;
    mvdownbtn:    TButton;
    mvupbtn:      TButton;
    Button8:      TButton;
    clonebutton:  TButton;
    copybtn:      TButton;
    pastebtn:     TButton;
    SyncNPCLines: TCheckBox;
    FloatMessageEditorPage: TJvStandardPage;
    GenSpeech:    TButton;
    procedure TreeView1CustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: boolean);
    procedure TreeView1Click(Sender: TObject);
    procedure npctextmaleKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure nogenderspecificClick(Sender: TObject);
    procedure npctextfemaleKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure nodeactionsKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure vofieldKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure nodenameKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure TreeView1KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure Button6Click(Sender: TObject);
    procedure linenumstartKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure Button7Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure delbuttonClick(Sender: TObject);
    procedure insbuttonClick(Sender: TObject);
    procedure nodedescKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure ListView1Click(Sender: TObject);
    procedure mvdownbtnClick(Sender: TObject);
    procedure mvupbtnClick(Sender: TObject);
    procedure useVOClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure clonebuttonClick(Sender: TObject);
    procedure copybtnClick(Sender: TObject);
    procedure pastebtnClick(Sender: TObject);
    procedure fltflagMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure fltgrpstartMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ListView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure Editplayeroptionregularmode1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure GenSpeechClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  pdialoguenode = ^dialoguenode;

var
  Form3:        TForm3;
  previousselection: integer;
  playeroptionbuffer: array of PlayerOption;
  playeroptionbuffersize: integer;
  selnode:      pdialoguenode;
  nodeselected: integer;

const
  REPLACE_DIRECTION_MALE_TO_FEMALE = 1;
  REPLACE_DIRECTION_FEMALE_TO_MALE = 2;


procedure UpdateDialogue;
procedure DialogueEditorClearForm;
function ReplaceGenderStrings(src: string; direction: integer): string;

implementation

uses Math, ScriptEdWindow, RemapLineNumbers, PlayerOptionEditor, DialogueHeaderEditor,
  SpeechGenInterface;

{$R *.dfm}

function ReplaceGenderStrings(src: string; direction: integer): string;
var
  t: integer;
  maleword: string;
  femaleword: string;
begin
  Result := src;
  for t := 0 to genderstringcnt - 1 do
  begin
    maleword := Genderstrings[t].male;
    femaleword := Genderstrings[t].female;
    case direction of
      REPLACE_DIRECTION_MALE_TO_FEMALE:
        Result := StringReplace(Result, maleword, femaleword, [rfReplaceAll]);
      REPLACE_DIRECTION_FEMALE_TO_MALE:
        Result := StringReplace(Result, femaleword, maleword, [rfReplaceAll]);

    end;

  end;

end;

procedure UpdateDialogue;
var
  x, t: integer;
  thetreenode: TTreeNode;
begin
  form3.treeview1.Items.Clear;
  for t := 0 to CurDLG.nodecount - 1 do
  begin
    //    consoledebug('Nodes: ' + curdlg.nodes[t].nodename);
    if curdlg.nodes[t] = nil then
      MessageDlg('Encountered a null node at position ' + IntToStr(t) +
        ' - This is not supposed to happen', mtWarning, [mbOK], 0);

    thetreenode := Form3.TreeView1.Items.Add(nil,
      format('%s - line %d, %d options', [curdlg.nodes[t].nodename,
      curdlg.nodes[t].start_index, curdlg.nodes[t].PlayerOptioncnt]));
  end;

end;


procedure TForm3.TreeView1CustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: boolean);
begin
  if Node.Level = 0 then
  begin
    TreeView1.Canvas.Font.Style := [fsbold];
    if curdlg.nodes[node.index].npctextmale = '' then
    begin
      TreeView1.Canvas.Font.Color := clGray;
    end else
    if curdlg.nodes[node.index].isfloatmessage = True then
      TreeView1.Canvas.Font.Color := clGreen
    else

      TreeView1.Canvas.Font.Color := clNavy;
  end else if Node.Level = 1 then
    TreeView1.Canvas.Font.Color := clGreen;

end;

procedure UpdatePlayerOptions;
var
  item: TListItem;
  t: integer;
begin
  form3.listview1.Clear;
  for t := 0 to curdlg.nodes[nodeselected].PlayerOptioncnt - 1 do
  begin
    item := form3.ListView1.Items.add;
    item.Caption := IntToStr(t + 1);
    item.subitems.add(curdlg.nodes[nodeselected].playeroptions[t].Text);
    if curdlg.nodes[nodeselected].playeroptions[t].gendertest = GENDER_FEMALE then
      item.subitems.add('female')
    else
    if curdlg.nodes[nodeselected].playeroptions[t].gendertest = GENDER_MALE then
      item.subitems.add('male')
    else
      item.subitems.add('both');
    item.subitems.add(curdlg.nodes[nodeselected].playeroptions[t].conditions);

    item.subitems.add(IntToStr(curdlg.nodes[nodeselected].playeroptions[t].iqtest));

    item.subitems.add(IntToStr(curdlg.nodes[nodeselected].playeroptions[t].linktonode));
    item.subitems.add(curdlg.nodes[nodeselected].playeroptions[t].actions);
    item.subitems.add(curdlg.nodes[nodeselected].playeroptions[t].playeroptioncomments);

  end;

end;

procedure DialogueEditorClearForm;
var
  t: integer;
begin
  for t := 0 to form3.ComponentCount - 1 do
  begin
    if form3.Components[t] is TMemo then
      TMemo(form3.Components[t]).Text := '';

    if form3.Components[t] is TEdit then
      TEdit(form3.Components[t]).Text := '';

    if form3.Components[t] is TCheckbox then
      TCheckBox(form3.Components[t]).Checked := False;

    if form3.Components[t] is TListView then
      TListView(form3.Components[t]).Clear;

  end;

end;

procedure TForm3.TreeView1Click(Sender: TObject);
begin

  if treeview1.selected <> nil then
  begin
    // A node is selected
    if treeview1.selected.level = 0 then
    begin

      nodeselected  := treeview1.selected.index;
      fltflag.Checked := curdlg.nodes[nodeselected].isfloatmessage;
      fltgrpstart.Checked := curdlg.nodes[nodeselected].floatgroupstartmarker;
      linenumstart.Text := IntToStr(CurDLG.nodes[nodeselected].start_index);
      nodedesc.Text := curdlg.nodes[nodeselected].nodedesc;
      nodename.Text := curdlg.nodes[nodeselected].nodename;
      npctextmale.Text := curdlg.nodes[nodeselected].npctextmale;
      npctextfemale.Text := curdlg.nodes[nodeselected].npctextfemale;
      if curdlg.nodes[nodeselected].npctextmale <>
        curdlg.nodes[nodeselected].npctextfemale then
        nogenderspecific.Checked := False
      else
        nogenderspecific.Checked := True;
      nodeactions.Text := curdlg.nodes[nodeselected].nodeactions;
      vofield.Text := curdlg.nodes[nodeselected].voicefield;
      if vofield.Text <> '' then
        useVO.Checked := True
      else
        useVO.Checked := False;
      UpdatePlayerOptions;
    end;

  end else
  begin
    // Nothing is selected

    DialogueEditorClearForm;
  end;

end;

procedure TForm3.npctextmaleKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  curdlg.nodes[nodeselected].npctextmale := npctextmale.Text;
  // Synchronized update of the female text
  if nogenderspecific.Checked = True then
  begin
    curdlg.nodes[nodeselected].npctextfemale := curdlg.nodes[nodeselected].npctextmale;
    npctextfemale.Text := npctextmale.Text;
  end;


  if (nogenderspecific.Checked = False) and (AutoReplaceGenderStrings = True) and
    (SyncNPCLines.Checked = True) then
  begin
    curdlg.nodes[nodeselected].npctextfemale := curdlg.nodes[nodeselected].npctextmale;
    curdlg.nodes[nodeselected].npctextfemale :=
      ReplaceGenderStrings(curdlg.nodes[nodeselected].npctextfemale,
      REPLACE_DIRECTION_MALE_TO_FEMALE);
    npctextfemale.Text := curdlg.nodes[nodeselected].npctextfemale;
  end;

end;

procedure TForm3.nogenderspecificClick(Sender: TObject);
begin
  npctextfemale.Enabled := (nogenderspecific.Checked = False);
  if nogenderspecific.Checked = True then
  begin
    if AutoUpdateFemaleLine = True then
    begin
      npctextfemale.Text := npctextmale.Text;
      curdlg.nodes[nodeselected].npctextfemale := curdlg.nodes[nodeselected].npctextmale;
    end;
    SyncNPCLines.Enabled := False;
  end;
  if nogenderspecific.Checked = False then
  begin
    SyncNPCLines.Enabled := True;
  end;

end;

procedure TForm3.npctextfemaleKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  curdlg.nodes[nodeselected].npctextfemale := npctextfemale.Text;

  if (nogenderspecific.Checked = False) and (AutoReplaceGenderStrings = True) and
    (SyncNPCLines.Checked = True) then
  begin
    curdlg.nodes[nodeselected].npctextmale := curdlg.nodes[nodeselected].npctextfemale;
    curdlg.nodes[nodeselected].npctextmale :=
      ReplaceGenderStrings(curdlg.nodes[nodeselected].npctextmale,
      REPLACE_DIRECTION_FEMALE_TO_MALE);
    npctextmale.Text := curdlg.nodes[nodeselected].npctextmale;
  end;

end;

procedure TForm3.FormCreate(Sender: TObject);
var
  u: integer;
begin

  previousselection := -1;
end;

procedure TForm3.nodeactionsKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  curdlg.nodes[nodeselected].nodeactions := nodeactions.Text;
end;

procedure TForm3.vofieldKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  curdlg.nodes[nodeselected].voicefield := vofield.Text;
end;

procedure TForm3.Button5Click(Sender: TObject);
var
  newname: string;
begin
  if form3.TreeView1.selected <> nil then
  begin
    newname := InputBox('Name for new node', 'Enter a name for the inserted node', '');
    InsertNode(newname, Form3.treeview1.Selected.index);
    UpdateDialogue;
  end;

end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  AddNode(format('Node%0.3d', [curdlg.nodecount + 1]));
  if curdlg.nodecount = 1 then
    curdlg.nodes[curdlg.nodecount - 1].start_index := 1
  else
  begin
    curdlg.nodes[curdlg.nodecount - 1].start_index :=
      curdlg.nodes[curdlg.nodecount - 2].start_index + LineNumberStep;
  end;

  UpdateDialogue;
end;

procedure TForm3.nodenameKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  curdlg.nodes[nodeselected].nodename := nodename.Text;
  TreeView1.selected.Text := format('%s - line %d, %d options',
    [curdlg.nodes[nodeselected].nodename, curdlg.nodes[nodeselected].start_index,
    curdlg.nodes[nodeselected].PlayerOptioncnt]);
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  if treeview1.Selected <> nil then
  begin
    deletenode(TreeView1.selected.index);
    updatedialogue;
  end;

end;

procedure TForm3.TreeView1KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  treeview1click(nil);
end;

procedure TForm3.Button6Click(Sender: TObject);
var
  nodeind, newnum: integer;
  oldnum, counter: integer;
  base: integer;
  oldflnum, dlgcmdtemp: string;
  walkstrpos: integer;
  oldlink, x, t, start, step, currentnum: integer;
begin
  form11.showmodal;
  if form11.ModalResult = mrOk then
  begin
    start := StrToInt(form11.Edit1.Text);
    step  := StrToInt(form11.Edit2.Text);
    currentnum := start;
    base  := start;
    counter := 0;
    for t := 0 to CurDLG.nodecount - 1 do
    begin
      CurDLG.nodes[t].old_index := CurDLG.nodes[t].start_index;
      if Form11.advancebyone.Checked = True then
      begin
        if curdlg.nodes[t].PlayerOptioncnt = 0 then
        begin
          //     consoledebug('set line to base=' + IntToStr(base) + ' + counter=' + IntToStr(counter) + ' = ' + IntToStr(base + counter));
          CurDLG.nodes[t].start_index := base + counter;
          Inc(counter);
        end else
        begin
          CurDLG.nodes[t].start_index := currentnum + counter;
          counter := 0;
          currentnum := currentnum + step;
          base := base + step;
        end;
      end else
      begin
        CurDLG.nodes[t].start_index := currentnum + counter;
        counter := 0;
        currentnum := currentnum + step;
        base := base + step;
      end;

    end;

    // second pass, remap linecalls
    for t := 0 to curdlg.nodecount - 1 do
    begin
      for x := 0 to curdlg.nodes[t].PlayerOptioncnt - 1 do
      begin
        if curdlg.nodes[t].PlayerOptions[x].linktonode > 0 then
        begin
          oldlink := curdlg.nodes[t].PlayerOptions[x].linktonode;
          //    consoledebug('old link: ' + IntToStr(oldlink));
          curdlg.nodes[t].PlayerOptions[x].linktonode := GetDLGNewNum(oldlink);
          //     consoledebug('new link: ' + IntToStr(curdlg.nodes[t].PlayerOptions[x].linktonode));
        end;

        if curdlg.nodes[t].PlayerOptions[x].actions <> '' then
        begin
          //     consoledebug('Actions: ' + curdlg.nodes[t].PlayerOptions[x].actions);
          if pos('fl ', curdlg.nodes[t].PlayerOptions[x].actions) <> 0 then
          begin
            dlgcmdtemp := curdlg.nodes[t].PlayerOptions[x].actions;
            dlgcmdtemp := StringReplace(dlgcmdtemp, 'fl', 'fl ', [rfReplaceAll]);
            dlgcmdtemp := StringReplace(dlgcmdtemp, '  ', ' ', [rfReplaceAll]);
            walkstrpos := pos('fl ', dlgcmdtemp) + 3;
            oldflnum := '';
            while (dlgcmdtemp[walkstrpos] <> ',') and
              (walkstrpos <= length(dlgcmdtemp)) do
            begin
              oldflnum := oldflnum + dlgcmdtemp[walkstrpos];
              Inc(walkstrpos);
            end;

            // oldflnum := copy(dlgcmdtemp, pos('fl ', dlgcmdtemp) + 3, length(dlgcmdtemp));
            //      consoledebug('float line oldlink: ' + oldflnum);
            dlgcmdtemp := stringreplace(dlgcmdtemp, 'fl ' + oldflnum,
              'fl ' + IntToStr(GetDLGNewNum(StrToInt(oldflnum))), []);
            //       consoledebug('new cmd string: ' + dlgcmdtemp);
            curdlg.nodes[t].PlayerOptions[x].actions := dlgcmdtemp;
          end;

        end;

      end;

    end;


    // Remap script calls
    ScriptCommentcnt := 0;
    for t := 0 to currentscript.LineCount - 1 do
    begin
      // Track value assignments and see
      // if there is a dialog number there
      if form11.remapvarassign.Checked = True then
      begin
        if CurrentScript.ScriptLines[t].thenPart.opcode = SA_NUM_ASSIGN then
        begin
          oldnum  := CurrentScript.ScriptLines[t].thenPart.varvalue[1];
          nodeind := GetNodeIndexWithDLGLine(oldnum);
          if nodeind <> -1 then
          begin
            consoledebug('Assignment of a dialogue line ' + IntToStr(oldnum) +
              ' on script line ' + IntToStr(t));
            newnum := getdlgnewnum(CurrentScript.ScriptLines[t].thenPart.varvalue[1]);
            AddScriptComment(t, 'Changes made in ' + datetimetostr(now));
            Addscriptcomment(t,
              'The assignment in the default statement part was previously ' +
              IntToStr(oldnum));
            CurrentScript.ScriptLines[t].thenPart.varvalue[1] := newnum;
          end;
        end;

        if CurrentScript.ScriptLines[t].elsePart.opcode = SA_NUM_ASSIGN then
        begin
          oldnum  := CurrentScript.ScriptLines[t].elsePart.varvalue[1];
          nodeind := GetNodeIndexWithDLGLine(oldnum);
          if nodeind <> -1 then
          begin
            consoledebug('Assignment of a dialogue line ' + IntToStr(oldnum) +
              ' on script line ' + IntToStr(t));
            newnum := getdlgnewnum(CurrentScript.ScriptLines[t].elsePart.varvalue[1]);
            AddScriptComment(t, 'Changes made in ' + datetimetostr(now));
            Addscriptcomment(t, 'The assignment in the else part was previously ' +
              IntToStr(oldnum));
            CurrentScript.ScriptLines[t].elsePart.varvalue[1] := newnum;
          end;
        end;
      end;


      if CurrentScript.ScriptLines[t].thenPart.opcode = SA_PRINT_LINE then
      begin
        if CurrentScript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
        begin
          ///    consoledebug('line ' + IntToStr(t) + ' thenpart [Float line] in the script refers to dialog num ' +
          //      IntToStr(CurrentScript.ScriptLines[t].thenPart.varvalue[0]));
          AddScriptComment(t, 'Changes made in ' + datetimetostr(now));
          Addscriptcomment(t,
            'The print line call of the default statement part previously ' +
            IntToStr(CurrentScript.ScriptLines[t].thenPart.varvalue[0]));
          newnum := getdlgnewnum(CurrentScript.ScriptLines[t].thenPart.varvalue[0]);
          //      consoledebug('new number is ' + IntToStr(newnum));
          CurrentScript.ScriptLines[t].thenPart.varvalue[0] := newnum;
        end;

      end;
      if CurrentScript.ScriptLines[t].elsePart.opcode = SA_PRINT_LINE then
      begin
        if CurrentScript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
        begin
          //     consoledebug('line ' + IntToStr(t) + ' thenpart [Float line] in the script refers to dialog num ' +
          //       IntToStr(CurrentScript.ScriptLines[t].elsePart.varvalue[0]));
          Addscriptcomment(t, 'The print line call of the else part was previously ' +
            IntToStr(CurrentScript.ScriptLines[t].elsePart.varvalue[0]));
          newnum := getdlgnewnum(CurrentScript.ScriptLines[t].elsePart.varvalue[0]);
          //      consoledebug('new number is ' + IntToStr(newnum));
          CurrentScript.ScriptLines[t].elsePart.varvalue[0] := newnum;
        end;
      end;


      if CurrentScript.ScriptLines[t].thenPart.opcode = SA_FLOAT_LINE then
      begin
        if CurrentScript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
        begin
          //      consoledebug('line ' + IntToStr(t) + ' thenpart [Float line] in the script refers to dialog num ' +
          //        IntToStr(CurrentScript.ScriptLines[t].thenPart.varvalue[0]));
          AddScriptComment(t, 'Changes made in ' + datetimetostr(now));
          Addscriptcomment(t,
            'The float line call of the default statement part was previously ' +
            IntToStr(CurrentScript.ScriptLines[t].thenPart.varvalue[0]));
          newnum := getdlgnewnum(CurrentScript.ScriptLines[t].thenPart.varvalue[0]);
          //      consoledebug('new number is ' + IntToStr(newnum));
          CurrentScript.ScriptLines[t].thenPart.varvalue[0] := newnum;
        end;

      end;
      if CurrentScript.ScriptLines[t].elsePart.opcode = SA_FLOAT_LINE then
      begin
        if CurrentScript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
        begin
          //      consoledebug('line ' + IntToStr(t) + ' thenpart [Float line] in the script refers to dialog num ' +
          //        IntToStr(CurrentScript.ScriptLines[t].elsePart.varvalue[0]));
          Addscriptcomment(t, 'The float line call of the else part was previously ' +
            IntToStr(CurrentScript.ScriptLines[t].elsePart.varvalue[0]));
          newnum := getdlgnewnum(CurrentScript.ScriptLines[t].elsePart.varvalue[0]);
          //       consoledebug('new number is ' + IntToStr(newnum));
          CurrentScript.ScriptLines[t].elsePart.varvalue[0] := newnum;
        end;
      end;


      if CurrentScript.ScriptLines[t].thenPart.opcode = SA_DIALOG then
      begin
        if CurrentScript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
        begin
          //        consoledebug('line ' + IntToStr(t) + ' thenpart in the script refers to dialog num ' + IntToStr(
          //          CurrentScript.ScriptLines[t].thenPart.varvalue[0]));
          AddScriptComment(t, 'Changes made in ' + datetimetostr(now));
          Addscriptcomment(t,
            'The dialog call of the default statement part was previously ' +
            IntToStr(CurrentScript.ScriptLines[t].thenPart.varvalue[0]));
          newnum := getdlgnewnum(CurrentScript.ScriptLines[t].thenPart.varvalue[0]);
          //        consoledebug('new number is ' + IntToStr(newnum));
          CurrentScript.ScriptLines[t].thenPart.varvalue[0] := newnum;
        end;

      end;

      if CurrentScript.ScriptLines[t].elsePart.opcode = SA_DIALOG then
      begin
        if CurrentScript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
        begin
          //        consoledebug('line ' + IntToStr(t) + ' elsepart in the script refers to dialog num ' + IntToStr(
          //          CurrentScript.ScriptLines[t].elsePart.varvalue[0]));
          Addscriptcomment(t, 'The dialog call of the else part was previously ' +
            IntToStr(CurrentScript.ScriptLines[t].elsePart.varvalue[0]));
          newnum := getdlgnewnum(CurrentScript.ScriptLines[t].elsePart.varvalue[0]);
          //        consoledebug('new number is ' + IntToStr(newnum));
          CurrentScript.ScriptLines[t].elsePart.varvalue[0] := newnum;
        end;

      end;

    end;


    UpdateDialogue;
  end;

end;

procedure TForm3.linenumstartKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if linenumstart.Text <> '' then
    curdlg.nodes[nodeselected].start_index := StrToInt(linenumstart.Text);
  TreeView1.selected.Text := format('%s - line %d, %d options',
    [curdlg.nodes[nodeselected].nodename, curdlg.nodes[nodeselected].start_index,
    curdlg.nodes[nodeselected].PlayerOptioncnt]);
end;

procedure TForm3.Button7Click(Sender: TObject);
var
  index: integer;
begin
  ClearForm;
  ClearData;
  RefreshData;
  form12.showmodal;
  if form12.ModalResult = mrOk then
  begin
    AddPlayerOption(nodeselected, '');
    index := CurDLG.nodes[nodeselected].PlayerOptioncnt - 1;
    GetData(CurDLG.nodes[nodeselected].playeroptions[index].conditions,
      CurDLG.nodes[nodeselected].playeroptions[index].actions,
      CurDLG.nodes[nodeselected].playeroptions[index].Text,
      CurDLG.nodes[nodeselected].playeroptions[index].iqtest,
      CurDLG.nodes[nodeselected].playeroptions[index].gendertest,
      CurDLG.nodes[nodeselected].playeroptions[index].linktonode,
      CurDLG.nodes[nodeselected].playeroptions[index].playeroptioncomments);
    ClearData;
    UpdatePlayerOptions;
    UpdateDialogue;

  end;

end;

procedure GoToPlayerOptionEditor;
var
  index: integer;
begin
  index := form3.ListView1.Selected.Index;
  RefreshData;
  SetData(CurDLG.nodes[nodeselected].playeroptions[index].conditions,
    CurDLG.nodes[nodeselected].playeroptions[index].actions,
    CurDLG.nodes[nodeselected].playeroptions[index].Text,
    CurDLG.nodes[nodeselected].playeroptions[index].iqtest,
    CurDLG.nodes[nodeselected].playeroptions[index].gendertest,
    CurDLG.nodes[nodeselected].playeroptions[index].linktonode,
    curdlg.nodes[nodeselected].playeroptions[index].playeroptioncomments);
  PlaceDataOnForm;
  form12.showmodal;
  if form12.modalresult = mrOk then
  begin
    GetData(CurDLG.nodes[nodeselected].playeroptions[index].conditions,
      CurDLG.nodes[nodeselected].playeroptions[index].actions,
      CurDLG.nodes[nodeselected].playeroptions[index].Text,
      CurDLG.nodes[nodeselected].playeroptions[index].iqtest,
      CurDLG.nodes[nodeselected].playeroptions[index].gendertest,
      CurDLG.nodes[nodeselected].playeroptions[index].linktonode,
      curdlg.nodes[nodeselected].playeroptions[index].playeroptioncomments);
    UpdatePlayerOptions;
  end;
end;

procedure TForm3.ListView1DblClick(Sender: TObject);
begin
  if listview1.selected <> nil then
  begin

    GoToPlayerOptionEditor;

  end;

end;

procedure TForm3.Button11Click(Sender: TObject);
begin
  form13.dlgheadertext.Text := CurDLG.dlgheader;
  form13.showmodal;
  if form13.modalresult = mrOk then
    CurDLG.dlgheader := form13.dlgheadertext.Text;

end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  if modulefolder = 'Arcanum' then
    SaveDialogueFile(arcanumpath + '\data\dlg\' + curdlg.dlgfilename, CurDLG^)
  else

    SaveDialogueFile(arcanumpath + '\modules\' + modulefolder + '\dlg\' +
      curdlg.dlgfilename, CurDLG^);
end;

procedure TForm3.delbuttonClick(Sender: TObject);
var
  t: integer;
  messagestr: string;
begin
  if listview1.selected = nil then
    exit;

  messagestr := 'Are you sure you want to delete this player option?';
  if listview1.selcount > 1 then
    messagestr := 'Are you sure you want to delete the selected player options?';
  if ConfirmPlayerOptionDelete = True then
  begin
    case MessageDlg(messagestr, mtConfirmation, [mbYes, mbNo], 0) of
      mrYes:
      begin
        for t := 0 to ListView1.items.Count - 1 do
        begin
          if listview1.Items[t].Selected = True then
            DeletePlayerOption(nodeselected, ListView1.items[t].index);
        end;

        UpdatePlayerOptions;
        UpdateDialogue;
      end;

    end;
  end else
  begin

    for t := 0 to ListView1.items.Count - 1 do
    begin
      if listview1.Items[t].Selected = True then
        DeletePlayerOption(nodeselected, ListView1.items[t].index);
    end;

  end;

end;

procedure TForm3.insbuttonClick(Sender: TObject);
var
  index: integer;
begin
  if listview1.selected <> nil then
  begin
    ClearForm;
    ClearData;
    RefreshData;
    form12.showmodal;
    if form12.ModalResult = mrOk then
    begin
      InsertPlayerOption('', nodeselected, listview1.Selected.index);
      index := listview1.Selected.index;
      GetData(CurDLG.nodes[nodeselected].playeroptions[index].conditions,
        CurDLG.nodes[nodeselected].playeroptions[index].actions,
        CurDLG.nodes[nodeselected].playeroptions[index].Text,
        CurDLG.nodes[nodeselected].playeroptions[index].iqtest,
        CurDLG.nodes[nodeselected].playeroptions[index].gendertest,
        CurDLG.nodes[nodeselected].playeroptions[index].linktonode,
        curdlg.nodes[nodeselected].playeroptions[index].playeroptioncomments);
      UpdatePlayerOptions;
      UpdateDialogue;
    end;
  end;

end;

procedure TForm3.nodedescKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  curdlg.nodes[nodeselected].nodedesc := nodedesc.Text;

end;

procedure TForm3.ListView1Click(Sender: TObject);
begin
  if listview1.selected <> nil then
  begin
    mvdownbtn.Enabled := True;
    mvupbtn.Enabled := True;
    insbutton.Enabled := True;
    delbutton.Enabled := True;
    clonebutton.Enabled := True;
    copybtn.Enabled := True;
  end else
  begin
    mvdownbtn.Enabled := False;
    mvupbtn.Enabled := False;
    insbutton.Enabled := False;
    delbutton.Enabled := False;
    clonebutton.Enabled := False;
    if playeroptionbuffersize = 0 then
      pastebtn.Enabled := False
    else
    if playeroptionbuffersize > 0 then
      pastebtn.Enabled := True;
  end;

end;

procedure TForm3.mvdownbtnClick(Sender: TObject);
var
  prev_index: integer;
  movenodeind: integer;
  movetonodeind: integer;
  temp: playeroption;
begin
  if listview1.selected = nil then
  begin
    ConsoleDebug('Nothing is selected! Can''t move down.');
    exit;
  end;

  if listview1.ItemIndex = listview1.items.Count - 1 then
  begin
    listview1.SetFocus;
    exit;
  end;

  prev_index  := listview1.selected.Index;
  movenodeind := listview1.Selected.index;
  movetonodeind := listview1.selected.index + 1;
  listview1.ClearSelection;
  temp := curdlg.nodes[nodeselected].playeroptions[movenodeind]^;
  curdlg.nodes[nodeselected].playeroptions[movenodeind]^ :=
    curdlg.nodes[nodeselected].playeroptions[movetonodeind]^;
  curdlg.nodes[nodeselected].playeroptions[movetonodeind]^ := temp;
  UpdatePlayerOptions;
  listview1.ItemIndex := movetonodeind;

  listview1.selected := listview1.items[listview1.ItemIndex];
  // listview1.Scroll(0,listview1.itemindex);
  listview1.selected.MakeVisible(False);
  listview1.SetFocus;
  // UpdateItems(listview1.itemindex,listview1.itemindex-1);

end;

procedure TForm3.mvupbtnClick(Sender: TObject);
var
  prev_index: integer;
  movenodeind: integer;
  movetonodeind: integer;
  temp: playeroption;
begin
  if listview1.selected = nil then
  begin
    ConsoleDebug('Nothing is selected! Can''t move up.');
    exit;
  end;

  if listview1.ItemIndex = 0 then
  begin
    listview1.SetFocus;
    exit;
  end;

  prev_index  := listview1.selected.Index;
  movenodeind := listview1.Selected.index;
  movetonodeind := listview1.selected.index - 1;
  listview1.ClearSelection;
  temp := curdlg.nodes[nodeselected].playeroptions[movenodeind]^;
  curdlg.nodes[nodeselected].playeroptions[movenodeind]^ :=
    curdlg.nodes[nodeselected].playeroptions[movetonodeind]^;
  curdlg.nodes[nodeselected].playeroptions[movetonodeind]^ := temp;
  UpdatePlayerOptions;
  listview1.ItemIndex := movetonodeind;

  listview1.selected := listview1.items[listview1.ItemIndex];
  // listview1.Scroll(0,listview1.itemindex);
  listview1.selected.MakeVisible(False);
  // UpdateItems(listview1.itemindex,listview1.itemindex-1);
  listview1.SetFocus;

end;

procedure TForm3.useVOClick(Sender: TObject);
begin
  vofield.Enabled := usevo.Checked;
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
  MkDir(voicedir);
  Button8.Enabled := False;
end;

procedure TForm3.TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if treeview1.GetNodeAt(x, y) = nil then
  begin
    DialogueEditorClearForm;
    treeview1.Selected := nil;
  end;

end;

procedure TForm3.clonebuttonClick(Sender: TObject);
var
  temp: playeroption;
begin
  temp := curdlg.nodes[nodeselected].playeroptions[listview1.selected.index]^;
  AddPlayerOption(nodeselected, temp.Text);
  curdlg.nodes[nodeselected].PlayerOptions[curdlg.nodes[nodeselected].PlayerOptioncnt -
    1]^ := temp;
  curdlg.nodes[nodeselected].PlayerOptions[curdlg.nodes[nodeselected].PlayerOptioncnt -
    1]^.conditions := temp.conditions;
  curdlg.nodes[nodeselected].PlayerOptions[curdlg.nodes[nodeselected].PlayerOptioncnt -
    1]^.actions := temp.actions;
  UpdatePlayerOptions;

end;

procedure TForm3.copybtnClick(Sender: TObject);
var
  t: integer;
begin
  //  playeroptionbuffer := curdlg.nodes[nodeselected].playeroptions[listview1.selected.index]^;
  playeroptionbuffersize := 0;
  for t := 0 to listview1.items.Count - 1 do
  begin
    if listview1.Items[t].Selected then
    begin
      //     consoledebug('Player option: ' + IntToStr(t) + ' is selected.');
      SetLength(playeroptionbuffer, playeroptionbuffersize + 1);
      playeroptionbuffer[playeroptionbuffersize] :=
        curdlg.nodes[nodeselected].playeroptions[t]^;
      Inc(playeroptionbuffersize);
    end;

  end;
  listview1.SetFocus;
  MessageDlg(format('%d player options copied to buffer.', [playeroptionbuffersize]),
    mtInformation, [mbOK], 0);
  pastebtn.Enabled := True;
end;

procedure TForm3.pastebtnClick(Sender: TObject);
var
  t: integer;
begin
  for t := 0 to playeroptionbuffersize - 1 do
  begin
    AddPlayerOption(nodeselected, playeroptionbuffer[t].Text);
    curdlg.nodes[nodeselected].PlayerOptions[curdlg.nodes[nodeselected].PlayerOptioncnt -
      1]^ := playeroptionbuffer[t];
  end;

  // AddPlayerOption(nodeselected, playeroptionbuffer.Text);
  // curdlg.nodes[nodeselected].PlayerOptions[curdlg.nodes[nodeselected].PlayerOptioncnt - 1]^ := playeroptionbuffer;
  // curdlg.nodes[nodeselected].PlayerOptions[curdlg.nodes[nodeselected].PlayerOptioncnt - 1]^.conditions := playeroptionbuffer.conditions;
  // curdlg.nodes[nodeselected].PlayerOptions[curdlg.nodes[nodeselected].PlayerOptioncnt - 1]^.actions := playeroptionbuffer.actions;
  UpdatePlayerOptions;
  UpdateDialogue;
end;

procedure TForm3.fltflagMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin

  curdlg.nodes[nodeselected].isfloatmessage := fltflag.Checked;
  UpdateDialogue;
end;

procedure TForm3.fltgrpstartMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  curdlg.nodes[nodeselected].floatgroupstartmarker := fltgrpstart.Checked;

end;

procedure TForm3.ListView1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if button = mbRight then
  begin
    listview1.IsEditing;
  end;

end;

procedure TForm3.Editplayeroptionregularmode1Click(Sender: TObject);
begin
  GoToPlayerOptionEditor;
end;

procedure TForm3.PopupMenu1Popup(Sender: TObject);
begin
  if listview1.selected = nil then
    Editplayeroptionregularmode1.Enabled := False
  else
    Editplayeroptionregularmode1.Enabled := True;
end;

procedure TForm3.GenSpeechClick(Sender: TObject);
begin
  if curdlg.nodes[nodeselected].voicefield <> '' then
    speechlinenum := StrToInt(curdlg.nodes[nodeselected].voicefield);
  form23.maletext.Text := Form3.npctextmale.Text;
  if form3.npctextfemale.Text <> form3.npctextmale.Text then
  begin
    form23.femaletext.Text := Form3.npctextfemale.Text;
    form23.file_male.Caption := 'v'+inttostr(speechlinenum)+'_m.wav';
    form23.file_female.Caption := 'v'+inttostr(speechlinenum)+'_f.wav';
   form23.AdvSmoothStatusIndicator1.Visible:=true;
   form23.AdvSmoothStatusIndicator2.Visible:=true;


  end else
  begin
    form23.file_male.Caption := 'v'+inttostr(speechlinenum)+'_m.wav';
    form23.file_female.Caption := '';
  form23.femaletext.Text := '';
     form23.AdvSmoothStatusIndicator1.Caption := '';
     form23.AdvSmoothStatusIndicator2.Caption := '';
   form23.AdvSmoothStatusIndicator1.Visible:=true;
   form23.AdvSmoothStatusIndicator2.Visible:=false;
end;

updatefilestatus;
  form23.outputpath.Caption := voicedir;
  form23.showmodal;
end;

end.
