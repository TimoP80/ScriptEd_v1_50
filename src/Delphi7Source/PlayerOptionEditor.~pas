unit PlayerOptionEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DLGParser, DLGFileIO, Dialogs, StdCtrls, Mask, ArcanumSCRLib, JvExMask, JvSpin, JvPageList, JvExControls,
  JvExStdCtrls, JvHtControls;

type
  TForm12 = class(TForm)
    Label1:          TLabel;
    Label2:          TLabel;
    Label3:          TLabel;
    conditionsline:  TEdit;
    Button1:         TButton;
    Label4:          TLabel;
    iqdata1:         TJvSpinEdit;
    Label5:          TLabel;
    actionsline:     TEdit;
    Button2:         TButton;
    Label6:          TLabel;
    LinkPages:       TJvPageList;
    CallScriptPage:  TJvStandardPage;
    LinkToNodePage:  TJvStandardPage;
    nodelist:        TListBOx;
    Label7:          TLabel;
    Button3:         TButton;
    Button4:         TButton;
    ComboBox2:       TComboBox;
    ExitDLGNullPage: TJvStandardPage;
    Label8:          TLabel;
    Label9:          TLabel;
    scriptlinelist:  TListBOx;
    Label10:         TLabel;
    JvHTListBox1:    TJvHTListBox;
    Label11:         TLabel;
    finaldata:       TLabel;
    Label12:         TLabel;
    nodetext:        TLabel;
    playertextline:  TMemo;
    Button5:         TButton;
    malerestr:       TCheckBox;
    femalerestr:     TCheckBox;
    normalint:       TRadioButton;
    dumbint:         TRadioButton;
    otherint:        TRadioButton;
    Label13:         TLabel;
    extcomments:     TMemo;
    procedure ComboBox2Click(Sender: TObject);
    procedure scriptlinelistClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nodelistClick(Sender: TObject);
    procedure playertextlineKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure conditionslineKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actionslineKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure iqdata1Click(Sender: TObject);
    procedure malerestrClick(Sender: TObject);
    procedure femalerestrClick(Sender: TObject);
    procedure otherintClick(Sender: TObject);
    procedure dumbintClick(Sender: TObject);
    procedure normalintClick(Sender: TObject);
    procedure JvHTListBox1Click(Sender: TObject);
    procedure extcommentsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12:         TForm12;
  playertextdata: String;
  conditiondata:  String;
  actiondata:     String;
  iqdata:         Integer;
  commentdata:    String;
  genderdata:     Integer;
  linkdata:       Integer;

procedure RefreshData;
procedure PlaceDataOnForm;
procedure SetData(conds, actions, playertext: String; iqtest, gender: Integer; link: Integer; comments: String);
procedure GetData(var conds, actions, playertext: String; var iqtest, gender: Integer; var link: Integer; var comments: String);
procedure ClearForm;
procedure ClearData;

implementation

{$R *.dfm}

procedure SetData(conds, actions, playertext: String; iqtest, gender: Integer; link: Integer; comments: String);
begin
  conditiondata := conds;
  actiondata := actions;
  playertextdata := playertext;
  iqdata := iqtest;
  genderdata := gender;
  linkdata := link;
  commentdata := comments;
end;

procedure ClearData;
begin
  conditiondata := '';
  actiondata := '';
  playertextdata := '';
  iqdata := 0;
  genderdata := NO_GENDER;
  linkdata := 0;
  commentdata := '';
end;

procedure GetData(var conds, actions, playertext: String; var iqtest, gender: Integer; var link: Integer; var comments: String);
begin

  if (form12.femalerestr.Checked = True) and (form12.malerestr.Checked = False) then
    genderdata := GENDER_FEMALE
  else
  if (form12.femalerestr.Checked = False) and (form12.malerestr.Checked = True) then
    genderdata := GENDER_MALE
  else
  if (form12.femalerestr.Checked = False) and (form12.malerestr.Checked = False) then
    genderdata := NO_GENDER;

  if Form12.normalint.Checked = True then
    iqdata := 5
  else
  if Form12.dumbint.Checked = True then
    iqdata := -4
  else
  if form12.otherint.Checked = True then
    iqdata := form12.iqdata1.AsInteger;
  conds := conditiondata;
  actions := actiondata;
  playertext := playertextdata;
  iqtest := iqdata;
  gender := genderdata;
  link := linkdata;
  comments := commentdata;
  //  ShowMessage('iq data = ' + IntToStr(iqdata));
end;

procedure ClearForm;
begin
  form12.conditionsline.Text := '';
  form12.actionsline.Text := '';
  form12.playertextline.Text := '';
  form12.iqdata1.Value := 1;
  form12.femalerestr.Checked := False;
  form12.malerestr.Checked := False;
  form12.extcomments.Clear;
  form12.combobox2.ItemIndex  := 0;
  Form12.LinkPages.ActivePage := Form12.ExitDLGNullPage;
end;

procedure PlaceDataOnForm;
var
  theint: Integer;
  thestr: String;
