(*

ScriptEd 1.50 Plugin interface
based on code from FMF Dialogue Tool


*)

unit pluginapi;

interface

uses
  Classes,
  Controls,
  Dialogs,
  arcanumscrlib,
  Forms,
  JclFileUtils,
  JclStrings,
  JvProgressDialog,
  Menus,
  SysUtils,
  Windows;

type
  TGetPluginNameProc = function: shortstring; stdcall;
  TGetPluginLongDescProc = function: shortstring; stdcall;
  TGenericDataProc = procedure(Data: shortstring); stdcall;
  TRunPluginProc = procedure(basepath: shortstring); stdcall;
  TDebugIntercept = procedure(msg: PChar); stdcall;


  TGenerateSpeechProc = procedure(text_male, text_female: PChar;
    voicename: PChar; outputpath: PChar; linenum: integer); stdcall;

  TCanAddToMenuFunc = function: boolean; stdcall;
  TGenericStringFunc = function: shortstring; stdcall;
  TGenericProc = procedure; stdcall;
  TSetAppProc = procedure(ahandle: HWnd); stdcall;

type
  TPluginRec = record
    filename:          string;
    interfaceversion:  string;
    displayname:       string;
    longdesc:          string;
    hasconfig:         boolean;
    isspeechgenerator: boolean;
    filterindex:       integer;
    instancehandle:    THandle;
    builddate:         TDateTime;
    creationdate:      TDateTime;
  end;

const
  ScriptEd_Version = '1.50';

const
  minimum_major_version = 1;

const
  minimum_minor_version = 50;

var
  DLLPlugins: array [0..35] of ^TPluginRec;

  GetPlugName:    TGetPluginNameProc;
  GetPlugLongDesc: TGetPluginLongDescProc;
  CanAddToMenu:   TCanAddToMenuFunc;
  DataProc:       TGenericDataProc;
  GetFilter:      TGenericStringFunc;
  CloseProc:      TGenericProc;
  RefreshProc:    TGenericProc;
  RunProc:        TRunPluginProc;
  ConfigProc:     TRunPluginProc;
  GenSpeechProc:  TGenerateSpeechProc;
  globalfilterindex: integer;
  SetApp:         TSetAppProc;
  DebugInterceptProc: TDebugintercept;
  GetKeyShortCut: TGenericStringFunc;
  GetInterfaceVersion: TGenericStringFunc;
  DLLHandle:      THandle;
  plugincnt:      integer;
  basepath:       string;
  intf:           string;

procedure ScanForPlugins(pattern: string = '*.dll'; const menutoinsert: TMenu = nil;
  menuitemtoinsert: TMenuItem = nil; clickevent: TNotifyEvent = nil;
  clearmenu: boolean = True; indextoinsert: integer = -1; debugmessage: string = '');

procedure ExecuteSpeechGenerator(filename: string; text_male: string;
  text_female: string; voicename: string; outputpath: string; linenum: integer);


procedure RequestPluginRefresh;
procedure ExecutePlugin(filename: string);
procedure ExecutePluginConfig(filename: string);
procedure ExecuteImportAction(opendlgfile, pluginname: string);
procedure ExternalRegister(appname: PChar; Name: PChar; description: PChar;
  InterfaceVersion: shortstring; menutoinsert: TMenu = nil;
  MenuItemtoInsert: TMenuItem = nil; clickevent: TNotifyEvent = nil);
function getpluginbyfilterindex(index: integer): integer;
function getpluginbyname(Name: string): integer;
procedure DoDebugIntercept(msg: string);
function pluginexists(Name: string): boolean;

var
  dahandle: THandle;

function DeInitPluginLib: boolean;

implementation

uses
  ScriptEdWindow;

function pluginexists(Name: string): boolean;
var
  s: integer;
begin
  Result := False;
  //  ConsoleDebug('Plugin Exists: '+name);
  for s := 0 to plugincnt - 1 do
  begin
    if (uppercase(DLLPlugins[s].filename) = uppercase(Name)) then
    begin
      Result := True;
      exit;
    end;
  end;

end;


function getpluginbyfilterindex(index: integer): integer;
var
  s: integer;
begin
  Result := -1;
  for s := 0 to plugincnt - 1 do
  begin
    if (DLLPlugins[s].filterindex = index) then
    begin
      Result := s;
      exit;
    end;
  end;
end;



function getpluginbyname(Name: string): integer;
var
  s: integer;
