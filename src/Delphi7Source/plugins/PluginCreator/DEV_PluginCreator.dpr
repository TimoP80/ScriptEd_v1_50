library DEV_PluginCreator;

{

Plugin project file Creator 

This will help with creating new plugins
for ScriptEd

}

uses
  Windows, Forms, Dialogs, plgwind in 'plgwind.pas' {plgwnd}, pluginfunc, SysUtils;

{$R *.res}
  procedure PluginClose; stdcall;
  begin;
//    plgwnd.Free;
  end;


  function GetPluginName: ShortString; stdcall;
  begin;
    Result := 'ScriptEd Plugin Creator';
  end;
  function GetPluginDescription: ShortString; stdcall;
  begin;
    Result := 'Plugin to generate a dpr file for a new plugin.';
  end;
  function GetInterfaceVersion: shortstring; stdcall;
  begin;
    Result := interface_version;
  end;

  function CanAddToMenu: boolean; stdcall;
  begin;
    Result := True;
  end;

  procedure RunPlugin(basepath: shortstring); stdcall;
  begin;
    plgwnd     := Tplgwnd.Create(application);
    dabasepath := basepath;

    plgwnd.showmodal;
    plgwnd.free;
  end;

exports
  GetPluginName,
  PluginClose,
   GetInterfaceVersion, CanAddToMenu,
  GetPluginDescription,
  RunPlugin;

begin

end.