begin
  form12.conditionsline.Text := conditiondata;
  form12.actionsline.Text := actiondata;
  form12.playertextline.Text := playertextdata;
  if iqdata = 5 then
  begin
    form12.iqdata1.Enabled := False;
    form12.normalint.Checked := True;
  end else
  if iqdata = -4 then
  begin
    form12.iqdata1.Enabled := False;
    form12.dumbint.Checked := True;
  end else
  begin
    form12.iqdata1.Enabled  := True;
    form12.otherint.Checked := True;
  end;

  form12.iqdata1.Value := iqdata;

  case genderdata of
    GENDER_FEMALE:
    begin
      form12.femalerestr.Checked := True;
      form12.malerestr.Checked := False;
    end;
    GENDER_MALE:
    begin
      form12.femalerestr.Checked := False;
      form12.malerestr.Checked := True;
    end;
    NO_GENDER:
    begin
      form12.femalerestr.Checked := False;
      form12.malerestr.Checked := False;
    end;

  end;
  if linkdata < 0 then
  begin
    form12.combobox2.ItemIndex := 1;
    Form12.LinkPages.ActivePage := Form12.CallScriptPage;
    thestr := IntToStr(linkdata);
    thestr := stringreplace(thestr, '-', '', [rfReplaceAll]);
    theint := StrToInt(thestr);
    form12.scriptlinelist.ItemIndex := theint;
    form12.JvHTListBox1.ItemIndex := theint;
    form12.scriptlinelistClick(nil);
  end else
  if linkdata > 0 then
  begin
    form12.combobox2.ItemIndex := 2;
    Form12.LinkPages.ActivePage := Form12.LinkToNodePage;
    form12.nodelist.ItemIndex := GetNodeIndexWithDLGLine(linkdata);
    form12.nodelistClick(nil);
  end else
  if linkdata = 0 then
  begin
    form12.ComboBox2.ItemIndex  := 0;
    form12.LinkPages.ActivePage := form12.ExitDLGNullPage;
  end;
  form12.extcomments.Text := commentdata;
end;

procedure RefreshData;
var
  t: Integer;
begin
  form12.nodelist.Items.Clear;
  for t := 0 to curdlg.nodecount - 1 do
  begin
    form12.nodelist.Items.add(curdlg.nodes[t].nodename);
  end;
  form12.scriptlinelist.Clear;
  for t := 0 to CurrentScript.LineCount - 1 do
  begin
    form12.scriptlinelist.Items.Add('Line ' + IntToStr(t));
  end;

end;


procedure TForm12.ComboBox2Click(Sender: TObject);
begin
  case combobox2.ItemIndex of
    0:
    begin
      linkdata := 0;
      LinkPages.ActivePage := ExitDLGNullPage;
      finaldata.Caption := IntToStr(linkdata);
    end;

    1:
      linkpages.ActivePage := CallScriptPage;
    2:
      linkpages.ActivePage := LinkToNodePage;
  end;

end;

procedure TForm12.scriptlinelistClick(Sender: TObject);
var
  str: String;
  s, id: Integer;
begin
  id := scriptlinelist.ItemIndex;
  if id <> -1 then
  begin
    jvhtlistbox1.Clear;
    for s := 0 to CurrentScript.LineCount - 1 do
    begin
      str := IntToStr(s) + '. ' + decode_script_line(currentscript.scriptlines[s]^);
      str := StringReplace(str, #13#10, '<br>', [rfReplaceAll]);
      if s = id then
        str := '<b>' + str + '</b>';
      JvHTListBox1.Items.add(str);

    end;
    jvhtlistbox1.ItemIndex := id;
    linkdata := StrToInt('-' + IntToStr(id));
    finaldata.Caption := IntToStr(linkdata);
    //decodedline.Caption := inttostr(id)+'. '+decode_script_line(currentscript.scriptlines[id]^);
  end;

end;

procedure TForm12.FormShow(Sender: TObject);
begin
  combobox2click(nil);
end;

procedure TForm12.nodelistClick(Sender: TObject);
var
  i: Integer;
  Name: String;
  ind: Integer;
begin

  i := nodelist.ItemIndex;
  if i <> -1 then
  begin
    Name := nodelist.Items[nodelist.ItemIndex];
    ind  := GetNodeIndex(Name);
    if ind <> -1 then
    begin
      nodetext.Caption := curdlg.nodes[ind].npctextmale;
      linkdata := curdlg.nodes[ind].start_index;
      finaldata.Caption := IntToStr(linkdata);
    end;
  end;

end;

procedure TForm12.playertextlineKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  playertextdata := playertextline.Text;
end;

procedure TForm12.conditionslineKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  conditiondata := conditionsline.Text;
end;

procedure TForm12.actionslineKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  actiondata := actionsline.Text;
end;

procedure TForm12.iqdata1Click(Sender: TObject);
begin
  iqdata := iqdata1.AsInteger;
end;

procedure TForm12.malerestrClick(Sender: TObject);
begin
  if femalerestr.Checked = True then
    femalerestr.Checked := False;

end;

procedure TForm12.femalerestrClick(Sender: TObject);
begin
  if malerestr.Checked = True then
    malerestr.Checked := False;

end;

procedure TForm12.otherintClick(Sender: TObject);
begin
  iqdata1.Enabled := True;
end;

procedure TForm12.dumbintClick(Sender: TObject);
begin
  iqdata1.Enabled := False;

end;

procedure TForm12.normalintClick(Sender: TObject);
begin
  iqdata1.Enabled := False;
end;

procedure TForm12.JvHTListBox1Click(Sender: TObject);
begin
  scriptlinelist.ItemIndex := jvhtlistbox1.ItemIndex;
  scriptlinelistClick(nil);
end;

procedure TForm12.extcommentsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  commentdata := extcomments.Text;
end;

end.