begin
  Result := 0;
  for s := 0 to plugincnt - 1 do
  begin
    if (DLLPlugins[s].filename = Name) then
    begin
      Result := s;
      exit;
    end;
  end;
end;

procedure ExecuteImportAction(opendlgfile, pluginname: string);
var
  i: integer;

begin

  i := getpluginbyname(pluginname);
  if GetModuleHandle(PChar(pluginname)) <> 0 then
  begin
    ConsoleDebug('Plugin appears to be active.');
    @DataProc := GetProcAddress(dllplugins[i].instancehandle, 'ImportData');
    if @DataProc <> nil then
    begin

      dataproc(opendlgfile);
    end;
  end
  else
  begin
    dllplugins[i].instancehandle := LoadLibrary(PChar(dllplugins[i].filename));
    if dllplugins[i].instancehandle = 0 then
    begin
      ShowMessage('FAILED TO GET HANDLE for ' + dllplugins[i].filename);
    end

    else if dllplugins[i].instancehandle <> 0 then
    begin
      @SetApp := GetProcAddress(dllplugins[i].instancehandle, 'SetApplicationHandle');
      if @SetApp <> nil then
      begin
        ConsoleDebug('Setting application handle for plugin.');
        SetApp(Application.Handle);

      end
      else
        ConsoleDebug(
          'Warning: Unable to set application handle: exported function SetApplicationHandle is not present.');
      @DataProc := GetProcAddress(dllplugins[i].instancehandle, 'ImportData');
      if @DataProc <> nil then
      begin
        dataproc(opendlgfile);
      end;
    end;

  end;

end;


procedure ExecuteSpeechGenerator(filename: string; text_male: string;
  text_female: string; voicename: string; outputpath: string; linenum: integer);

var
  i: integer;

begin
  i := getpluginbyname(filename);
  if GetModuleHandle(PChar(filename)) <> 0 then
  begin
    ConsoleDebug('Plugin appears to be active.');
    @genspeechProc := GetProcAddress(dllplugins[i].instancehandle, 'GenerateSpeech');
    if @genspeechProc <> nil then
    begin
      if text_female = '' then
        GenSpeechProc(PChar(text_male), nil, PChar(voicename),
          PChar(outputpath), linenum)
      else

        GenSpeechProc(PChar(text_male), PChar(text_female), PChar(voicename),
          PChar(outputpath), linenum);
    end;

  end
  else
  begin
    dllplugins[i].instancehandle := LoadLibrary(PChar(dllplugins[i].filename));
    if dllplugins[i].instancehandle = 0 then
    begin
      ShowMessage('FAILED TO GET HANDLE for ' + dllplugins[i].filename);
    end

    else if dllplugins[i].instancehandle <> 0 then
    begin
      @SetApp := GetProcAddress(dllplugins[i].instancehandle, 'SetApplicationHandle');
      if @SetApp <> nil then
      begin
        ConsoleDebug('Setting application handle for plugin.');
        SetApp(Application.Handle);
      end;
      @genspeechProc := GetProcAddress(dllplugins[i].instancehandle, 'GenerateSpeech');
      if @genspeechProc <> nil then
      begin
        if text_female = '' then
          GenSpeechProc(PChar(text_male), nil, PChar(voicename),
            PChar(outputpath), linenum)
        else
          GenSpeechProc(PChar(text_male), PChar(text_female), PChar(voicename),
            PChar(outputpath), linenum);
      end;
    end;

  end;

end;

procedure ExecutePlugin(filename: string);

var
  i: integer;

begin
  i := getpluginbyname(filename);
  if GetModuleHandle(PChar(filename)) <> 0 then
  begin
    ConsoleDebug('Plugin appears to be active.');
    @RunProc := GetProcAddress(dllplugins[i].instancehandle, 'RunPlugin');
    if @RunProc <> nil then
    begin
      runproc(basepath);
    end;

  end
  else
  begin
    dllplugins[i].instancehandle := LoadLibrary(PChar(dllplugins[i].filename));
    if dllplugins[i].instancehandle = 0 then
    begin
      ShowMessage('FAILED TO GET HANDLE for ' + dllplugins[i].filename);
    end

    else if dllplugins[i].instancehandle <> 0 then
    begin
      @SetApp := GetProcAddress(dllplugins[i].instancehandle, 'SetApplicationHandle');
      if @SetApp <> nil then
      begin
        ConsoleDebug('Setting application handle for plugin.');
        SetApp(Application.Handle);
      end;
      @RunProc := GetProcAddress(dllplugins[i].instancehandle, 'RunPlugin');
      if @RunProc <> nil then
      begin
        runproc(basepath);
      end;
    end;

  end;

