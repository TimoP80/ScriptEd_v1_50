unit ScriptDebugView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pluginfunc, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Memo1:  TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  thescript: PScriptFile;
  Form1:     TForm1;

procedure DumpScript;

implementation

procedure DumpScript;
var
  t: integer;
begin
  form1.Memo1.Lines.Clear;
  for t := 0 to thescript.LineCount - 1 do
  begin
    if thescript.scriptlines[t].ifpart.opcode > 0 then
      form1.Memo1.Lines.add(IntToStr(t + 1) + ' IF -- ' + OpcodeConditionToString(
        thescript.scriptlines[t].ifpart.opcode));

    if thescript.scriptlines[t].thenPart.opcode > 0 then
      form1.Memo1.Lines.add(IntToStr(t + 1) + ' ACTION -- ' + OpcodeActionToString(
        thescript.scriptlines[t].thenPart.opcode));

    if thescript.scriptlines[t].elsePart.opcode > 0 then
      form1.Memo1.Lines.add(IntToStr(t + 1) + ' ELSE -- ' + OpcodeActionToString(
        thescript.scriptlines[t].elsePart.opcode));

  end;

end;


{$R *.dfm}

end.
