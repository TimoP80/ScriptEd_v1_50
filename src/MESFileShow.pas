unit MESFileShow;

interface

uses
  Windows, moduleloader, mesfileio, mesparser, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms, Dialogs,
  arcanumscrlib, StdCtrls, ComCtrls;

type
  TForm7 = class(TForm)
    Button1: TButton;
    ListView1: TListView;
    Label1: TLabel;
    index: TEdit;
    Label2: TLabel;
    mesdata: TMemo;
    addbutton: TButton;
    deletebutton: TButton;
    insertbutton: TButton;
    Label3: TLabel;
    comments: TMemo;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Button3: TButton;
    procedure ListView1Click(Sender: TObject);
    procedure deletebuttonClick(Sender: TObject);
    procedure addbuttonClick(Sender: TObject);
    procedure indexKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure commentsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mesdataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure insertbuttonClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ListView1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;
  currentmsgfile: messagefile;

procedure ShowMSGData(var msgfile: messagefile);

implementation

uses MESFileHeader;

procedure UpdateMSGData;
var
  s: TListItem;
  t: Integer;
begin
  Form7.ListView1.Clear;

  for t := 0 to currentmsgfile.entrycnt - 1 do
  begin
    s := Form7.ListView1.Items.add;
    s.Caption := IntToStr(currentmsgfile.entries[t].index);
    s.SubItems.add(currentmsgfile.entries[t].messagestr);
  end;

end;

procedure UpdateListItem;
begin
  if Form7.ListView1.selected <> nil then
  begin
    Form7.ListView1.Items[Form7.ListView1.ItemIndex].Caption :=
      IntToStr(currentmsgfile.entries[Form7.ListView1.selected.index].index);
    Form7.ListView1.Items[Form7.ListView1.ItemIndex].SubItems[0] :=
      currentmsgfile.entries[Form7.ListView1.selected.index].messagestr;
  end;

end;

procedure ShowMSGData(var msgfile: messagefile);
var
  s: TListItem;
  t: Integer;
begin
  currentmsgfile := msgfile;
  currentmsgfile.entries := msgfile.entries;
  Form7.ListView1.Clear;
  Form7.index.Text := '';
  Form7.comments.Text := '';
  Form7.mesdata.Text := '';

  for t := 0 to msgfile.entrycnt - 1 do
  begin
    s := Form7.ListView1.Items.add;
    s.Caption := IntToStr(msgfile.entries[t].index);
    s.SubItems.add(msgfile.entries[t].messagestr);
  end;
  Form7.Caption := 'MES File Data - [' + extractfilename
    (msgfile.msgfilename) + ']';
end;

{$R *.dfm}

procedure TForm7.ListView1Click(Sender: TObject);
begin
  if ListView1.selected <> nil then
  begin
    mesdata.Text := currentmsgfile.entries[ListView1.selected.index].messagestr;
    index.Text := IntToStr(currentmsgfile.entries[ListView1.selected.
      index].index);
    comments.Text := currentmsgfile.entries[ListView1.selected.index]
      .beforeline_comments.Text;
    CheckBox1.Checked := currentmsgfile.entries[ListView1.selected.index]
      .add_linebreak;
    deletebutton.Enabled := True;
  end
  else
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
  if ListView1.selected = nil then
  begin
    exit;
  end;
  oldindex := ListView1.selected.index;
  if oldindex = ListView1.Items.Count - 1 then
    oldindex := ListView1.selected.index - 1;
  DeleteMesEntry(ListView1.selected.index, currentmsgfile);
  UpdateMSGData;

  ListView1.ItemIndex := oldindex;
  ListView1.selected.MakeVisible(False);
  ListView1.SetFocus;

end;

procedure TForm7.addbuttonClick(Sender: TObject);
var
  newid: Integer;
  oldindex: Integer;
begin
  oldindex := ListView1.Items.Count;
  newid := currentmsgfile.entries[ListView1.Items[ListView1.Items.Count - 1].
    index].index + 1;
  AddMesEntry(newid, '', currentmsgfile);
  UpdateMSGData;
  ListView1.SetFocus;
  // listview1.ScrollBy(0, listview1.items.Count - 1);
  ListView1.ItemIndex := oldindex;
  ListView1.selected.MakeVisible(False);
  ListView1Click(nil);
end;

procedure TForm7.indexKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ListView1.selected = nil then
    exit;

  if index.Text <> '' then
  begin

    currentmsgfile.entries[ListView1.selected.index].index :=
      StrToInt(index.Text);
    UpdateListItem;
  end;
end;

procedure TForm7.commentsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  t: Integer;
begin
  if ListView1.selected = nil then
    exit;

  currentmsgfile.entries[ListView1.selected.index].beforeline_comments.Clear;
  for t := 0 to comments.Lines.Count - 1 do
  begin
    currentmsgfile.entries[ListView1.selected.index].beforeline_comments.add
      (comments.Lines[t], 0, 0);
  end;

end;

procedure TForm7.mesdataKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ListView1.selected = nil then
    exit;

  currentmsgfile.entries[ListView1.selected.index].messagestr := mesdata.Text;
  UpdateListItem;

end;

procedure TForm7.insertbuttonClick(Sender: TObject);
var
  newid: Integer;
  oldindex: Integer;
begin
  oldindex := ListView1.selected.index;
  newid := currentmsgfile.entries[ListView1.selected.index].index + 1;
  InsertMesEntry(newid, oldindex + 1, currentmsgfile);
  UpdateMSGData;
  ListView1.SetFocus;
  // listview1.ScrollBy(0, listview1.items.Count - 1);
  ListView1.ItemIndex := oldindex + 1;
  ListView1.selected.MakeVisible(False);
  ListView1Click(nil);

end;

procedure TForm7.Button3Click(Sender: TObject);
begin
updateheader;
form24.showmodal;
if form24.ModalResult=mrOk then
begin
  Currentmsgfile.header := form24.MESHeader.Text;
end;
end;

procedure TForm7.CheckBox1Click(Sender: TObject);
begin
  currentmsgfile.entries[ListView1.selected.index].add_linebreak :=
    CheckBox1.Checked;

end;

procedure TForm7.ListView1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ListView1Click(nil);
end;

end.
