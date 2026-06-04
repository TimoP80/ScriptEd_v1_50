unit DialogueEditor;

interface

uses
  Windows, Messages, dlgfileio, dlgparser, dynamic_bass, arcanumscrlib,
  SysUtils,
  Variants, Classes, Graphics, Controls, Forms,
  pluginapi, ScriptEdCOnfig, Moduleloader, Dialogs, StdCtrls, ComCtrls,
  JvDotNetControls, JvExComCtrls, JvComCtrls, JvJanTreeView, Menus,
  JvPageList, JvExControls, htmltv;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Label3: TLabel;
    Button2: TButton;
    Button3: TButton;
    Label7: TLabel;
    nodename: TEdit;
    Button4: TButton;
    Button5: TButton;
    Label8: TLabel;
    linenumstart: TEdit;
    Button6: TButton;
    Button11: TButton;
    fltflag: TCheckBox;
    fltgrpstart: TCheckBox;
    JvPageList1: TJvPageList;
    PopupMenu1: TPopupMenu;
    Editplayeroptionregularmode1: TMenuItem;
    Editallplayeroptionslistmode1: TMenuItem;
    DialogueEditorPage: TJvStandardPage;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    npctextmale: TMemo;
    npctextfemale: TMemo;
    nodeactions: TEdit;
    nogenderspecific: TCheckBox;
    useVO: TCheckBox;
    vofield: TEdit;
    ListView1: TListView;
    Button7: TButton;
    insbutton: TButton;
    delbutton: TButton;
    Button10: TButton;
    nodedesc: TMemo;
    mvdownbtn: TButton;
    mvupbtn: TButton;
    Button8: TButton;
    clonebutton: TButton;
    copybtn: TButton;
    pastebtn: TButton;
    SyncNPCLines: TCheckBox;
    FloatMessageEditorPage: TJvStandardPage;
    GenSpeech: TButton;
    Button9: TButton;
    PlaySpeech: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    RemoveBlankNodesBtn: TButton;
    TreeView1: THTMLTreeview;
    OllamaGenerate: TButton;
    procedure TreeView1Click(Sender: TObject);
    procedure npctextmaleKeyUp(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure nogenderspecificClick(Sender: TObject);
    procedure npctextfemaleKeyUp(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure nodeactionsKeyUp(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure vofieldKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure nodenameKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure TreeView1KeyUp(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure Button6Click(Sender: TObject);
    procedure linenumstartKeyUp(Sender: TObject; var Key: word;
      Shift: TShiftState);
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
    procedure Button9Click(Sender: TObject);
    procedure PlaySpeechClick(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure RemoveBlankNodesBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  pdialoguenode = ^dialoguenode;

var
  Form3: TForm3;
  previousselection: integer;
  playeroptionbuffer: array of PlayerOption;
  playeroptionbuffersize: integer;
  selnode: pdialoguenode;
  nodeselected: integer;
  sfxstream: HSTREAM;
  dialoguehasVO: boolean;

const
  REPLACE_DIRECTION_MALE_TO_FEMALE = 1;
  REPLACE_DIRECTION_FEMALE_TO_MALE = 2;
  // Define this as constant for testing different values in the dialogue treeview
  WORD_WRAP_WIDTH = 120;

procedure UpdateDialogue;
procedure DialogueEditorClearForm;
function ReplaceGenderStrings(src: string; direction: integer): string;

implementation

uses Math, ScriptEdWindow, RemapLineNumbers, PlayerOptionEditor,
  DialogueHeaderEditor, addmessagesfromlist,
  SpeechGenInterface, InterNPCDialogue, SelectCondition, OllamaGenericDialog;

{$R *.dfm}

function BASS_ErrorToString(BASS_ErrorCode: integer): String;

begin

  case BASS_ErrorCode of
    0:
      Result := 'BASS_OK';
    1:
      Result := 'BASS_ERROR_MEM';
    2:
      Result := 'BASS_ERROR_FILEOPEN';
    3:
      Result := 'BASS_ERROR_DRIVER';
    4:
      Result := 'BASS_ERROR_BUFLOST';
    5:
      Result := 'BASS_ERROR_HANDLE';
    6:
      Result := 'BASS_ERROR_FORMAT';
    7:
      Result := 'BASS_ERROR_POSITION';
    8:
      Result := 'BASS_ERROR_INIT';
    9:
      Result := 'BASS_ERROR_START';
    14:
      Result := 'BASS_ERROR_ALREADY';
    18:
      Result := 'BASS_ERROR_NOCHAN';
    19:
      Result := 'BASS_ERROR_ILLTYPE';
    20:
      Result := 'BASS_ERROR_ILLPARAM';
    21:
      Result := 'BASS_ERROR_NO3D';
    22:
      Result := 'BASS_ERROR_NOEAX';
    23:
      Result := 'BASS_ERROR_DEVICE';
    24:
      Result := 'BASS_ERROR_NOPLAY';
    25:
      Result := 'BASS_ERROR_FREQ';
    27:
      Result := 'BASS_ERROR_NOTFILE';
    29:
      Result := 'BASS_ERROR_NOHW';
    31:
      Result := 'BASS_ERROR_EMPTY';
    32:
      Result := 'BASS_ERROR_NONET';
    33:
      Result := 'BASS_ERROR_CREATE';
    34:
      Result := 'BASS_ERROR_NOFX';
    37:
      Result := 'BASS_ERROR_NOTAVAIL';
    38:
      Result := 'BASS_ERROR_DECODE';
    39:
      Result := 'BASS_ERROR_DX';
    40:
      Result := 'BASS_ERROR_TIMEOUT';
    41:
      Result := 'BASS_ERROR_FILEFORM';
    42:
      Result := 'BASS_ERROR_SPEAKER';
    43:
      Result := 'BASS_ERROR_VERSION';
    44:
      Result := 'BASS_ERROR_CODEC';
    45:
      Result := 'BASS_ERROR_ENDED';
    46:
      Result := 'BASS_ERROR_BUSY';
  else
    Result := 'BASS_ERROR_UNKNOWN';
  end;
end;

procedure PlaySound(soundfilez: string; fademusicdown: boolean = False);
var
  sfxfile: pchar;
begin

  sfxfile := pchar(soundfilez);

  sfxstream := BASS_StreamCreateFile(False, sfxfile, 0, 0, 0 or BASS_UNICODE);

  consoledebug('Playing sound ' + sfxfile);

  if sfxstream <> 0 then
  begin

    BASS_ChannelPlay(sfxstream, False);
    BASS_ChannelSetAttribute(sfxstream, BASS_ATTRIB_VOL, 0.67);
    while BASS_ChannelIsActive(sfxstream) = BASS_ACTIVE_PLAYING do
    begin

    end;
    BASS_ChannelStop(sfxstream);
    BASS_StreamFree(sfxstream);
  end
  else
  begin
    consoledebug('Error playing sound errorcode! ' +
      BASS_ErrorToString(BASS_ErrorGetCode));
  end;
end;

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

(*
procedure UpdateDialogue;
var
  y,X, t: integer;
  thetreenode: TTreeNode;
  childnode: TTreeNode;
  playeroptionsnode: TTreeNode;
begin
  Form3.TreeView1.Items.Clear;
  for t := 0 to CurDLG.nodecount - 1 do
  begin
    // consoledebug('Nodes: ' + curdlg.nodes[t].nodename);

    thetreenode := Form3.TreeView1.Items.Add(nil,
      format('<FONT color="clNavy"><B>%s</B></FONT> - <FONT color="clGreen">line %d, %d options</FONT>', [CurDLG.nodes[t].nodename,
      CurDLG.nodes[t].start_index, CurDLG.nodes[t].PlayerOptioncnt]));
    childnode := Form3.TreeView1.Items.AddChild(thetreenode,
      wraptext('<B>NPC Text: </B>'+CurDLG.nodes[t].npctextmale,'<BR>',[' ','.'],70));

    for y := 0 to curdlg.nodes[t].PlayerOptioncnt-1 do
      begin

     playeroptionsnode := Form3.TreeView1.Items.AddChild(childnode,
      wraptext('<B>Player option</B>: '+CurDLG.nodes[t].playeroptions[y].Text+' => '+inttostr(CurDLG.nodes[t].playeroptions[y].linktonode),'<BR>',[' ','.'],70));

      end;

    thetreenode.Expand(True);
  end;
end;
*)
procedure UpdateDialogue;
var
  t, y: Integer;
  thetreenode, childnode, playeroptionsnode, rootNodeToSelect: TTreeNode;
  treeItems: TTreeNodes;
  curNode: DialogueNode;
  theplayerOption: PlayerOption;
begin
  // Use TreeView.Items to avoid repeated property lookups
  treeItems := Form3.TreeView1.Items;

  // Determine the root node of the currently selected item, if any
  rootNodeToSelect := nil;
  (*if Assigned(Form3.TreeView1.Selected) then
  begin
    // Traverse up to the root node
    rootNodeToSelect := Form3.TreeView1.Selected;
    while Assigned(rootNodeToSelect.Parent) do
      rootNodeToSelect := rootNodeToSelect.Parent;
  end; *)

  // Suspend TreeView updates for performance
  Form3.TreeView1.Items.BeginUpdate;
  try
    treeItems.Clear;

    for t := 0 to CurDLG.nodecount - 1 do
    begin
      curNode := CurDLG.nodes[t]^;

      // Add the main dialogue node
      thetreenode := treeItems.Add(nil,
        Format('<FONT color="clNavy"><B>%s</B></FONT> - <FONT color="clGreen">line %d, %d options</FONT>',
        [curNode.nodename, curNode.start_index, curNode.PlayerOptioncnt]));

      // Add the NPC text as a child node
      childnode := treeItems.AddChild(thetreenode,
        WrapText('<B>NPC Text: </B>' + curNode.npctextmale, '<BR>', [' ', '.'], WORD_WRAP_WIDTH));

      // Add player options as child nodes
      for y := 0 to curNode.PlayerOptioncnt - 1 do
      begin
        theplayerOption := curNode.playeroptions[y]^;
        playeroptionsnode := treeItems.AddChild(childnode,
          WrapText('<B>Player option</B>: ' + theplayerOption.Text + ' => ' + IntToStr(theplayerOption.linktonode),
          '<BR>', [' ', '.'],  WORD_WRAP_WIDTH));
      end;

      // Expand the node after all children are added
     if AutoExpand then thetreenode.Expand(True);
    end;

    // Restore the previously selected root node (if any)
    (*if (Assigned(rootNodeToSelect)) then
    begin
      for t := 0 to treeItems.Count - 1 do
      begin
        if (treeItems[t].Level = 0) and (treeItems[t].Text = rootNodeToSelect.Text) then
        begin
          Form3.TreeView1.Selected := treeItems[t];
          Break;
        end;
      end;
    end;*)
  finally
    // Resume TreeView updates
    Form3.TreeView1.Items.EndUpdate;
  end;
end;


procedure UpdatePlayerOptions;
var
  item: TListItem;
  t: integer;
begin
  // Guard against invalid state - no dialogue loaded, no node selected,
  // or the selected index is out of range. The ListView is cleared in
  // every case so the user does not see stale data from a previous node.
  Form3.ListView1.Clear;
  if (CurDLG = nil) or (CurDLG.nodecount <= 0) or
     (nodeselected < 0) or (nodeselected >= CurDLG.nodecount) then
    Exit;
  if CurDLG.nodes[nodeselected] = nil then
    Exit;
  for t := 0 to CurDLG.nodes[nodeselected].PlayerOptioncnt - 1 do
  begin
    item := Form3.ListView1.Items.Add;
    item.Caption := IntToStr(t + 1);
    item.subitems.Add(CurDLG.nodes[nodeselected].playeroptions[t].Text);
    if CurDLG.nodes[nodeselected].playeroptions[t].gendertest = GENDER_FEMALE
    then
      item.subitems.Add('female')
    else if CurDLG.nodes[nodeselected].playeroptions[t].gendertest = GENDER_MALE
    then
      item.subitems.Add('male')
    else
      item.subitems.Add('both');
    item.subitems.Add(CurDLG.nodes[nodeselected].playeroptions[t].conditions);

    item.subitems.Add(IntToStr(CurDLG.nodes[nodeselected].playeroptions
      [t].iqtest));

    item.subitems.Add(IntToStr(CurDLG.nodes[nodeselected].playeroptions[t]
      .linktonode));
    item.subitems.Add(CurDLG.nodes[nodeselected].playeroptions[t].actions);
    item.subitems.Add(CurDLG.nodes[nodeselected].playeroptions[t]
      .playeroptioncomments);

  end;

end;

procedure DialogueEditorClearForm;
var
  t: integer;
begin
  for t := 0 to Form3.ComponentCount - 1 do
  begin
    if Form3.Components[t] is TMemo then
      TMemo(Form3.Components[t]).Text := '';

    if Form3.Components[t] is TEdit then
      TEdit(Form3.Components[t]).Text := '';

    if Form3.Components[t] is TCheckBox then
      TCheckBox(Form3.Components[t]).Checked := False;

    if Form3.Components[t] is TListView then
      TListView(Form3.Components[t]).Clear;

  end;
  // Reset the selected-node pointer so any subsequent code that uses
  // nodeselected (UpdatePlayerOptions, etc.) does not accidentally
  // operate on a stale index.
  nodeselected := -1;

end;

procedure TForm3.TreeView1Click(Sender: TObject);
var
  voicename: string;
  rootNode: TTreeNode;
  idx: integer;
begin
  // Nothing selected - clear the form and reset state.
  if TreeView1.selected = nil then
  begin
    DialogueEditorClearForm;
    Exit;
  end;

  // If the user clicked a child node (NPC text or a player option),
  // walk up to the root dialogue node. The form always reflects the
  // root node's data - the children are just for display.
  rootNode := TreeView1.selected;
  while (rootNode <> nil) and (rootNode.Level > 0) do
    rootNode := rootNode.Parent;

  if (rootNode = nil) or (rootNode.Level <> 0) then
  begin
    DialogueEditorClearForm;
    Exit;
  end;

  // If the user clicked a child, change the selection visually to the
  // root so the highlight matches the data shown in the form.
  if TreeView1.selected <> rootNode then
  begin
    TreeView1.Selected := rootNode;
    Exit; // TreeView1.Selected assignment will re-trigger TreeView1Click
  end;

  // Validate the node index is in range for the current dialogue.
  idx := rootNode.Index;
  if (CurDLG = nil) or (idx < 0) or (idx >= CurDLG.nodecount) or
     (CurDLG.nodes[idx] = nil) then
  begin
    DialogueEditorClearForm;
    Exit;
  end;

  nodeselected := idx;
  fltflag.Checked := CurDLG.nodes[nodeselected].isfloatmessage;
  fltgrpstart.Checked := CurDLG.nodes[nodeselected].floatgroupstartmarker;
  linenumstart.Text := IntToStr(CurDLG.nodes[nodeselected].start_index);
  nodedesc.Text := CurDLG.nodes[nodeselected].nodedesc;
  nodename.Text := CurDLG.nodes[nodeselected].nodename;
  npctextmale.Text := CurDLG.nodes[nodeselected].npctextmale;
  npctextfemale.Text := CurDLG.nodes[nodeselected].npctextfemale;
  if CurDLG.nodes[nodeselected].npctextmale <> CurDLG.nodes[nodeselected].npctextfemale
  then
    nogenderspecific.Checked := False
  else
    nogenderspecific.Checked := True;
  nodeactions.Text := CurDLG.nodes[nodeselected].nodeactions;
  vofield.Text := CurDLG.nodes[nodeselected].voicefield;
  PlaySpeech.Visible := True;
  if vofield.Text <> '' then
  begin
    voicename := arcanumpath + '\Modules\' + modulefolder + '\Sound\Speech\'
      + format('%0.5d', [script_id]) + '\v' + vofield.Text + '_m.mp3';
    if fileexists(voicename) then
    begin
      consoledebug(voicename + ' found.');
      PlaySpeech.Enabled := True;
    end
    else
    begin
      consoledebug(voicename + ' not found.');
      PlaySpeech.Enabled := False;
    end;
    useVO.Checked := True
  end
  else
    useVO.Checked := False;
  UpdatePlayerOptions;
end;

procedure TForm3.npctextmaleKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
var childnode: TTreeNode;
selectednode: TTreeNode;
  begin
  CurDLG.nodes[nodeselected].npctextmale := npctextmale.Text;

   selectednode := TreeView1.Selected;
   if assigned(selectednode) then
   begin
     childnode := selectednode.getFirstChild;
     if assigned(childnode) then
     begin
       childnode.Text :=  wraptext('<B>NPC Text: </B>'+CurDLG.nodes[nodeselected].npctextmale,'<BR>',[' ','.'], WORD_WRAP_WIDTH);
     end;
   end;

  // Synchronized update of the female text
  if nogenderspecific.Checked = True then
  begin
    CurDLG.nodes[nodeselected].npctextfemale := CurDLG.nodes[nodeselected]
      .npctextmale;
    npctextfemale.Text := npctextmale.Text;

  end;

  if (nogenderspecific.Checked = False) and (AutoReplaceGenderStrings = True)
    and (SyncNPCLines.Checked = True) then
  begin
    CurDLG.nodes[nodeselected].npctextfemale := CurDLG.nodes[nodeselected]
      .npctextmale;
    CurDLG.nodes[nodeselected].npctextfemale :=
      ReplaceGenderStrings(CurDLG.nodes[nodeselected].npctextfemale,
      REPLACE_DIRECTION_MALE_TO_FEMALE);
    npctextfemale.Text := CurDLG.nodes[nodeselected].npctextfemale;
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
      CurDLG.nodes[nodeselected].npctextfemale := CurDLG.nodes[nodeselected]
        .npctextmale;
    end;
    SyncNPCLines.Enabled := False;
  end;
  if nogenderspecific.Checked = False then
  begin
    SyncNPCLines.Enabled := True;
  end;

end;

procedure TForm3.npctextfemaleKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  CurDLG.nodes[nodeselected].npctextfemale := npctextfemale.Text;

  if (nogenderspecific.Checked = False) and (AutoReplaceGenderStrings = True)
    and (SyncNPCLines.Checked = True) then
  begin
    CurDLG.nodes[nodeselected].npctextmale := CurDLG.nodes[nodeselected]
      .npctextfemale;
    CurDLG.nodes[nodeselected].npctextmale :=
      ReplaceGenderStrings(CurDLG.nodes[nodeselected].npctextmale,
      REPLACE_DIRECTION_FEMALE_TO_MALE);
    npctextmale.Text := CurDLG.nodes[nodeselected].npctextmale;
  end;

end;

procedure TForm3.FormCreate(Sender: TObject);
var
  u: integer;
begin

  previousselection := -1;
end;

procedure TForm3.nodeactionsKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  CurDLG.nodes[nodeselected].nodeactions := nodeactions.Text;
end;

procedure TForm3.vofieldKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  CurDLG.nodes[nodeselected].voicefield := vofield.Text;
end;

procedure TForm3.Button5Click(Sender: TObject);
var
  newname: string;
begin
  if Form3.TreeView1.selected <> nil then
  begin
    newname := InputBox('Name for new node',
      'Enter a name for the inserted node', '');
    InsertNode(newname, Form3.TreeView1.selected.index);
    UpdateDialogue;
  end;

end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  AddNode(format('Node%0.3d', [CurDLG.nodecount + 1]));
  if CurDLG.nodecount = 1 then
    CurDLG.nodes[CurDLG.nodecount - 1].start_index := 1
  else
  begin
    CurDLG.nodes[CurDLG.nodecount - 1].start_index :=
      CurDLG.nodes[CurDLG.nodecount - 2].start_index + LineNumberStep;
  end;

  if (AutoIncrementVONumber = True) and (dialoguehasVO = True) then
  begin
    if CurDLG.nodecount = 1 then
      CurDLG.nodes[CurDLG.nodecount - 1].voicefield := '1'
    else
      CurDLG.nodes[CurDLG.nodecount - 1].voicefield :=
        IntToStr(strtoint(CurDLG.nodes[CurDLG.nodecount - 2].voicefield) + 1);
  end;

  UpdateDialogue;
end;

procedure TForm3.nodenameKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  CurDLG.nodes[nodeselected].nodename := nodename.Text;
  TreeView1.selected.Text := format('%s - line %d, %d options',
    [CurDLG.nodes[nodeselected].nodename,
    CurDLG.nodes[nodeselected].start_index,
    CurDLG.nodes[nodeselected].PlayerOptioncnt]);
end;

procedure TForm3.Button3Click(Sender: TObject);
var
  rootNode: TTreeNode;
  idx: integer;
begin
  if TreeView1.selected = nil then
    Exit;

  // Walk up to the root dialogue node - if a child was selected (NPC
  // text or a player option), deleting the child's index would target
  // the wrong node entirely.
  rootNode := TreeView1.selected;
  while (rootNode <> nil) and (rootNode.Level > 0) do
    rootNode := rootNode.Parent;

  if (rootNode = nil) or (rootNode.Level <> 0) then
    Exit;

  idx := rootNode.Index;
  if (idx < 0) or (idx >= CurDLG.nodecount) then
    Exit;

  if MessageDlg(Format('Delete node "%s" (line %d) and all its player options?',
    [CurDLG.nodes[idx].nodename, CurDLG.nodes[idx].start_index]),
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  // Free player options and dispose the node before deleting from the array
  if CurDLG.nodes[idx].PlayerOptioncnt > 0 then
  begin
    SetLength(CurDLG.nodes[idx].playeroptions, 0);
    CurDLG.nodes[idx].PlayerOptioncnt := 0;
  end;
  Dispose(CurDLG.nodes[idx]);
  DeleteNode(idx);
  UpdateDialogue;
end;

procedure TForm3.TreeView1KeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  TreeView1Click(nil);
end;

procedure TForm3.Button6Click(Sender: TObject);
var
  nodeind, newnum: integer;
  oldnum, counter: integer;
  base: integer;
  oldflnum, dlgcmdtemp: string;
  walkstrpos: integer;
  oldlink, X, t, start, step, currentnum: integer;
begin
  form11.showmodal;
  if form11.ModalResult = mrOk then
  begin
    start := strtoint(form11.Edit1.Text);
    step := strtoint(form11.Edit2.Text);
    currentnum := start;
    base := start;
    counter := 0;
    for t := 0 to CurDLG.nodecount - 1 do
    begin
      CurDLG.nodes[t].old_index := CurDLG.nodes[t].start_index;
      if form11.advancebyone.Checked = True then
      begin
        if CurDLG.nodes[t].PlayerOptioncnt = 0 then
        begin
          // consoledebug('set line to base=' + IntToStr(base) + ' + counter=' + IntToStr(counter) + ' = ' + IntToStr(base + counter));
          CurDLG.nodes[t].start_index := base + counter;
          Inc(counter);
        end
        else
        begin
          CurDLG.nodes[t].start_index := currentnum + counter;
          counter := 0;
          currentnum := currentnum + step;
          base := base + step;
        end;
      end
      else
      begin
        CurDLG.nodes[t].start_index := currentnum + counter;
        counter := 0;
        currentnum := currentnum + step;
        base := base + step;
      end;

    end;

    // second pass, remap linecalls
    for t := 0 to CurDLG.nodecount - 1 do
    begin
      for X := 0 to CurDLG.nodes[t].PlayerOptioncnt - 1 do
      begin
        if CurDLG.nodes[t].playeroptions[X].linktonode > 0 then
        begin
          oldlink := CurDLG.nodes[t].playeroptions[X].linktonode;
          // consoledebug('old link: ' + IntToStr(oldlink));
          CurDLG.nodes[t].playeroptions[X].linktonode := GetDLGNewNum(oldlink);
          // consoledebug('new link: ' + IntToStr(curdlg.nodes[t].PlayerOptions[x].linktonode));
        end;

        if CurDLG.nodes[t].playeroptions[X].actions <> '' then
        begin
          // consoledebug('Actions: ' + curdlg.nodes[t].PlayerOptions[x].actions);
          if pos('fl ', CurDLG.nodes[t].playeroptions[X].actions) <> 0 then
          begin
            dlgcmdtemp := CurDLG.nodes[t].playeroptions[X].actions;
            dlgcmdtemp := StringReplace(dlgcmdtemp, 'fl', 'fl ',
              [rfReplaceAll]);
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
            // consoledebug('float line oldlink: ' + oldflnum);
            dlgcmdtemp := StringReplace(dlgcmdtemp, 'fl ' + oldflnum,
              'fl ' + IntToStr(GetDLGNewNum(strtoint(oldflnum))), []);
            // consoledebug('new cmd string: ' + dlgcmdtemp);
            CurDLG.nodes[t].playeroptions[X].actions := dlgcmdtemp;
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
        if currentscript.ScriptLines[t].thenPart.opcode = SA_NUM_ASSIGN then
        begin
          oldnum := currentscript.ScriptLines[t].thenPart.varvalue[1];
          nodeind := GetNodeIndexWithDLGLine(oldnum);
          if nodeind <> -1 then
          begin
            consoledebug('Assignment of a dialogue line ' + IntToStr(oldnum) +
              ' on script line ' + IntToStr(t));
            newnum := GetDLGNewNum(currentscript.ScriptLines[t]
              .thenPart.varvalue[1]);
            AddScriptComment(t, 'Changes made in ' + datetimetostr(now));
            AddScriptComment(t,
              'The assignment in the default statement part was previously ' +
              IntToStr(oldnum));
            currentscript.ScriptLines[t].thenPart.varvalue[1] := newnum;
          end;
        end;

        if currentscript.ScriptLines[t].elsePart.opcode = SA_NUM_ASSIGN then
        begin
          oldnum := currentscript.ScriptLines[t].elsePart.varvalue[1];
          nodeind := GetNodeIndexWithDLGLine(oldnum);
          if nodeind <> -1 then
          begin
            consoledebug('Assignment of a dialogue line ' + IntToStr(oldnum) +
              ' on script line ' + IntToStr(t));
            newnum := GetDLGNewNum(currentscript.ScriptLines[t]
              .elsePart.varvalue[1]);
            AddScriptComment(t, 'Changes made in ' + datetimetostr(now));
            AddScriptComment(t,
              'The assignment in the else part was previously ' +
              IntToStr(oldnum));
            currentscript.ScriptLines[t].elsePart.varvalue[1] := newnum;
          end;
        end;
      end;

      if currentscript.ScriptLines[t].thenPart.opcode = SA_PRINT_LINE then
      begin
        if currentscript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
        begin
          /// consoledebug('line ' + IntToStr(t) + ' thenpart [Float line] in the script refers to dialog num ' +
          // IntToStr(CurrentScript.ScriptLines[t].thenPart.varvalue[0]));
          AddScriptComment(t, 'Changes made in ' + datetimetostr(now));
          AddScriptComment(t,
            'The print line call of the default statement part previously ' +
            IntToStr(currentscript.ScriptLines[t].thenPart.varvalue[0]));
          newnum := GetDLGNewNum(currentscript.ScriptLines[t]
            .thenPart.varvalue[0]);
          // consoledebug('new number is ' + IntToStr(newnum));
          currentscript.ScriptLines[t].thenPart.varvalue[0] := newnum;
        end;

      end;
      if currentscript.ScriptLines[t].elsePart.opcode = SA_PRINT_LINE then
      begin
        if currentscript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
        begin
          // consoledebug('line ' + IntToStr(t) + ' thenpart [Float line] in the script refers to dialog num ' +
          // IntToStr(CurrentScript.ScriptLines[t].elsePart.varvalue[0]));
          AddScriptComment(t,
            'The print line call of the else part was previously ' +
            IntToStr(currentscript.ScriptLines[t].elsePart.varvalue[0]));
          newnum := GetDLGNewNum(currentscript.ScriptLines[t]
            .elsePart.varvalue[0]);
          // consoledebug('new number is ' + IntToStr(newnum));
          currentscript.ScriptLines[t].elsePart.varvalue[0] := newnum;
        end;
      end;

      if currentscript.ScriptLines[t].thenPart.opcode = SA_FLOAT_LINE then
      begin
        if currentscript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
        begin
          // consoledebug('line ' + IntToStr(t) + ' thenpart [Float line] in the script refers to dialog num ' +
          // IntToStr(CurrentScript.ScriptLines[t].thenPart.varvalue[0]));
          AddScriptComment(t, 'Changes made in ' + datetimetostr(now));
          AddScriptComment(t,
            'The float line call of the default statement part was previously '
            + IntToStr(currentscript.ScriptLines[t].thenPart.varvalue[0]));
          newnum := GetDLGNewNum(currentscript.ScriptLines[t]
            .thenPart.varvalue[0]);
          // consoledebug('new number is ' + IntToStr(newnum));
          currentscript.ScriptLines[t].thenPart.varvalue[0] := newnum;
        end;

      end;
      if currentscript.ScriptLines[t].elsePart.opcode = SA_FLOAT_LINE then
      begin
        if currentscript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
        begin
          // consoledebug('line ' + IntToStr(t) + ' thenpart [Float line] in the script refers to dialog num ' +
          // IntToStr(CurrentScript.ScriptLines[t].elsePart.varvalue[0]));
          AddScriptComment(t,
            'The float line call of the else part was previously ' +
            IntToStr(currentscript.ScriptLines[t].elsePart.varvalue[0]));
          newnum := GetDLGNewNum(currentscript.ScriptLines[t]
            .elsePart.varvalue[0]);
          // consoledebug('new number is ' + IntToStr(newnum));
          currentscript.ScriptLines[t].elsePart.varvalue[0] := newnum;
        end;
      end;

      if currentscript.ScriptLines[t].thenPart.opcode = SA_DIALOG then
      begin
        if currentscript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
        begin
          // consoledebug('line ' + IntToStr(t) + ' thenpart in the script refers to dialog num ' + IntToStr(
          // CurrentScript.ScriptLines[t].thenPart.varvalue[0]));
          AddScriptComment(t, 'Changes made in ' + datetimetostr(now));
          AddScriptComment(t,
            'The dialog call of the default statement part was previously ' +
            IntToStr(currentscript.ScriptLines[t].thenPart.varvalue[0]));
          newnum := GetDLGNewNum(currentscript.ScriptLines[t]
            .thenPart.varvalue[0]);
          // consoledebug('new number is ' + IntToStr(newnum));
          currentscript.ScriptLines[t].thenPart.varvalue[0] := newnum;
        end;

      end;

      if currentscript.ScriptLines[t].elsePart.opcode = SA_DIALOG then
      begin
        if currentscript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
        begin
          // consoledebug('line ' + IntToStr(t) + ' elsepart in the script refers to dialog num ' + IntToStr(
          // CurrentScript.ScriptLines[t].elsePart.varvalue[0]));
          AddScriptComment(t, 'The dialog call of the else part was previously '
            + IntToStr(currentscript.ScriptLines[t].elsePart.varvalue[0]));
          newnum := GetDLGNewNum(currentscript.ScriptLines[t]
            .elsePart.varvalue[0]);
          // consoledebug('new number is ' + IntToStr(newnum));
          currentscript.ScriptLines[t].elsePart.varvalue[0] := newnum;
        end;

      end;

    end;

    UpdateDialogue;
  end;

end;

procedure TForm3.linenumstartKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if linenumstart.Text <> '' then
    CurDLG.nodes[nodeselected].start_index := strtoint(linenumstart.Text);
  TreeView1.selected.Text := format('%s - line %d, %d options',
    [CurDLG.nodes[nodeselected].nodename,
    CurDLG.nodes[nodeselected].start_index,
    CurDLG.nodes[nodeselected].PlayerOptioncnt]);
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
  SelectedChild: TTreeNode;
  SelectedNode: TTreeNode;
  ChildNode: TTreeNode;
  ChildIndex: Integer;
begin



  index := Form3.ListView1.selected.index;

  RefreshData;
  SetData(CurDLG.nodes[nodeselected].playeroptions[index].conditions,
    CurDLG.nodes[nodeselected].playeroptions[index].actions,
    CurDLG.nodes[nodeselected].playeroptions[index].Text,
    CurDLG.nodes[nodeselected].playeroptions[index].iqtest,
    CurDLG.nodes[nodeselected].playeroptions[index].gendertest,
    CurDLG.nodes[nodeselected].playeroptions[index].linktonode,
    CurDLG.nodes[nodeselected].playeroptions[index].playeroptioncomments);
  PlaceDataOnForm;
  form12.showmodal;
  if form12.ModalResult = mrOk then
  begin
    GetData(CurDLG.nodes[nodeselected].playeroptions[index].conditions,
      CurDLG.nodes[nodeselected].playeroptions[index].actions,
      CurDLG.nodes[nodeselected].playeroptions[index].Text,
      CurDLG.nodes[nodeselected].playeroptions[index].iqtest,
      CurDLG.nodes[nodeselected].playeroptions[index].gendertest,
      CurDLG.nodes[nodeselected].playeroptions[index].linktonode,
      CurDLG.nodes[nodeselected].playeroptions[index].playeroptioncomments);
    UpdatePlayerOptions;

    // Get the selected node
  SelectedNode := form3.TreeView1.Selected;

  if (Assigned(SelectedNode)) and (selectednode.HasChildren=true) and (selectednode.Level=0) then
  begin

    // Specify the index of the child node you want to access
    ChildIndex := index; // Change this to the desired index
    selectedchild := SelectedNode.getFirstChild;
    // Check if the selected node has children and the index is valid
    if (assigned(selectedchild)) and (ChildIndex >= 0) and (ChildIndex < Selectedchild.Count) then
    begin
      // Access the child node by index
      ChildNode := SelectedCHild.Item[ChildIndex];

      // Perform operations on the child node
      //ShowMessage('Child Node Text: ' + ChildNode.Text);

      // Example: Update the child node's text
      ChildNode.Text := wraptext('<B>Player option</B>: '+CurDLG.nodes[nodeselected].playeroptions[index].Text+' => '+
      inttostr(CurDLG.nodes[nodeselected].playeroptions[index].linktonode),'<BR>',[' ','.'], WORD_WRAP_WIDTH);
    end
    else
    begin
      ShowMessage('Invalid child index.');
    end;
  end
  else
  begin
    ShowMessage('Please select a parent node.');
  end;

  end;
end;

procedure TForm3.ListView1DblClick(Sender: TObject);
begin
  if ListView1.selected <> nil then
  begin

    GoToPlayerOptionEditor;

  end;

end;

procedure TForm3.Button11Click(Sender: TObject);
begin
  form13.dlgheadertext.Text := CurDLG.dlgheader;
  form13.showmodal;
  if form13.ModalResult = mrOk then
    CurDLG.dlgheader := form13.dlgheadertext.Text;

end;

procedure TForm3.Button12Click(Sender: TObject);
var
  u: integer;
  startindex: integer;
begin
  messagelist.showmodal;

  if messagelist.ModalResult = mrOk then
  begin
    if CurDLG.nodecount = 0 then
      startindex := 1
    else
      startindex := CurDLG.nodes[CurDLG.nodecount - 1].start_index;

    for u := 0 to messagelist.memo1.lines.Count - 1 do
    begin

      AddNode(format('Node%0.3d', [CurDLG.nodecount + 1]));
      CurDLG.nodes[CurDLG.nodecount - 1].npctextmale :=
        messagelist.memo1.lines[u];
      CurDLG.nodes[CurDLG.nodecount - 1].npctextfemale :=
        messagelist.memo1.lines[u];
      CurDLG.nodes[CurDLG.nodecount - 1].start_index := startindex + u + 1;
    end;
  end;
  UpdateDialogue;
end;

procedure TForm3.Button13Click(Sender: TObject);
var
  messagestr: string;
begin
  messagestr := 'Are you sure you want to clear all nodes?';
  case MessageDlg(messagestr, mtConfirmation, [mbYes, mbNo], 0) of
    mrYes:
      begin
        CurDLG.nodecount := 0;
        UpdateDialogue;

      end;
  end;
end;

procedure TForm3.Button14Click(Sender: TObject);
begin
  form29.showmodal;
  if form29.ModalResult = mrOk then
  begin

    nodeactions.Text := 'gv' + IntToStr(globalvar_dialogue) + ' ' +
      IntToStr(dlgline) + ', gv' + IntToStr(globalvar_script) + ' ' +
      IntToStr(scrline);

    CurDLG.nodes[nodeselected].nodeactions := nodeactions.Text;
    UpdateDialogue;
  end;
end;

procedure TForm3.Button15Click(Sender: TObject);
var
  I: integer;
begin
  for I := 0 to CurDLG.nodes[nodeselected].PlayerOptioncnt - 1 do
  begin
    CurDLG.nodes[nodeselected].playeroptions[I].conditions :=
      'lf' + IntToStr(I + 1) + ' 0';
    CurDLG.nodes[nodeselected].playeroptions[I].actions :=
      'lf' + IntToStr(I + 1) + ' 1';
  end;
  UpdatePlayerOptions;
end;

procedure TForm3.Button16Click(Sender: TObject);
var childnode: TTreeNode;
selectednode: TTreeNode;
  begin


 form30.showmodal;
  if form30.ModalResult = mrOk then
  begin
    npctextmale.Text := form30.ollamaresult.Text;
    CurDLG.nodes[nodeselected].npctextmale := npctextmale.Text;
    selectednode := TreeView1.Selected;
   if assigned(selectednode) then
   begin
     childnode := selectednode.getFirstChild;
     if assigned(childnode) then
     begin
       childnode.Text :=  wraptext('<B>NPC Text: </B>'+CurDLG.nodes[nodeselected].npctextmale,'<BR>',[' ','.'], WORD_WRAP_WIDTH);
     end;
   end;
    // Synchronized update of the female text
    if nogenderspecific.Checked = True then
    begin
      CurDLG.nodes[nodeselected].npctextfemale := CurDLG.nodes[nodeselected]
        .npctextmale;
      npctextfemale.Text := npctextmale.Text;
    end;

    if (nogenderspecific.Checked = False) and (AutoReplaceGenderStrings = True)
      and (SyncNPCLines.Checked = True) then
    begin
      CurDLG.nodes[nodeselected].npctextfemale := CurDLG.nodes[nodeselected]
        .npctextmale;
      CurDLG.nodes[nodeselected].npctextfemale :=
        ReplaceGenderStrings(CurDLG.nodes[nodeselected].npctextfemale,
        REPLACE_DIRECTION_MALE_TO_FEMALE);
      npctextfemale.Text := CurDLG.nodes[nodeselected].npctextfemale;
    end;
  end;

end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  if modulefolder = 'Arcanum' then
    SaveDialogueFile(arcanumpath + '\data\dlg\' + CurDLG.dlgfilename, CurDLG^)
  else

    SaveDialogueFile(arcanumpath + '\modules\' + modulefolder + '\dlg\' +
      CurDLG.dlgfilename, CurDLG^);
end;

procedure TForm3.delbuttonClick(Sender: TObject);
var
  t: integer;
  messagestr: string;
begin
  if ListView1.selected = nil then
    exit;

  messagestr := 'Are you sure you want to delete this player option?';
  if ListView1.selcount > 1 then
    messagestr :=
      'Are you sure you want to delete the selected player options?';
  if ConfirmPlayerOptionDelete = True then
  begin
    case MessageDlg(messagestr, mtConfirmation, [mbYes, mbNo], 0) of
      mrYes:
        begin
          for t := 0 to ListView1.Items.Count - 1 do
          begin
            if ListView1.Items[t].selected = True then
              DeletePlayerOption(nodeselected, ListView1.Items[t].index);
          end;

          UpdatePlayerOptions;
          UpdateDialogue;
        end;

    end;
  end
  else
  begin

    for t := 0 to ListView1.Items.Count - 1 do
    begin
      if ListView1.Items[t].selected = True then
        DeletePlayerOption(nodeselected, ListView1.Items[t].index);
    end;

  end;

end;

procedure TForm3.insbuttonClick(Sender: TObject);
var
  index: integer;
begin
  if ListView1.selected <> nil then
  begin
    ClearForm;
    ClearData;
    RefreshData;
    form12.showmodal;
    if form12.ModalResult = mrOk then
    begin
      InsertPlayerOption('', nodeselected, ListView1.selected.index);
      index := ListView1.selected.index;
      GetData(CurDLG.nodes[nodeselected].playeroptions[index].conditions,
        CurDLG.nodes[nodeselected].playeroptions[index].actions,
        CurDLG.nodes[nodeselected].playeroptions[index].Text,
        CurDLG.nodes[nodeselected].playeroptions[index].iqtest,
        CurDLG.nodes[nodeselected].playeroptions[index].gendertest,
        CurDLG.nodes[nodeselected].playeroptions[index].linktonode,
        CurDLG.nodes[nodeselected].playeroptions[index].playeroptioncomments);
      UpdatePlayerOptions;
      UpdateDialogue;
    end;
  end;

end;

procedure TForm3.nodedescKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  CurDLG.nodes[nodeselected].nodedesc := nodedesc.Text;

end;

procedure TForm3.ListView1Click(Sender: TObject);
begin
  if ListView1.selected <> nil then
  begin
    mvdownbtn.Enabled := True;
    mvupbtn.Enabled := True;
    insbutton.Enabled := True;
    delbutton.Enabled := True;
    clonebutton.Enabled := True;
    copybtn.Enabled := True;
  end
  else
  begin
    mvdownbtn.Enabled := False;
    mvupbtn.Enabled := False;
    insbutton.Enabled := False;
    delbutton.Enabled := False;
    clonebutton.Enabled := False;
    if playeroptionbuffersize = 0 then
      pastebtn.Enabled := False
    else if playeroptionbuffersize > 0 then
      pastebtn.Enabled := True;
  end;

end;

procedure TForm3.mvdownbtnClick(Sender: TObject);
var
  prev_index: integer;
  movenodeind: integer;
  movetonodeind: integer;
  temp: PlayerOption;
begin
  if ListView1.selected = nil then
  begin
    consoledebug('Nothing is selected! Can''t move down.');
    exit;
  end;

  if ListView1.ItemIndex = ListView1.Items.Count - 1 then
  begin
    ListView1.SetFocus;
    exit;
  end;

  prev_index := ListView1.selected.index;
  movenodeind := ListView1.selected.index;
  movetonodeind := ListView1.selected.index + 1;
  ListView1.ClearSelection;
  temp := CurDLG.nodes[nodeselected].playeroptions[movenodeind]^;
  CurDLG.nodes[nodeselected].playeroptions[movenodeind]^ :=
    CurDLG.nodes[nodeselected].playeroptions[movetonodeind]^;
  CurDLG.nodes[nodeselected].playeroptions[movetonodeind]^ := temp;
  UpdatePlayerOptions;
  ListView1.ItemIndex := movetonodeind;

  ListView1.selected := ListView1.Items[ListView1.ItemIndex];
  // listview1.Scroll(0,listview1.itemindex);
  ListView1.selected.MakeVisible(False);
  ListView1.SetFocus;
  // UpdateItems(listview1.itemindex,listview1.itemindex-1);

end;

procedure TForm3.mvupbtnClick(Sender: TObject);
var
  prev_index: integer;
  movenodeind: integer;
  movetonodeind: integer;
  temp: PlayerOption;
begin
  if ListView1.selected = nil then
  begin
    consoledebug('Nothing is selected! Can''t move up.');
    exit;
  end;

  if ListView1.ItemIndex = 0 then
  begin
    ListView1.SetFocus;
    exit;
  end;

  prev_index := ListView1.selected.index;
  movenodeind := ListView1.selected.index;
  movetonodeind := ListView1.selected.index - 1;
  ListView1.ClearSelection;
  temp := CurDLG.nodes[nodeselected].playeroptions[movenodeind]^;
  CurDLG.nodes[nodeselected].playeroptions[movenodeind]^ :=
    CurDLG.nodes[nodeselected].playeroptions[movetonodeind]^;
  CurDLG.nodes[nodeselected].playeroptions[movetonodeind]^ := temp;
  UpdatePlayerOptions;
  ListView1.ItemIndex := movetonodeind;

  ListView1.selected := ListView1.Items[ListView1.ItemIndex];
  // listview1.Scroll(0,listview1.itemindex);
  ListView1.selected.MakeVisible(False);
  // UpdateItems(listview1.itemindex,listview1.itemindex-1);
  ListView1.SetFocus;

end;

procedure TForm3.useVOClick(Sender: TObject);
begin
  vofield.Enabled := useVO.Checked;
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
  MkDir(voicedir);
  dialoguehasVO := True;
  Button8.Enabled := False;
end;

procedure TForm3.Button9Click(Sender: TObject);
var
  Y: integer;
begin
  for Y := 0 to CurDLG.nodecount - 1 do
  begin
    if CurDLG.nodes[Y].voicefield = '' then
    begin
      consoledebug('Numbering ' + CurDLG.nodes[Y].nodename + ' as ' +
        IntToStr(Y + 1));
      CurDLG.nodes[Y].voicefield := IntToStr(Y + 1);
    end;
  end;
end;

procedure TForm3.RemoveBlankNodesBtnClick(Sender: TObject);
var
  Y, removed, cnt: integer;
  blanklist: array of integer;
begin
  if CurDLG.nodecount = 0 then
  begin
    MessageDlg('No nodes loaded.', mtInformation, [mbOK], 0);
    Exit;
  end;

  // First pass: collect blank node indices WITHOUT modifying anything
  removed := 0;
  for Y := 0 to CurDLG.nodecount - 1 do
  begin
    if (CurDLG.nodes[Y].npctextmale = '') and
       (CurDLG.nodes[Y].npctextfemale = '') and
       (CurDLG.nodes[Y].nodeactions = '') and
       (CurDLG.nodes[Y].PlayerOptioncnt = 0) then
    begin
      SetLength(blanklist, removed + 1);
      blanklist[removed] := Y;
      Inc(removed);
    end;
  end;

  if removed = 0 then
  begin
    MessageDlg('No blank nodes found.', mtInformation, [mbOK], 0);
    Exit;
  end;

  if MessageDlg(Format('Remove %d blank node(s) from the dialogue? ' +
    'These are nodes with no NPC text and no player options ' +
    '(e.g. {N}{}{}{}{}{}{} in the .dlg file).', [removed]),
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  begin
    SetLength(blanklist, 0);
    Exit;
  end;

  // Second pass: dispose and delete blank nodes in REVERSE order so the
  // indices of remaining nodes don't shift while we iterate. The existing
  // DeleteNode procedure handles shifting the rest of the array down.
  for Y := removed - 1 downto 0 do
  begin
    Dispose(CurDLG.nodes[blanklist[Y]]);
    DeleteNode(blanklist[Y]);
  end;
  SetLength(blanklist, 0);

  consoledebug(Format('Removed %d blank node(s) from dialogue.', [removed]));
  // Refresh the tree view
  UpdateDialogue;
end;

procedure TForm3.TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if TreeView1.GetNodeAt(X, Y) = nil then
  begin
    DialogueEditorClearForm;
    TreeView1.selected := nil;
  end;

end;

procedure TForm3.clonebuttonClick(Sender: TObject);
var
  temp: PlayerOption;
begin
  temp := CurDLG.nodes[nodeselected].playeroptions[ListView1.selected.index]^;
  AddPlayerOption(nodeselected, temp.Text);
  CurDLG.nodes[nodeselected].playeroptions
    [CurDLG.nodes[nodeselected].PlayerOptioncnt - 1]^ := temp;
  CurDLG.nodes[nodeselected].playeroptions
    [CurDLG.nodes[nodeselected].PlayerOptioncnt - 1]^.conditions :=
    temp.conditions;
  CurDLG.nodes[nodeselected].playeroptions
    [CurDLG.nodes[nodeselected].PlayerOptioncnt - 1]^.actions := temp.actions;
  UpdatePlayerOptions;

end;

procedure TForm3.copybtnClick(Sender: TObject);
var
  t: integer;
begin
  // playeroptionbuffer := curdlg.nodes[nodeselected].playeroptions[listview1.selected.index]^;
  playeroptionbuffersize := 0;
  for t := 0 to ListView1.Items.Count - 1 do
  begin
    if ListView1.Items[t].selected then
    begin
      // consoledebug('Player option: ' + IntToStr(t) + ' is selected.');
      SetLength(playeroptionbuffer, playeroptionbuffersize + 1);
      playeroptionbuffer[playeroptionbuffersize] := CurDLG.nodes[nodeselected]
        .playeroptions[t]^;
      Inc(playeroptionbuffersize);
    end;

  end;
  ListView1.SetFocus;
  MessageDlg(format('%d player options copied to buffer.',
    [playeroptionbuffersize]), mtInformation, [mbOK], 0);
  pastebtn.Enabled := True;
end;

procedure TForm3.pastebtnClick(Sender: TObject);
var
  t: integer;
begin
  for t := 0 to playeroptionbuffersize - 1 do
  begin
    AddPlayerOption(nodeselected, playeroptionbuffer[t].Text);
    CurDLG.nodes[nodeselected].playeroptions
      [CurDLG.nodes[nodeselected].PlayerOptioncnt - 1]^ :=
      playeroptionbuffer[t];
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

  CurDLG.nodes[nodeselected].isfloatmessage := fltflag.Checked;
  UpdateDialogue;
end;

procedure TForm3.fltgrpstartMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  CurDLG.nodes[nodeselected].floatgroupstartmarker := fltgrpstart.Checked;

end;

procedure TForm3.ListView1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if Button = mbRight then
  begin
    ListView1.IsEditing;
  end;

end;

procedure TForm3.Editplayeroptionregularmode1Click(Sender: TObject);
begin
  GoToPlayerOptionEditor;
end;

procedure TForm3.PlaySpeechClick(Sender: TObject);
var
  voicename: string;
begin
  voicename := arcanumpath + '\Modules\' + modulefolder + '\Sound\Speech\' +
    format('%0.5d', [script_id]) + '\v' + vofield.Text + '_m.mp3';
  PlaySound(voicename);
end;

procedure TForm3.PopupMenu1Popup(Sender: TObject);
begin
  if ListView1.selected = nil then
    Editplayeroptionregularmode1.Enabled := False
  else
    Editplayeroptionregularmode1.Enabled := True;
end;

procedure TForm3.GenSpeechClick(Sender: TObject);
var
  voicename: string;
begin
  if CurDLG.nodes[nodeselected].voicefield <> '' then
    speechlinenum := strtoint(CurDLG.nodes[nodeselected].voicefield);
  form23.maletext.Text := Form3.npctextmale.Text;
  if Form3.npctextfemale.Text <> Form3.npctextmale.Text then
  begin
    form23.femaletext.Text := Form3.npctextfemale.Text;
    form23.file_male.Caption := 'v' + IntToStr(speechlinenum) + '_m.wav';
    form23.file_female.Caption := 'v' + IntToStr(speechlinenum) + '_f.wav';
    form23.AdvSmoothStatusIndicator1.Visible := True;
    form23.AdvSmoothStatusIndicator2.Visible := True;

  end
  else
  begin
    form23.file_male.Caption := 'v' + IntToStr(speechlinenum) + '_m.wav';
    form23.file_female.Caption := '';
    form23.femaletext.Text := '';
    form23.AdvSmoothStatusIndicator1.Caption := '';
    form23.AdvSmoothStatusIndicator2.Caption := '';
    form23.AdvSmoothStatusIndicator1.Visible := True;
    form23.AdvSmoothStatusIndicator2.Visible := False;
  end;

  updatefilestatus;
  form23.outputpath.Caption := voicedir;
  voicename := arcanumpath + '\Modules\' + modulefolder + '\Sound\Speech\' +
    format('%0.5d', [script_id]) + '\v' + vofield.Text + '_m.mp3';

  form23.showmodal;
  if fileexists(voicename) then
  begin

    PlaySpeech.Enabled := True;
  end
  else
  begin
    PlaySpeech.Enabled := False;
  end;
end;

end.
