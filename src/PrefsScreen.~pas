unit PrefsScreen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  arcanumscrlib, ScriptEdConfig, Dialogs, StdCtrls, Mask, JvExMask, JvToolEdit, ComCtrls, ExtCtrls,
  dws2Compiler, dws2Debugger,
  dws2Exprs, dws2Symbols, dws2Stack, dws2Comp,
  JvSpin;

type
  TForm15 = class(TForm)
    Button1:                   TButton;
    PageControl1:              TPageControl;
    TabSheet1:                 TTabSheet;
    scriptrenumber:            TCheckBox;
    Label1:                    TLabel;
    arcanumpath:               TJvDirectoryEdit;
    Button2:                   TButton;
    playeroptioncommentstyle:  TCheckBox;
    showcmpmodules:            TCheckBox;
    Label2:                    TLabel;
    newdlgnodestep:            TJvSpinEdit;
    EnterCompileTrigger:       TCheckBox;
    TabSheet2:                 TTabSheet;
    genderspecificreplace:     TCheckBox;
    Label3:                    TLabel;
    ListView1:                 TListView;
    Label4:                    TLabel;
    maledata:                  TEdit;
    Label5:                    TLabel;
    femaledata:                TEdit;
    Button3:                   TButton;
    Button4:                   TButton;
    debugverbose:              TCheckBox;
    TabSheet4:                 TTabSheet;
    Label6:                    TLabel;
    HelperScriptList:          TListView;
    Label7:                    TLabel;
    scriptfilename:            TJvFilenameEdit;
    Label8:                    TLabel;
    description:               TEdit;
    Label9:                    TLabel;
    categorycombo:             TComboBox;
    Button5:                   TButton;
    Button6:                   TButton;
    IncludeEntryPoints:        TCheckBox;
    AutoUpdateFemaleLine:      TCheckBox;
    confirmplayeroptiondelete: TCheckBox;
    procedure ListView1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure maledataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure femaledataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure HelperScriptListClick(Sender: TObject);
    procedure scriptfilenameAfterDialog(Sender: TObject; var AName: String; var AAction: Boolean);
    procedure Button5Click(Sender: TObject);
    procedure descriptionKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure categorycomboClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form15:        TForm15;
  script_import: TProgram;
  inf:           IInfo;

procedure RefreshGenderStrings;
procedure RefreshHelperScripts;
procedure WriteHelperScriptLoader;

implementation

uses scriptedwindow;

{$R *.dfm}

procedure WriteHelperScriptLoader;
var
  strs: TStrings;
  t: Integer;
begin

  strs := TStringList.Create;
  strs.add('//');
  strs.add('// ScriptEd 1.50');
  strs.add('// Helper Scripts master file');
  strs.add('//');
  strs.add('// --- note: this file is maintained by ScriptEd preferences --- ');
  strs.add('//');
  strs.add('// This file contains the list of helper scripts');
  strs.add('// to be added to the "Helper Scripts"-menu');
  strs.add('//');
  strs.add('');
  strs.add('InitializeHelperScriptMenu;');
  for t := 0 to tempscnt - 1 do
  begin
    strs.add(format('AddHelperScript(''%s'',''%s'',''%s'');', [templatescripts[t].filename, templatescripts[t].description,
      templatescripts[t].category]));
  end;
  strs.add('');
  strs.add('// end of scripts list');
  strs.add('//');
  strs.add('// File last updated ' + datetimetostr(now));
  strs.add('');
  strs.SaveToFile(extractfiledir(ParamStr(0)) + '\helperscripts\HelperScripts.dws');

end;

procedure DeleteHelperScript(ind: Integer);
var
  t: Integer;
begin
  if ind = tempscnt - 1 then
  begin
    tempscnt := tempscnt - 1;
    exit;
  end;
  for t := ind to tempscnt - 1 do
  begin
    templatescripts[t] := templatescripts[t + 1];
  end;
  tempscnt := tempscnt - 1;

end;


procedure RefreshHelperScripts;
var
  item: TListItem;
  t: Integer;
begin
  Form15.HelperScriptList.Clear;
  for t := 0 to tempscnt - 1 do
  begin
    item := form15.helperscriptlist.items.add;
    item.Caption := templatescripts[t].filename;
    item.subitems.add(templatescripts[t].description);
    item.subitems.add(templatescripts[t].category);
  end;
end;

procedure RefreshGenderStrings;
var
  x: TListItem;
  z: Integer;
begin
  form15.listview1.Clear;
  for z := 0 to genderstringcnt - 1 do
  begin
    x := form15.ListView1.Items.add;
    x.Caption := genderstrings[z].male;
    x.subitems.add(genderstrings[z].female);
  end;

end;

procedure TForm15.ListView1Click(Sender: TObject);
begin
  if listview1.selected <> nil then
  begin
    maledata.Text := genderstrings[listview1.selected.index].male;
    femaledata.Text := genderstrings[listview1.selected.index].female;
  end else
  begin
    maledata.Text := '';
    femaledata.Text := '';

  end;

