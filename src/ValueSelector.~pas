unit ValueSelector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mesfileio, mesparser, GenericSelectorWindow, StdCtrls, JvExStdCtrls, JvHtControls,
  Mask, JvExMask, JvSpin;

type
  TForm18 = class(TForm16)
    Label2: TLabel;
    valuedata: TJvSpinEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form18: TForm18;

procedure ValueselectorFillInDataFromMesFile(mes: MessageFile);

implementation

procedure ValueselectorFillInDataFromMesFile(mes: MessageFile);
var
  linedata: String;
  wordwrapped: String;
  commentswrapped: String;
  t: Integer;
begin
  form18.JvHTListBox1.Clear;
  for t := 0 to mes.entrycnt - 1 do
  begin
    wordwrapped := mes.entries[t].messagestr;
    wordwrapped := StringReplace(wordwrapped, '''', '\sq', [rfReplaceAll]);
    wordwrapped := StringReplace(wordwrapped, '"', '\dq', [rfReplaceAll]);
    wordwrapped := wraptext(wordwrapped, '<br>' + '       ', [' ', '-', ','], 53);
    wordwrapped := StringReplace(wordwrapped, '\sq', '''', [rfReplaceAll]);
    wordwrapped := StringReplace(wordwrapped, '\dq', '"', [rfReplaceAll]);
    linedata := format('%4d', [mes.entries[t].index]) + ' - ' + wordwrapped;


    form18.JvHTListBox1.Items.Add(linedata);

  end;

end;

{$R *.dfm}

end.
