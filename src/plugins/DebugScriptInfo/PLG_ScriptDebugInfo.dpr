library PLG_ScriptDebugInfo;

{

ScriptEd plugin

Plugin Name: Compiled Data Viewer
Author: T. Pitkänen

Description:

This plugin is for viewing compiled script data that resides in memory after pressing the compile button.

}

uses
  SysUtils,
  Forms,
  Classes,
  pluginfunc,
  Dialogs,
  ScriptDebugView in 'ScriptDebugView.pas' {Form1};

{$R *.res}

 // This function should return the name of the plugin to be
 // displayed in the menu of the host application
  function GetPluginName: ShortString; stdcall;
  begin
    Result := 'Compiled Data Viewer';
  end;

  // This function should return a more detailed description of the plugin
  function GetPluginDescription: ShortString; stdcall;
  begin
    Result := 'Displays raw compiled script data (opcode + parameters)';
  end;

  function CanAddToMenu: boolean; stdcall;
  begin
    Result := True;
  end;

  // This procedure is called when the host application is
  // being closed. Here you should make sure the plugin
  // closes all windows it has opened.
  procedure PluginClose; stdcall;
  begin
  end;


  // This procedure is called when the plugin needs to update its display
  // due to changes made to the dialogue

  procedure PluginUpdate; stdcall;
  begin
    new(thescript);
    getscript(thescript);
    dumpscript;
  end;


  // This function is used when you want to receive debug messages from the
  // host application

  procedure DebugIntercept(msg: PChar); stdcall;
  begin
  end;

  // This procedure defines the code for launching a configuration dialog box
  procedure PluginConfig(basepath: shortstring); stdcall;
  begin
  end;


  // This function should return a key shortcut to be used in the menu
  // format is:
  // CTRL|ALT|SHIFT+<key> [A-Z]
  // examples: CTRL+B, ALT+A, CTRL+ALT+H

  function GetKeyShortCut: shortstring; stdcall;
  begin
    ;
    Result := '';
  end;

  // This function is automatically set to return the interface version
  // that is defined in the pluginfunc unit.
  function GetInterfaceVersion: shortstring; stdcall;
  begin
    Result := interface_version;
  end;

  // This is the main procedure for the plugin.

  // If you want the plugin to display a non-modal dialog
  // you should make a while..do loop
  // such as:

  // while Form1.visible do
  // begin;
  // application.processmessages
  // end;

  // This will allow the plugin to run in the background
  // and it will return from this procedure after the window is closed
  // either by a button or the exit callback function PluginClose

  // The basepath parameter contains the current path (the root
  // of the host application)

  procedure RunPlugin(basepath: shortstring); stdcall;
  begin
    Form1 := TForm1.Create(nil);
    form1.Show;
    new(thescript);
    getscript(thescript);
dumpscript;
    while form1.Visible do
    begin
      application.ProcessMessages;
    end;
    form1.Free;

  end;

exports
  GetPluginName,
  PluginClose,
  PluginUpdate,
  GetPluginDescription,
  DebugIntercept,
  PluginConfig,
  CanAddToMenu,
  RunPlugin,
  GetKeyShortCut,
  GetInterfaceVersion;

begin

end.
