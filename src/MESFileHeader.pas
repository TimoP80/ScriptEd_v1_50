unit MESFileHeader;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm24 = class(TForm)
    Label1: TLabel;
    MESHeader: TMemo;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form24: TForm24;
  procedure UpdateHeader;
implementation

uses MesParser, MesFileIO, Mesfileshow;

{$R *.dfm}

procedure UpdateHeader;
begin
  Form24.MESHeader.Text := currentmsgfile.header;
end;

end.
