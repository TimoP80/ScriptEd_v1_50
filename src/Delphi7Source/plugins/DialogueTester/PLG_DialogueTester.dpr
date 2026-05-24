library PLG_DialogueTester;

{ 

ScriptEd plugin

Plugin Name: Dialogue Tester 
Author: Dj Unique

Description:

This is a plugin for testing your dialogues.

It gets the mes data from the currently loaded module in the host application for displaying information about global flags, global variables and so on.

}

uses
  SysUtils,
  Classes,
  pluginfunc,dialogs;
  
{$R *.res}

// This function should return the name of the plugin to be
// displayed in the menu of the host application
function GetPluginName: ShortString; stdcall;
begin
result := 'Dialogue Tester';
end;

// This function should return a more detailed description of the plugin
function GetPluginDescription: ShortString; stdcall;
begin
result := 'Plugin for testing your dialogues. Full support for scripting commands.';
end;
function CanAddToMenu: boolean; stdcall;
begin
result := True;
end;

// This procedure is called when the host application is
// being closed. Here you should make sure the plugin
// closes all windows it has opened.
procedure PluginClose; stdcall;
begin
end;


// This procedure is called when the plugin needs to update its display
// due to changes made to the dialogue
//
procedure PluginUpdate; stdcall;
begin
end;






// This function should return a key shortcut to be used in the menu
// format is:
// CTRL|ALT|SHIFT+<key> [A-Z]
// examples: CTRL+B, ALT+A, CTRL+ALT+H
//
function GetKeyShortCut: shortstring; stdcall;
begin;
result := '';
end;

// This function is automatically set to return the interface version
// that is defined in the pluginfunc unit.
function GetInterfaceVersion: shortstring; stdcall;
begin
result := interface_version;
end;

// This is the main procedure for the plugin.
//
// If you want the plugin to display a non-modal dialog
// you should make a while..do loop
// such as:
//
// while Form1.visible do
// begin;
// application.processmessages
// end;
//
// This will allow the plugin to run in the background
// and it will return from this procedure after the window is closed
// either by a button or the exit callback function PluginClose
//
// The basepath parameter contains the current path (the root
// of the host application)

procedure RunPlugin (basepath: shortstring); stdcall;
begin
end;

exports
   GetPluginName,PluginClose, PluginUpdate,
   GetPluginDescription, 
   
   CanAddToMenu,
   RunPlugin,
   GetKeyShortCut,
   GetInterfaceVersion;

begin

end.
