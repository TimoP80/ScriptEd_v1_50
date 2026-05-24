unit compileProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, VCl.Graphics, Vcl.Controls, vcl.Forms,
  vcl.Dialogs, vcl.StdCtrls, vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    filenamepanel: TPanel;
    statuspanel: TPanel;
    linescompiledpanel: TPanel;
    filesizepanel: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form1.hide;
end;

end.
