unit AdvancedDATOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  moduleloader, CompressionSettings, JclFileUtils, ScriptEdConfig, Dialogs, StdCtrls, CheckLst, JvExCheckLst, JvCheckListBox,
  xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TForm22 = class(TForm)
    Label1:          TLabel;
    JvCheckListBox1: TJvCheckListBox;
    Label2:          TLabel;
    grp_ext:         TEdit;
    grp_list:        TListBOx;
    Label3:          TLabel;
    Button1:         TButton;
    Button2:         TButton;
    grp_folders:     TListBOx;
    Button3:         TButton;
    Button4:         TButton;
    Label4:          TLabel;
    Button5:         TButton;
    Button6:         TButton;
    XMLDocument1:    TXMLDocument;
    procedure Button3Click(Sender: TObject);
    procedure grp_listClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  file_split_group = record
    folders:   TStrings;
    extension: String;
  end;


var
  split_groups:      array of ^file_split_group;
  groupcnt:          Integer;
  Form22:            TForm22;
  modulesplitgroups: IXMLCompressionSettingsType;
  folderlist:        TStringList;
  filelist:          TStrings;

procedure GetFolders;

implementation

uses LoadModule;

procedure UpdateFolderList;
var
  t: Integer;
begin
  form22.JvCheckListBox1.Clear;
  for t := 0 to folderlist.Count - 1 do
  begin
    form22.JvCheckListBox1.Items.Add(folderlist[t]);
  end;
end;

procedure TransferCompressionSettingsFromXML;
var
  i, t: Integer;
  cgrp: IXMLSplitGroupType;

begin
  groupcnt := 0;
  for t := 0 to modulesplitgroups.Count - 1 do
  begin
    cgrp := modulesplitgroups[t];
    setlength(split_groups, groupcnt + 1);
    new(split_groups[t]);
    split_groups[t].extension := cgrp.Ext;
    split_groups[t].folders := TStringList.Create;
    for i := 0 to cgrp.folders.Count - 1 do
    begin
      split_groups[t].folders.Add(cgrp.Folders.Folder[i]);
      folderlist.Delete(folderlist.IndexOf(cgrp.Folders.Folder[i]));
    end;
    Inc(groupcnt);
  end;
end;


procedure TransferCompressionSettingsToXML;
var
  i, t: Integer;
  cgrp: IXMLSplitGroupType;
begin
  modulesplitgroups.Clear;
  for t := 0 to groupcnt - 1 do
  begin
    cgrp := modulesplitgroups.Add;
    cgrp.Ext := split_groups[t].extension;
    for i := 0 to split_groups[t].folders.Count - 1 do
    begin
      cgrp.Folders.Add(split_groups[t].folders[i]);
    end;
  end;
end;

procedure GetFolders;
var
  foldername: String;
  t: Integer;
begin
  filelist := TStringList.Create;
  folderlist := TStringList.Create;
  AdvBuildFileList(arcanumpath + '\Modules\' + selectedmodule + '\*', faAnyFile, filelist,
    amAny, [flRecursive, flFullNames]);
  for t := 0 to filelist.Count - 1 do
  begin
    foldername := ExtractRelativePath(arcanumpath + '\Modules\' + selectedmodule + '\', filelist[t]);
    foldername := extractfiledir(foldername);
    if (folderlist.IndexOf(foldername) = -1) and (isdirectory(arcanumpath + '\Modules\' + selectedmodule + '\' + foldername)) and
      (foldername <> '') then
    begin
      folderlist.Add(foldername);
    end;
  end;
  folderlist.sorted := True;
  UpdateFolderList;

end;


{$R *.dfm}

procedure DeleteSplitGroup(ind: Integer);
var
  t: Integer;
begin
  if ind = groupcnt - 1 then
  begin
    groupcnt := groupcnt - 1;
    exit;
  end;
  for t := ind to groupcnt - 1 do
  begin
    split_groups[t] := split_groups[t + 1];
  end;
  groupcnt := groupcnt - 1;
end;

procedure UpdateSplitGroups;
var
  t: Integer;
begin
  Form22.grp_list.Clear;
  for t := 0 to groupcnt - 1 do
  begin
    form22.grp_list.Items.Add('Group ' + IntToStr(t + 1) + ' => .' + split_groups[t].extension);
  end;

end;


procedure TForm22.Button3Click(Sender: TObject);
var
  t: Integer;
begin
  setlength(split_groups, groupcnt + 1);
  new(split_groups[groupcnt]);
  split_groups[groupcnt].folders := TStringList.Create;
  split_groups[groupcnt].extension := grp_ext.Text;
  for t := 0 to JvCheckListBox1.Items.Count - 1 do
  begin
    if jvchecklistbox1.Checked[t] = True then
    begin
      split_groups[groupcnt].folders.Add(JvCheckListBox1.Items[t]);
      // Clea
      jvchecklistbox1.Checked[t] := False;
      folderlist.Delete(folderlist.indexof(jvchecklistbox1.items[t]));
    end;
  end;
  Inc(groupcnt);
  UpdateSplitGroups;
  UpdateFolderList;
end;


procedure TForm22.grp_listClick(Sender: TObject);

begin
  if grp_list.ItemIndex = -1 then
    exit;
  grp_folders.Items.Assign(split_groups[grp_list.ItemIndex].folders);
  grp_ext.Text := split_groups[grp_list.ItemIndex].extension;

end;

procedure TForm22.Button4Click(Sender: TObject);
begin
  if grp_list.ItemIndex = -1 then
    exit;
  folderlist.AddStrings(split_groups[grp_list.ItemIndex].folders);
  DeleteSplitGroup(grp_list.ItemIndex);
  UpdateSplitGroups;
  UpdateFolderList;
  grp_folders.Clear;
  grp_ext.Text := '';
end;

procedure TForm22.FormCreate(Sender: TObject);
begin
  modulesplitgroups := NewCompressionSettings;

  if fileexists(arcanumpath + '\Modules\' + modulefolder + '\CompressionSettings.xml') then
  begin
    XMLDocument1.FileName := arcanumpath + '\Modules\' + modulefolder + '\CompressionSettings.xml';
    modulesplitgroups := GetCompressionSettings(xmldocument1);

  end;

end;

procedure TForm22.Button5Click(Sender: TObject);
begin
  modulesplitgroups := GetCompressionSettings(xmldocument1);
  TransferCompressionSettingsToXML;
  XMLDocument1.FileName := arcanumpath + '\Modules\' + selectedmodule + '\CompressionSettings.xml';
  xmldocument1.SaveToFile;
end;

procedure TForm22.Button6Click(Sender: TObject);
begin
  modulesplitgroups := NewCompressionSettings;
  if fileexists(arcanumpath + '\Modules\' + selectedmodule + '\CompressionSettings.xml') then
  begin
    XMLDocument1.FileName := arcanumpath + '\Modules\' + selectedmodule + '\CompressionSettings.xml';
    xmldocument1.LoadFromFile;
    modulesplitgroups := GetCompressionSettings(xmldocument1);
    TransferCompressionSettingsFromXML;
    UpdateFolderList;
    UpdateSplitGroups;
  end;

end;

end.
