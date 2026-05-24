unit MESFileShow;

interface

uses
  Windows, moduleloader, mesfileio, mesparser, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  arcanumscrlib, StdCtrls, ComCtrls;

type
  TForm7 = class(TForm)
    Button1:      TButton;
    ListView1:    TListView;
    Label1:       TLabel;
    index:        TEdit;
    Label2:       TLabel;
    mesdata:      TMemo;
    addbutton:    TButton;
    deletebutton: TButton;
    insertbutton: TButton;
    Label3:       TLabel;
    comments:     TMemo;
    Button2:      TButton;
    CheckBox1:    TCheckBox;
    procedure ListView1Click(Sender: TObject);
    procedure deletebuttonClick(Sender: TObject);
    procedure addbuttonClick(Sender: TObject);
    procedure indexKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure commentsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mesdataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure insertbuttonClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ListView1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7:          TForm7;
  currentmsgfile: messagefile;

procedure ShowMSGData(var msgfile: MessageFile);

implementation

procedure UpdateMSGData;
var
  s: TListItem;
  t: Integer;
begin
  form7.ListView1.Clear;

  for t := 0 to currentmsgfile.entrycnt - 1 do
  begin
    s := form7.ListView1.Items.add;
    s.Caption := IntToStr(currentmsgfile.entries[t].index);
    s.SubItems.Add(currentmsgfile.entries[t].messagestr);
  end;

end;

procedure UpdateListItem;
begin
  if form7.listview1.selected <> nil then
  begin
    form7.listview1.items[form7.listview1.ItemIndex].Caption := IntToStr(currentmsgfile.entries[form7.ListView1.Selected.index].index);
    form7.listview1.items[form7.listview1.ItemIndex].SubItems[0] := currentmsgfile.entries[form7.ListView1.Selected.index].messagestr;
  end;

end;

procedure ShowMSGData(var msgfile: MessageFile);
var
  s: TListItem;
  t: Integer;
begin
  currentmsgfile := msgfile;
  currentmsgfile.entries := msgfile.entries;
  form7.ListView1.Clear;
  form7.index.Text := '';
  form7.comments.Text := '';
  form7.mesdata.Text := '';

  for t := 0 to msgfile.entrycnt - 1 do
  begin
    s := form7.ListView1.Items.add;
    s.Caption := IntToStr(msgfile.entries[t].index);
    s.SubItems.Add(msgfile.entries[t].messagestr);
  end;
  form7.Caption := 'MES File Data - [' + extractfilename(msgfile.msgfilename) + ']';
end;

{$R *.dfm}

procedure TForm7.ListView1Click(Sender: TObject);
begin
  if listview1.selected <> nil then
  begin
    mesdata.Text := currentmsgfile.entries[listview1.selected.index].messagestr;
    index.Text := IntToStr(currentmsgfile.entries[listview1.selected.index].index);
    comments.Text := currentmsgfile.entries[listview1.selected.index].beforeline_comments.Text;
    CheckBox1.Checked := currentmsgfile.entries[listview1.selected.index].add_linebreak;
    deletebutton.Enabled := True;
  end else
  begin
    deletebutton.Enabled := False;
    mesdata.Text := '';
    index.Text := '';
    comments.Text := '';
  end;
end;

procedure TForm7.deletebuttonClick(Sender: TObject);
var
  oldindex: Integer;
begin
  if listview1.Selected = nil then
  begin
    exit;
  end;
  oldindex := listview1.selected.index;
  if oldindex = listview1.items.Count-1 then
  oldindex := listview1.selected.index-1;
  DeleteMesEntry(listview1.selected.index, currentmsgfile);
  UpdateMSGData;

  listview1.ItemIndex := oldindex;
  listview1.Selected.MakeVisible(False);
  listview1.SetFocus;

end;


procedure TForm7.addbuttonClick(Sender: TObject);
var
  newid: Integer;
  oldindex: Integer;
begin
  oldindex := listview1.items.Count;
  newid := currentmsgfile.entries[listview1.items[listview1.items.Count - 1].Index].index + 1;
  AddMesEntry(newid, '', CurrentmsgFile);
  updatemsgdata;
  listview1.SetFocus;
  // listview1.ScrollBy(0, listview1.items.Count - 1);
  listview1.ItemIndex := oldindex;
  listview1.Selected.MakeVisible(False);
  ListView1Click(nil);
end;

procedure TForm7.indexKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if listview1.selected = nil then
    exit;

  if index.Text <> '' then
  begin

    currentmsgfile.entries[listview1.Selected.index].index := StrToInt(index.Text);
    UpdateListItem;
  end;
end;


procedure TForm7.commentsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  t: Integer;
begin
  if listview1.selected = nil then
    exit;

  currentmsgfile.entries[listview1.Selected.index].beforeline_comments.Clear;
  for t := 0 to comments.Lines.Count - 1 do
  begin
    currentmsgfile.entries[listview1.Selected.index].beforeline_comments.Add(comments.Lines[t], 0, 0);
  end;

end;

procedure TForm7.mesdataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if listview1.selected = nil then
    exit;

  currentmsgfile.entries[listview1.Selected.index].messagestr := mesdata.Text;
  UpdateListItem;

end;


procedure TForm7.insertbuttonClick(Sender: TObject);
var
  newid: Integer;
  oldindex: Integer;
begin
  oldindex := listview1.selected.index;
  newid := currentmsgfile.entries[listview1.Selected.index].index + 1;
  InsertMesEntry(newid, oldindex + 1, CurrentmsgFile);
  updatemsgdata;
  listview1.SetFocus;
  // listview1.ScrollBy(0, listview1.items.Count - 1);
  listview1.ItemIndex := oldindex + 1;
  listview1.Selected.MakeVisible(False);
  ListView1Click(nil);

end;

procedure TForm7.CheckBox1Click(Sender: TObject);
begin
  currentmsgfile.entries[listview1.selected.index].add_linebreak := CheckBox1.Checked;

end;

procedure TForm7.ListView1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ListView1Click(nil);
end;

end.

