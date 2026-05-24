unit scriptproperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Arcanumscrlib, Dialogs, StdCtrls, ComCtrls;

type
  TForm4 = class(TForm)
    Label7: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox26: TCheckBox;
    CheckBox27: TCheckBox;
    CheckBox28: TCheckBox;
    CheckBox29: TCheckBox;
    CheckBox30: TCheckBox;
    CheckBox31: TCheckBox;
    CheckBox32: TCheckBox;
    Counter0: TEdit;
    UpDown1: TUpDown;
    Counter1: TEdit;
    UpDown2: TUpDown;
    Counter2: TEdit;
    UpDown3: TUpDown;
    Counter3: TEdit;
    UpDown4: TUpDown;
    Button1: TButton;
    Button2: TButton;
    description: TEdit;
    nonmagictrap: TCheckBox;
    radius2: TCheckBox;
    magictrap: TCheckBox;
    radius3: TCheckBox;
    autoremove: TCheckBox;
    radius5: TCheckBox;
    deathspeech: TCheckBox;
    teleporttrig: TCheckBox;
    surrspeech: TCheckBox;
    procedure SetScriptBits(Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.SetScriptBits(Sender: TObject);
var
  bitnum: Integer;
begin
  bitnum := TCheckBox(Sender).Tag - 1;
  scriptflags.ToggleBit(bitnum);
end;

end.
