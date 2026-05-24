unit ModuleScriptLoad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ScriptEdConfig, JclFileUtils, arcanumscrlib, ModuleLoader, Dialogs, StdCtrls,
  ComCtrls,
  JvFormPlacement, JvComponentBase, JvAppStorage, JvAppIniStorage, Menus;

type
  TForm10 = class(TForm)
    ListView1: TListView;
    Button1: TButton;
    Button2: TButton;
    JvFormStorage1: TJvFormStorage;
    PopupMenu1: TPopupMenu;
    DeleteScript1: TMenuItem;
    Label1: TLabel;
    ScriptFilter: TEdit;
    Button3: TButton;
    procedure ListView1Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure DeleteScript1Click(Sender: TObject);
    procedure ScriptFilterKeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;
  scriptlst: TStrings;
  tempscript: ScriptFile;
  selectedmodulescript: String;

procedure LoadModuleScriptList;
procedure LoadModuleDialogueList;

implementation

uses scriptedwindow;

procedure LoadModuleScriptList;
var
  path: String;
  str: String;
  voicefolder: string;
  desc: String;
  test: boolean;
  createdate, date: TDateTime;
  t: Integer;
  thelistitem: TListItem;
begin

  // Code for uncompressed modules
  if pos('.dat', modulefolder) = 0 then
  begin
    scriptlst := TStringList.Create;
    Form10.ListView1.Clear;
    path := arcanumpath + '\Modules\' + modulefolder + '\scr\?????*.scr';
    advbuildfilelist(path, faAnyFile, scriptlst, amAny, []);
    for t := 0 to scriptlst.Count - 1 do
    begin

      voicefolder := arcanumpath + '\Modules\' + modulefolder + '\Sound\Speech\'
        + copy(extractfilename(scriptlst[t]), 1, 5);

      if Form10.ScriptFilter.text <> '' then
      begin
        if (pos(Form10.ScriptFilter.text, scriptlst[t]) <> 0) then
        begin

          LoadScriptHeaderOnly(arcanumpath + '\Modules\' + modulefolder +
            '\scr\' + scriptlst[t], tempscript);
          desc := tempscript.Description;
          thelistitem := Form10.ListView1.Items.Add;
          str := copy(scriptlst[t], 1, 5);

          if IsStrANumber(str) = True then
            thelistitem.Caption := str
          else
            thelistitem.Caption := '';

          if IsStrANumber(str) = True then
            str := copy(scriptlst[t], 6, length(scriptlst[t]))
          else
            str := scriptlst[t];

          thelistitem.SubItems.Add(str);
          thelistitem.SubItems.Add(desc);
          test := GetFileLastWrite(arcanumpath + '\Modules\' + modulefolder +
            '\scr\' + scriptlst[t], date);
          if test = false then
            thelistitem.SubItems.Add('N/A')
          else
            thelistitem.SubItems.Add(datetostr(date));
          test := GetFileCreation(arcanumpath + '\Modules\' + modulefolder +
            '\scr\' + scriptlst[t], createdate);
          if test = false then
            thelistitem.SubItems.Add('N/A')
          else
            thelistitem.SubItems.Add(datetostr(createdate));

          voicefolder := arcanumpath + '\Modules\' + modulefolder +
            '\Sound\Speech\' + copy(extractfilename(scriptlst[t]), 1, 5);
          if directoryexists(voicefolder) = True then
            thelistitem.SubItems.Add('Yes')
          else
            thelistitem.SubItems.Add('No');
        end;

      end
      else
      begin

        LoadScriptHeaderOnly(arcanumpath + '\Modules\' + modulefolder + '\scr\'
          + scriptlst[t], tempscript);
        desc := tempscript.Description;
        thelistitem := Form10.ListView1.Items.Add;
        str := copy(scriptlst[t], 1, 5);

        if IsStrANumber(str) = True then
          thelistitem.Caption := str
        else
          thelistitem.Caption := '';

        if IsStrANumber(str) = True then
          str := copy(scriptlst[t], 6, length(scriptlst[t]))
        else
          str := scriptlst[t];

        thelistitem.SubItems.Add(str);
        thelistitem.SubItems.Add(desc);
        test := GetFileLastWrite(arcanumpath + '\Modules\' + modulefolder +
          '\scr\' + scriptlst[t], date);
        if test = false then
          thelistitem.SubItems.Add('N/A')
        else
          thelistitem.SubItems.Add(datetostr(date));
        test := GetFileCreation(arcanumpath + '\Modules\' + modulefolder +
          '\scr\' + scriptlst[t], createdate);
        if test = false then
          thelistitem.SubItems.Add('N/A')
        else
          thelistitem.SubItems.Add(datetostr(createdate));

        voicefolder := arcanumpath + '\Modules\' + modulefolder +
          '\Sound\Speech\' + copy(extractfilename(scriptlst[t]), 1, 5);
        if directoryexists(voicefolder) = True then
          thelistitem.SubItems.Add('Yes')
        else
          thelistitem.SubItems.Add('No');
      end;
    end;
  end
  else
  // Code for compressed modules
  begin
    MessageDlg('Compressed module - Script are not shown yet' + #13 + #10 + '' +
      #13 + #10 + 'code incomplete, SORRY!', mtInformation, [mbOK], 0);
  end;

end;

procedure LoadModuleDialogueList;
var
  path: String;
  str: String;
  voicefolder: string;
  desc: String;
  test: boolean;
  createdate, date: TDateTime;
  t: Integer;
  thelistitem: TListItem;
begin

  // Code for uncompressed modules
  if pos('.dat', modulefolder) = 0 then
  begin
    scriptlst := TStringList.Create;
    Form10.ListView1.Clear;
    path := arcanumpath + '\Modules\' + modulefolder + '\scr\?????*.scr';
    advbuildfilelist(path, faAnyFile, scriptlst, amAny, []);
    for t := 0 to scriptlst.Count - 1 do
    begin

      voicefolder := arcanumpath + '\Modules\' + modulefolder + '\Sound\Speech\'
        + copy(extractfilename(scriptlst[t]), 1, 5);

      if Form10.ScriptFilter.text <> '' then
      begin
        if (pos(Form10.ScriptFilter.text, scriptlst[t]) <> 0) and
          (fileexists(arcanumpath + '\Modules\' + modulefolder + '\dlg\' +
          changefileext(scriptlst[t], '.dlg'))) then
        begin

          LoadScriptHeaderOnly(arcanumpath + '\Modules\' + modulefolder +
            '\scr\' + scriptlst[t], tempscript);
          desc := tempscript.Description;
          thelistitem := Form10.ListView1.Items.Add;
          str := copy(scriptlst[t], 1, 5);

          if IsStrANumber(str) = True then
            thelistitem.Caption := str
          else
            thelistitem.Caption := '';

          if IsStrANumber(str) = True then
            str := copy(scriptlst[t], 6, length(scriptlst[t]))
          else
            str := scriptlst[t];

          thelistitem.SubItems.Add(str);
          thelistitem.SubItems.Add(desc);
          test := GetFileLastWrite(arcanumpath + '\Modules\' + modulefolder +
            '\scr\' + scriptlst[t], date);
          if test = false then
            thelistitem.SubItems.Add('N/A')
          else
            thelistitem.SubItems.Add(datetostr(date));
          test := GetFileCreation(arcanumpath + '\Modules\' + modulefolder +
            '\scr\' + scriptlst[t], createdate);
          if test = false then
            thelistitem.SubItems.Add('N/A')
          else
            thelistitem.SubItems.Add(datetostr(createdate));

          voicefolder := arcanumpath + '\Modules\' + modulefolder +
            '\Sound\Speech\' + copy(extractfilename(scriptlst[t]), 1, 5);
          if directoryexists(voicefolder) = True then
            thelistitem.SubItems.Add('Yes')
          else
            thelistitem.SubItems.Add('No');
        end;

      end
      else
      begin

        if (fileexists(arcanumpath + '\Modules\' + modulefolder + '\dlg\' +
          changefileext(scriptlst[t], '.dlg'))) then
        begin
          LoadScriptHeaderOnly(arcanumpath + '\Modules\' + modulefolder +
            '\scr\' + scriptlst[t], tempscript);
          desc := tempscript.Description;
          thelistitem := Form10.ListView1.Items.Add;
          str := copy(scriptlst[t], 1, 5);

          if IsStrANumber(str) = True then
            thelistitem.Caption := str
          else
            thelistitem.Caption := '';

          if IsStrANumber(str) = True then
            str := copy(scriptlst[t], 6, length(scriptlst[t]))
          else
            str := scriptlst[t];

          thelistitem.SubItems.Add(str);
          thelistitem.SubItems.Add(desc);
          test := GetFileLastWrite(arcanumpath + '\Modules\' + modulefolder +
            '\scr\' + scriptlst[t], date);
          if test = false then
            thelistitem.SubItems.Add('N/A')
          else
            thelistitem.SubItems.Add(datetostr(date));
          test := GetFileCreation(arcanumpath + '\Modules\' + modulefolder +
            '\scr\' + scriptlst[t], createdate);
          if test = false then
            thelistitem.SubItems.Add('N/A')
          else
            thelistitem.SubItems.Add(datetostr(createdate));

          voicefolder := arcanumpath + '\Modules\' + modulefolder +
            '\Sound\Speech\' + copy(extractfilename(scriptlst[t]), 1, 5);
          if directoryexists(voicefolder) = True then
            thelistitem.SubItems.Add('Yes')
          else
            thelistitem.SubItems.Add('No');
        end;
      end;
    end;
  end
  else
  // Code for compressed modules
  begin
    MessageDlg('Compressed module - Script are not shown yet' + #13 + #10 + '' +
      #13 + #10 + 'code incomplete, SORRY!', mtInformation, [mbOK], 0);
  end;

end;

{$R *.dfm}

procedure TForm10.ListView1Click(Sender: TObject);
begin
  if ListView1.selected <> nil then
    selectedmodulescript := ListView1.selected.Caption +
      ListView1.selected.SubItems[0];

end;

procedure TForm10.ListView1DblClick(Sender: TObject);
begin
  modalresult := mrOk;
end;

procedure TForm10.ScriptFilterKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    LoadModuleScriptList;
end;

procedure TForm10.Button3Click(Sender: TObject);
begin
  ScriptFilter.text := '';
  LoadModuleScriptList;
end;

procedure TForm10.DeleteScript1Click(Sender: TObject);
var
  deleteresult: boolean;
begin
  case MessageDlg(format('Are you sure you wish to delete this script file?' +
    #13 + #10 + '' + #13 + #10 + '%s', [selectedmodulescript]), mtConfirmation,
    [mbYes, mbNo], 0) of
    mrYes:
      begin
        deleteresult := DeleteFile(arcanumpath + '\Modules\' + modulefolder +
          '\scr\' + selectedmodulescript);
        if deleteresult = false then
          ConsoleDebug('Delete failed!')
        else
          ConsoleDebug('Delete success!');

        LoadModuleScriptList;
      end;
  end;
end;

end.
