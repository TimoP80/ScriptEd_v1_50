unit GenericSelectorWindow;

interface

uses
  Windows, Messages, SysUtils, dlgfileio, dlgparser, Variants, Classes, Graphics, Controls, Forms,
  JclFileUtils, moduleloader, scriptedconfig, Mesfileio, mesparser, Dialogs,
  StdCtrls, JvExStdCtrls, JvHtControls;

type
  TForm16 = class(TForm)
    JvHTListBox1: TJvHTListBox;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    procedure JvHTListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  strs: TStrings;
  Form16: TForm16;

procedure FillInDataFromMesFile(mes: MessageFile);
procedure GetAllModuleMesFiles;
procedure FillInDataFromMesFileWithDivisor(divisor: integer; mes: MessageFile);
procedure FillInDataFromDialogueFile(dlgptr: PDialogueFile);

implementation

uses CocoBase;

procedure GetAllModuleMesFiles;
var
  t: Integer;
  linedata: String;
begin
  strs := TStringList.Create;
  advbuildfilelist(arcanumpath + '\Modules\' + modulefolder + '\*.mes',
    faAnyfile, strs, amAny, [flRecursive, flFullNames]);
  Form16.JvHTListBox1.Clear;
  for t := 0 to strs.Count - 1 do
  begin
    linedata := ExtractRelativePath(arcanumpath + '\Modules\' + modulefolder +
      '\', strs[t]);
    Form16.JvHTListBox1.Items.Add(linedata);
  end;

end;

procedure FillInDataFromMesFileWithDivisor(divisor: integer; mes: MessageFile);
var
  linedata: String;
  wordwrapped: String;
  commentswrapped: String;
  t: Integer;
begin
  Form16.JvHTListBox1.Clear;
  for t := 0 to mes.entrycnt - 1 do
  begin
    wordwrapped := mes.entries[t].messagestr;
    wordwrapped := StringReplace(wordwrapped, '''', '\sq', [rfReplaceAll]);
    wordwrapped := StringReplace(wordwrapped, '"', '\dq', [rfReplaceAll]);
    wordwrapped := wraptext(wordwrapped, '<br>' + '       ',
      [' ', '-', ','], 53);
    wordwrapped := StringReplace(wordwrapped, '\sq', '''', [rfReplaceAll]);
    wordwrapped := StringReplace(wordwrapped, '\dq', '"', [rfReplaceAll]);
    linedata := format('%4d', [mes.entries[t].index div divisor]) + ' - ' + wordwrapped;
    Form16.JvHTListBox1.Items.Add(linedata);
  end;
end;

procedure FillInDataFromDialogueFile(dlgptr: PDialogueFile);
var
  linedata: String;
  wordwrapped: String;
  commentswrapped: String;
  t: Integer;
begin
  Form16.JvHTListBox1.Clear;
  for t := 0 to dlgptr.nodecount - 1 do
  begin
    wordwrapped := dlgptr.nodes[t].npctextmale;
    wordwrapped := StringReplace(wordwrapped, '''', '\sq', [rfReplaceAll]);
    wordwrapped := StringReplace(wordwrapped, '"', '\dq', [rfReplaceAll]);
    wordwrapped := wraptext(wordwrapped, '<br>' + '       ',
      [' ', '-', ','], 53);
    wordwrapped := StringReplace(wordwrapped, '\sq', '''', [rfReplaceAll]);
    wordwrapped := StringReplace(wordwrapped, '\dq', '"', [rfReplaceAll]);
    linedata := format('%4d', [dlgptr.nodes[t].start_index]) + ' - ' + wordwrapped;
    Form16.JvHTListBox1.Items.Add(linedata);
  end;
end;

procedure FillInDataFromMesFile(mes: MessageFile);
var
  linedata: String;
  wordwrapped: String;
  commentswrapped: String;
  t: Integer;
begin
  Form16.JvHTListBox1.Clear;
  for t := 0 to mes.entrycnt - 1 do
  begin
    wordwrapped := mes.entries[t].messagestr;
    wordwrapped := StringReplace(wordwrapped, '''', '\sq', [rfReplaceAll]);
    wordwrapped := StringReplace(wordwrapped, '"', '\dq', [rfReplaceAll]);
    wordwrapped := wraptext(wordwrapped, '<br>' + '       ',
      [' ', '-', ','], 53);
    wordwrapped := StringReplace(wordwrapped, '\sq', '''', [rfReplaceAll]);
    wordwrapped := StringReplace(wordwrapped, '\dq', '"', [rfReplaceAll]);
    linedata := format('%4d', [mes.entries[t].index]) + ' - ' + wordwrapped;
    Form16.JvHTListBox1.Items.Add(linedata);
  end;
end;

{$R *.dfm}

procedure TForm16.JvHTListBox1DblClick(Sender: TObject);
begin
  modalresult := mrOk;
end;

end.