end;


procedure ExecutePluginConfig(filename: string);

var
  i: integer;

begin
  i := getpluginbyname(filename);
  if GetModuleHandle(PChar(filename)) <> 0 then
  begin
    ConsoleDebug('WARNING: Plugin already running!');
    exit;
  end;
  dllplugins[i].instancehandle := LoadLibrary(PChar(dllplugins[i].filename));
  if dllplugins[i].instancehandle = 0 then
  begin
    ShowMessage('FAILED TO GET HANDLE for ' + dllplugins[i].filename);
  end
  else if dllplugins[i].instancehandle <> 0 then
  begin
    @ConfigProc := GetProcAddress(dllplugins[i].instancehandle, 'PluginConfig');
    if @ConfigProc <> nil then
    begin
      @SetApp := GetProcAddress(dllplugins[i].instancehandle, 'SetApplicationHandle');
      if @SetApp <> nil then
      begin
        ConsoleDebug('Setting application handle for plugin.');
        SetApp(Application.Handle);

      end
      else
        ConsoleDebug(
          'Warning: Unable to set application handle: exported function SetApplicationHandle is not present.');

      ConfigProc(basepath);

      if (GetModuleHandle(PChar(dllplugins[i].filename)) <> 0) and
        (FreeLibrary(dllplugins[i].instancehandle) = False) then
      begin
        ConsoleDebug('Failed freeing library!');
      end;
    end;
  end;

end;



function DeInitPluginLib: boolean;
var
  opencnt, t: integer;
  hand: THandle;
  list: string;
