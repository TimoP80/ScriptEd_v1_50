unit plgwind;

interface

uses
  Classes, Controls, Dialogs, ExtCtrls, Forms,
  Graphics,
  Menus, Messages, StdCtrls, SysUtils, Variants, Windows,
  ComCtrls, Mask, JvExMask, JvToolEdit, JvExComCtrls, JvHotKey;

type
  Tplgwnd = class(TForm)
    Panel1:      TPanel;
    Label1:      TLabel;
    plgName:     TEdit;
    Description: TLabel;
    plgdesc:     TMemo;
    Label2:      TLabel;
    appdesc:     TEdit;
    Label3:      TLabel;
    auth:        TEdit;
    Button1:     TButton;
    Label4:      TLabel;
    Button2:     TButton;
    CheckBox1:   TCheckBox;
    Label5:      TLabel;
    JvHotKey1:   TJvHotKey;
    CheckBox2:   TCheckBox;
    CheckBox3:   TCheckBox;
    CheckBox4:   TCheckBox;
    CheckBox5:   TCheckBox;
    output:      TJvFilenameEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dabasepath: shortstring;
  plgwnd:     Tplgwnd;
  template:   TStrings;

implementation

{$R *.dfm}



procedure Tplgwnd.Button1Click(Sender: TObject);

begin

  if output.filename = '' then
  begin
    ;
    MessageDlg('Can''t save plugin project if you have not specified an output filename!',
      mtWarning, [mbOK], 0);
    exit;
  end;


  template := TStringList.Create;
  template.loadfromfile(dabasepath + '\plugins\Plugintemplate.txt');
  template.Text := StringReplace(template.Text, '<shortcut>', ShortCutToText(JvHotKey1.hotkey), [rfReplaceAll]);
  template.Text := StringReplace(template.Text, '<pluginname>', plgName.Text, [rfReplaceAll]);
  template.Text := StringReplace(template.Text, '<author>', auth.Text, [rfReplaceAll]);
  template.Text := StringReplace(template.Text, '<plugindesc>', plgdesc.Text, [rfReplaceAll]);
  template.Text := StringReplace(template.Text, '<pluginappdesc>', appdesc.Text, [rfReplaceAll]);
  template.Text := StringReplace(template.Text, '<libname>', extractfilename(changefileext(output.filename, '')), [rfReplaceAll]);

  if checkbox5.Checked then
  begin
    ;
    template.Text := StringReplace(template.Text, '<insert_pluginconfig>',
      '// This procedure defines the code for launching a configuration dialog box\nprocedure PluginConfig (basepath: shortstring); stdcall;\nbegin\nend;\n',
      [rfReplaceAll]);
    template.Text := StringReplace(template.Text, '<pluginconfig>', 'PluginConfig,', [rfReplaceAll]);
  end else
  begin
    ;
    template.Text := StringReplace(template.Text, '<insert_pluginconfig>', '', [rfReplaceAll]);
    template.Text := StringReplace(template.Text, '<pluginconfig>', '', [rfReplaceAll]);
  end;

  if checkbox3.Checked then
  begin
    ;
    template.Text := StringReplace(template.Text, '<insert_pluginclose>',
      '// This procedure is called when the host application is\n// being closed. Here you should make sure the plugin\n// closes all windows it has opened.\nprocedure PluginClose; stdcall;\nbegin\nend;\n', [rfReplaceAll]);
    template.Text := StringReplace(template.Text, '<pluginclose>', 'PluginClose,', [rfReplaceAll]);
  end else
  begin
    ;
    template.Text := StringReplace(template.Text, '<insert_pluginclose>', '', [rfReplaceAll]);
    template.Text := StringReplace(template.Text, '<pluginclose>', '', [rfReplaceAll]);
  end;

  if checkbox2.Checked then
  begin
    ;
    template.Text := StringReplace(template.Text, '<insert_pluginupdate>',
      '// This procedure is called when the plugin needs to update its display\n// due to changes made to the dialogue\n//\nprocedure PluginUpdate; stdcall;\nbegin\nend;\n',
      [rfReplaceAll]);
    template.Text := StringReplace(template.Text, '<pluginupdate>', 'PluginUpdate,', [rfReplaceAll]);
  end else
  begin
    ;
    template.Text := StringReplace(template.Text, '<insert_pluginupdate>', '', [rfReplaceAll]);
    template.Text := StringReplace(template.Text, '<pluginupdate>', '', [rfReplaceAll]);
  end;
  if checkbox4.Checked then
  begin
    ;
    template.Text := StringReplace(template.Text, '<insert_debugintercept>',
      '// This function is used when you want to receive debug messages from the\n// host application\n//\nprocedure DebugIntercept (msg: pchar); stdcall;\nbegin\nend;',
      [rfReplaceAll]);
    template.Text := StringReplace(template.Text, '<debugintercept>', 'DebugIntercept,', [rfReplaceAll]);
  end else
  begin
    ;
    template.Text := StringReplace(template.Text, '<insert_debugintercept>', '', [rfReplaceAll]);
    template.Text := StringReplace(template.Text, '<debugintercept>', '', [rfReplaceAll]);
  end;


  {$IFDEF FDBEdit}
template.Text := StringReplace(template.text,'<define>','{$DEFINE FDBEDIT}',[rfReplaceAll]);
{$ENDIF}
{$IFDEF WorldEdit}
{$MESSAGE 'WorldEdit define!'}
template.Text := StringReplace(template.text,'<define>','{$DEFINE WorldEdit}',[rfReplaceAll]);
{$ENDIF}

  template.Text := StringReplace(template.Text, '\n', #13#10, [rfReplaceAll]);
  template.Text := StringReplace(template.Text, '<addtomenu>', BoolToStr(CheckBox1.Checked, True), [rfReplaceAll]);
  template.SaveToFile(output.filename);

  modalresult := mrOk;
end;

end.