end;

procedure TForm15.Button3Click(Sender: TObject);
begin
  if (maledata.Text <> '') and (femaledata.Text <> '') then
  begin
    AddGenderString(maledata.Text, femaledata.Text);
    RefreshGenderStrings;
    maledata.Text := '';
    femaledata.Text := '';
  end;

end;

procedure TForm15.Button4Click(Sender: TObject);
begin
  if ListView1.selected <> nil then
  begin
    DeleteGenderString(listview1.selected.index);
    RefreshGenderStrings;
    maledata.Text := '';

    femaledata.Text := '';
  end;

end;

procedure TForm15.maledataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if listview1.selected <> nil then
  begin
    ListView1.Selected.Caption := maledata.Text;
    genderstrings[listview1.selected.index].male := maledata.Text;
  end;

end;

procedure TForm15.femaledataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if listview1.selected <> nil then
  begin
    ListView1.Selected.subitems[0] := femaledata.Text;
    genderstrings[listview1.selected.index].female := femaledata.Text;
  end;

end;

procedure TForm15.FormCreate(Sender: TObject);
begin
  scriptfilename.InitialDir := ExtractFileDir(ParamStr(0)) + '\helperscripts';
end;

procedure TForm15.HelperScriptListClick(Sender: TObject);
begin
  if helperscriptlist.Selected <> nil then
  begin
    scriptfilename.FileName := templatescripts[helperscriptlist.selected.index].filename;
    description.Text := templatescripts[helperscriptlist.selected.index].description;
    categorycombo.ItemIndex := categorycombo.Items.indexof(templatescripts[helperscriptlist.selected.index].category);
  end else
  begin
    scriptfilename.FileName := '';
    description.Text := '';
    categorycombo.ItemIndex := -1;
  end;

end;

procedure TForm15.scriptfilenameAfterDialog(Sender: TObject; var AName: String; var AAction: Boolean);
var
  x,ind: Integer;
  resultinf: IInfo;
  scriptdata: TStrings;
begin
  scriptdata := TStringList.Create;
  scriptdata.loadfromfile(aname);
  AName := ExtractRelativePath(extractfiledir(ParamStr(0)) + '\', AName);

  if HelperScriptList.selected = nil then
  begin
    if pos('ImportScript', scriptdata.Text) <> 0 then
    begin
      Consoledebug('This script is importable, calling the ImportScriptProcedure');
      script_import := mainform.delphiwebscriptII1.compile(scriptdata.Text);
      if script_import.Msgs.Count > 0 then
      begin
        ConsoleDebug('ERROR MESSAGES!');
        for x:=0 to script_import.Msgs.count-1 do
        begin
        ConsoleDebug(script_import.Msgs[x].AsString);
        end;

        exit;
      end;
      script_import.beginprogram;
      inf := script_import.info.Func['ImportScript'];
      resultinf := inf.Call;
      RefreshHelperScripts;
      script_import.EndProgram;
      AName := '';
    end;

  end;


  if HelperScriptList.selected <> nil then
  begin
    HelperScriptList.Selected.Caption := aname;
    ind := helperscriptlist.Selected.Index;
    templatescripts[ind].filename := aname;
  end;

end;

procedure TForm15.Button5Click(Sender: TObject);
begin
  if (scriptfilename.FileName <> '') and (description.Text <> '') and (categorycombo.ItemIndex <> -1) then
  begin
    setlength(templatescripts, tempscnt + 1);
    new(templatescripts[tempscnt]);
    templatescripts[tempscnt].filename := scriptfilename.FileName;
    templatescripts[tempscnt].description := description.Text;
    templatescripts[tempscnt].category := categorycombo.Text;
    templatescripts[tempscnt].deleted  := False;
    Inc(tempscnt);
    RefreshHelperScripts;
    scriptfilename.FileName := '';
    description.Text := '';
    categorycombo.Text := '';
  end;

end;

procedure TForm15.descriptionKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ind: Integer;
begin

  if HelperScriptList.selected <> nil then
  begin
    HelperScriptList.Selected.subitems[0] := description.Text;
    ind := helperscriptlist.Selected.Index;
    templatescripts[ind].description := description.Text;
  end;

end;

procedure TForm15.categorycomboClick(Sender: TObject);
var
  ind: Integer;
begin
  if HelperScriptList.selected <> nil then
  begin
    HelperScriptList.Selected.subitems[1] := categorycombo.Text;
    ind := helperscriptlist.Selected.Index;
    templatescripts[ind].category := categorycombo.Text;
  end;
end;

procedure TForm15.Button6Click(Sender: TObject);
begin
  if HelperScriptList.selected <> nil then
  begin
    DeleteHelperScript(HelperScriptList.Selected.index);
    RefreshHelperScripts;
    scriptfilename.FileName := '';
    description.Text := '';
    categorycombo.Text := '';
  end;

end;

end.
