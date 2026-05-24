unit QuestEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  arcanumscrlib, strutils_, mesfileio, mesparser, ModuleLoader, Dialogs, ExtCtrls, StdCtrls,
  JvgListBox, Mask, JvExMask, JvSpin, JvExStdCtrls, JvHtControls;

type
  TForm8 = class(TForm)
    Label1:        TLabel;
    Label2:        TLabel;
    questlogsmart: TMemo;
    Label3:        TLabel;
    questlogdumb:  TMemo;
    Label4:        TLabel;
    questxpr:      TEdit;
    Label5:        TLabel;
    questaligns:   TEdit;
    Button1:       TButton;
    Button2:       TButton;
    Label6:        TLabel;
    questid:       TJvSpinEdit;
    Button3:       TButton;
    Button4:       TButton;
    questlist:     TJvHTListBox;
    Label7:        TLabel;
    xprewarddata:  TLabel;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure questlogsmartKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure questlogdumbKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure questxprKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure questalignsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure questlistClick(Sender: TObject);
    procedure questlistMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8:     TForm8;
  questdata: String;

procedure UpdateQuestsList;

implementation

procedure UpdateItem(ind: Integer);
var
  wordwrapped: String;
begin
  if length(gamequestlog.entries[ind].messagestr) >= 63 then
  begin
    wordwrapped := gamequestlog.entries[ind].messagestr;
    wordwrapped := StringReplace(wordwrapped, '''', '\sq', [rfReplaceAll]);

    wordwrapped := wraptext(wordwrapped, '<br>', [' ', '-', '.', ','], 63);

    wordwrapped := StringReplace(wordwrapped, '\sq', '''', [rfReplaceAll]);

    form8.questlist.Items[ind] := IntToStr(gamequestlog.entries[ind].index) + ' - ' + wordwrapped;
  end else
    form8.questlist.Items[ind] := IntToStr(gamequestlog.entries[ind].index) + ' - ' + gamequestlog.entries[ind].messagestr;

end;


procedure UpdateQuestsList;
var
  wordwrapped: String;
  t: Integer;
begin
  Form8.questlist.Clear;
  for t := 0 to GameQuestLog.entrycnt - 1 do
  begin

    if length(gamequestlog.entries[t].messagestr) >= 63 then
    begin
      wordwrapped := gamequestlog.entries[t].messagestr;
      wordwrapped := StringReplace(wordwrapped, '''', '\sq', [rfReplaceAll]);

      wordwrapped := wraptext(wordwrapped, '<br>', [' ', '-', '.', ','], 63);

      wordwrapped := StringReplace(wordwrapped, '\sq', '''', [rfReplaceAll]);

      form8.questlist.Items.add(IntToStr(gamequestlog.entries[t].index) + ' - ' + wordwrapped);
    end else
      form8.questlist.Items.add(IntToStr(gamequestlog.entries[t].index) + ' - ' + gamequestlog.entries[t].messagestr);

  end;

end;


{$R *.dfm}

function makespc(start, stop: Integer): String;
var
  i: Integer;
begin
  Result := '';
  for i := start to stop do
    Result := Result + ' ';
end;

procedure TForm8.Button3Click(Sender: TObject);
var
  lastid: Integer;
begin
  if gamequest.entrycnt > 0 then
    lastid := GameQuest.entries[gamequest.entrycnt - 1].index
  else
    lastid := 1000;

  AddMesEntry(lastid + 1, 'new quest', GameQuestLog);
  AddMesEntry(lastid + 1, 'new quest dumb', GameQuestLogDumb);
  AddMesEntry(lastid + 1, '0 0 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1', GameQuest);
  UpdateQuestsList;
end;

procedure TForm8.Button4Click(Sender: TObject);
var
  id: Integer;
  smartlogindex, dumblogindex: Integer;
begin
  if questlist.ItemIndex <> -1 then
  begin
    id := questlist.ItemIndex;
    smartlogindex := GetMesIndexByID(gamequest.entries[id].index, gamequestlog);
    if smartlogindex <> -1 then
      DeleteMesEntry(smartlogindex, GameQuestLog)
    else
      consoledebug('Not deleting this index for smart player because it doesn''t exist!');


    dumblogindex := GetMesIndexByID(gamequest.entries[id].index, gamequestlogdumb);
    if dumblogindex <> -1 then
      DeleteMesEntry(dumblogindex, GameQuestLogDumb)
    else
      consoledebug('Not deleting this index for dumb player because it doesn''t exist!');

    DeleteMesEntry(id, GameQuest);
    UpdateQuestsList;
  end;

end;

procedure TForm8.questlogsmartKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if questlist.ItemIndex <> -1 then
  begin
    GameQuestLog.entries[questlist.ItemIndex].messagestr := questlogsmart.Text;
    UpdateItem(questlist.ItemIndex);
  end;

end;

procedure TForm8.questlogdumbKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if questlist.ItemIndex <> -1 then
  begin
    GameQuestLogDumb.entries[questlist.ItemIndex].messagestr := questlogdumb.Text;
    UpdateItem(questlist.ItemIndex);
  end;
end;

procedure TForm8.questxprKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ind: Integer;

  Data: String;
  data_int: Integer;
  wordpos: Integer;
begin
  if questxpr.Text = '' then
    exit;
  ind := questlist.ItemIndex;
  questdata := GameQuest.entries[ind].messagestr;

  Data := extractwordpos(1, questdata, [' '], wordpos);
  Delete(questdata, wordpos, length(Data));
  insert(questxpr.Text, questdata, wordpos);
  data_int := StrToInt(questxpr.Text);
  xprewarddata.Caption := GetMesStringByID(data_int, QuestXPRewards);

  GameQuest.entries[ind].messagestr := questdata;

end;

procedure TForm8.questalignsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ind: Integer;

  Data: String;
  wordpos: Integer;
begin
  if questaligns.Text = '' then
    exit;

  ind  := questlist.ItemIndex;
  questdata := GameQuest.entries[ind].messagestr;
  Data := extractwordpos(2, questdata, [' '], wordpos);
  Delete(questdata, wordpos, length(Data));
  insert(questaligns.Text, questdata, wordpos);
  GameQuest.entries[ind].messagestr := questdata;

end;

procedure TForm8.questlistClick(Sender: TObject);
var
  thepos, x, Data: Integer;
  theword, posdatastr: String;
  dumbmissing, smartmissing: Boolean;
  questdatasmartindex, questdatadumbindex, questxp, questalign: Integer;
  questdata: String;
begin
  if questlist.ItemIndex <> -1 then
  begin
    Data := questlist.ItemIndex;
    questlogsmart.Enabled := True;
    questlogdumb.Enabled := True;
    questdatadumbindex := GetMesIndexByID(GameQuest.entries[Data].index, GameQuestLogDumb);
    questdatasmartindex := GetMesIndexByID(GameQuest.entries[Data].index, GameQuestLog);
    dumbmissing := False;
    smartmissing := False;
    // Sanity check - is either of these entries missing?
    if questdatadumbindex = -1 then
    begin
      Consoledebug('Quest log entry (dumb) ' + IntToStr(GameQuest.entries[Data].index) + ' is missing!');
      dumbmissing := True;

    end;

    if questdatasmartindex = -1 then
    begin
      Consoledebug('Quest log entry (normal) ' + IntToStr(GameQuest.entries[Data].index) + ' is missing!');
      smartmissing := True;

    end;



    if Data > gamequestlogdumb.entrycnt - 1 then
    begin
      ConsoleDebug('ERROR! Dumb quest log is out of sync at quest id ' + IntToStr(GameQuest.entries[Data].index) + '!');
      questlogdumb.Enabled := False;
    end else
    begin
      consoledebug('attempting to access ' + IntToStr(Data) + '/' + IntToStr(GameQuestLogDumb.entrycnt));
      if dumbmissing = False then

        questlogdumb.Text := GameQuestLogDumb.entries[questdatadumbindex].messagestr
      else
      begin
        MessageDlg(format('WARNING!' + #13 + #10 + '' + #13 + #10 + 'Dumb player quest log text for quest %d' +
          #13 + #10 + 'is missing! Both smart and dumb quest log data should be kept ' + #13#10 +
          ' in sync even if the entry doesn''t get used. ', [gamequest.entries[Data].index]), mtWarning, [mbOK], 0);
        questlogdumb.Enabled := False;
        questlogdumb.Text := '';
      end;

    end;

    if smartmissing = False then
      questlogsmart.Text := GameQuestLog.entries[Data].messagestr
    else
    begin
      MessageDlg(format('WARNING!' + #13 + #10 + '' + #13 + #10 + 'Normal player quest log text for quest %d' +
        #13 + #10 + 'is missing! Both smart and dumb quest log data should be kept ' + #13#10 +
        ' in sync even if the entry doesn''t get used. ', [gamequest.entries[Data].index]), mtWarning, [mbOK], 0);
      questlogsmart.Enabled := False;
      questlogsmart.Text := '';
    end;

    questdata := GameQuest.entries[Data].messagestr;
    questxp := StrToInt(extractword(1, questdata, [' ']));
    questalign := StrToInt(extractword(2, questdata, [' ']));
    questxpr.Text := IntToStr(questxp);
    xprewarddata.Caption := GetMesStringByID(questxp, QuestXPRewards);
    questaligns.Text := IntToStr(questalign);
    questid.Value := GameQuest.entries[Data].index;
  end;
end;

procedure TForm8.questlistMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if questlist.ItemAtPos(Point(x, y), True) = -1 then
  begin
    questid.Value := 1000;
    questlogsmart.Clear;
    questlogdumb.Clear;
    questxpr.Clear;
    questaligns.Clear;
    questlist.ItemIndex := -1;

  end;

end;

end.
