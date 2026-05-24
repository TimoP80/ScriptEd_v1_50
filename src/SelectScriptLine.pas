unit SelectScriptLine;

interface

uses
  Windows, ArcanumSCRLib, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls, JvExStdCtrls, JvHtControls;

type
  TForm19 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    JvHTListBox1: TJvHTListBox;
    Button1: TButton;
    Button2: TButton;
    procedure JvHTListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form19: TForm19;
  displayscript: ScriptFile;
  selectedline: Integer;

procedure ShowScriptLines(fname: String);
procedure ShowScriptLines_EditorScript;

implementation

procedure ShowScriptLines_EditorScript;
var
  thisscriptline: String;
  t: Integer;
begin
  Form19.Label2.Caption := extractfilename(currentscript.filename);
  Form19.JvHTListBox1.Clear;
  for t := 0 to displayscript.LineCount - 1 do
  begin
    thisscriptline := decode_script_line(currentscript.scriptlines[t]^);
    thisscriptline := StringReplace(thisscriptline, #13#10, '<br>',
      [rfReplaceAll]);
    Form19.JvHTListBox1.Items.Add(IntToStr(t) + '. ' + thisscriptline + '<br>');
  end;

end;

procedure ShowScriptLines(fname: String);
var
  thisscriptline: String;
  t: Integer;
begin
  Form19.Label2.Caption := extractfilename(fname);
  Form19.JvHTListBox1.Clear;
  LoadScript(fname, displayscript);
  for t := 0 to displayscript.LineCount - 1 do
  begin
    thisscriptline := decode_script_line(displayscript.scriptlines[t]^);
    thisscriptline := StringReplace(thisscriptline, #13#10, '<br>',
      [rfReplaceAll]);
    Form19.JvHTListBox1.Items.Add(IntToStr(t) + '. ' + thisscriptline + '<br>');
  end;

end;

{$R *.dfm}

procedure TForm19.JvHTListBox1Click(Sender: TObject);
begin
  if pos('.', JvHTListBox1.Items[JvHTListBox1.ItemIndex]) <> 0 then
  begin
    selectedline := StrToInt(copy(JvHTListBox1.Items[JvHTListBox1.ItemIndex], 1,
      pos('.', JvHTListBox1.Items[JvHTListBox1.ItemIndex]) - 1));
  end;

end;

end.
