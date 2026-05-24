(*

  ScriptEd 1.50 - Module loader

  This unit loads all module related data into memory

*)

unit ModuleLoader;

interface

uses Windows, ScriptEdConfig, SysUtils, arcdatlib, ArcanumSCRLib, MesFileIO,
  MESParser;

var

  modulefolder: ansiString;
  moduleDATHandle: datfileheader;
  modulefile: file;
  // from <module>/semes - variable files
  ScriptGlobalFlags, ScriptGlobalVars, ScriptPCFlags, ScriptPCVars: Messagefile;
  // from <module>/mes - quest data
  GameQuest, GameQuestLog, GameQuestLogDumb: Messagefile;
  // from <module>/oemes - internal names and factions
  Faction, GameOName: Messagefile;
  // from <module>/mes - rumors + journal entries
  GameRD_npc_f2f, GameRD_npc_f2m, GameRD_npc_m2f, GameRD_npc_m2m,
    GameRD_npc_m2m_dumb: Messagefile;
  // from <module>/mes - reputations
  GameRP_npc_f2f, GameRP_npc_f2m, GameRP_npc_m2f, GameRP_npc_m2m: Messagefile;
  // misc data from rules
  GameRepLog, GameRep: Messagefile;
  // written stuff
  GameNewsPaper, GameBook, GameNote, GameDesc, GameKey, GameTelegram,
    StoryState: Messagefile;

  // Global data
  Prototypes: Messagefile;
  QuestXPRewards: Messagefile;
  QuestState: Messagefile;
  // ScriptEd special data
  AttachmentPoints, AttachmentPointDesc, Stats, ScriptCallTypes,
    MesFileGeneric: Messagefile;

function LoadModuleData(folder: String): Boolean;

implementation

uses
  Vcl.Dialogs;

function LoadModuleData(folder: String): Boolean;
var
  startTime64, endTime64, frequency64: Int64;
  elapsedSeconds: Single;
