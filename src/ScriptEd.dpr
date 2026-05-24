program ScriptEd;

uses
  Vcl.Forms,
  pluginapi,
  ArcanumSCRLib in 'ArcanumSCRLib.pas',
  DialogueGenerator in 'DialogueGenerator.pas',
  DialogueGeneratorForm in 'DialogueGeneratorForm.pas',
  ScriptEdWindow in 'ScriptEdWindow.pas' {MainForm},
  compileProgress in 'compileProgress.pas' {Form1},
  LoadOfficialScript in 'LoadOfficialScript.pas' {Form2},
  aboutbox in 'aboutbox.pas' {Form5},
  scriptproperties in 'scriptproperties.pas' {Form4},
  DLGFileIO in 'DLGFileIO.pas',
  DialogueEditor in 'DialogueEditor.pas' {Form3},
  ModuleLoader in 'ModuleLoader.pas',
  LoadModule in 'LoadModule.pas' {Form6},
  MESFileShow in 'MESFileShow.pas' {Form7},
  QuestEditor in 'QuestEditor.pas' {Form8},
  JournalEditor in 'JournalEditor.pas' {Form9},
  ScriptEdConfig in 'ScriptEdConfig.pas',
  ModuleScriptLoad in 'ModuleScriptLoad.pas' {Form10},
  RemapLineNumbers in 'RemapLineNumbers.pas' {Form11},
  PlayerOptionEditor in 'PlayerOptionEditor.pas' {Form12},
  DialogueHeaderEditor in 'DialogueHeaderEditor.pas' {Form13},
  GeneratedPCResponse in 'GeneratedPCResponse.pas' {Form14},
  PrefsScreen in 'PrefsScreen.pas' {Form15},
  GenericSelectorWindow in 'GenericSelectorWindow.pas' {Form16},
  InfoWindow in 'InfoWindow.pas' {Form17},
  ValueSelector in 'ValueSelector.pas' {Form18},
  SelectScriptLine in 'SelectScriptLine.pas' {Form19},
  UncompressModule in 'UncompressModule.pas' {Form20},
  ScriptInfoWindow in 'ScriptInfoWindow.pas' {Form21},
  AdvancedDATOptions in 'AdvancedDATOptions.pas' {Form22},
  CompressionSettings in 'CompressionSettings.pas',
  SpeechGenInterface in 'SpeechGenInterface.pas' {Form23},
  AdvSmoothSplashScreen,
  Vcl.Themes,
  Vcl.Styles,
  MESFileHeader in 'MESFileHeader.pas' {Form24},
  SelectAction in 'SelectAction.pas' {Form25},
  SelectCondition in 'SelectCondition.pas' {Form26},
  SelectCondAndStatement in 'SelectCondAndStatement.pas' {Form27},
  AddMessagesFromLIst in 'AddMessagesFromLIst.pas' {MessageList},
  ActionsEditor in 'ActionsEditor.pas' {Form28},
  InterNPCDialogue in 'InterNPCDialogue.pas' {Form29},
  OllamaLib in 'OllamaLib.pas',
  OllamaGenericDialog in 'OllamaGenericDialog.pas' {Form30},
  ProgressDialogOllama in 'ProgressDialogOllama.pas' {Form31};

{$R *.res}

var
  x: TSplashListItem;
  u, t: Integer;

begin

  Application.Initialize;
  TStyleManager.TrySetStyle('Slate Classico');
  TStyleManager.SystemHooks := [shMenus, shDialogs,shToolTips];
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TForm24, Form24);
  Application.CreateForm(TForm25, Form25);
  Application.CreateForm(TForm26, Form26);
  Application.CreateForm(TForm27, Form27);
  Application.CreateForm(TMessageList, MessageList);
  Application.CreateForm(TForm28, Form28);
  Application.CreateForm(TForm29, Form29);
  Application.CreateForm(TForm30, Form30);
  Application.CreateForm(TForm31, Form31);
  x := MainForm.AdvSmoothSplashScreen1.ListItems.Add;
  x.HTMLText := 'Initializing forms...';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TForm11, Form11);
  Application.CreateForm(TForm12, Form12);
  Application.CreateForm(TForm13, Form13);
  Application.CreateForm(TForm14, Form14);
  Application.CreateForm(TForm15, Form15);
  Application.CreateForm(TForm16, Form16);
  Application.CreateForm(TForm17, Form17);
  Application.CreateForm(TForm18, Form18);
  Application.CreateForm(TForm19, Form19);
  Application.CreateForm(TForm20, Form20);
  Application.CreateForm(TForm21, Form21);
  Application.CreateForm(TForm22, Form22);
  Application.CreateForm(TForm23, Form23);

  MainForm.AdvSmoothSplashScreen1.Refresh;
  for u := 0 to plugincnt - 1 do
  begin
    if dllplugins[u].isspeechgenerator = True then
    begin
      consoledebug('Initializing SAPI5 plugin - "' + dllplugins[u]
        .displayname + '"');
      Form3.GenSpeech.Visible := True;
      executeplugin(dllplugins[u].filename);
    end;
  end;

  for t := 0 to Application.ComponentCount - 1 do
  begin
    if Application.Components[t] is TForm then
    begin
      if TForm(Application.Components[t]).Position <> poMainFormCenter then
      begin
        consoledebug(TForm(Application.Components[t]).Name + ' (' +
          TForm(Application.Components[t]).Caption +
          ') is not centered to Main Form!');
        TForm(Application.Components[t]).Position := poMainFormCenter;
      end;
    end;
  end;

  MainForm.AdvSmoothSplashScreen1.Hide;
  MainForm.JvMRUManager1.Load;
  Application.Run;

end.
