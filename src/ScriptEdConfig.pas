unit ScriptEdConfig;

interface

uses System.SysUtils, System.IniFiles;

type
  genderstringdata = record
    male: String;
    female: String;
  end;

var
  cfg: TInifile;
  conditions_data: TInifile;
  actions_data: TInifile;
  AutoRemapLineNumbers: Boolean;
  LastModuleFolder: String;
  arcanumpath: String;
  // this setting is autodetected
  MainGameEditingMode: Boolean;
  EnterCompileTrigger: Boolean;
  genderstrings: array of ^genderstringdata;
  genderstringcnt: Integer;
  AutoReplaceGenderStrings: Boolean;
  PlayerOptionCommentEOL: Boolean;
  VerboseDebug: Boolean;
  LineNumberStep: Integer;
  ShowCompressedModules: Boolean;
  AutoUpdateFemaleLine: Boolean;
  IncludeEntryPoints: Boolean;
  ConfirmPlayerOptionDelete: Boolean;
  UseDBMaker: boolean;
  AutoIncrementVONumber: boolean;
  OllamaModel: string;
  AutoExpand: boolean;
  OllamaEnabled: boolean;
  OllamaCloudEnabled: boolean;
  OllamaCloudApiKey: string;
  OllamaCloudUrl: string;
  OllamaProvider: string; // 'Local' or 'Cloud'

procedure LoadConfig;
procedure saveConfig;
procedure AddGenderString(male, female: String);
procedure DeleteGenderString(ind: Integer);

implementation

uses ArcanumSCRLIB;

procedure DeleteGenderString(ind: Integer);
var
  t: Integer;
begin
  if ind = genderstringcnt - 1 then
  begin
    genderstringcnt := genderstringcnt - 1;
    exit;
  end;
  for t := ind to genderstringcnt - 1 do
  begin
    genderstrings[t] := genderstrings[t + 1];
  end;
  genderstringcnt := genderstringcnt - 1;

end;

procedure AddGenderString(male, female: String);
begin
  setlength(genderstrings, genderstringcnt + 1);
  new(genderstrings[genderstringcnt]);
  genderstrings[genderstringcnt].male := male;
  genderstrings[genderstringcnt].female := female;
  Inc(genderstringcnt);
end;

procedure saveConfig;
var
  g: Integer;
begin

   cfg.WriteString('General', 'DAT_Path', arcanumpath);
   cfg.WriteString('Ollama', 'OllamaModel', OllamaModel);
   cfg.WriteBool('Ollama', 'OllamaEnabled', OllamaEnabled);
   cfg.WriteString('OllamaCloud', 'OllamaCloudUrl', OllamaCloudUrl);
   cfg.WriteString('OllamaCloud', 'OllamaCloudApiKey', OllamaCloudApiKey);
   cfg.WriteBool('OllamaCloud', 'OllamaCloudEnabled', OllamaCloudEnabled);
   cfg.WriteString('Ollama', 'OllamaProvider', OllamaProvider);
  cfg.WriteString('General', 'LastModuleDir', LastModuleFolder);
  cfg.WriteBool('General', 'VerboseDebug', VerboseDebug);
  cfg.WriteBool('General', 'EnterCompileTrigger', EnterCompileTrigger);
  cfg.WriteBool('General', 'RemapLineNumbers', AutoRemapLineNumbers);
  cfg.WriteBool('General', 'IncludeEntryPoints', IncludeEntryPoints);
  cfg.WriteBool('General', 'PlayerOptionCommentEOL', PlayerOptionCommentEOL);
  cfg.WriteBool('General', 'ConfirmPlayerOptionDelete',
    ConfirmPlayerOptionDelete);
  cfg.WriteBool('General', 'ShowCompressedModules', ShowCompressedModules);
  cfg.WriteInteger('General', 'DLGNodeNumberStep', LineNumberStep);

  cfg.WriteBool('General', 'AutoUpdateFemaleLine', AutoUpdateFemaleLine);
  cfg.WriteBool('General','UseDBMaker', UseDBMaker);
  cfg.WriteBool('General','ExpandDialogueTreeNodes', autoexpand);
  cfg.WriteBool('General','AutoVONumbersOnNewNode', AutoIncrementVONumber);
  cfg.WriteInteger('Dialogue Editor', 'GenderStringsCount', genderstringcnt);
  for g := 0 to genderstringcnt - 1 do
  begin
    cfg.WriteString('Dialogue Editor', 'GenderString' + IntToStr(g + 1) +
      'male', genderstrings[g].male);
    cfg.WriteString('Dialogue Editor', 'GenderString' + IntToStr(g + 1) +
      'female', genderstrings[g].female);
  end;

  // arcanumpath := extractfilepath(arcanumpath);
  cfg.WriteBool('Dialogue Editor', 'GenderSpecificReplace',
    AutoReplaceGenderStrings);
  consoledebug('Saved configuration to ' + cfg.FileName);
