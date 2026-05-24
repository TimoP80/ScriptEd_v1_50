unit ScriptEdWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  arcdatlib, arcanumscrlib, JclFileUtils, SynEditMiscClasses,
  SynEditSearch, Dialogs, Menus,
  cutils, cstrings, ModuleLoader, dlgfileio, SynEditHighlighter,
  SynHighlighterGeneral, XPMan, ComCtrls, StdCtrls,
  strutils_, MesFileIO, SynEdit, JclUnicode, pluginapi, JvExStdCtrls, JvShapedButton,
  ScriptEdConfig, JvExControls, JvDialButton, JvLED, JvSegmentedLEDDisplay,
  dws2Compiler, dws2Debugger,
  dws2Exprs, dws2Symbols, dws2Stack, dws2Comp, dws2VCLGUIFunctions,
  dlgparser, SynCompletionProposal, SynAutoCorrect, dws2StringResult,
  JvComponentBase, JvMRUManager, JvAppStorage, JvFormPlacement,
  JvAppIniStorage, ToolWin, ImgList, VistaAltFixUnit, AdvSmoothSplashScreen;

type
  TMainForm = class(TForm)
    XPManifest1:  TXPManifest;
    ScriptEditor: TSynEdit;
    SynGeneralSyn1: TSynGeneralSyn;
    MainMenu1:    TMainMenu;
    File1:        TMenuItem;
    Help1:        TMenuItem;
    Script1:      TMenuItem;
    Module1:      TMenuItem;
    Plugins1:     TMenuItem;
    Newscript1:   TMenuItem;
    Loadscript1:  TMenuItem;
    Savescript1:  TMenuItem;
    Savescriptas1: TMenuItem;
    N1:           TMenuItem;
    Selectmodule1: TMenuItem;
    N2:           TMenuItem;
    Quit1:        TMenuItem;
    SetscriptID1: TMenuItem;
    Properties1:  TMenuItem;
    N3:           TMenuItem;
    Action1:      TMenuItem;
    Condition1:   TMenuItem;
    Compile1:     TMenuItem;
    OpenDialog1:  TOpenDialog;
    SaveDialog1:  TSaveDialog;
    SynEditSearch1: TSynEditSearch;
    CompilerLog:  TMemo;
    StatusBar1:   TStatusBar;
    Preferences1: TMenuItem;
    Loadofficialscript1: TMenuItem;
    About1:       TMenuItem;
    N4:           TMenuItem;
    Createdialogue1: TMenuItem;
    Removedialogue1: TMenuItem;
    DialogueEditor1: TMenuItem;
    Undocompile1: TMenuItem;
    LoadScript2:  TMenuItem;
    N5:           TMenuItem;
    InternalData1: TMenuItem;
    EditGlobalFlags1: TMenuItem;
    EditGlobalVariables1: TMenuItem;
    EditPCFlags1: TMenuItem;
    EditPCVariables1: TMenuItem;
    EditInternalNames1: TMenuItem;
    EditFactions1: TMenuItem;
    GameText1:    TMenuItem;
    Quests1:      TMenuItem;
    QuestEntries1: TMenuItem;
    HelperScripts1: TMenuItem;
    DelphiWebScriptII1: TDelphiWebScriptII;
    dws2Unit1:    Tdws2Unit;
    dws2StringsUnit1: Tdws2StringsUnit;
    dws2GUIFunctions1: Tdws2GUIFunctions;
    Rumors1:      TMenuItem;
    Editjournalentries1: TMenuItem;
    SynAutoCorrect1: TSynAutoCorrect;
    SynCompletionProposal1: TSynCompletionProposal;
    Description1: TMenuItem;
    StoryState1:  TMenuItem;
    Notes1:       TMenuItem;
    Books1:       TMenuItem;
    Written1:     TMenuItem;
    WorldEdData1: TMenuItem;
    elegrams1:    TMenuItem;
    Newspapers1:  TMenuItem;
    Keys1:        TMenuItem;
    Editreputations1: TMenuItem;
    Recentlyeditedscripts1: TMenuItem;
    JvMRUManager1: TJvMRUManager;
    JvFormStorage1: TJvFormStorage;
    JvAppIniFileStorage1: TJvAppIniFileStorage;
    ToolBar1:     TToolBar;
    ToolButton1:  TToolButton;
    ImageList1:   TImageList;
    ToolButton2:  TToolButton;
    ToolButton3:  TToolButton;
    ToolButton4:  TToolButton;
    ToolButton5:  TToolButton;
    DeveloperTools1: TMenuItem;
    Dumpscriptingfunctionstoatextfile1: TMenuItem;
    Editreputationlog1: TMenuItem;
    EditscriptattachmentpointMESdata1: TMenuItem;
    EditAttachmentPointdescriptions1: TMenuItem;
    CreatenewMESfile1: TMenuItem;
    Editmesfile1: TMenuItem;
    ToolButton6:  TToolButton;
    ToolButton7:  TToolButton;
    Selectmessagefiletoedit1: TMenuItem;
    VistaAltFix1: TVistaAltFix;
    AdvSmoothSplashScreen1: TAdvSmoothSplashScreen;
    procedure Newscript1Click(Sender: TObject);
    procedure pluginexec(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Quit1Click(Sender: TObject);
    procedure Loadscript1Click(Sender: TObject);
    procedure Compile1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Loadofficialscript1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure Savescriptas1Click(Sender: TObject);
    procedure Undocompile1Click(Sender: TObject);
    procedure DialogueEditor1Click(Sender: TObject);
    procedure Selectmodule1Click(Sender: TObject);
    procedure EditGlobalFlags1Click(Sender: TObject);
    procedure EditGlobalVariables1Click(Sender: TObject);
    procedure EditPCFlags1Click(Sender: TObject);
    procedure EditPCVariables1Click(Sender: TObject);
    procedure EditInternalNames1Click(Sender: TObject);
    procedure EditFactions1Click(Sender: TObject);
    procedure QuestLog1Click(Sender: TObject);
    procedure QuestLogDumb1Click(Sender: TObject);
    procedure LoadPASScript(filename: string);
    procedure QuestEntries1Click(Sender: TObject);
    procedure dws2Unit1FunctionsCompileScriptEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsEditorAddLineEval(Info: TProgramInfo);
    procedure ShowHint(Sender: TObject);
    procedure Editjournalentries1Click(Sender: TObject);
    procedure dws2Unit1FunctionsDebugMessageEval(Info: TProgramInfo);
    procedure ScriptEditorKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure ScriptEditorKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure ScriptEditorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure Savescript1Click(Sender: TObject);
    procedure LoadScript2Click(Sender: TObject);
    procedure Createdialogue1Click(Sender: TObject);
    procedure Description1Click(Sender: TObject);
    procedure StoryState1Click(Sender: TObject);
    procedure Books1Click(Sender: TObject);
    procedure Notes1Click(Sender: TObject);
    procedure elegrams1Click(Sender: TObject);
    procedure Newspapers1Click(Sender: TObject);
    procedure Keys1Click(Sender: TObject);
    procedure Preferences1Click(Sender: TObject);
    procedure Editreputations1Click(Sender: TObject);
    procedure dws2Unit1FunctionsAddHelperScriptEval(Info: TProgramInfo);
    procedure ScriptClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action1Click(Sender: TObject);
    procedure Condition1Click(Sender: TObject);
    procedure dws2Unit1FunctionsAddScriptCommandEval(Info: TProgramInfo);
    procedure SetscriptID1Click(Sender: TObject);
    procedure JvMRUManager1Click(Sender: TObject; const RecentName, Caption: string;
      UserData: integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure dws2Unit1FunctionsSelectGlobalFlagEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsSelectGlobalVarEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsSelectQuestEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsSelectRumorEval(Info: TProgramInfo);
    procedure Dumpscriptingfunctionstoatextfile1Click(Sender: TObject);
    procedure dws2Unit1FunctionsSelectPCFlagEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsSelectPCVarEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsSelectInternalNameEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsChooseScriptEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsChooseFocusEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsChooseValueEval(Info: TProgramInfo);
    procedure Editreputationlog1Click(Sender: TObject);
    procedure dws2Unit1FunctionsSelectScriptLineEval(Info: TProgramInfo);
    procedure dws2Unit1VariablesModuleFolderReadVar(var Value: variant);
    procedure dws2Unit1VariablesModuleFolderWriteVar(Value: variant);
    procedure dws2Unit1VariablesArcanumPathReadVar(var Value: variant);
    procedure dws2Unit1VariablesArcanumPathWriteVar(Value: variant);
    procedure dws2Unit1FunctionsSelectLineFromCurrentScriptEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsSelectBasicPrototypeEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsInitializeHelperScriptMenuEval(Info: TProgramInfo);
    procedure EditscriptattachmentpointMESdata1Click(Sender: TObject);
    procedure EditAttachmentPointdescriptions1Click(Sender: TObject);
    procedure CreatenewMESfile1Click(Sender: TObject);
    procedure Editmesfile1Click(Sender: TObject);
    procedure dws2Unit1FunctionsGetEditorCursorPositionEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsInsertScriptLineEval(Info: TProgramInfo);
    procedure dws2Unit1VariablesEditorYPositionReadVar(var Value: variant);
    procedure dws2Unit1VariablesEditorYPositionWriteVar(Value: variant);
    procedure dws2Unit1FunctionsShowScriptInfoEval(Info: TProgramInfo);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure Selectmessagefiletoedit1Click(Sender: TObject);
    procedure dws2Unit1FunctionsChooseFocus_IntegerEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsSelectScriptCallTypeEval(Info: TProgramInfo);
    procedure dws2Unit1FunctionsSelectAttachmentPointEval(Info: TProgramInfo);
    procedure SynCompletionProposal1CodeCompletion(Sender: TObject;
      var Value: string; Shift: TShiftState; Index: integer; EndToken: char);
  private
    { Private declarations }
  public
    procedure RefreshScript;
    { Public declarations }
  end;

  {$I 'version.inc'}
const
  LINE_THEN = 1;
  LINE_ELSE = 2;



type
  timeeventcommand = record
    scriptname: string;
    menuitem:   string;
    shortcut:   string;
  end;


type
  script_line_ref = record
    linenum:        integer;
    line_call_orig: integer;
    line_call_new:  integer;
    line_data_orig: scrline;
    line_type:      integer;
  end;

type
  templatescript = record
    filename:    string;
    description: string;
    category:    string;
    deleted:     boolean;
  end;




var
  scriptlinerefs:     array of script_line_ref;
  scriptlinerefcount: integer;
  currentprog:        TProgram;
  MainForm:           TMainForm;
  templatescripts:    array of ^templatescript;
  tempscnt:           integer;
  builddate:          string;
  script_changed:     boolean;
  voicedir:           string;
  previousline:       string;
  undobuffer:         string;
  dlglines:           array of integer;
  dlglinecnt:         integer;

procedure ChangeNotify;
function SelectFocus: string;
procedure SplashMessage(str: string);

implementation

uses LoadOfficialScript, aboutbox, scriptproperties, DialogueEditor,
  LoadModule, MESFileShow, QuestEditor, JournalEditor, compileProgress,
  ModuleScriptLoad, PrefsScreen, GenericSelectorWindow, InfoWindow,
  MESParser, ValueSelector, SelectScriptLine, ScriptInfoWindow,
  SpeechGenInterface;


{$R *.dfm}

function SelectFocus: string;
begin
  form16.Caption := 'Select object';
  form16.Label1.Caption := 'List of focus strings';
  fillindatafrommesfile(focusdata);
  form16.showmodal;
  if form16.modalresult = mrOk then
    Result := focusdata.entries[form16.JvHTListBox1.ItemIndex].messagestr
  else
  if form16.modalresult = mrCancel then
    Result := '';
end;

function SelectValue: string;
begin
  form18.Caption := 'Select Value type';
  form18.Label1.Caption := 'List of value types';
  ValueselectorFillInDataFromMesFile(ValueData);
  form18.jvhtlistbox1.ItemIndex := 3;
  form18.showmodal;
  if form18.modalresult = mrOk then
  begin
    if form18.JvHTListBox1.ItemIndex = 3 then
      Result := IntToStr(Form18.valuedata.AsInteger)
    else
      Result := valuedata.entries[form18.JvHTListBox1.ItemIndex].messagestr +
        ' ' + IntToStr(Form18.valuedata.AsInteger);
  end else
  if form18.modalresult = mrCancel then
    Result := '';
end;

procedure AddScriptLineRef(linenum: integer; orig: integer; new: integer;
  line_type: integer; scrdata: scrline);
begin
  setlength(scriptlinerefs, scriptlinerefcount + 1);
  scriptlinerefs[scriptlinerefcount].linenum := linenum;
  scriptlinerefs[scriptlinerefcount].line_call_orig := orig;
  scriptlinerefs[scriptlinerefcount].line_call_new := new;
  scriptlinerefs[scriptlinerefcount].line_data_orig := scrdata;
  scriptlinerefs[scriptlinerefcount].line_type := line_type;
  Inc(scriptlinerefcount);
end;

procedure ScriptLineAdd(str: PChar); stdcall;
begin
  MainForm.ScriptEditor.Lines.Add(str);
end;

procedure ScriptFilenameUpdate;
begin
  if script_changed = True then
    mainform.Caption := 'ScriptEd 1.50 - [' + currentscript.filename + '*]'
  else
    mainform.Caption := 'ScriptEd 1.50 - [' + currentscript.filename + ']';
end;

procedure ChangeNotify;
begin
  script_changed := True;
  ScriptFilenameUpdate;
end;

procedure TMainForm.LoadPASScript(filename: string);
var
  t: integer;
var
  scriptdata: TStrings;
  errorlist: string;
begin
  if not (fileexists(filename)) then
  begin
    consoledebug(filename + ' not found! at dir: ' + getcurrentdir);
    messagedlg(format('Error executing script %s:' + #13 + #10 + '' +
      #13 + #10 + 'File does not exist!', [filename]),
      mtError, [mbOK], 0);
    exit;
  end;

  scriptdata := TStringList.Create;
  scriptdata.loadfromfile(filename);
  currentprog := delphiwebscriptii1.compile(scriptdata.Text);
  currentprog.Execute;
  if currentprog.msgs.Count > 0 then
  begin
    errorlist := '[ExecuteScript]' + #13#10 + 'Script data has errors:';
    for t := 0 to currentprog.msgs.Count - 1 do
    begin
      errorlist := errorlist + #13#10 + currentprog.msgs[t].asinfo;
    end;
    messagedlg(errorlist, mtError, [mbOK], 0);
  end;
  currentprog.Free;
  scriptdata.Free;
end;


procedure TMainForm.RefreshScript;
var
  t: integer;
  oldx, oldy: integer;
begin
  try
    oldx := ScriptEditor.CaretX;
    oldy := ScriptEditor.CaretY;
    ScriptEditor.Lines.BeginUpdate;
    ScriptEditor.Clear;
    ScriptEditor.Lines.add(decode_script_header(currentscript^));
    //   showmessage('script linecount = '+inttostr(currentscript^.linecount));
    for t := 0 to CurrentScript.LineCount - 1 do
    begin
      if CommentOnLine(t) <> '' then
      begin
        ScriptEditor.Lines.add(commentonline(t));
        ScriptEditor.Lines.add('');
      end;

      ScriptEditor.Lines.add(IntToStr(t) + '. ' +
        decode_script_line(currentscript.scriptlines[t]^));
    end;
    ScriptEditor.Lines.Text :=
      stringreplace(ScriptEditor.Lines.Text, #13#10, WideCRLf, [rfReplaceAll]);
    ScriptEditor.Lines.add('');
    if script_changed = True then
      mainform.Caption := 'ScriptEd 1.50 - [' + currentscript.filename + '*]'
    else
      mainform.Caption := 'ScriptEd 1.50 - [' + currentscript.filename + ']';
    ScriptEditor.CaretX := oldx;
    ScriptEditor.CaretY := oldy;
    ScriptEditor.Lines.EndUpdate;
    RequestPluginRefresh;
  except
    on e: Exception do
    begin
      MessageDlg('Error while updating script (' + e.message + ')', mtError, [mbOK], 0);
    end
  end;

end;

procedure TMainForm.Newscript1Click(Sender: TObject);
begin
  if script_changed = True then
  begin
    case MessageDlg(format('Save changes to script ''%s'' before creating a new one?',
        [currentscript.filename]), mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        Savescript1Click(nil);

      mrCancel: exit;

    end;
  end;

  initscriptdata;
  CurDLG.nodecount := 0;
  if form3 <> nil then
    dialogueeditorclearform;
  ScriptEditor.Lines.Clear;
  CurrentScript.filename := 'untitled.scr';
  ScriptEditor.Lines.add('description ""');
  ScriptEditor.Lines.add('MAX_LINES_ALLOCATED 10');
  RefreshScript;

  requestpluginrefresh;

end;



procedure TMainForm.pluginexec(Sender: TObject);
begin
  executeplugin(dllplugins[TMenuItem(Sender).tag].filename);
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  StatusBar1.SimpleText := Application.Hint;
end;

procedure SplashMessage(str: string);
var
  x: TSplashListItem;
begin
  x := mainform.AdvSmoothSplashScreen1.ListItems.Add;
  x.HTMLText := str;
     mainform.AdvSmoothSplashScreen1.Refresh;
  end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  date: TDateTime;
  f: integer;
begin
  memo_output := CompilerLog;
  if ParamStr(1) = '/devmode' then
    DeveloperTools1.Visible := True
  else
    developertools1.Visible := False;

  loadconfig;
  Application.OnHint := Showhint;
  SynAutoCorrect1.Items.LoadFromFile(extractfiledir(ParamStr(0)) + '\autocorrect.lst');
  init_dat_logger(getcurrentdir);
  getfilelastwrite(ParamStr(0), date);
  builddate := datetimetostr(date);
  Newscript1Click(nil);

  splashmessage('Loading script compiler data');
  AttachmentPoints := ParseMES('data\AttachmentPoint.mes');
  AttachmentPointDesc := ParseMES('data\AttachmentPointDesc.mes');
  Stats := ParseMES('data\Stats.mes');
  ScriptCallTypes := ParseMES('data\ScriptCallType.mes');
  consoledebug('Initializing opcodes...');
  InitOpcodes;
  consoledebug('Initializing script data...');
  for f := 0 to FocusData.entrycnt - 1 do
  begin
    SynCompletionProposal1.ItemList.Add(focusdata.entries[f].messagestr);
  end;

  for f := 0 to ActionOpcodes.entrycnt - 1 do
  begin
    SynCompletionProposal1.ItemList.Add(ActionOpcodes.entries[f].messagestr);
  end;

  for f := 0 to ConditionOpcodes.entrycnt - 1 do
  begin
    SynCompletionProposal1.ItemList.Add(ConditionOpcodes.entries[f].messagestr);
  end;

  splashmessage('Loading standard plugins');
  scanforplugins('plugins\PLG_*.dll', MainMenu1, Plugins1, mainform.Pluginexec,
    False, -1, 'Scanning for standard ScriptEd Plugins');
  splashmessage('Loading development tool plugins');
  scanforplugins('plugins\DEV_*.dll', MainMenu1, Plugins1, mainform.Pluginexec,
    False, -1, 'Scanning for Development tool Plugins');
  splashmessage('Loading dialogue editor plugins');
  scanforplugins('plugins\DLG_*.dll', MainMenu1, Plugins1, mainform.Pluginexec,
    False, -1, 'Scanning for Dialogue Editor Plugins');

  if arcanum_is_installed = True then
  begin
    splashmessage('Arcanum installed, path: '+arcanumpath);

    QuestXPRewards := ParseMESFromDAT('rules\xp_quest.mes', arcanum3hnd,
      arcanumpath + '\Arcanum3.dat', arcanum3dat);
    Prototypes := ParseMESFromDAT('mes\description.mes', arcanum3hnd,
      arcanumpath + '\Arcanum3.dat', arcanum3dat);
    modulefolder := lastmodulefolder;
    if lastmodulefolder <> '' then
    begin
       splashmessage('Loading module data: "'+modulefolder+'"');
 LoadModuleData(arcanumpath + '\Modules\' + modulefolder);
      Module1.Caption := 'Module: ' + modulefolder;
      Module1.Visible := True;
    end;

  end else
  begin

    Selectmodule1.Visible := False;
  end;


  OpenDialog1.InitialDir := arcanumpath + '\Modules\' + modulefolder + '\scr\';
  SaveDialog1.InitialDir := arcanumpath + '\Modules\' + modulefolder + '\scr\';
  mainform.LoadPASScript('helperscripts\HelperScripts.dws');

end;



procedure TMainForm.Quit1Click(Sender: TObject);
begin
  mainform.Close;
end;

procedure TMainForm.Loadscript1Click(Sender: TObject);
var
  parseresult: boolean;
begin

  if script_changed = True then
  begin
    case MessageDlg(format('Save changes to script ''%s'' before creating a new one?',
        [currentscript.filename]), mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        Savescript1Click(nil);

      mrCancel: exit;

    end;
  end;

  if OpenDialog1.Execute then
  begin
    //showmessage(format('filter index = %d',[opendialog1.FilterIndex]));
    case opendialog1.FilterIndex of
      1:
      begin
        ChDir(extractfiledir(opendialog1.filename));
        LoadScript(opendialog1.FileName, currentscript^);
        chdir('..');
        if fileexists('dlg\' + changefileext(extractfilename(opendialog1.filename),
          '.dlg')) then
        begin
          DialogueEditor1.Enabled := True;
          LoadDialogue('dlg\' +
            changefileext(extractfilename(opendialog1.filename), '.dlg'));
        end else
          ConsoleDebug('dialogue file not present in ' + getcurrentdir);

        RefreshScript;
        RequestPluginRefresh;
        undobuffer := ScriptEditor.Lines.Text;
        SetCurrentDir(extractfiledir(ParamStr(0)));
      end;
      2:
      begin
        //ScriptEditor.Lines.LoadFromFile();
        ParseTextScript(opendialog1.filename, parseresult);
        RefreshScript;
        RequestPluginRefresh;
        undobuffer := ScriptEditor.Lines.Text;
      end;

    end;

  end;

end;

procedure TMainForm.Compile1Click(Sender: TObject);
var
  temp: TStrings;
  parseresult: boolean;
  z, s: integer;
  linenumadjust: integer;
  oldlinecount: integer;
  lineadjust, modifier: integer;
  linegoesto: integer;
  curopcode: integer;
  startTime64, endTime64, frequency64: int64;
  elapsedSeconds: single;
begin
  // keep track of go to lines
  scriptlinerefcount := 0;
  undobuffer := ScriptEditor.Text;

  if Sender <> nil then
  begin
    form1.Show;
    form1.filenamepanel.Caption :=
      'Filename: ' + extractfilename(currentscript.filename);
    form1.linescompiledpanel.Caption := 'Lines compiled: 0';
    form1.statuspanel.Caption := 'Status: Compiling...';

  end;

  if AutoRemapLineNumbers = True then
  begin
    oldlinecount := currentscript.LineCount;
    for s := 0 to CurrentScript.LineCount - 1 do
    begin
      case CurrentScript.ScriptLines[s].thenPart.opcode of
        SA_GOTO:
        begin
          linegoesto := CurrentScript.ScriptLines[s].thenPart.varvalue[0];
          if linegoesto > currentscript.LineCount - 1 then
          begin //   AddScriptLineRef(s, linegoesto, -1, LINE_THEN, nil)
            consoledebug('Not going to track a nonexistent line ' +
              IntToStr(linegoesto) + ', SORRY!');
          end else
            AddScriptLineRef(s, linegoesto, -1, LINE_THEN,
              currentscript.scriptlines[linegoesto].thenpart);
          // consoledebug('Line ' + IntToStr(s) + ' has a go to command with parameter ' + IntToStr(linegoesto));

        end;
      end;

      case CurrentScript.ScriptLines[s].elsePart.opcode of
        SA_GOTO:
        begin
          linegoesto := CurrentScript.ScriptLines[s].elsePart.varvalue[0];
          //  consoledebug('Line ' + IntToStr(s) + ' has a go to command with parameter ' +
          //    IntToStr(CurrentScript.ScriptLines[s].elsePart.varvalue[0]));
          if linegoesto > currentscript.LineCount - 1 then
          begin //   AddScriptLineRef(s, linegoesto, -1, LINE_THEN, nil)
            //   consoledebug('Not going to track a nonexistent line ' + IntToStr(linegoesto) + ', SORRY!');
          end else
            AddScriptLineRef(s, linegoesto, -1, LINE_ELSE,
              currentscript.scriptlines[linegoesto].thenPart);
        end;
      end;

    end;
  end;

  temp := TStringList.Create;
  temp.Text := ScriptEditor.Lines.Text;
  application.ProcessMessages;
  temp.Text := StringReplace(temp.Text, WideCRLF, #13#10, [rfReplaceAll]);
  application.ProcessMessages;
  temp.SaveToFile('temp.txt');
  application.ProcessMessages;
  QueryPerformanceFrequency(frequency64);
  QueryPerformanceCounter(startTime64);
  ParseTextScript('temp.txt', parseresult);

  SaveScript('temp.scr', currentscript^);
  QueryPerformanceCounter(endTime64);
  elapsedSeconds := (endTime64 - startTime64) / frequency64;
  CompilerLog.Lines.add('Script updated - ' + IntToStr(currentscript^.LineCount) +
    ' lines in script.');
  Compilerlog.Lines.add(format('Operation took %0.5f seconds to complete',
    [elapsedseconds]));
  if parseresult = True then
  begin
    form1.statuspanel.Caption := 'Status: OK';

    //  This huge mess of a code block is supposed to remap line numbers
    //  from lines that contain the 'goto line X' command

    //  Horrible mess, but it does its job.

    // Brute force look up - if line count is changed
    // Tries once, if not found, tries again, if still not found
    // goes all the way up or down

    if AutoRemapLineNumbers = True then
    begin
      for s := 0 to scriptlinerefcount - 1 do
      begin
        //    consoledebug('checking line reference: ' + IntToStr(s) + ': from line ' + IntToStr(scriptlinerefs[s].linenum));
        // check also line count and change references accordingly
        lineadjust := -1;
        if oldlinecount > currentscript.LineCount then
        begin
          //    consoledebug('required adjustment due to change in linecount - lines removed');
          modifier := oldlinecount - currentscript.linecount;
          linenumadjust := scriptlinerefs[s].linenum;
          //   consoledebug('modifier = ' + IntToStr(modifier));
          lineadjust := scriptlinerefs[s].line_call_orig - modifier;
          //   consoledebug('new line call should be: ' + IntToStr(lineadjust));
          if linenumadjust >= currentscript.LineCount then
          begin
            //   consoledebug('fucking wack head muthafucka - adjusting linenumadjust to '+inttostr(currentscript.LineCount-1));
            linenumadjust := currentscript.linecount - 1;
          end;

          if scriptlinerefs[s].line_type = LINE_THEN then
          begin
            //   consoledebug('checking opcode for thenline: ' + opcodeactiontostring(currentscript.scriptlines[linenumadjust].thenPart.opcode));
            if currentscript.scriptlines[linenumadjust].thenPart.opcode <> SA_GOTO then
            begin
              //     consoledebug('THIS IS NOT THE FUCKING GOTO LINE going one backward!');
              linenumadjust := scriptlinerefs[s].linenum - 1;
              if currentscript.scriptlines[linenumadjust].thenPart.opcode <> SA_GOTO then
              begin
                //      consoledebug('STILL NOT THE FUCKING GOTO LINE going one backward once more!');
                linenumadjust := linenumadjust - 1;
                //      consoledebug('opcode at pos: ' + OpcodeActionToString(currentscript.scriptlines[linenumadjust].thenPart.opcode));
                if currentscript.scriptlines[linenumadjust].thenPart.opcode <>
                  SA_GOTO then
                begin
                  //        consoledebug('FINE! LETS FUCKING GO UP TO THE FIRST FUCKING LINE DAMMIT!');
                  while (currentscript.scriptlines[linenumadjust].thenPart.opcode <>
                      SA_GOTO) and (linenumadjust >= 0) do
                  begin
                    linenumadjust := linenumadjust - 1;
                  end;
                  //        consoledebug('all done.');
                end;

              end;

            end;

          end;

          if scriptlinerefs[s].line_type = LINE_ELSE then
          begin
            //    consoledebug('checking opcode for elseline: ' + opcodeactiontostring(currentscript.scriptlines[linenumadjust].elsePart.opcode));
            if currentscript.scriptlines[linenumadjust].elsePart.opcode <> SA_GOTO then
            begin
              //      consoledebug('THIS IS NOT THE FUCKING GOTO LINE going one backward!');
              linenumadjust := scriptlinerefs[s].linenum - 1;
              if currentscript.scriptlines[linenumadjust].elsePart.opcode <> SA_GOTO then
              begin
                //        consoledebug('STILL NOT THE FUCKING GOTO LINE going one backward once more!');
                linenumadjust := linenumadjust - 1;
                //        consoledebug('opcode at pos: ' + OpcodeActionToString(currentscript.scriptlines[linenumadjust].elsePart.opcode));
                if currentscript.scriptlines[linenumadjust].elsePart.opcode <>
                  SA_GOTO then
                begin
                  //          consoledebug('FINE! LETS FUCKING GO UP TO THE FIRST FUCKING LINE DAMMIT!');
                  while (currentscript.scriptlines[linenumadjust].elsePart.opcode <>
                      SA_GOTO) and (linenumadjust >= 0) do
                  begin
                    linenumadjust := linenumadjust - 1;
                  end;
                  //           consoledebug('all done.');
                end;

              end;

            end;

          end;


          //  consoledebug('new linenum to adjust should be: ' + IntToStr(linenumadjust));
        end else
        if oldlinecount < currentscript.LineCount then
        begin
          //   consoledebug('required adjustment due to change in linecount - lines added');
          modifier := currentscript.linecount - oldlinecount;
          linenumadjust := scriptlinerefs[s].linenum;

          //   consoledebug('modifier = ' + IntToStr(modifier));
          lineadjust := scriptlinerefs[s].line_call_orig + modifier;
          //    consoledebug('new line call should be: ' + IntToStr(lineadjust));

          if scriptlinerefs[s].line_type = LINE_THEN then
          begin
            if currentscript.scriptlines[linenumadjust].thenPart.opcode <> SA_GOTO then
            begin
              linenumadjust := scriptlinerefs[s].linenum + 1;
              if currentscript.scriptlines[linenumadjust].thenPart.opcode <> SA_GOTO then
              begin
                linenumadjust := linenumadjust + 1;
                if currentscript.scriptlines[linenumadjust].thenPart.opcode <>
                  SA_GOTO then
                begin
                  while (currentscript.scriptlines[linenumadjust].thenPart.opcode <>
                      SA_GOTO) and (linenumadjust < currentscript.LineCount) do
                  begin
                    linenumadjust := linenumadjust + 1;
                  end;
                end;

              end;

            end;

          end;

          if scriptlinerefs[s].line_type = LINE_ELSE then
          begin
            if currentscript.scriptlines[linenumadjust].elsePart.opcode <> SA_GOTO then
            begin
              linenumadjust := scriptlinerefs[s].linenum + 1;
              if currentscript.scriptlines[linenumadjust].elsePart.opcode <> SA_GOTO then
              begin
                linenumadjust := linenumadjust + 1;

                if currentscript.scriptlines[linenumadjust].elsePart.opcode <>
                  SA_GOTO then
                begin
                  while (currentscript.scriptlines[linenumadjust].elsePart.opcode <>
                      SA_GOTO) and (linenumadjust < currentscript.LineCount) do
                  begin
                    linenumadjust := linenumadjust + 1;
                  end;
                  //             consoledebug('all done.');

                end;

                //           consoledebug('opcode at pos: ' + OpcodeActionToString(currentscript.scriptlines[linenumadjust].elsePart.opcode));
              end;

            end;

          end;

          //     consoledebug('new linenum to adjust should be: ' + IntToStr(linenumadjust));

        end;


        linegoesto := scriptlinerefs[s].line_call_orig;
        case scriptlinerefs[s].line_type of
          LINE_THEN:
          begin
            if (lineadjust <> -1) then
            begin
              // linegoesto := lineadjust;
              //        consoledebug('adjusting linenum in line: ' + IntToStr(scriptlinerefs[s].linenum));
              if scriptlinerefs[s].line_data_orig.opcode =
                currentscript.ScriptLines[linegoesto].thenPart.opcode then
              begin
                //          consoledebug('LINE DID NOT FUCKING CHANGE!! NOT DOING ANYTHING');
              end else
              begin
                scriptlinerefs[s].linenum := linenumadjust;
                currentscript.scriptlines[scriptlinerefs[s].linenum].thenPart.VarValue[0]
                := lineadjust;
              end;

            end;

            if scriptlinerefs[s].line_data_orig.opcode <>
              currentscript.ScriptLines[linegoesto].thenPart.opcode then
            begin
              //        consoledebug('THEN_PART: Opcode has changed, let''s find it!');
              //        consoledebug('ORIGINAL OPCODE = ' + OpcodeActionToString(scriptlinerefs[s].line_data_orig.opcode) +
              //          ' new opcode: ' + opcodeactiontostring(currentscript.ScriptLines[linegoesto].thenPart.opcode));
              if linegoesto = 0 then
                z := 0
              else
                z := linegoesto - 1;

              //        consoledebug('line start: ' + IntToStr(z));
              while (z < currentscript.LineCount - 1) do
              begin
                if (currentscript.ScriptLines[z].thenPart.opcode =
                  scriptlinerefs[s].line_data_orig.opcode) and
                  (currentscript.ScriptLines[z].thenPart.VarTypes[0] =
                  scriptlinerefs[s].line_data_orig.VarTypes[0]) and
                  (currentscript.ScriptLines[z].thenPart.VarValue[0] =
                  scriptlinerefs[s].line_data_orig.VarValue[0]) then

                begin
                  //            consoledebug('Original opcode and parameters found - setting line data at line ' + IntToStr(
                  //              scriptlinerefs[s].linenum) + ' to new value ' + IntToStr(z));
                  currentscript.scriptlines[scriptlinerefs[s].linenum].thenPart.VarValue
                    [0] := z;
                  break;
                end;

                Inc(z);
              end;

            end;
          end;
          LINE_ELSE:
          begin

            if (lineadjust <> -1) then
            begin
              if scriptlinerefs[s].line_data_orig.opcode =
                currentscript.ScriptLines[linegoesto].thenPart.opcode then
              begin
              end else
              begin
                scriptlinerefs[s].linenum := linenumadjust;
                currentscript.scriptlines[scriptlinerefs[s].linenum].elsePart.VarValue[0]
                := lineadjust;
              end;

            end;


            if scriptlinerefs[s].line_data_orig.opcode <>
              currentscript.ScriptLines[linegoesto].thenPart.opcode then
            begin
              ///    consoledebug('ELSE_PART: Opcode has changed, let''s find it!');
              //    consoledebug('ORIGINAL OPCODE = ' + OpcodeActionToString(scriptlinerefs[s].line_data_orig.opcode) +
              //      ' new opcode: ' + opcodeactiontostring(currentscript.ScriptLines[linegoesto].thenPart.opcode));
              if linegoesto = 0 then
                z := 0
              else
                z := linegoesto - 1;


              //     consoledebug('line start: ' + IntToStr(z));
              while (z < currentscript.LineCount - 1) do
              begin
                //      consoledebug('parsing at ' + IntToStr(z));
                //      consoledebug(decode_script_line(currentscript.ScriptLines[z]^));
                if (currentscript.ScriptLines[z].thenPart.opcode =
                  scriptlinerefs[s].line_data_orig.opcode) and
                  (currentscript.ScriptLines[z].thenPart.VarTypes[0] =
                  scriptlinerefs[s].line_data_orig.VarTypes[0]) and
                  (currentscript.ScriptLines[z].thenPart.VarValue[0] =
                  scriptlinerefs[s].line_data_orig.VarValue[0]) then

                begin
                  //       consoledebug('Original opcode and parameters found - setting line data at line ' + IntToStr(
                  //          scriptlinerefs[s].linenum) + ' to new value ' + IntToStr(z));
                  currentscript.scriptlines[scriptlinerefs[s].linenum].elsePart.VarValue
                    [0] := z;
                  break;
                end;

                Inc(z);
              end;

            end;
          end;
        end;

      end;
    end;


    // End horrible code mess
    if fileexists('temp.txt') then
    begin
      //   consoledebug('DEBUG - deleting temporary text script', False);
      DeleteFile('temp.txt');
    end;
    if fileexists('temp.scr') then
    begin
      //  consoledebug('DEBUG - deleting temporary binary script', False);
      DeleteFile('temp.scr');
    end;


    RefreshScript;

  end else
  begin
    form1.statuspanel.Caption := 'Status: ERROR';
    for s := 0 to errorlist.Count - 1 do
    begin
      ConsoleDebug(errorlist[s]);
    end;

    compilerlog.Lines.add('Script contains errors.');
  end;

  Undocompile1.Enabled := True;

  temp.Free;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LastModuleFolder := modulefolder;
  SaveConfig;

  halt;
  //  cleanuptempfiles(scriptsdat, extractfiledir(ParamStr(0)) + '\');
end;

procedure TMainForm.Loadofficialscript1Click(Sender: TObject);
begin
  form2.UpdateScriptList;
  form2.showmodal;
  if form2.modalresult = mrOk then
  begin
    //   consoledebug('selected file: ' + selectedfile);
    openfilefromdat(scriptdathandle, scriptsdat, selectedfile,
      arcanumpath + '\data\scr\' + extractfilename(selectedfile));
    // determine where to find the dialogue
    if DirectoryExists(arcanumpath + '\data\dlg') = False then
    begin
      MkDir(arcanumpath + '\data\dlg');
      consoledebug('dlg override folder was created.');
    end;

    if actionopcodesdat.dat_filename <> opcodesdat.dat_filename then
    begin
      //  consoledebug('searching dialogue from arcanum4.dat');
      if getfileindex(actionopcodesdat, '\dlg\' +
        extractfilename(changefileext(selectedfile, '.dlg'))) <> -1 then
      begin
        //     consoledebug('found patched');
        openfilefromdat(actiondathandle, actionopcodesdat, '\dlg\' +
          extractfilename(changefileext(selectedfile, '.dlg')),
          extractfilename(changefileext(selectedfile, '.dlg')));
      end else
      begin
        //     consoledebug('not patched, defaulting to arcanum3.dat');
        openfilefromdat(dathandle, opcodesdat, '\dlg\' +
          extractfilename(changefileext(selectedfile, '.dlg')),
          arcanumpath + 'data\dlg\' +
          extractfilename(changefileext(selectedfile, '.dlg')));
      end;

    end;

    if fileexists(arcanumpath + '\data\dlg\' +
      changefileext(extractfilename(selectedfile), '.dlg')) then
    begin
      DialogueEditor1.Enabled := True;
      LoadDialogue(arcanumpath + '\data\dlg\' +
        changefileext(extractfilename(selectedfile), '.dlg'));
    end else
      consoledebug('This script has no associated dialogue');

    LoadScript(arcanumpath + '\data\scr\' + extractfilename(selectedfile),
      currentscript^);
    RefreshScript;

  end;

end;

procedure TMainForm.About1Click(Sender: TObject);
var
  t: integer;
  version_str: string;
begin
  version_str := format('%d.%d.%d-%s', [version_major, version_minor,
    version_release, version_status]);
  form5.label1.Caption := format(form5.label1.Caption,
    [version_str, builddate, plugincnt, ActionOpcodes.entrycnt,
    ConditionOpcodes.entrycnt]);
  if plugincnt = 0 then
  begin
    form5.noplugins.Visible := True;
    form5.label2.Hide;
    form5.Label3.Hide;

  end else
  begin
    form5.label2.Show;
    form5.Label3.Show;

    form5.noplugins.Visible := False;
  end;

  form5.listbox1.Clear;
  for t := 0 to plugincnt - 1 do
  begin
    form5.listbox1.items.add(extractfilename(dllplugins[t].filename));
  end;
{$IFDEF BETARELEASE}
    form5.Label4.Caption := 'Note: This is a beta release. This means that not everything has been thoroughly tested. If you encounter a bug, please report it by e-email at tpitkane@gmail.com';
{$ENDIF}
  form5.Show;

end;



procedure GetModuleDir(var Data: PChar); stdcall;
begin
  Getmem(Data, length(arcanumpath + '\Modules\' + modulefolder) + 1);
  Data := PChar(arcanumpath + '\Modules\' + modulefolder);
  consoledebug('returned module dir as ' + Data);
end;

procedure GetDialogue(var dlgptr: PDialogueFile); stdcall;
begin
  // consoledebug('Setting script pointer');
  dlgptr := curdlg;
end;


procedure ClearVoiceComboItems; stdcall;
begin
  form23.VoiceList.Clear;
end;

procedure AddVoiceComboItem(str: PChar); stdcall;

begin
  form23.VoiceList.Items.Add(str);
end;

procedure GetScript(var scrptr: PScriptFile); stdcall;
begin
  // consoledebug('Setting script pointer');
  scrptr := CurrentScript;
end;

procedure DebugMessage(Data: PChar); stdcall;
begin
  consoledebug(Data);
end;

procedure EditorFindLine(linenum: integer); stdcall;
var
  theline: integer;
  t: integer;
begin
  theline := -1;
  for t := 0 to mainform.ScriptEditor.Lines.Count - 1 do
  begin
    if pos(IntToStr(linenum) + '.', mainform.ScriptEditor.Lines[t]) <> 0 then
    begin
      theline := t;
      break;
    end;

  end;
  if theline <> -1 then
  begin
    mainform.ScriptEditor.CaretX := 1;
    mainform.ScriptEditor.CaretY := theline + 1;
    mainform.ScriptEditor.EnsureCursorPosVisible;
    mainform.ScriptEditor.SetFocus;
  end;

end;


exports
  GetDialogue,
  AddVoiceComboItem,
  ClearVoiceComboItems,
  EditorFindLine,
  GetModuleDir,
  DebugMessage,
  GetScript,
  ScriptLineAdd;

procedure TMainForm.Properties1Click(Sender: TObject);
begin

  form4.nonmagictrap.Checked :=
    (currentscript.scriptflags and FLAGS_NONMAGICAL_TRAP) <> 0;
  form4.magictrap.Checked := (currentscript.scriptflags and FLAGS_MAGICAL_TRAP) <> 0;
  form4.radius2.Checked := (currentscript.scriptflags and FLAGS_RADIUS_TWO) <> 0;
  form4.radius3.Checked := (currentscript.scriptflags and FLAGS_RADIUS_THREE) <> 0;
  form4.radius5.Checked := (currentscript.scriptflags and FLAGS_RADIUS_FIVE) <> 0;
  form4.teleporttrig.Checked :=
    (currentscript.scriptflags and FLAGS_TELEPORT_TRIGGER) <> 0;
  form4.deathspeech.Checked := (currentscript.scriptflags and FLAGS_DEATH_SPEECH) <> 0;
  form4.autoremove.Checked := (currentscript.scriptflags and FLAGS_AUTO_REMOVING) <> 0;
  form4.surrspeech.Checked := (currentscript.scriptflags and
    FLAGS_SURRENDER_SPEECH) <> 0;
  form4.description.Text := currentscript.Description;
  form4.Counter0.Text := IntToStr(currentscript.Counter0);
  form4.Counter1.Text := IntToStr(currentscript.Counter1);
  form4.Counter2.Text := IntToStr(currentscript.Counter2);
  form4.Counter3.Text := IntToStr(currentscript.Counter3);
  form4.CheckBox1.Checked := scriptflags.BitSet(0);
  form4.CheckBox2.Checked := scriptflags.BitSet(1);
  form4.CheckBox3.Checked := scriptflags.BitSet(2);
  form4.CheckBox4.Checked := scriptflags.BitSet(3);
  form4.CheckBox5.Checked := scriptflags.BitSet(4);
  form4.CheckBox6.Checked := scriptflags.BitSet(5);
  form4.CheckBox7.Checked := scriptflags.BitSet(6);
  form4.CheckBox8.Checked := scriptflags.BitSet(7);
  form4.CheckBox9.Checked := scriptflags.BitSet(8);
  form4.CheckBox10.Checked := scriptflags.BitSet(9);
  form4.CheckBox11.Checked := scriptflags.BitSet(10);
  form4.CheckBox12.Checked := scriptflags.BitSet(11);
  form4.CheckBox13.Checked := scriptflags.BitSet(12);
  form4.CheckBox14.Checked := scriptflags.BitSet(13);
  form4.CheckBox15.Checked := scriptflags.BitSet(14);
  form4.CheckBox16.Checked := scriptflags.BitSet(15);
  form4.CheckBox17.Checked := scriptflags.BitSet(16);
  form4.CheckBox18.Checked := scriptflags.BitSet(17);
  form4.CheckBox19.Checked := scriptflags.BitSet(18);
  form4.CheckBox20.Checked := scriptflags.BitSet(19);
  form4.CheckBox21.Checked := scriptflags.BitSet(20);
  form4.CheckBox22.Checked := scriptflags.BitSet(21);
  form4.CheckBox23.Checked := scriptflags.BitSet(22);
  form4.CheckBox24.Checked := scriptflags.BitSet(23);
  form4.CheckBox25.Checked := scriptflags.BitSet(24);
  form4.CheckBox26.Checked := scriptflags.BitSet(25);
  form4.CheckBox27.Checked := scriptflags.BitSet(26);
  form4.CheckBox28.Checked := scriptflags.BitSet(27);
  form4.CheckBox29.Checked := scriptflags.BitSet(28);
  form4.CheckBox30.Checked := scriptflags.BitSet(29);
  form4.CheckBox31.Checked := scriptflags.BitSet(30);
  form4.CheckBox32.Checked := scriptflags.BitSet(31);

  form4.showmodal;

  if form4.modalresult = mrOk then
  begin
    strpcopy(currentscript.description, form4.description.Text);
    currentscript.ScriptFlags := 0;

    if form4.CheckBox1.Checked then
      scriptflags.SetBit(0)
    else
      scriptflags.ClrBit(0);

    if form4.CheckBox2.Checked then
      scriptflags.SetBit(1)
    else
      scriptflags.ClrBit(1);

    if form4.CheckBox3.Checked then
      scriptflags.SetBit(2)
    else
      scriptflags.ClrBit(2);

    if form4.CheckBox4.Checked then
      scriptflags.SetBit(3)
    else
      scriptflags.ClrBit(3);


    if form4.CheckBox5.Checked then
      scriptflags.SetBit(4)
    else
      scriptflags.ClrBit(4);

    if form4.CheckBox6.Checked then
      scriptflags.SetBit(5)
    else
      scriptflags.ClrBit(5);

    if form4.CheckBox7.Checked then
      scriptflags.SetBit(6)
    else
      scriptflags.ClrBit(6);

    if form4.CheckBox8.Checked then
      scriptflags.SetBit(7)
    else
      scriptflags.ClrBit(7);


    if form4.CheckBox9.Checked then
      scriptflags.SetBit(8)
    else
      scriptflags.ClrBit(8);

    if form4.CheckBox10.Checked then
      scriptflags.SetBit(9)
    else
      scriptflags.ClrBit(9);

    if form4.CheckBox11.Checked then
      scriptflags.SetBit(10)
    else
      scriptflags.ClrBit(10);

    if form4.CheckBox12.Checked then
      scriptflags.SetBit(11)
    else
      scriptflags.ClrBit(11);

    if form4.CheckBox13.Checked then
      scriptflags.SetBit(12)
    else
      scriptflags.ClrBit(12);

    if form4.CheckBox14.Checked then
      scriptflags.SetBit(13)
    else
      scriptflags.ClrBit(13);

    if form4.CheckBox15.Checked then
      scriptflags.SetBit(14)
    else
      scriptflags.ClrBit(14);

    if form4.CheckBox16.Checked then
      scriptflags.SetBit(15)
    else
      scriptflags.ClrBit(15);

    if form4.CheckBox17.Checked then
      scriptflags.SetBit(16)
    else
      scriptflags.ClrBit(16);

    if form4.CheckBox18.Checked then
      scriptflags.SetBit(17)
    else
      scriptflags.ClrBit(17);

    if form4.CheckBox19.Checked then
      scriptflags.SetBit(18)
    else
      scriptflags.ClrBit(18);

    if form4.CheckBox20.Checked then
      scriptflags.SetBit(19)
    else
      scriptflags.ClrBit(19);

    if form4.CheckBox21.Checked then
      scriptflags.SetBit(20)
    else
      scriptflags.ClrBit(20);

    if form4.CheckBox22.Checked then
      scriptflags.SetBit(21)
    else
      scriptflags.ClrBit(21);

    if form4.CheckBox23.Checked then
      scriptflags.SetBit(22)
    else
      scriptflags.ClrBit(22);

    if form4.CheckBox24.Checked then
      scriptflags.SetBit(23)
    else
      scriptflags.ClrBit(23);

    if form4.CheckBox25.Checked then
      scriptflags.SetBit(24)
    else
      scriptflags.ClrBit(24);

    if form4.CheckBox26.Checked then
      scriptflags.SetBit(25)
    else
      scriptflags.ClrBit(25);

    if form4.CheckBox27.Checked then
      scriptflags.SetBit(26)
    else
      scriptflags.ClrBit(26);

    if form4.CheckBox28.Checked then
      scriptflags.SetBit(27)
    else
      scriptflags.ClrBit(27);

    if form4.CheckBox29.Checked then
      scriptflags.SetBit(28)
    else
      scriptflags.ClrBit(28);

    if form4.CheckBox30.Checked then
      scriptflags.SetBit(29)
    else
      scriptflags.ClrBit(29);

    if form4.CheckBox31.Checked then
      scriptflags.SetBit(30)
    else
      scriptflags.ClrBit(30);

    if form4.CheckBox32.Checked then
      scriptflags.SetBit(31)
    else
      scriptflags.ClrBit(31);


    currentscript.Counter0 := StrToInt(form4.Counter0.Text);
    currentscript.Counter1 := StrToInt(form4.Counter1.Text);
    currentscript.Counter2 := StrToInt(form4.Counter2.Text);
    currentscript.Counter3 := StrToInt(form4.Counter3.Text);


    if Form4.nonmagictrap.Checked then
      currentscript.ScriptFlags := currentscript.ScriptFlags + FLAGS_NONMAGICAL_TRAP;

    if Form4.magictrap.Checked then
      currentscript.ScriptFlags := currentscript.ScriptFlags + FLAGS_MAGICAL_TRAP;

    if Form4.teleporttrig.Checked then
      currentscript.ScriptFlags := currentscript.ScriptFlags + FLAGS_TELEPORT_TRIGGER;

    if Form4.surrspeech.Checked then
      currentscript.ScriptFlags := currentscript.ScriptFlags + FLAGS_SURRENDER_SPEECH;

    if Form4.autoremove.Checked then
      currentscript.ScriptFlags := currentscript.ScriptFlags + FLAGS_AUTO_REMOVING;

    if Form4.deathspeech.Checked then
      currentscript.ScriptFlags := currentscript.ScriptFlags + FLAGS_DEATH_SPEECH;

    if Form4.radius2.Checked then
      currentscript.ScriptFlags := currentscript.ScriptFlags + FLAGS_RADIUS_TWO;

    if Form4.radius3.Checked then
      currentscript.ScriptFlags := currentscript.ScriptFlags + FLAGS_RADIUS_THREE;

    if Form4.radius5.Checked then
      currentscript.ScriptFlags := currentscript.ScriptFlags + FLAGS_RADIUS_FIVE;




    RefreshScript;
  end;

end;

procedure TMainForm.Savescriptas1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    case savedialog1.filterindex of
      1:
      begin
        Compile1Click(nil);

        SaveScript(savedialog1.FileName, currentscript^);
        currentscript^.filename := extractfilename(savedialog1.filename);
        RefreshScript;
        script_changed := False;
        ScriptFilenameUpdate;
      end;

      2:
      begin
        ScriptEditor.Lines.savetofile(savedialog1.filename);
      end;

    end;
  end;

end;

procedure TMainForm.Undocompile1Click(Sender: TObject);
begin
  if undobuffer <> '' then
    ScriptEditor.Text := undobuffer
  else
  begin
    consoledebug('Warning: undo buffer is empty - not going to do anything.');
  end;

  undocompile1.Enabled := False;

end;

procedure TMainForm.DialogueEditor1Click(Sender: TObject);

begin
  voicedir := arcanumpath + '\Modules\' + modulefolder + '\Sound\Speech\' +
    copy(extractfilename(currentscript.filename), 1, 5);
  if directoryexists(arcanumpath + '\Modules\' + modulefolder +
    '\Sound\Speech\' + copy(extractfilename(currentscript.filename), 1, 5)) then
  begin
    consoledebug('VoiceOverFolder "' + voicedir + '" exists - disable create button');
    Form3.Button8.Enabled := False;
  end else
  begin
    consoledebug('VoiceOverFolder "' + voicedir +
      '" does not exist - enable create button');
    Form3.Button8.Enabled := True;
  end;

  UpdateDialogue;
  Form3.SyncNPCLines.Visible := AutoReplaceGenderStrings;
  form3.showmodal;
  RefreshScript;
end;

procedure TMainForm.Selectmodule1Click(Sender: TObject);
begin
  form6.CompressButton.Enabled := False;
  form6.showmodal;

  if form6.modalresult = mrOk then
  begin
    if form6.listview1.selected <> nil then
    begin
      modulefolder := form6.ListView1.selected.Caption;
      LoadModuleData(arcanumpath + '\Modules\' + modulefolder);
      Module1.Caption := 'Module: ' + modulefolder;
      Module1.Visible := True;
      OpenDialog1.InitialDir := arcanumpath + '\Modules\' + modulefolder + '\scr\';
      SaveDialog1.InitialDir := arcanumpath + '\Modules\' + modulefolder + '\scr\';
    end;

  end;
end;

procedure TMainForm.EditGlobalFlags1Click(Sender: TObject);
begin
  ShowMSGData(ScriptGlobalFlags);
  form7.showmodal;
  if form7.modalresult = mrOk then
  begin
    ScriptGlobalFlags := currentmsgfile;
    SaveMesFile(scriptglobalflags.msgfilename, ScriptGlobalFlags);
  end;

end;

procedure TMainForm.EditGlobalVariables1Click(Sender: TObject);
begin
  ShowMSGData(ScriptGlobalVars);
  form7.showmodal;
  if form7.modalresult = mrOk then
  begin
    ScriptGLobalVars := currentmsgfile;
    savemesfile(scriptglobalvars.msgfilename, ScriptGlobalVars);
  end;

end;

procedure TMainForm.EditPCFlags1Click(Sender: TObject);
begin
  ShowMSGData(ScriptPCFlags);
  form7.showmodal;
  if form7.ModalResult = mrOk then
  begin
    ScriptPCFlags := currentmsgfile;
    savemesfile(scriptpcflags.msgfilename, ScriptPCFlags);

  end;

end;

procedure TMainForm.EditPCVariables1Click(Sender: TObject);
begin
  ShowMSGData(ScriptPCVars);
  form7.showmodal;
  if form7.ModalResult = mrOk then
  begin
    ScriptPCVars := currentmsgfile;
    savemesfile(scriptpcvars.msgfilename, scriptpcvars);
  end;

end;

procedure TMainForm.EditInternalNames1Click(Sender: TObject);
begin
  ShowMSGData(GameOName);
  form7.showmodal;
  if form7.ModalResult = mrOk then
  begin
    GameOname := currentmsgfile;
    savemesfile(GameOName.msgfilename, GameOName);
  end;
end;

procedure TMainForm.EditFactions1Click(Sender: TObject);
begin
  ShowMSGData(Faction);
  form7.showmodal;
  if form7.ModalResult = mrOk then
  begin
    Faction := currentmsgfile;
    savemesfile(Faction.msgfilename, Faction);
  end;
end;

procedure TMainForm.QuestLog1Click(Sender: TObject);
begin
  ShowMSGData(GameQuestLog);
  form7.showmodal;
end;

procedure TMainForm.QuestLogDumb1Click(Sender: TObject);
begin
  ShowMSGData(GameQuestLogDumb);
  form7.showmodal;

end;

procedure TMainForm.QuestEntries1Click(Sender: TObject);
begin
  UpdateQuestsList;
  Form8.showmodal;
  if form8.modalresult = mrOk then
  begin
    savemesfile(GameQuest.msgfilename, GameQuest);
    savemesfile(GameQuestLog.msgfilename, GameQuestLog);
    savemesfile(GameQuestLogDumb.msgfilename, GameQuestLogDumb);
  end;

end;

procedure TMainForm.dws2Unit1FunctionsCompileScriptEval(Info: TProgramInfo);
begin
  Compile1Click(nil);
end;

procedure TMainForm.dws2Unit1FunctionsEditorAddLineEval(Info: TProgramInfo);
var
  line: string;
begin
  line := info['linedata'];

  line := StringReplace(line, #13#10, WideCRLF, [rfReplaceALl]);

  ScriptEditor.Lines.add(line);

end;

procedure TMainForm.Editjournalentries1Click(Sender: TObject);
begin
  updatejournaldata;
  form9.showmodal;
  if form9.ModalResult = mrOk then
  begin
    SaveMesFile(GameRD_npc_m2m.msgfilename, GameRD_npc_m2m);
    SaveMesFile(GameRD_npc_m2m_dumb.msgfilename, GameRD_npc_m2m_dumb);
  end;

end;

procedure TMainForm.dws2Unit1FunctionsDebugMessageEval(Info: TProgramInfo);
begin
  ConsoleDebug(Info['data']);
end;

procedure TMainForm.ScriptEditorKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
var
  line: integer;
  y: integer;
  res: boolean;
  currentline: string;
begin
  // go up to the line we are in
  line := 0;
  for y := 0 to ScriptEditor.CaretY - 1 do
  begin
    if Pos('.', ScriptEditor.Lines[y]) <> 0 then
      Inc(line);
  end;
  if key = 13 then
  begin
    previousline := ScriptEditor.Lines[ScriptEditor.CaretY - 1];

  end;

  StatusBar1.SimpleText := 'Current scr line: ' + IntToStr(line - 1);

end;

procedure TMainForm.ScriptEditorKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if key = 13 then
  begin
    if (pos('if ', lowercase(previousline)) = 0) and (previousline <> '') and
      (pos('//', previousline) = 0) then
    begin
      ChangeNotify;

      if EnterCompileTrigger = True then
        Compile1Click(nil);

    end;
  end;

end;

procedure TMainForm.ScriptEditorMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  wordcnt: integer;
  wordparamstr, textdata: string;
  scriptslst: TStrings;
  scriptfile: string;
  nodeind, i: integer;
  wordparam, wordpos: integer;
  dlgdata, globalparam, globaltype, thisword, linetext: string;
begin
  // This code processes script text
  // at the current line
  // when right mouse button is pressed

  // Various lookups can be performed here such as:

  // Global Flag
  // Global Variable
  // Quest
  // Internal Name (item, npc, scenery and so on)
  // Prototype

  if Button = mbRight then
  begin
    linetext := ScriptEditor.linetext;
    //consoledebug('Word at mouse cursor: ' + scripteditor.wordatmouse);

    // Check that the line isn't:
    // call script attached to (obj) at point (num) at line (num) with triggerer (obj)

    // this is because we have no idea what is actually attached to that script

    if (pos('change this script', linetext) <> 0) then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for I := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if (thisword = 'script') and
          (extractword(i - 1, linetext, [' ', ':', ',']) = 'to') then
        begin
          wordparamstr := extractword(i + 1, linetext, [' ', ':', ',']);
          wordparam  := StrToInt(wordparamstr);
          globalparam := '';
          // proceed to find the script
          // The scope is Current Module only
          globaltype := 'Script';
          break;
        end;
      end;
    end;



    if (pos('call script', linetext) <> 0) and (pos('attached to', linetext) = 0) then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for I := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if thisword = 'script' then
        begin
          wordparamstr := extractword(i + 1, linetext, [' ', ':', ',']);
          wordparam  := StrToInt(wordparamstr);
          globalparam := '';
          // proceed to find the script
          // The scope is Current Module only
          globaltype := 'Script';
          break;
        end;
      end;
    end;

    if pos('stat', linetext) <> 0 then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for I := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if thisword = 'stat' then
        begin
          wordparamstr := extractword(i + 1, linetext, [' ', ':', ',']);
          if isstranumber(wordparamstr) then
          begin
            wordparam  := StrToInt(wordparamstr);
            globalparam := '';
            globaltype := 'Stat';
            break;
          end;

        end;
      end;
    end;
    if pos('basic prototype', linetext) <> 0 then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for I := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if thisword = 'prototype' then
        begin
          wordparamstr := extractword(i + 1, linetext, [' ', ':', ',']);
          if isstranumber(wordparamstr) then
          begin
            wordparam  := StrToInt(wordparamstr);
            globalparam := '';
            globaltype := 'Proto';
            break;
          end;

        end;
      end;
    end;

    if pos('rumor:', linetext) <> 0 then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for I := 2 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if (thisword = 'rumor') then
        begin
          wordparamstr := extractword(i + 1, linetext, [' ', ':', ',']);
          if IsStrANumber(wordparamstr) then
          begin
            wordparam  := StrToInt(wordparamstr);
            globalparam := '';
            globaltype := 'Rumor';
            break;
          end;
        end;
      end;
    end;


    if pos('quest', linetext) <> 0 then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for I := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if thisword = 'quest' then
        begin
          wordparamstr := extractword(i + 1, linetext, [' ', ':', ',']);
          if IsStrANumber(wordparamstr) then
          begin
            wordparam  := StrToInt(wordparamstr);
            globalparam := '';
            globaltype := 'Quest';
            break;
          end;
        end;
      end;
    end;

    if pos('dialog', linetext) <> 0 then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for I := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if thisword = 'dialog' then
        begin
          wordparamstr := extractword(i + 1, linetext, [' ', ':', ',']);
          if IsStrANumber(wordparamstr) = True then
          begin
            wordparam  := StrToInt(wordparamstr);
            globalparam := '';
            globaltype := 'Dialog';
            break;
          end;

        end;
      end;
    end;

    if pos('float line', linetext) <> 0 then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for I := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if thisword = 'line' then
        begin
          wordparamstr := extractword(i + 1, linetext, [' ', ':', ',']);
          if IsStrANumber(wordparamstr) = True then
          begin
            wordparam  := StrToInt(wordparamstr);
            globalparam := '';
            globaltype := 'FloatMessage';
            break;
          end;

        end;
      end;
    end;


    if pos('item named', linetext) <> 0 then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for I := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if thisword = 'named' then
        begin
          wordparam  := StrToInt(extractword(i + 1, linetext, [' ', ':', ',']));
          globalparam := '';
          globaltype := 'InternalName';
          break;
        end;
      end;
    end;

    if pos('is named', linetext) <> 0 then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for I := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if thisword = 'named' then
        begin
          wordparam  := StrToInt(extractword(i + 1, linetext, [' ', ':', ',']));
          globalparam := '';
          globaltype := 'InternalName';
          break;
        end;
      end;
    end;

    if pos('rename', linetext) <> 0 then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for I := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if thisword = 'as' then
        begin
          wordparam  := StrToInt(extractword(i + 1, linetext, [' ', ':', ',']));
          globalparam := '';
          globaltype := 'InternalName';
          break;
        end;
      end;
    end;

    if pos('global flag', linetext) <> 0 then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for I := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if thisword = 'flag' then
        begin
          wordparam  := StrToInt(extractword(i + 1, linetext, [' ', ':', ',']));
          globalparam := 'Global';
          globaltype := 'Flag';
          break;
        end;
      end;
    end;

    if ScriptEditor.WordAtMouse = 'point' then
    begin
      //globalparam := ScriptEditor.wordatmouse;
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for i := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if (thisword = ScriptEditor.WordAtMouse) and
          (extractword(i - 1, linetext, [' ', ':', ',']) = 'at') then
        begin
          //wordpos := WordPosition(i, linetext, [' ', ':', ',']);
          globaltype := 'AttachmentPoint';
          wordparam  := StrToInt(extractword(i + 1, linetext, [' ', ':', ',']));
          break;
        end;
      end;
    end;


    if ScriptEditor.WordAtMouse = 'Global' then
    begin
      globalparam := ScriptEditor.wordatmouse;
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for i := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if thisword = ScriptEditor.WordAtMouse then
        begin
          //wordpos := WordPosition(i, linetext, [' ', ':', ',']);
          globaltype := extractword(i + 1, linetext, [' ', ':', ',']);
          wordparam  := StrToInt(extractword(i + 2, linetext, [' ', ':', ',']));
          break;
        end;
      end;
    end;

    if (ScriptEditor.WordAtMouse = 'Flag') or (ScriptEditor.WordAtMouse =
      'Variable') then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for i := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if thisword = ScriptEditor.WordAtMouse then
        begin
          //wordpos := WordPosition(i, linetext, [' ', ':', ',']);
          globalparam := extractword(i - 1, linetext, [' ', ':', ',']);
          globaltype := extractword(i, linetext, [' ', ':', ',']);
          wordparam := StrToInt(extractword(i + 1, linetext, [' ', ':', ',']));
          break;
        end;
      end;
    end;

    if (isstranumber(ScriptEditor.WordAtMouse) = True) then
    begin
      wordcnt := wordcount(linetext, [' ', ':', ',']);
      for i := 1 to wordcnt do
      begin
        thisword := extractword(i, linetext, [' ', ':', ',']);
        if thisword = ScriptEditor.WordAtMouse then
        begin
          //wordpos := WordPosition(i, linetext, [' ', ':', ',']);
          globalparam := extractword(i - 2, linetext, [' ', ':', ',']);
          globaltype := extractword(i - 1, linetext, [' ', ':', ',']);
          wordparam := StrToInt(extractword(i, linetext, [' ', ':', ',']));
          break;
        end;
      end;
    end;


    if (globalparam <> '') and (globaltype = 'Variable') then
    begin
      textdata := 'Global Var ' + IntToStr(wordparam) + ' = ' +
        GetMesStringByID(wordparam, ScriptGlobalVars);
    end;

    if (globaltype = 'InternalName') then
    begin
      if GetMesStringByID(wordparam, gameoname) = '' then
        textdata := 'Internal Name ' + IntToStr(wordparam) + ' = ' +
          GetMesStringByID(wordparam, Prototypes)
      else
        textdata := 'Internal Name ' + IntToStr(wordparam) + ' = ' +
          GetMesStringByID(wordparam, gameoname);
      consoledebug('TEXTDATA == ' + textdata);
    end;


    if (globaltype = 'Script') then
    begin
      scriptslst := TStringList.Create;
      if modulefolder = 'Arcanum' then
        AdvBuildFileList(arcanumpath + '\data' + format('\scr\%0.5d*.scr', [wordparam]),
          faAnyFile, scriptslst, amAny)
      else

        AdvBuildFileList(arcanumpath + '\Modules\' + modulefolder +
          format('\scr\%0.5d*.scr', [wordparam]), faAnyFile, scriptslst, amAny);
      if scriptslst.Count > 0 then
      begin
        scriptfile := extractfilename(scriptslst[0]);
        textdata := 'Script ' + IntToStr(wordparam) + ' = ' + scriptfile;
      end else
        textdata := 'Unknown script ' + IntToStr(wordparam);
      scriptslst.Free;

    end;

    if (globaltype = 'Proto') then
    begin
      textdata := 'Prototype ' + IntToStr(wordparam) + ' = ' +
        GetMesStringByID(wordparam, Prototypes);
    end;
    if (globaltype = 'Stat') then
    begin
      textdata := 'Stat ' + IntToStr(wordparam) + ' = ' +
        GetMesStringByID(wordparam, Stats);
    end;
    if (globaltype = 'Dialog') then
    begin
      if curdlg.nodecount > 0 then
      begin
        nodeind := GetNodeIndexWithDLGLine(wordparam);
        dlgdata := curdlg.nodes[nodeind].npctextmale;
        if curdlg.nodes[nodeind].npctextfemale <> curdlg.nodes[nodeind].npctextmale then
        begin
          textdata := 'Dialogue line ' + IntToStr(wordparam) + ':' +
            #13#10'Male PC - ' + #13#10#13#10 + dlgdata + #13#10#13#10 +
            'Female PC - ' + #13#10 + #13#10 + curdlg.nodes[nodeind].npctextfemale;
        end else

          textdata := 'Dialogue line ' + IntToStr(wordparam) + ': ' + #13#10 + dlgdata;
      end;

    end;

    if (globaltype = 'FloatMessage') then
    begin
      if curdlg.nodecount > 0 then
      begin
        nodeind := GetNodeIndexWithDLGLine(wordparam);
        dlgdata := curdlg.nodes[nodeind].npctextmale;
        if curdlg.nodes[nodeind].npctextfemale <> curdlg.nodes[nodeind].npctextmale then
        begin
          textdata := 'Float message ' + IntToStr(wordparam) + ':' +
            #13#10'Male PC - ' + #13#10 + #13#10 + dlgdata + #13#10 +
            'Female PC - ' + #13#10 + #13#10 + curdlg.nodes[nodeind].npctextfemale;
        end else
          textdata := 'Float message ' + IntToStr(wordparam) + ': ' + dlgdata;
      end;

    end;


    if (globaltype = 'AttachmentPoint') then
    begin
      textdata := 'Script Attachment Point ' + IntToStr(wordparam) +
        ' = ' + GetMesStringByID(wordparam, AttachmentPoints);
      textdata := textdata + #13#10 + #13#10 +
        GetMesStringByID(wordparam, AttachmentPointDesc);
    end;

    if (globaltype = 'Rumor') then
    begin
      textdata := 'Rumor ' + IntToStr(wordparam) + ' = ' +
        GetMesStringByID(wordparam * 20, GameRD_npc_m2m);
    end;

    if (globaltype = 'Quest') then
    begin
      textdata := 'Quest ' + IntToStr(wordparam) + ' = ' +
        GetMesStringByID(wordparam, gameQuestLog);
    end;

    if (globalparam <> '') and (globaltype = 'Flag') then
    begin
      textdata := 'Global Flag ' + IntToStr(wordparam) + ' = ' +
        GetMesStringByID(wordparam, ScriptGlobalFlags);
    end;
    if textdata <> '' then
    begin
      form17.Show;
      form17.Infotext.Text := textdata;
      //     consoledebug(textdata);

    end;

  end;

end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  deinitresult: boolean;
begin
  if script_changed = True then
  begin
    case MessageDlg(format('Save changes to script ''%s'' before exiting?',
        [currentscript.filename]), mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
      begin
        Savescript1Click(nil);
        canclose := True;
      end;
      mrNo:
        canclose := True;
      mrCancel: canclose := False;

    end;
  end;
  deinitresult := DeInitPluginLib;
  if deinitresult = True then
  begin
    consoledebug('Closed plugins! quitting!');
    canclose := True;
  end;

  if deinitresult = False then
  begin
    consoledebug('Can''t close yet, something is still open.');
    canclose := False;
  end;

end;

procedure TMainForm.Savescript1Click(Sender: TObject);
begin
  // Compile the script before saving

  Compile1Click(nil);
  if CurrentScript.filename = 'untitled.scr' then
  begin
    Savescriptas1Click(nil);
  end else
  begin
    consoledebug('Script has existing name - save over it!');
    ChDir(arcanumpath + '\Modules\' + modulefolder + '\scr');
    SaveScript(currentscript^.filename, currentscript^);
    script_changed := False;
    chdir(extractfiledir(ParamStr(0)));
  end;
  ScriptFilenameUpdate;

end;

procedure TMainForm.LoadScript2Click(Sender: TObject);
begin
  LoadModuleScriptList;
  form10.showmodal;
  if form10.modalresult = mrOk then
  begin

    ChDir(arcanumpath + '\Modules\' + modulefolder + '\scr');
    LoadScript(selectedmodulescript, currentscript^);
    chdir('..');
    if fileexists('dlg\' + changefileext(selectedmodulescript, '.dlg')) then
    begin
      DialogueEditor1.Enabled := True;
      LoadDialogue('dlg\' + changefileext(selectedmodulescript, '.dlg'));
    end else
      ConsoleDebug('dialogue file not present in ' + getcurrentdir + '\dlg');

    RefreshScript;
    RequestPluginRefresh;
    undobuffer := ScriptEditor.Lines.Text;
    SetCurrentDir(extractfiledir(ParamStr(0)));
    JvMRUManager1.Add(arcanumpath + '\Modules\' + modulefolder +
      '\scr\' + selectedmodulescript, 0);
  end;

end;

procedure Add_DLGLine(ind: integer);
begin
  SetLength(dlglines, dlglinecnt + 1);
  dlglines[dlglinecnt] := ind;
  Inc(dlglinecnt);
end;

procedure BubbleSort(var A: array of integer);
var
  I, J, T: integer;
begin
  for I := High(A) downto Low(A) do
    for J := Low(A) to High(A) - 1 do
      if A[J] > A[J + 1] then
      begin
        //   VisualSwap(A[J], A[J + 1], J, J + 1);
        T := A[J];
        A[J] := A[J + 1];
        A[J + 1] := T;
        //   if Terminated then Exit;
      end;
end;

procedure TMainForm.Createdialogue1Click(Sender: TObject);
var
  DialogueFileName: string;
  dlgnum, t: integer;
  tempsave:  TStrings;
begin
  if currentscript.filename = 'untitled.scr' then
  begin
    MessageDlg('You must save your script first before creating a dialogue file.',
      mtInformation, [mbOK], 0);
    exit;
  end;
  DialogueFileName := arcanumpath + '\Modules\' + modulefolder +
    '\dlg\' + changefileext(currentscript.filename, '.dlg');



  if fileexists(DialogueFileName) = True then
  begin
    case MessageDlg(format('This action will overwrite the existing ' +
        #13 + #10 + 'dialogue file ''%s''' + #13 + #10 + '' + #13 +
        #10 + 'Do you wish to continue?', [DialogueFileName]), mtConfirmation,
        [mbYes, mbNo], 0) of
      mrNo: exit;
    end;
  end else

  if fileexists(DialogueFileName) = False then
  begin
    Consoledebug(DialogueFileName + ' does not exist... Confirm action...');
    case MessageDlg(format('The dialogue file ' + DialogueFileName +
        ' does not seem to exist. ' + #13#10 +
        'If it actually DOES exist, all your work will be lost. do you wish to proceed?',
        [DialogueFileName]), mtConfirmation, [mbYes, mbNo], 0) of
      mrNo: exit;
    end;
  end;


  tempsave := TStringList.Create;
  tempsave.Add('// Dialogue for script ' + currentscript.filename +
    ' of module ' + modulefolder);
  tempsave.add('// Generated by ScriptEd 1.50');
  tempsave.add('//');
  tempsave.add('// Dialog entry points:');



  for t := 0 to currentscript.linecount - 1 do
  begin

    if (CurrentScript.ScriptLines[t].thenPart.opcode = SA_DIALOG) or
      (CurrentScript.ScriptLines[t].elsePart.opcode = SA_DIALOG) or
      (CurrentScript.ScriptLines[t].thenPart.opcode = SA_FLOAT_LINE) or
      (CurrentScript.ScriptLines[t].elsePart.opcode = SA_FLOAT_LINE) then
    begin
      tempsave.add('//');
      tempsave.add('// <<SCRIPT>>: ' +
        StringReplace(decode_script_line(CurrentScript.ScriptLines[t]^),
        #13#10, #13#10 + '// ', [rfReplaceAll]));
    end;

    if CurrentScript.ScriptLines[t].elsePart.opcode = SA_FLOAT_LINE then
    begin

      if CurrentScript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
      begin
        dlgnum := currentscript.scriptlines[t].elsePart.varvalue[0];
        tempsave.add('// Line ' + IntToStr(t) + ' - float message ' + IntToStr(dlgnum));
      end;
    end;

    if CurrentScript.ScriptLines[t].thenPart.opcode = SA_FLOAT_LINE then
    begin
      if CurrentScript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
      begin
        dlgnum := currentscript.scriptlines[t].thenPart.varvalue[0];
        tempsave.add('// Line ' + IntToStr(t) + ' - float message ' + IntToStr(dlgnum));
      end;
    end;

    if CurrentScript.ScriptLines[t].elsePart.opcode = SA_DIALOG then
    begin

      if CurrentScript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
      begin
        dlgnum := currentscript.scriptlines[t].elsePart.varvalue[0];

        tempsave.add('// Line ' + IntToStr(t) + ' - dlg line ' + IntToStr(dlgnum));
      end;
    end;

    if CurrentScript.ScriptLines[t].thenPart.opcode = SA_DIALOG then
    begin
      if CurrentScript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
      begin
        dlgnum := currentscript.scriptlines[t].thenPart.varvalue[0];
        tempsave.add('// Line ' + IntToStr(t) + '  - dlg line ' + IntToStr(dlgnum));
      end;
    end;

  end;
  tempsave.add('//');
  tempsave.add('// ENDHEADER');
  tempsave.add('//');

  // First we add all the dialogue lines
  // to a temporary array

  // Then bubblesort them from the smallest to the largest
  // to maintain a sequential numbering of lines
  // instead of chaotic randomness

  dlglinecnt := 0;

  for t := 0 to currentscript.linecount - 1 do
  begin

    if CurrentScript.ScriptLines[t].elsePart.opcode = SA_DIALOG then
    begin
      if CurrentScript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
      begin
        dlgnum := currentscript.scriptlines[t].elsePart.varvalue[0];
        Add_DLGLine(dlgnum);
        //      tempsave.add('{' + IntToStr(dlgnum) + '}{}{}{}{}{}{}');
      end;
    end;
    if CurrentScript.ScriptLines[t].thenPart.opcode = SA_DIALOG then
    begin
      if CurrentScript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
      begin
        dlgnum := currentscript.scriptlines[t].thenPart.varvalue[0];
        Add_DLGLine(dlgnum);
      end;
    end;

    if CurrentScript.ScriptLines[t].elsePart.opcode = SA_FLOAT_LINE then
    begin
      if CurrentScript.ScriptLines[t].elsePart.VarTypes[0] = 3 then
      begin
        dlgnum := currentscript.scriptlines[t].elsePart.varvalue[0];
        Add_DLGLine(dlgnum);
        //      tempsave.add('{' + IntToStr(dlgnum) + '}{}{}{}{}{}{}');
      end;
    end;
    if CurrentScript.ScriptLines[t].thenPart.opcode = SA_FLOAT_LINE then
    begin
      if CurrentScript.ScriptLines[t].thenPart.VarTypes[0] = 3 then
      begin
        dlgnum := currentscript.scriptlines[t].thenPart.varvalue[0];
        Add_DLGLine(dlgnum);
      end;
    end;

  end;
  Bubblesort(dlglines);
  for t := 0 to dlglinecnt - 1 do
  begin
    dlgnum := dlglines[t];
    tempsave.add('{' + IntToStr(dlgnum) + '}{}{}{}{}{}{}');
    tempsave.add('');
  end;

  tempsave.SaveToFile(arcanumpath + '\Modules\' + modulefolder +
    '\dlg\' + changefileext(currentscript.filename, '.dlg'));
  curdlg.dlgfilename := changefileext(currentscript.filename, '.dlg');
  MessageDlg(format('Dialogue file created as:' + #13 + #10 + '' +
    #13 + #10 + '%s', [arcanumpath + '\Modules\' + modulefolder +
    '\dlg\' + changefileext(currentscript.filename, '.dlg')]), mtInformation, [mbOK], 0);
  tempsave.Free;
  DialogueEditor1.Enabled := True;
  LoadDialogue(arcanumpath + '\Modules\' + modulefolder + '\dlg\' +
    changefileext(currentscript.filename, '.dlg'));
end;

procedure TMainForm.Description1Click(Sender: TObject);
begin
  ShowMSGData(GameDesc);
  form7.showmodal;
  if form7.modalresult = mrOk then
  begin
    gamedesc := currentmsgfile;
    SaveMesFile(GameDesc.msgfilename, GameDesc);
  end;
end;

procedure TMainForm.StoryState1Click(Sender: TObject);
begin
  ShowMSGData(StoryState);
  form7.showmodal;
  if form7.modalresult = mrOk then
  begin
    StoryState := currentmsgfile;
    SaveMesFile(StoryState.msgfilename, StoryState);
  end;
end;

procedure TMainForm.Books1Click(Sender: TObject);
begin
  ShowMSGData(GameBook);
  form7.showmodal;
  if form7.modalresult = mrOk then
  begin
    GameBook := currentmsgfile;
    SaveMesFile(GameBook.msgfilename, GameBook);
  end;
end;

procedure TMainForm.Notes1Click(Sender: TObject);
begin
  ShowMSGData(GameNote);
  form7.showmodal;
  if form7.modalresult = mrOk then
  begin
    GameNote := currentmsgfile;
    SaveMesFile(GameBook.msgfilename, GameNote);
  end;
end;

procedure TMainForm.elegrams1Click(Sender: TObject);
begin
  ShowMSGData(GameTelegram);
  form7.showmodal;
  if form7.modalresult = mrOk then
  begin
    GameTelegram := currentmsgfile;
    SaveMesFile(GameTelegram.msgfilename, GameTelegram);
  end;
end;

procedure TMainForm.Newspapers1Click(Sender: TObject);
begin
  ShowMSGData(GameNewsPaper);
  form7.showmodal;
  if form7.modalresult = mrOk then
  begin
    GameNewsPaper := currentmsgfile;
    SaveMesFile(GameNewsPaper.msgfilename, gamenewspaper);
  end;
end;


procedure TMainForm.ScriptClick(Sender: TObject);
begin
  loadpasscript(extractfiledir(ParamStr(0)) + '\' +
    templatescripts[TMenuItem(Sender).tag].filename);
end;

procedure TMainForm.Keys1Click(Sender: TObject);
begin
  ShowMSGData(GameKey);
  form7.showmodal;
  if form7.modalresult = mrOk then
  begin
    gamekey := currentmsgfile;
    SaveMesFile(GameKey.msgfilename, GameKey);
  end;
end;

procedure TMainForm.Preferences1Click(Sender: TObject);
begin
  form15.scriptrenumber.Checked := AutoRemapLineNumbers;
  form15.playeroptioncommentstyle.Checked := PlayerOptionCommentEOL;
  form15.arcanumpath.Text := arcanumpath;
  form15.newdlgnodestep.AsInteger := LineNumberStep;
  form15.showcmpmodules.Checked := ShowCompressedModules;
  form15.EnterCompileTrigger.Checked := EnterCompileTrigger;
  form15.DebugVerbose.Checked := VerboseDebug;
  form15.IncludeEntryPoints.Checked := IncludeEntryPoints;
  form15.genderspecificreplace.Checked := AutoReplaceGenderStrings;
  form15.autoupdatefemaleline.Checked := AutoUpdateFemaleLine;
  form15.confirmplayeroptiondelete.Checked := ConfirmPlayerOptionDelete;
  refreshgenderstrings;
  RefreshHelperScripts;
  form15.showmodal;
  if form15.ModalResult = mrOk then
  begin
    AutoRemapLineNumbers := form15.scriptrenumber.Checked;
    PlayerOptionCommentEOL := form15.playeroptioncommentstyle.Checked;
    arcanumpath  := form15.arcanumpath.Text;
    LineNumberStep := form15.newdlgnodestep.AsInteger;
    ShowCompressedModules := form15.showcmpmodules.Checked;
    IncludeEntryPoints := form15.IncludeEntryPoints.Checked;
    EnterCompileTrigger := form15.EnterCompileTrigger.Checked;
    VerboseDebug := form15.DebugVerbose.Checked;
    AutoReplaceGenderStrings := form15.genderspecificreplace.Checked;
    AutoUpdateFemaleLine := form15.autoupdatefemaleline.Checked;
    ConfirmPlayerOptionDelete := form15.confirmplayeroptiondelete.Checked;
    WriteHelperScriptLoader;
    LoadPASScript(extractfiledir(ParamStr(0)) + '\helperscripts\HelperScripts.dws');
    saveconfig;

  end;

end;

procedure TMainForm.Editreputations1Click(Sender: TObject);
begin
  ShowMSGData(GameRep);
  form7.showmodal;
  if form7.modalresult = mrOk then
  begin
    GameRep := currentmsgfile;
    SaveMesFile(GameRep.msgfilename, GameRep);
  end;
end;

procedure TMainForm.dws2Unit1FunctionsAddHelperScriptEval(Info: TProgramInfo);
var
  y: integer;
var
  category, s: TMenuItem;
begin

  if fileexists(extractfiledir(ParamStr(0)) + '\' + info['Filename']) = False then
  begin
    consoledebug(format('Warning: Supplied helper script "%s" does not exist.',
      [info['filename']]));
  end;
  setlength(templatescripts, tempscnt + 1);
  new(templatescripts[tempscnt]);
  templatescripts[tempscnt].filename := info['Filename'];
  templatescripts[tempscnt].description := info['Description'];
  templatescripts[tempscnt].category := info['Category'];
  templatescripts[tempscnt].deleted := False;
  s := TMenuItem.Create(mainmenu1);
  s.Caption := templatescripts[tempscnt].description;
  s.tag := tempscnt;
  s.onclick := mainform.scriptclick;
  category := TMenuItem.Create(mainmenu1);
  category.Caption := info['Category'];
  if helperscripts1.find(info['Category']) = nil then
    helperscripts1.add(category)
  else
    category := helperscripts1.find(info['Category']);
  category.add(s);
  Inc(tempscnt);
  if tempscnt > 0 then
    mainform.helperscripts1.Visible :=
      True
  else
    mainform.helperscripts1.Visible :=
      False;

end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  compilerlog.Perform(EM_LineSCROLL, 1, MainForm.compilerlog.Lines.Count);
end;

procedure TMainForm.Action1Click(Sender: TObject);
begin
  MessageDlg('Not implemented yet!' + #13 + #10 + '' + #13 + #10 +
    'A proper script line wizard will be' + #13 + #10 + 'coming up in 1.50-stable!',
    mtInformation, [mbOK], 0);
end;

procedure TMainForm.Condition1Click(Sender: TObject);
begin
  MessageDlg('Not implemented yet!' + #13 + #10 + '' + #13 + #10 +
    'A proper script line wizard will be' + #13 + #10 + 'coming up in 1.50-stable!',
    mtInformation, [mbOK], 0);
end;


procedure DoScriptCommand(opcode, param1, param2, param3, param4,
  param5, param6, param7, param8: integer; Lines: TStrings; position: integer = -1);
var
  line: string;
begin

  case opcode of
    SA_RETURN_SKIP:
      line := 'return and SKIP default';
    SA_RETURN_RUN:
      line := 'return and RUN default';
    SA_GOTO:
      line := 'goto line ' + IntToStr(param1);
    SA_DIALOG:
      line := 'dialog ' + IntToStr(param1);
    SA_REMOVE_SCRIPT:
      line := 'remove this script';
    SA_CHANGE_SCRIPT:
      line := 'change this script to script ' + IntToStr(param1);
    SA_CALL_SCRIPT:
      line := 'call script ' + IntToStr(param1) + ' at line ' +
        IntToStr(param2) + ' with triggerer ' + GetMesStringByID(param3, focusdata) +
        ' and attachee ' + GetMesStringByID(param4, focusdata);
    SA_CALL_SCRIPT_IN_SECONDS:
      line := 'call script ' + IntToStr(param1) + ' at line ' +
        IntToStr(param2) + ' with triggerer ' + GetMesStringByID(param3, focusdata) +
        ' and attachee ' + GetMesStringByID(param4, focusdata) + ' in ' +
        IntToStr(param5) + ' seconds';
    SA_CALL_SCRIPT_AT_SECOND:
      line := 'call script ' + IntToStr(param1) + ' at line ' +
        IntToStr(param2) + ' with triggerer ' + GetMesStringByID(param3, focusdata) +
        ' and attachee ' + GetMesStringByID(param4, focusdata) + ' at second ' +
        IntToStr(param5);

    SA_CALL_SCRIPT_ATTACHED_TO:
      line := 'call script attached to ' + GetMesStringByID(param1, focusdata) +
        ' at point ' + IntToStr(param2) + ' at line ' + IntToStr(param3) +
        ' with triggerer ' + GetMesStringByID(param4, focusdata);
    SA_SET_LOCAL_FLAG:
      line := 'set local flag ' + IntToStr(param1) + ' to true';
    SA_CLEAR_LOCAL_FLAG:
      line := 'clear local flag ' + IntToStr(param1);
    SA_SET_PC_QUEST_STATE:
      line := 'set PC Triggerer quest ' + IntToStr(param1) + ' to state ' +
        IntToStr(param2);
    SA_SET_GLOBAL_QUEST_STATE:
      line := 'set quest ' + IntToStr(param1) + ' to global state ' + IntToStr(param2);
    SA_CRITTER_PARTY_ADD:
      line := 'have critter ' + GetMesStringByID(param1, focusdata) +
        ' become a follower of ' + GetMesStringByID(param2, focusdata);
    SA_CRITTER_PARTY_REMOVE:
      line := 'have critter Attachee stop following his leader';
    SA_CREATE_ITEM_INSIDE_OBJ:
      line := 'create item with basic prototype ' + IntToStr(param1) +
        ' inside ' + GetMesStringByID(param2, focusdata);
  end;
  if position = -1 then
    Lines.add(line)
  else
    Lines.Insert(position, line);
end;


procedure TMainForm.dws2Unit1FunctionsAddScriptCommandEval(Info: TProgramInfo);
var
  position, opcode: integer;
  param1, param2, param3, param4, param5, param6, param7, param8: integer;
begin
  opcode := info['opcode'];
  param1 := info['param1'];
  param2 := info['param2'];
  param3 := info['param3'];
  param4 := info['param4'];
  param5 := info['param5'];
  param6 := info['param6'];
  param7 := info['param7'];
  param8 := info['param8'];
  position := info['pos'];
  DoScriptCommand(opcode, param1, param2, param3, param4, param5, param6, param7,
    param8, ScriptEditor.Lines, position);

end;

procedure TMainForm.SetscriptID1Click(Sender: TObject);
begin
  MessageDlg('Not implemented yet.' + #13 + #10 + '' + #13 + #10 +
    'Script ID should currently be written' + #13 + #10 +
    'manually when you save the script' + #13 + #10 + 'file.' + #13 +
    #10 + '' + #13 + #10 + 'This will be sorted out later to correspond ' +
    #13 + #10 + 'the behaviour of the old ScriptEd.', mtInformation, [mbOK], 0);
end;

procedure TMainForm.JvMRUManager1Click(Sender: TObject;
  const RecentName, Caption: string; UserData: integer);
begin
  consoledebug('Selected: ' + recentname);

  ChDir(extractfiledir(recentname));
  LoadScript(extractfilename(recentname), currentscript^);
  chdir('..');
  if fileexists('dlg\' + changefileext(extractfilename(recentname), '.dlg')) then
  begin
    DialogueEditor1.Enabled := True;
    LoadDialogue('dlg\' + changefileext(extractfilename(recentname), '.dlg'));
  end else
    ConsoleDebug('dialogue file not present in ' + getcurrentdir + '\dlg');

  RefreshScript;
  RequestPluginRefresh;
  undobuffer := ScriptEditor.Lines.Text;
  SetCurrentDir(extractfiledir(ParamStr(0)));

end;

procedure TMainForm.ToolButton1Click(Sender: TObject);
begin
  Compile1Click(toolbutton1);
end;

procedure TMainForm.ToolButton2Click(Sender: TObject);
begin
  DialogueEditor1Click(nil);
end;

procedure TMainForm.ToolButton3Click(Sender: TObject);
begin
  EditGlobalFlags1Click(nil);
end;

procedure TMainForm.ToolButton4Click(Sender: TObject);
begin
  EditGlobalVariables1Click(nil);
end;

procedure TMainForm.dws2Unit1FunctionsSelectGlobalFlagEval(Info: TProgramInfo);
begin
  form16.Caption := 'Select Global Flag';
  form16.Label1.Caption := 'List of global flags in module "' + modulefolder + '"';
  fillindatafrommesfile(scriptglobalflags);
  form16.showmodal;
  if form16.modalresult = mrOk then
    info['result'] := scriptglobalflags.entries[form16.JvHTListBox1.ItemIndex].index
  else
  if form16.modalresult = mrCancel then
    info['result'] := -1;

end;

procedure TMainForm.dws2Unit1FunctionsSelectGlobalVarEval(Info: TProgramInfo);
begin
  form16.Caption := 'Select Global Variable';
  form16.Label1.Caption := 'List of global vars in module "' + modulefolder + '"';
  fillindatafrommesfile(scriptglobalvars);
  form16.showmodal;
  if form16.modalresult = mrOk then
    info['result'] := scriptglobalvars.entries[form16.JvHTListBox1.ItemIndex].index
  else
  if form16.modalresult = mrCancel then
    info['result'] := -1;

end;

procedure TMainForm.dws2Unit1FunctionsSelectQuestEval(Info: TProgramInfo);
begin
  form16.Caption := 'Select Quest';
  form16.Label1.Caption := 'List of quests in module "' + modulefolder + '"';
  fillindatafrommesfile(gamequestlog);
  form16.showmodal;
  if form16.modalresult = mrOk then
    info['result'] := gamequestlog.entries[form16.JvHTListBox1.ItemIndex].index
  else
  if form16.modalresult = mrCancel then
    info['result'] := -1;

end;

procedure TMainForm.dws2Unit1FunctionsSelectRumorEval(Info: TProgramInfo);
begin
  form16.Caption := 'Select Rumor / Journal Entry';
  form16.Label1.Caption := 'List of rumors / journal entries in module "' +
    modulefolder + '"';
  fillindatafrommesfile(GameRD_npc_m2m);
  form16.showmodal;
  if form16.modalresult = mrOk then
    info['result'] := gamerd_npc_m2m.entries[form16.JvHTListBox1.ItemIndex].index div 20
  else
  if form16.modalresult = mrCancel then
    info['result'] := -1;

end;

procedure TMainForm.Dumpscriptingfunctionstoatextfile1Click(Sender: TObject);
var
  constind: integer;
  x: integer;
  lst: TStrings;
begin
  lst := TStringList.Create;
  lst.add('ScriptEd Helper Script Functions Reference');
  lst.add('------------------------------------------');
  lst.add('');
  lst.add('Constants:');
  lst.add('');
  for x := 0 to dws2Unit1.Constants.Count - 1 do
  begin
    //  consoledebug('index of '+dws2unit1.Constants.Items[x].Name+': '+inttostr(TDWS2Constant(dws2unit1.Constants.Items[x]).Value));
    constind := TDWS2Constant(dws2unit1.Constants.Items[x]).Value;
    if pos('SC_', dws2unit1.Constants.Items[x].Name) <> 0 then
    begin
      lst.add('// ' + GetMesStringByID(constind, ConditionOpcodes));
    end;

    if pos('SA_', dws2unit1.Constants.Items[x].Name) <> 0 then
    begin
      lst.add('// ' + GetMesStringByID(constind, ActionOpcodes));
    end;

    lst.Add(dws2unit1.Constants.Items[x].DisplayName);
  end;
  lst.add('');
  lst.add('Global Variables from ScriptEd.exe');
  lst.add('');
  for x := 0 to dws2Unit1.Variables.Count - 1 do
  begin
    lst.Add(dws2unit1.Variables.Items[x].DisplayName);
    lst.add('');
  end;
  lst.add('');
  lst.add('Functions:');
  lst.add('');
  for x := 0 to dws2Unit1.Functions.Count - 1 do
  begin
    lst.Add(dws2unit1.functions.Items[x].DisplayName);
    lst.add('');
    lst.add('<description here>');
    lst.add('');
  end;
  lst.savetofile('ScriptingHelpTemp.txt');
end;

procedure TMainForm.dws2Unit1FunctionsSelectPCFlagEval(Info: TProgramInfo);
begin
  form16.Caption := 'Select PC flag';
  form16.Label1.Caption := 'List of PC flags in module "' + modulefolder + '"';
  fillindatafrommesfile(ScriptPCFlags);
  form16.showmodal;
  if form16.modalresult = mrOk then
    info['result'] := scriptpcflags.entries[form16.JvHTListBox1.ItemIndex].index
  else
  if form16.modalresult = mrCancel then
    info['result'] := -1;

end;

procedure TMainForm.dws2Unit1FunctionsSelectPCVarEval(Info: TProgramInfo);
begin
  form16.Caption := 'Select PC var';
  form16.Label1.Caption := 'List of PC vars in module "' + modulefolder + '"';
  fillindatafrommesfile(ScriptPCVars);
  form16.showmodal;
  if form16.modalresult = mrOk then
    info['result'] := scriptpcVars.entries[form16.JvHTListBox1.ItemIndex].index
  else
  if form16.modalresult = mrCancel then
    info['result'] := -1;

end;

procedure TMainForm.dws2Unit1FunctionsSelectInternalNameEval(Info: TProgramInfo);
begin
  form16.Caption := 'Select internal name';
  form16.Label1.Caption := 'List of internal names in module "' + modulefolder + '"';
  fillindatafrommesfile(GameOName);
  form16.showmodal;
  if form16.modalresult = mrOk then
    info['result'] := GameOName.entries[form16.JvHTListBox1.ItemIndex].index
  else
  if form16.modalresult = mrCancel then
    info['result'] := -1;

end;

procedure TMainForm.dws2Unit1FunctionsChooseScriptEval(Info: TProgramInfo);
var
  script: integer;
begin
  LoadModuleScriptList;
  form10.showmodal;
  if form10.modalresult = mrOk then
  begin
    if isstranumber(copy(selectedmodulescript, 1, 5)) then
    begin
      script := StrToInt(copy(selectedmodulescript, 1, 5));
    end else
      script := -2;
    info['FileNameStorage'] := selectedmodulescript;
    info['result'] := script;

  end else
    script := -1;

end;

procedure TMainForm.dws2Unit1FunctionsChooseFocusEval(Info: TProgramInfo);
begin
  form16.Caption := 'Select Focus string';
  form16.Label1.Caption := 'List of focus strings';
  fillindatafrommesfile(focusdata);
  form16.showmodal;
  if form16.modalresult = mrOk then
    info['result'] := focusdata.entries[form16.JvHTListBox1.ItemIndex].messagestr
  else
  if form16.modalresult = mrCancel then
    info['result'] := '';
end;

procedure TMainForm.dws2Unit1FunctionsChooseValueEval(Info: TProgramInfo);
begin
  form18.Caption := 'Select Value type';
  form18.Label1.Caption := 'List of value types';
  ValueselectorFillInDataFromMesFile(ValueData);
  form18.jvhtlistbox1.ItemIndex := 3;
  form18.showmodal;
  if form18.modalresult = mrOk then
  begin
    if form18.JvHTListBox1.ItemIndex = 3 then
      info['result'] := IntToStr(Form18.valuedata.AsInteger)
    else

      info['result'] := valuedata.entries[form18.JvHTListBox1.ItemIndex].messagestr +
        ' ' + IntToStr(Form18.valuedata.AsInteger);
  end else
  if form18.modalresult = mrCancel then
    info['result'] := '';
end;

procedure TMainForm.Editreputationlog1Click(Sender: TObject);
begin
  ShowMSGData(GameRepLog);
  form7.showmodal;
  if form7.modalresult = mrOk then
  begin
    GameRepLog := currentmsgfile;
    SaveMesFile(GameRepLog.msgfilename, GameRepLog);
  end;
end;

procedure TMainForm.dws2Unit1FunctionsSelectScriptLineEval(Info: TProgramInfo);
begin
  ShowScriptLines(info['srcfile']);
  form19.showmodal;

  if form19.modalresult = mrOk then
  begin
    Info['result'] := selectedline;
  end else
    Info['result'] := -1;

end;

procedure TMainForm.dws2Unit1VariablesModuleFolderReadVar(var Value: variant);
begin
  Value := modulefolder;
end;

procedure TMainForm.dws2Unit1VariablesModuleFolderWriteVar(Value: variant);
begin
  modulefolder := Value;

end;

procedure TMainForm.dws2Unit1VariablesArcanumPathReadVar(var Value: variant);
begin
  Value := arcanumpath;
end;

procedure TMainForm.dws2Unit1VariablesArcanumPathWriteVar(Value: variant);
begin
  arcanumpath := Value;
end;

procedure TMainForm.dws2Unit1FunctionsSelectLineFromCurrentScriptEval(
  Info: TProgramInfo);
begin
  ShowScriptLines_EditorScript;
  form19.showmodal;

  if form19.modalresult = mrOk then
  begin
    Info['result'] := selectedline;
  end else
    Info['result'] := -1;

end;

procedure TMainForm.dws2Unit1FunctionsSelectBasicPrototypeEval(Info: TProgramInfo);
begin
  form16.Caption := 'Select prototype';
  form16.Label1.Caption := 'List of global Arcanum prototypes';
  fillindatafrommesfile(Prototypes);
  form16.showmodal;
  if form16.modalresult = mrOk then
    info['result'] := Prototypes.entries[form16.JvHTListBox1.ItemIndex].index
  else
  if form16.modalresult = mrCancel then
    info['result'] := -1;

end;

procedure TMainForm.dws2Unit1FunctionsInitializeHelperScriptMenuEval(Info: TProgramInfo);
begin
  tempscnt := 0;
  mainform.HelperScripts1.Clear;
end;

procedure TMainForm.EditscriptattachmentpointMESdata1Click(Sender: TObject);
begin
  ShowMSGData(AttachmentPoints);
  form7.showmodal;
  if form7.modalresult = mrOk then
  begin
    AttachmentPoints := currentmsgfile;
    SaveMesFile(AttachmentPoints.msgfilename, AttachmentPoints);
  end;

end;

procedure TMainForm.EditAttachmentPointdescriptions1Click(Sender: TObject);
begin
  ShowMSGData(AttachmentPointDesc);
  form7.showmodal;
  if form7.modalresult = mrOk then
  begin
    AttachmentPointDesc := currentmsgfile;
    SaveMesFile(AttachmentPointDesc.msgfilename, AttachmentPointDesc);
  end;
end;

procedure TMainForm.CreatenewMESfile1Click(Sender: TObject);
var
  thesavedialog: TSaveDialog;
begin
  thesavedialog := TSaveDialog.Create(MainForm);

  thesavedialog.Filter := 'MES Files (*.mes)|*.mes|All files (*.*)|*.*';
  thesavedialog.DefaultExt := 'mes';
  thesavedialog.InitialDir := extractfiledir(ParamStr(0)) + '\data';
  if thesavedialog.Execute then
  begin
    MesFileGeneric.entrycnt := 0;
    MesFileGeneric.msgfilename := thesavedialog.FileName;
    AddMesEntry(0, 'New message string', MesFileGeneric);
    SaveMesFile(mesfilegeneric.msgfilename, MesFileGeneric);
    ShowMSGData(MesFileGeneric);
    form7.showmodal;
    if form7.modalresult = mrOk then
    begin
      MesFileGeneric := currentmsgfile;
      SaveMesFile(MesFileGeneric.msgfilename, MesFileGeneric);
    end;
  end;

  //MesFileGeneric.msgfilename :=

end;

procedure TMainForm.Editmesfile1Click(Sender: TObject);
var
  theopendialog: TOpenDialog;
begin
  theopendialog := TOpenDialog.Create(MainForm);

  theopendialog.Filter := 'MES Files (*.mes)|*.mes|All files (*.*)|*.*';
  theOpendialog.InitialDir := extractfiledir(ParamStr(0)) + '\data';
  if theopendialog.Execute then
  begin
    MesFileGeneric := ParseMES(theopendialog.filename);
    ShowMSGData(MesFileGeneric);
    form7.showmodal;
    if form7.modalresult = mrOk then
    begin
      MesFileGeneric := currentmsgfile;
      SaveMesFile(MesFileGeneric.msgfilename, MesFileGeneric);
    end;
  end;
end;

procedure TMainForm.dws2Unit1FunctionsGetEditorCursorPositionEval(Info: TProgramInfo);
begin
  info['result'] := ScriptEditor.CaretY;
end;

procedure TMainForm.dws2Unit1FunctionsInsertScriptLineEval(Info: TProgramInfo);
begin
  ScriptEditor.Lines.Insert(info['pos'], info['line']);
end;

procedure TMainForm.dws2Unit1VariablesEditorYPositionReadVar(var Value: variant);
begin
  Value := ScriptEditor.CaretY;
end;

procedure TMainForm.dws2Unit1VariablesEditorYPositionWriteVar(Value: variant);
begin
  ScriptEditor.CaretY := Value;
end;

procedure TMainForm.dws2Unit1FunctionsShowScriptInfoEval(Info: TProgramInfo);
begin
  form21.scriptname.Caption := info['name'];
  form21.description.Caption := info['description'];
  form21.author.Caption := info['author'];
  form21.infotext.Text  := info['infotext'];
  form21.showmodal;

end;

procedure TMainForm.ToolButton6Click(Sender: TObject);
begin
  EditInternalNames1Click(nil);
end;

procedure TMainForm.ToolButton7Click(Sender: TObject);
begin
  Description1Click(nil);

end;

procedure TMainForm.Selectmessagefiletoedit1Click(Sender: TObject);
var
  thefile: string;
begin
  form16.Caption := 'Select MES file';
  form16.Label1.Caption := 'List of MES files in module ' + modulefolder;
  GetAllModuleMesFiles;
  form16.ShowModal;
  if form16.modalresult = mrOk then
  begin
    if form16.jvhtlistbox1.ItemIndex = -1 then
      exit;
    thefile := form16.JvHTListBox1.Items[form16.JvHTListBox1.ItemIndex];

    MesFileGeneric := ParseMES(arcanumpath + '\Modules\' + modulefolder + '\' + thefile);
    ShowMSGData(MesFileGeneric);
    form7.showmodal;
    if form7.modalresult = mrOk then
    begin
      MesFileGeneric := currentmsgfile;
      SaveMesFile(MesFileGeneric.msgfilename, MesFileGeneric);
    end;
  end;

end;

procedure TMainForm.dws2Unit1FunctionsChooseFocus_IntegerEval(Info: TProgramInfo);
begin
  form16.Caption := info['Caption'];
  form16.Label1.Caption := 'List of focus types';
  fillindatafrommesfile(focusdata);
  form16.showmodal;
  if form16.modalresult = mrOk then
    info['result'] := focusdata.entries[form16.JvHTListBox1.ItemIndex].index
  else
  if form16.modalresult = mrCancel then
    info['result'] := -1;
end;

procedure TMainForm.dws2Unit1FunctionsSelectScriptCallTypeEval(Info: TProgramInfo);
var
  tempdata: integer;
begin
  form16.Caption := 'Select script call type';
  form16.Label1.Caption := 'List of script call types';
  fillindatafrommesfile(ScriptCallTypes);
  form16.showmodal;
  if form16.modalresult = mrOk then
  begin
    tempdata := ScriptCallTypes.entries[form16.JvHTListBox1.ItemIndex].index;
    case tempdata of
      0:
        info['result'] := SA_CALL_SCRIPT;
      1:
        info['result'] := SA_CALL_SCRIPT_IN_SECONDS;
      2:
        info['result'] := SA_CALL_SCRIPT_AT_SECOND;
      3:
        info['result'] := SA_CALL_SCRIPT_ATTACHED_TO;
    end;

  end else
  if form16.modalresult = mrCancel then
    info['result'] := -1;

end;

procedure TMainForm.dws2Unit1FunctionsSelectAttachmentPointEval(Info: TProgramInfo);
begin
  form16.Caption := 'Select attachment point';
  form16.Label1.Caption := 'List of script attachment points';
  fillindatafrommesfile(AttachmentPoints);
  form16.showmodal;
  if form16.modalresult = mrOk then
    info['result'] := AttachmentPoints.entries[form16.JvHTListBox1.ItemIndex].index
  else
  if form16.modalresult = mrCancel then
    info['result'] := -1;
end;

procedure TMainForm.SynCompletionProposal1CodeCompletion(Sender: TObject;
  var Value: string; Shift: TShiftState; Index: integer; EndToken: char);
var
  temp, replacestr: string;
  opcode, prmtype, i, paramcount: integer;
begin
  temp := Value;
  paramcount := GetOpcodeParamCount(temp);
  opcode := GetMesIDByString(temp, ActionOpcodes);
  if opcode = -1 then
  begin
    opcode := GetMesIDByString(temp, ConditionOpcodes);

  end;
  i := 1;
  while i <= paramcount do
  begin
    prmtype := GetOpcodeParamType(i, temp);
    case prmtype of
      PARAM_TYPE_OBJ:
      begin
        replacestr := selectfocus;
        Value := StringReplace(Value, '(obj)', replacestr, []);
      end;
      PARAM_TYPE_NUM:
      begin
        replacestr := SelectValue;
        Value := StringReplace(Value, '(num)', replacestr, []);
      end;
    end;
    Inc(i);
  end;

end;

end.
