unit SelectAction;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TForm25 = class(TForm)
    Button1: TButton;
    CMDList: TListView;
    Button2: TButton;
    procedure CMDListClick(Sender: TObject);
    procedure CMDListDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form25: TForm25;
  selectedcommand: string;
   procedure ListCommands;
implementation
    uses ScriptEdWindow, ArcanumSCRLIb;

{$R *.dfm}

procedure ListCommands;
var i: integer;
var l: TListItem;
begin
 form25.CMDList.Clear;
 for i := 0 to ActionOpcodes.entrycnt-1 do
 begin
     l := form25.Cmdlist.Items.Add;
     l.Caption := actionopcodes.entries[i].messagestr;
     l.SubItems.Add(IntToStr(GetOpcodeParamCount(l.caption)));
 end;
end;

procedure TForm25.Button1Click(Sender: TObject);
begin
modalresult:=mrOk;
end;

procedure TForm25.CMDListClick(Sender: TObject);
begin
selectedcommand := CMDList.Selected.Caption;
end;

procedure TForm25.CMDListDblClick(Sender: TObject);
begin
modalresult:=mrOk;
end;

end.