end;

procedure LoadConfig;
var
  cnt, g: Integer;
begin
  cfg := TInifile.Create(extractfiledir(ParamStr(0)) + '\ScriptEd.ini');
  actions_data := Tinifile.Create(extractfiledir(ParamStr(0)) + '\data\DialogueActions.cfg');
  conditions_data := Tinifile.Create(extractfiledir(ParamStr(0)) + '\data\DialogueConditions.cfg');
   arcanumpath := cfg.ReadString('General', 'DAT_Path', '');

   OllamaEnabled := cfg.ReadBool('Ollama', 'OllamaEnabled', False);
   ollamamodel :=  cfg.ReadString('Ollama', 'OllamaModel', '');
   OllamaCloudEnabled := cfg.ReadBool('OllamaCloud', 'OllamaCloudEnabled', False);
   OllamaCloudApiKey := cfg.ReadString('OllamaCloud', 'OllamaCloudApiKey', '');
   OllamaCloudUrl := cfg.ReadString('OllamaCloud', 'OllamaCloudUrl', 'https://api.ollama.cloud/v1');
   OllamaProvider := cfg.ReadString('Ollama', 'OllamaProvider', 'Local Ollama');
  cnt := cfg.ReadInteger('Dialogue Editor', 'GenderStringsCount', 0);
  genderstringcnt := 0;
  setlength(genderstrings, cnt + 1);
  for g := 1 to cnt do
  begin
    new(genderstrings[g - 1]);
    genderstrings[g - 1].male := cfg.ReadString('Dialogue Editor',
      'GenderString' + IntToStr(g) + 'male', '');
    genderstrings[g - 1].female := cfg.ReadString('Dialogue Editor',
      'GenderString' + IntToStr(g) + 'female', '');
    Inc(genderstringcnt);
  end;
autoexpand := cfg.ReadBool('General','ExpandDialogueTreeNodes', false);

  // arcanumpath := extractfilepath(arcanumpath);
  AutoReplaceGenderStrings := cfg.ReadBool('Dialogue Editor',
    'GenderSpecificReplace', False);
  LastModuleFolder := cfg.ReadString('General', 'LastModuleDir', '');
  EnterCompileTrigger := cfg.ReadBool('General', 'EnterCompileTrigger', False);
  AutoRemapLineNumbers := cfg.ReadBool('General', 'RemapLineNumbers', True);
  AutoUpdateFemaleLine := cfg.ReadBool('General',
    'AutoUpdateFemaleLine', False);
  IncludeEntryPoints := cfg.ReadBool('General', 'IncludeEntryPoints', True);
  cfg.ReadBool('General','ExpandDialogueTreeNodes', autoexpand);

  ConfirmPlayerOptionDelete := cfg.ReadBool('General',
    'ConfirmPlayerOptionDelete', True);
  PlayerOptionCommentEOL := cfg.ReadBool('General',
    'PlayerOptionCommentEOL', False);
  ShowCompressedModules := cfg.ReadBool('General',
    'ShowCompressedModules', True);
  UseDBMaker := cfg.ReadBool('General',
    'UseDBMaker', True);

  AutoIncrementVONumber := cfg.ReadBool('General','AutoVONumbersOnNewNode', true);

  VerboseDebug := cfg.ReadBool('General', 'VerboseDebug', False);
  LineNumberStep := cfg.ReadInteger('General', 'DLGNodeNumberStep', 20);
  consoledebug('Loaded configuration from ' + cfg.FileName);
end;

end.
