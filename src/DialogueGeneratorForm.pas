unit DialogueGeneratorForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  OllamaLib, Clipbrd;

type
  TFormDialogueGen = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EditNodeDesc: TEdit;
    MemoPlayerText: TMemo;
    ButtonGenNPC: TButton;
    MemoNPCResult: TMemo;
    ButtonCopyNPC: TButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    EditContext: TEdit;
    ButtonGenOptions: TButton;
    MemoOptionsResult: TMemo;
    ButtonCopyOptions: TButton;
    ButtonCreateNodes: TButton;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    EditJournalTopic: TEdit;
    CheckBoxSmart: TCheckBox;
    ButtonGenJournal: TButton;
    MemoJournalResult: TMemo;
    ButtonCopyJournal: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonGenNPCClick(Sender: TObject);
    procedure CheckBoxContinueClick(Sender: TObject);
    procedure ButtonGenOptionsClick(Sender: TObject);
    procedure ButtonCreateNodesClick(Sender: TObject);
    procedure ButtonGenJournalClick(Sender: TObject);
    procedure ButtonCopyNPCClick(Sender: TObject);
    procedure ButtonCopyOptionsClick(Sender: TObject);
    procedure ButtonCopyJournalClick(Sender: TObject);
  private
    FAPI: TOllamaAPIBase;
    FModel: string;
    procedure SetAPI(API: TOllamaAPIBase; const Model: string);
  public
    class procedure Execute(API: TOllamaAPIBase; const Model: string);
  end;

var
  FormDialogueGen: TFormDialogueGen;

implementation

{$R *.dfm}

uses
  DialogueGenerator, DLGFileIO, ScriptEdConfig, DLGParser, DialogueEditor;

{ TFormDialogueGen }

class procedure TFormDialogueGen.Execute(API: TOllamaAPIBase; const Model: string);
begin
  with Create(nil) do
  try
    SetAPI(API, Model);
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormDialogueGen.SetAPI(API: TOllamaAPIBase; const Model: string);
begin
  FAPI := API;
  FModel := Model;
end;

procedure TFormDialogueGen.FormCreate(Sender: TObject);
begin
  // No initialization needed
end;

procedure TFormDialogueGen.CheckBoxContinueClick(Sender: TObject);
begin
  MemoExistingNPC.Enabled := CheckBoxContinue.Checked;
  MemoExistingPlayer.Enabled := CheckBoxContinue.Checked;
  LabelExistingNPC.Enabled := CheckBoxContinue.Checked;
  LabelExistingPlayer.Enabled := CheckBoxContinue.Checked;
end;

procedure TFormDialogueGen.ButtonGenNPCClick(Sender: TObject);
var
  NodeDesc, PlayerText, Response: string;
begin
  NodeDesc := Trim(EditNodeDesc.Text);
  PlayerText := Trim(MemoPlayerText.Text);
  if (NodeDesc = '') or (PlayerText = '') then
  begin
    ShowMessage('Please enter both NPC description and player text.');
    Exit;
  end;
  if CheckBoxContinue.Checked then
    Response := TDialogueGenerator.GenerateNPCResponseFromContext(FAPI, FModel,
      Trim(MemoExistingNPC.Text), Trim(MemoExistingPlayer.Text), PlayerText)
  else
    Response := TDialogueGenerator.GenerateNPCResponse(FAPI, FModel, NodeDesc, PlayerText);
  MemoNPCResult.Text := Response;
end;

procedure TFormDialogueGen.ButtonGenOptionsClick(Sender: TObject);
var
  Context: string;
  Options: TStringList;
  i: Integer;
begin
  Context := Trim(EditContext.Text);
  if Context = '' then
  begin
    ShowMessage('Please enter context for player options.');
    Exit;
  end;
  Options := TDialogueGenerator.GeneratePlayerOptions(FAPI, FModel, Context);
  try
    MemoOptionsResult.Clear;
    for i := 0 to Options.Count - 1 do
      MemoOptionsResult.Lines.Add(IntToStr(i+1) + '. ' + Options[i]);
  finally
    Options.Free;
  end;