begin
  Result := False;
  opencnt := 0;
  list := '';
  for t := 0 to plugincnt - 1 do
  begin
    hand := GetModuleHandle(PChar(dllplugins[t].filename));
    if (hand <> 0) then
    begin
      //ConsoleDebug('Freeing library '+dllplugins[t].filename);
      @CloseProc :=
        GetProcAddress(hand, 'PluginClose');
      if @closeproc <> nil then
      begin
        ConsoleDebug('Closing plugin ' + dllplugins[t].filename);
        closeproc;
      end
      else
      begin
        list := list + dllplugins[t].displayname + ' [' + dllplugins[t].filename +
          ']' + #13#10;
        Inc(opencnt);

      end;

    end;
  end;
  if opencnt > 0 then
  begin
    MessageDlg(format(
      'The following plugins can not close by themselves: (PluginClose missing)' +
      #13 + #10 + '%s' + #13 + #10 + 'Close them before quitting.', [list]),
      mtWarning, [mbOK], 0);
    Result := False;
  end
  else
    Result := True;

end;

(*

Scans through plugins that can receive debug messages to process them
(e.g. print it out in a control etc.)

 *)

procedure DoDebugIntercept(msg: string);
var
  t: integer;
  hand: THandle;

begin
  for t := 0 to plugincnt - 1 do
  begin
    hand := GetModuleHandle(PChar(dllplugins[t].filename));
    if (hand <> 0) then
    begin
      //ConsoleDebug('Freeing library '+dllplugins[t].filename);
      //list := list +  + ' [' + dllplugins[t].filename + ']' + #13#10;
      @DebugInterceptProc := GetProcAddress(hand, 'DebugIntercept');
      if @DebugInterceptProc <> nil then
      begin
        DebugInterceptProc(PChar(msg));
      end;

    end;
  end;

end;


procedure RequestPluginRefresh;
var
  t: integer;
  hand: THandle;

begin
  for t := 0 to plugincnt - 1 do
  begin
    hand := GetModuleHandle(PChar(dllplugins[t].filename));
    if (hand <> 0) then
    begin
      //ConsoleDebug('Freeing library '+dllplugins[t].filename);
      //list := list +  + ' [' + dllplugins[t].filename + ']' + #13#10;
      @refreshproc := GetProcAddress(hand, 'PluginUpdate');
      if @refreshproc <> nil then
      begin
        ConsoleDebug('Requesting "' + dllplugins[t].displayname +
          '" to refresh dialogue.');
        try
          refreshproc;
        except
          on e: Exception do
          begin
            MessageDlg(format('The plugin "%s" (%s) crashed when trying to update.',
              [dllplugins[t].displayname, dllplugins[t].filename]), mtError, [mbOK], 0);
          end;
        end;
      end;

    end;
  end;

end;


// TODO -cPlugin stuff -oDjUnique: This will allow plugins to register additional plugins etc. or whatever
procedure ExternalRegister(appname: PChar; Name: PChar; description: PChar;
  InterfaceVersion: shortstring; menutoinsert: TMenu = nil;
  MenuItemtoInsert: TMenuItem = nil; clickevent: TNotifyEvent = nil);
begin
  ConsoleDebug('Starting external register process received from ' + appname);
  new(DLLPlugins[plugincnt]);
  DLLPlugins[plugincnt].filename := appname;
  DLLPlugins[plugincnt].interfaceversion := interfaceversion;
  DLLPlugins[plugincnt].displayname := Name;
  DLLPlugins[plugincnt].longdesc := description;

  GetFileCreation(appname, DLLPlugins[plugincnt].creationdate);
  GetFileLastWrite(appname, DLLPlugins[plugincnt].builddate);
  ConsoleDebug('Registered ' + DLLPlugins[plugincnt].filename +
    ' as a non-visible plugin.');
  ShowMessage('Plugin "' + appname + '" (' + Name + ') registered.');
  Inc(plugincnt);
end;

procedure ScanForPlugins(pattern: string = '*.dll'; const menutoinsert: TMenu = nil;
  menuitemtoinsert: TMenuItem = nil; clickevent: TNotifyEvent = nil;
  clearmenu: boolean = True; indextoinsert: integer = -1; debugmessage: string = '');
var
  i: integer;
  validversion: boolean;
  pluginlist: TStrings;
  minorversionplg, minorversionapp: integer;
  s: TMenuItem;
begin
  if (menutoinsert <> nil) and (clearmenu = True) then
  begin
    menuitemtoinsert.Clear;
  end;

  PluginList := TStringList.Create;
  if debugmessage <> '' then
    ConsoleDebug(debugmessage);
  AdvBuildFileList(pattern, faAnyFile, Pluginlist, amAny, [flFullNames]);
  if pluginlist.Count > 0 then
  begin
    globalfilterindex := 2;
    //progressdata.OnProgress;
    for I := 0 to PluginList.Count - 1 do
    begin
      application.ProcessMessages;
      //showmessage(pluginlist[i]);
      DLLHandle := LoadLibrary(PChar(pluginlist[i]));
      if DLLHandle <> 0 then
      begin
        //MessageDlg('Got DLL Handle!', mtWarning, [mbOK], 0);


        @GetPlugName := GetProcAddress(DLLHandle, 'GetPluginName');
        @GetPlugLongDesc :=
          GetProcAddress(DLLHandle, 'GetPluginDescription');
        if @getplugname = nil then
          ShowMessage('GetPluginName not found!');
        if @getpluglongdesc = nil then
          ShowMessage('GetPluginDescription not found!');
        if (@GetPlugName <> nil) and (@GetPlugLongDesc <> nil) then
        begin
          new(dllplugins[plugincnt]);
          dllplugins[plugincnt].filterindex := -1;
          DLLplugins[plugincnt].filename := pluginlist[i];
          GetFileCreation(DLLplugins[plugincnt].filename,
            DLLplugins[plugincnt].creationdate);
          GetFileLastWrite(DLLplugins[plugincnt].filename,
            DLLplugins[plugincnt].builddate);



          DLLplugins[plugincnt].displayname := GetPlugName;
          @ConfigProc :=
            GetProcAddress(DLLHandle, 'PluginConfig');
          if @ConfigProc <> nil then
          begin
            DLLplugins[plugincnt].hasconfig := True;
          end
          else
            DLLplugins[plugincnt].hasconfig := False;
          @GenSpeechProc := getprocaddress(dllhandle, 'GenerateSpeech');
          if @genspeechproc <> nil then

            DLLplugins[plugincnt].isspeechgenerator := True
          else
            DLLplugins[plugincnt].isspeechgenerator := False;



          DLLplugins[plugincnt].longdesc := GetPlugLongDesc;
          //DLLplugins[plugincnt].versioninfo := TJclFileVersioninfo.Create(DLLplugins[plugincnt].filename);
          //form1.BULogFile1.Add(DateTimeToSTR(Now), 'Init',DLLplugins[plugincnt].filename+' versioninfo: '+DLLplugins[plugincnt].versioninfo.FileDescription+', '+DLLplugins[plugincnt].versioninfo.FileVersion);

          @GetInterfaceVersion := GetProcAddress(DLLHandle, 'GetInterfaceVersion');
          if @GetInterfaceVersion <> nil then
          begin
            DLLplugins[plugincnt].interfaceversion := GetInterfaceVersion;
            if DLLplugins[plugincnt].interfaceversion = '' then
              DLLplugins[plugincnt].interfaceversion :=
                ScriptEd_Version;
            try
              minorversionplg :=
                StrToInt(copy(DLLplugins[plugincnt].interfaceversion,
                pos('.', DLLplugins[plugincnt].interfaceversion) +
                1, length(DLLplugins[plugincnt].interfaceversion)));
              minorversionapp :=
                StrToInt(copy(ScriptEd_Version, pos('.', ScriptEd_Version) +
                1, length(ScriptEd_Version)));
            except
              on e: EConvertError do
              begin
                MessageDlg(format(
                  'Plugin "%s" returned a blank string for version, plugin rejected.',
                  [DLLplugins[plugincnt].filename]), mtWarning, [mbOK], 0);
                validversion := False;

              end;
            end;

            if (minorversionplg >= minimum_minor_version) then
              validversion := True
            else
              validversion := False;

            if validversion = False then
            begin
              ConsoleDebug(DLLplugins[plugincnt].filename +
                ' has incompatible interface version (' +
                DLLplugins[plugincnt].interfaceversion + '), plugin not loaded.');
              MessageDlg(format('The plugin ''%s'' is not compatible with this' +
                #13 + #10 + 'version of ScriptEd. ' + #13 + #10 +
                'The plugin has not been loaded.' + #13 + #10 + '' +
                #13 + #10 + 'Expected minimum interface version is 1.%d' +
                #13 + #10 + 'Interface version returned by the plugin was %s' +
                #13 + #10 + '' + #13 + #10 + 'The plugin should be recompiled with the' +
                #13 + #10 + 'most current plugin API version.',
                [DLLplugins[plugincnt].filename, minimum_minor_version,
                DLLplugins[plugincnt].interfaceversion]), mtWarning, [mbOK], 0);
            end;

          end
          else
          begin
            ConsoleDebug(DLLplugins[plugincnt].filename +
              ' contains no interface version. Plugin is probably unsafe!');

            validversion := True;
          end;
          @GetFilter := GetProcAddress(DLLHandle, 'GetFilter');
          if (@GetFilter <> nil) then
          begin

            mainform.OpenDialog1.filter := mainform.opendialog1.Filter + '|' + GetFilter;
            dllplugins[plugincnt].filterindex := globalfilterindex;
            Inc(globalfilterindex);
          end;
          @CanAddToMenu := GetProcAddress(DLLHandle, 'CanAddToMenu');
          if (menutoinsert <> nil) and (@canaddtomenu <> nil) then
          begin
            if (canaddtomenu = True) and (validversion = True) then
            begin
              s := TMenuItem.Create(menutoinsert);
              s.Caption := dllplugins[plugincnt].displayname;
              s.tag := plugincnt;
              s.OnClick := clickevent;
              @GetKeyShortCut :=
                GetProcAddress(DLLHandle, 'GetKeyShortCut');
              if @getkeyshortcut <> nil then
              begin
                s.ShortCut := TextToShortCut(GetKeyShortCut);
              end;

              if indextoinsert = -1 then
              begin
                menuitemtoinsert.add(s);
              end
              else
                menuitemtoinsert.Insert(indextoinsert, s);

              menuitemtoinsert.Visible := True;

            end;
          end;
          ConsoleDebug(' --> ' + DLLplugins[plugincnt].displayname);
          Inc(plugincnt);

          if FreeLibrary(DLLHandle) = False then
            MessageDlg('Fail to release plugin DLL handle!', mtError, [mbOK], 0);

        end
        else
        begin
          ShowMessage('Did not find needed procedures!');

          FreeLibrary(DLLHandle);
          ConsoleDebug('DLL Handle released.');

        end;
        //ConsoleDebug('Failed to get DLL handle for '+pluginlist[i]);
      end;
    end;
  end;
  //showmessage(inttostr(plugincnt)+' DLL plug-ins found.');

  pluginlist.Free;

end;

begin
  basepath := extractfiledir(ParamStr(0));
end.

