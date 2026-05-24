unit ProgressDialogOllama;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvExControls, JvWaitingProgress,
  Vcl.StdCtrls, Vcl.ExtCtrls, JvWaitingGradient;

type
  TForm31 = class(TForm)
    Label1: TLabel;
    JvWaitingGradient1: TJvWaitingGradient;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form31: TForm31;

implementation

{$R *.dfm}

procedure TForm31.Timer1Timer(Sender: TObject);
begin
  Application.ProcessMessages;
end;

end.