end;

procedure TFormDialogueGen.ButtonCreateNodesClick(Sender: TObject);
var
  Context: string;
  Options: TStringList;
  i, newNodeIndex: Integer;
  OptionText, LinkText: string;
  P: Integer;
begin
  if nodeselected < 0 then
  begin
    ShowMessage('Please select a dialogue node in the editor first.');
    Exit;
  end;
  Context := Trim(EditContext.Text);
  if Context = '' then
  begin
    ShowMessage('Please enter context for player options.');
    Exit;
  end;
  Options := TDialogueGenerator.GeneratePlayerOptionsWithLinks(FAPI, FModel, Context);
  try
    for i := 0 to Options.Count - 1 do
    begin
      OptionText := Options[i];
      P := Pos('=> NODE:', OptionText);
      if P > 0 then
      begin
        LinkText := Trim(Copy(OptionText, P + 8, Length(OptionText)));
        OptionText := Trim(Copy(OptionText, 1, P - 1));
      end
      else
        LinkText := '';
      AddNode(Format('Node%0.3d', [CurDLG.nodecount + 1]));
      newNodeIndex := CurDLG.nodecount - 1;
      if newNodeIndex = 0 then
        CurDLG.nodes[newNodeIndex].start_index := 1
      else
        CurDLG.nodes[newNodeIndex].start_index := CurDLG.nodes[newNodeIndex - 1].start_index + LineNumberStep;
      CurDLG.nodes[newNodeIndex].nodename := LinkText;
      AddPlayerOption(nodeselected, OptionText);
      CurDLG.nodes[nodeselected].playeroptions[CurDLG.nodes[nodeselected].PlayerOptioncnt - 1].linktonode := 
        CurDLG.nodes[newNodeIndex].start_index;
    end;
    MemoOptionsResult.Clear;
    for i := 0 to Options.Count - 1 do
      MemoOptionsResult.Lines.Add(IntToStr(i+1) + '. ' + Options[i]);
    UpdatePlayerOptions;
    UpdateDialogue;
  finally
    Options.Free;
  end;
end;

procedure TFormDialogueGen.ButtonGenJournalClick(Sender: TObject);
var
  Topic: string;
  Response: string;
begin
  Topic := Trim(EditJournalTopic.Text);
  if Topic = '' then
  begin
    ShowMessage('Please enter a journal topic.');
    Exit;
  end;
  Response := TDialogueGenerator.GenerateJournalEntry(FAPI, FModel, Topic, CheckBoxSmart.Checked);
  MemoJournalResult.Text := Response;
end;

procedure TFormDialogueGen.ButtonCopyNPCClick(Sender: TObject);
begin
  Clipboard.AsText := MemoNPCResult.SelText;
  if MemoNPCResult.SelLength > 0 then
    ShowMessage('Copied to clipboard.')
  else
    ShowMessage('Select text first or copy all with Ctrl+A then Ctrl+C.');
end;

procedure TFormDialogueGen.ButtonCopyOptionsClick(Sender: TObject);
begin
  Clipboard.AsText := MemoOptionsResult.SelText;
  if MemoOptionsResult.SelLength > 0 then
    ShowMessage('Copied to clipboard.')
  else
    ShowMessage('Select text first or copy all with Ctrl+A then Ctrl+C.');
end;

procedure TFormDialogueGen.ButtonCopyJournalClick(Sender: TObject);
begin
  Clipboard.AsText := MemoJournalResult.SelText;
  if MemoJournalResult.SelLength > 0 then
    ShowMessage('Copied to clipboard.')
  else
    ShowMessage('Select text first or copy all with Ctrl+A then Ctrl+C.');
end;

end.
