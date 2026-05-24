unit SelectCondition;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TForm26 = class(TForm)
    Button1: TButton;
    CMDList: TListView;
    Button2: TButton;
    procedure CMDListClick(Sender: TObject);
    procedure CMDListDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form26: TForm26;
  selectedcondition: string;
procedure ListConditions;

implementation

    uses ScriptEdWindow, arcanumscrlib;

procedure ListConditions;
var i: integer;
var l: TListItem;
begin
 form26.CMDList.Clear;
 for i := 0 to ConditionOpcodes.entrycnt-1 do
 begin
     l := form26.Cmdlist.Items.Add;
     l.Caption := ConditionOpcodes.entries[i].messagestr;
     l.SubItems.Add(IntToStr(GetOpcodeParamCount(l.caption)));
 end;
end;

{$R *.dfm}

procedure TForm26.CMDListClick(Sender: TObject);
begin
selectedcondition:=CMDList.Selected.Caption;
end;

procedure TForm26.CMDListDblClick(Sender: TObject);
begin
ModalResult:=mrOk;
end;

end.
