unit SelectCondAndStatement;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm27 = class(TForm)
    Label1: TLabel;
    condlist: TComboBox;
    thenlist: TComboBox;
    Label2: TLabel;
    elselist: TComboBox;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form27: TForm27;

procedure UpdateLists;

implementation

uses ScriptEdWindow, ArcanumSCRLib;

{$R *.dfm}

procedure UpdateLists;
var
  i: integer;
begin
  Form27.condlist.Clear;
  Form27.thenlist.Clear;
  Form27.elselist.Clear;
  for i := 0 to ConditionOpcodes.entrycnt - 1 do
  begin
    Form27.condlist.Items.Add(ConditionOpcodes.entries[i].messagestr);
  end;

  for i := 0 to ActionOpcodes.entrycnt - 1 do
  begin
    Form27.thenlist.Items.Add(ActionOpcodes.entries[i].messagestr);
    Form27.elselist.Items.Add(ActionOpcodes.entries[i].messagestr);
  end;

end;

end.