begin
  if pos('.dat', folder) <> 0 then
  begin
    QueryPerformanceFrequency(frequency64);
    QueryPerformanceCounter(startTime64);
    opendatfile(modulefile, moduleDATHandle, folder);

    QuestState := ParseMES(ExtractFileDir(paramstr(0))+'\data\QuestState.mes');
    ScriptGlobalFlags := ParseMESFromModuleDAT('semes\globalflags.mes');
    ScriptGlobalVars := ParseMESFromModuleDAT('semes\globalvars.mes');
    if getfileindex(moduleDATHandle, 'semes\pcflags.mes') <> -1 then
      ScriptPCFlags := ParseMESFromModuleDAT('semes\pcflags.mes');
    if getfileindex(moduleDATHandle, 'semes\pcvars.mes') <> -1 then
      ScriptPCVars := ParseMESFromModuleDAT('semes\pcvars.mes');
    GameQuest := ParseMESFromModuleDAT('rules\GameQuest.mes');
    GameQuestLog := ParseMESFromModuleDAT('mes\GameQuestLog.mes');
    GameQuestLogDumb := ParseMESFromModuleDAT('mes\GameQuestLogDumb.mes');
    if getfileindex(moduleDATHandle, 'oemes\gamefaction.mes') <> -1 then
      Faction := ParseMESFromModuleDAT('oemes\gamefaction.mes');

    if getfileindex(moduleDATHandle, 'oemes\gameoname.mes') <> -1 then
      GameOName := ParseMESFromModuleDAT('oemes\gameoname.mes');
    GameRD_npc_f2f := ParseMESFromModuleDAT('mes\game_rd_npc_f2f.mes');
    GameRD_npc_f2m := ParseMESFromModuleDAT('mes\game_rd_npc_f2m.mes');
    GameRD_npc_m2f := ParseMESFromModuleDAT('mes\game_rd_npc_m2f.mes');
    GameRD_npc_m2m := ParseMESFromModuleDAT('mes\game_rd_npc_m2m.mes');
    GameRD_npc_m2m_dumb := ParseMESFromModuleDAT
      ('mes\game_rd_npc_m2m_dumb.mes');
    if getfileindex(moduleDATHandle, 'Rules\GameRep.mes') <> -1 then
      GameRep := ParseMESFromModuleDAT('Rules\GameRep.mes');
    GameBook := ParseMESFromModuleDAT('mes\gamebook.mes');
    GameNewsPaper := ParseMESFromModuleDAT('mes\gamenewspaper.mes');
    GameNote := ParseMESFromModuleDAT('mes\gamenote.mes');
    GameRepLog := ParseMESFromModuleDAT('mes\gamereplog.mes');
    GameDesc := ParseMESFromModuleDAT('mes\gamedesc.mes');
    GameKey := ParseMESFromModuleDAT('mes\gamekey.mes');
    GameTelegram := ParseMESFromModuleDAT('mes\gametelegram.mes');
    StoryState := ParseMESFromModuleDAT('mes\storystate.mes');
    cleanuptempfiles(moduleDATHandle, GetEnvironmentVariable('Temp') + '\');
    QueryPerformanceCounter(endTime64);
    elapsedSeconds := (endTime64 - startTime64) / frequency64;
  end
  else
  begin

    QueryPerformanceFrequency(frequency64);
    QueryPerformanceCounter(startTime64);
    consoledebug('Loading module data from ' + folder);
    QuestState := ParseMES(ExtractFileDir(paramstr(0))+'\data\QuestState.mes');
    ScriptGlobalFlags := ParseMES(folder + '\semes\globalflags.mes');
    ScriptGlobalVars := ParseMES(folder + '\semes\globalvars.mes');
    if fileexists(folder + '\semes\pcflags.mes') then
      ScriptPCFlags := ParseMES(folder + '\semes\pcflags.mes');
    if fileexists(folder + '\semes\pcvars.mes') then
      ScriptPCVars := ParseMES(folder + '\semes\pcvars.mes');
    GameQuest := ParseMES(folder + '\rules\GameQuest.mes');
    GameQuestLog := ParseMES(folder + '\mes\GameQuestLog.mes');
    GameQuestLogDumb := ParseMES(folder + '\mes\GameQuestLogDumb.mes');
    GameRepLog := ParseMES(folder + '\mes\gamereplog.mes');

    if fileexists(folder + '\oemes\gamefaction.mes') then
      Faction := ParseMES(folder + '\oemes\gamefaction.mes');

    // The main arcanum module gets the internal names from
    // Arcanum3.dat/mes/oname.mes so we should
    // check if module is Arcanum and load the appropriate file

    if pos('Modules\Arcanum', folder) <> 0 then
    begin
      GameOName := ParseMESFromDAT('oemes\oname.mes', arcanum3hnd,
        arcanumpath + '\arcanum3.dat', arcanum3dat);
    end
    else
    begin
      if fileexists(folder + '\oemes\gameoname.mes') then
        GameOName := ParseMES(folder + '\oemes\gameoname.mes');
    end;

    GameRD_npc_f2f := ParseMES(folder + '\mes\game_rd_npc_f2f.mes');
    GameRD_npc_f2m := ParseMES(folder + '\mes\game_rd_npc_f2m.mes');
    GameRD_npc_m2f := ParseMES(folder + '\mes\game_rd_npc_m2f.mes');
    GameRD_npc_m2m := ParseMES(folder + '\mes\game_rd_npc_m2m.mes');
    GameRD_npc_m2m_dumb := ParseMES(folder + '\mes\game_rd_npc_m2m_dumb.mes');
    GameRep := ParseMES(folder + '\Rules\GameRep.mes');
    GameBook := ParseMES(folder + '\mes\gamebook.mes');
    GameNote := ParseMES(folder + '\mes\gamenote.mes');
    GameNewsPaper := ParseMES(folder + '\mes\gamenewspaper.mes');
    GameDesc := ParseMES(folder + '\mes\gamedesc.mes');
    GameKey := ParseMES(folder + '\mes\gamekey.mes');
    GameTelegram := ParseMES(folder + '\mes\gametelegram.mes');
    StoryState := ParseMES(folder + '\mes\storystate.mes');
    Result := True;
    QueryPerformanceCounter(endTime64);
    elapsedSeconds := (endTime64 - startTime64) / frequency64;
  end;

  consoledebug(format('Loading module took in %0.7f seconds',
    [elapsedSeconds]));
end;

end.
